Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68DDCC43219
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 16:51:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA768206BF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 16:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p3ZJC91k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA768206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60799 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJhb9-0005XN-Ce
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 12:51:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJhaA-0004qQ-UT
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:50:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJha9-0003dv-Uf
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:50:46 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:38842)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJha9-0003bc-KI
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:50:45 -0400
Received: by mail-pl1-x644.google.com with SMTP id f36so79550plb.5
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 09:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=6GsEehMrGxTNJ75kS5l1YQNwV0S6GpS3jOZIJxIwfHk=;
	b=p3ZJC91kQtDtDVtvRhKMnIJ6nU+UB4QRDjpSYk1H1f1k5Xz3ifQECyV+C+ES/ZAUrB
	n2W74PL+sRUs+Ep8HgRTw2DJWMJuzAeFZP0vEeqKCy8nWzVz5WT3bVs626R+YaBEAH11
	lnNlugkvi1sADWd2xFrAuJ17+sdqqEbsVRzx2p2PVpCE/Z3PFWjzUkBxvR2mTdKENsdb
	eUywopeNhrtHTf+aoxVaYkPQc5jzJ/OwuAaLTZywiZU4r2ZGd4PAb+zax3BqN/MQn7sF
	j3RcifKkdGByuuFjdl8Sy+ajVjSnvl3LK4LjRwy5Lh2QSozY988u9fgZpYcMgl91qf3R
	3F6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=6GsEehMrGxTNJ75kS5l1YQNwV0S6GpS3jOZIJxIwfHk=;
	b=L0fGNG+7tP470gmBtvCMd0MHD08WRit3qtTY4MLcdJi3ngYapyLw2ymxkZL1bGZinl
	h95oR5/FqzxZuotTbYCNtDoVZc/ECbSc8R4VjL6ZX4guAdiENCiOUCXX6ZoscbLDqNhZ
	fR+WtOyCkOLzoTlN6lWZnJGFVwWM8s50Pfmv2FkRq2pKkxd5+r5dk4FhhuRGbhiPFoqk
	Ar3EzCyj9AZuZOLW/LnmColMyaq9vEExRqoPhBHBTCwY91ftyv99COyozVskWnQT/nna
	jKYSGehyul6seDppRTLS5hWRvWlrQJ9wubJA1kICtGfbr83/1qFy0iLAnFY8d4IVBU+a
	HhgA==
X-Gm-Message-State: APjAAAWiqjvhhZpU5dP1eG5jMjpciCR75MHVRf2FjZGkeRNJkVxJuBa/
	evGi68bsTuE4WOUK898JOWVYKz2J4WQ=
X-Google-Smtp-Source: APXvYqwvLuO0NnHt07fKSGYZtcoVl3I9CwPGXEcaTnt5LyScge5cXwcCokxRkQakxv6WqqkwSlW96w==
X-Received: by 2002:a17:902:aa85:: with SMTP id
	d5mr38983217plr.251.1556211044069; 
	Thu, 25 Apr 2019 09:50:44 -0700 (PDT)
Received: from [192.168.1.11] (97-113-179-147.tukw.qwest.net. [97.113.179.147])
	by smtp.gmail.com with ESMTPSA id l1sm25977016pgp.9.2019.04.25.09.50.42
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 Apr 2019 09:50:43 -0700 (PDT)
To: Palmer Dabbelt <palmer@sifive.com>
References: <mhng-f65ff93d-20e5-4c4a-919a-c311ae97649d@palmer-si-x1e>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <357d260b-4baf-aea8-c332-f77ce2a3e9b2@linaro.org>
Date: Thu, 25 Apr 2019 09:50:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <mhng-f65ff93d-20e5-4c4a-919a-c311ae97649d@palmer-si-x1e>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::644
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
Message-ID: <20190425165041.3Ij1a5u3SoYnHz4i-BNldathz02OmkkWe-HAjiEjcpQ@z>

On 4/25/19 9:04 AM, Palmer Dabbelt wrote:
>>  # *** RV64C Standard Extension (Quadrant 2) ***
>> -c_slli            000 .  .....  ..... 10 @c_shift2
>> +slli              000 .  .....  ..... 10 @c_shift2
> 
> This is another one where rd=0 is illegal in the compressed ISA, but again we
> don't appear to handle these correctly before the cleanups.

I see "HINT, rd=0" in the 2.2 documentation for this case.


r~

