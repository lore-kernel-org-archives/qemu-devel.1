Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A229C43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 01:03:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 005F620866
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 01:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="No0jlmTy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 005F620866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57771 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLdeg-0003u5-8Y
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 21:03:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1hLddI-0003GQ-Qe
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 21:02:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1hLddF-0007k0-AI
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 21:02:00 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:34145)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1hLddF-0007i3-0t
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 21:01:57 -0400
Received: by mail-pg1-x541.google.com with SMTP id c13so6683285pgt.1
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 18:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
	h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
	:content-transfer-encoding;
	bh=+dMuCy8/ZPqKt1IiTMdmEPknxoPIN17XpSc3WaCu9ps=;
	b=No0jlmTyf0u3mLoJwQ11Nnyic48vKSGJQmrZYdijkS9fcJGTtJ3asIWABp2faMjoA+
	ha9/oTBhiyBq8UA1/OBsB68E88n16sGF5s4GOFFKSjlal0paSnscMIH1T7o/vsczKclp
	oARbFpl8pX/sQmbn5XZm969PiFAYZSzNJhD90lLuOhhjl9xmyNk9WkZ4mRc4jw5vX14r
	W7skvarvxXDNBXhOuWVlZ/1m/MqbSlYJ4NnIAnnUIWARY3sQUL1sy6HAe3Elj1Q40b85
	sLgBQfFpis3wbRjTGflhiGh+ia6+xnybFCanvoXEcnTWthU/7Q1Pha0gaekJlXlETjEa
	wUFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
	:mime-version:content-transfer-encoding;
	bh=+dMuCy8/ZPqKt1IiTMdmEPknxoPIN17XpSc3WaCu9ps=;
	b=uR8dAvatSNOaCOSJ2pRmPc6K3sjSuoFIbpgWIvw3OO5/K1QylTjQoRxfXMp7Rm9dJE
	lZVaaTHitSzC0QiXwJW9O4paZEqN6K29v1lfsBkpDBJe7eSbcq7RQez3J7oODH6d6zxB
	d1akhkWlmtoftoXsIx7F1E6MAe9hx2z+27Gjq/hv8kJkoULw8dn66/mqulkV0XnHg8Y6
	PIhVuBWMSEke+PZjh1rhE8jhr1r3khg620Hpy0NMglEAl8Cvz8T7xRv80j098fbwhhp8
	4dswOpzUPUACeJCbGHinWFe22Uv4QJXQxR54Prx4bZ4mkcb6Ri44rhYe+6izpE0+cFtq
	8RVw==
X-Gm-Message-State: APjAAAUtb8ucVMN3B/R+n7fqnxUADH01/tfItoaSGfu/q6xEWVizi/dU
	G2XpWkKJU5XqcOmzfsfQNpnVClWS753ZqQ==
X-Google-Smtp-Source: APXvYqwkt4SwPw+/yLHOBxBkHs9r9fkCUvAh6MptjDE+kGfwZ876iZdNaH+xipf9adDJ8sWqG7EGxQ==
X-Received: by 2002:a62:2e02:: with SMTP id u2mr37469462pfu.1.1556672514422;
	Tue, 30 Apr 2019 18:01:54 -0700 (PDT)
Received: from localhost ([12.206.222.5]) by smtp.gmail.com with ESMTPSA id
	s19sm35124284pgj.62.2019.04.30.18.01.52
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 30 Apr 2019 18:01:53 -0700 (PDT)
Date: Tue, 30 Apr 2019 18:01:53 -0700 (PDT)
X-Google-Original-Date: Tue, 30 Apr 2019 18:00:41 PDT (-0700)
In-Reply-To: <357d260b-4baf-aea8-c332-f77ce2a3e9b2@linaro.org>
From: Palmer Dabbelt <palmer@sifive.com>
To: richard.henderson@linaro.org
Message-ID: <mhng-4cf09562-97fc-4e60-8a96-62aa58a9e038@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: Re: [Qemu-devel] [PATCH for-4.1 4/8] target/riscv: Merge argument
 decode for RVC shifti
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190501010153.aKSEhXc77KcSaX7CLGNEWXbzFBkaXumgHKeTnJb5kz4@z>

On Thu, 25 Apr 2019 09:50:41 PDT (-0700), richard.henderson@linaro.org wrote:
> On 4/25/19 9:04 AM, Palmer Dabbelt wrote:
>>>  # *** RV64C Standard Extension (Quadrant 2) ***
>>> -c_slli            000 .  .....  ..... 10 @c_shift2
>>> +slli              000 .  .....  ..... 10 @c_shift2
>>
>> This is another one where rd=0 is illegal in the compressed ISA, but again we
>> don't appear to handle these correctly before the cleanups.
>
> I see "HINT, rd=0" in the 2.2 documentation for this case.

Looks like you're right -- I was assuming the "rd != 0" to mean that it was an
illegal instruction, but I just confirmed with Andrew that it's legal.  In this
case (and probably the others I mentioned), I think QEMU is correct already.

