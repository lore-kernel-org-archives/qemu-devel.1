Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF25C04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 16:42:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DC0A2459C
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 16:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CDgN1x64"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DC0A2459C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46285 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWkbt-00057y-Fg
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 12:42:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWkSq-0007Wu-1h
	for qemu-devel@nongnu.org; Fri, 31 May 2019 12:33:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWkSp-0000X6-7E
	for qemu-devel@nongnu.org; Fri, 31 May 2019 12:33:08 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:42784)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hWkSo-0000TM-Vj
	for qemu-devel@nongnu.org; Fri, 31 May 2019 12:33:07 -0400
Received: by mail-oi1-x244.google.com with SMTP id v25so7605491oic.9
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 09:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=cB4en2+uCPke6Fuk4m0z7OxmoutTGxu19V77q4wQRvQ=;
	b=CDgN1x64K3MaJveyDi+TyckygfdwLiT6+yqcMxmpdSfWxPmlAlZwVbCpixfWq041WZ
	CQGc+i5sHBBWSDVi3Gxarl0LpZg9oq5qFUO6tCbE2NFbr3GEBOY/Zxu9ePPevd0Q8keS
	KEACtCEh0hVEoMDnYoJZYD68uFV/6mGIGq0geopy69VDXmhGvwprxUxS719IRbl2blLA
	RK7NeGWI8asdDBwn7dunZhWpOGAyP5jiUlpQDlmahgHBSmYZ+uuISyr4quu43R95AMAV
	te36aEyt0N8ChltR7yBx0FqgveO8YmD/viJ7KBInGjCamDAb0TuDSFYJ+9AF+osmQi7k
	dkPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=cB4en2+uCPke6Fuk4m0z7OxmoutTGxu19V77q4wQRvQ=;
	b=Vv7cp4A2GWXz7o76LRnUMpBOPMyh7bNO9Lth8V97vljOUERqztwLqZciVS8ZPJnacu
	EvURnzr3V/GbkQncoTUItaX6rgPnadXWmUw+AxeEkXW3kImqEVu5+TVs1UJxggvuV6CK
	TJsVG+cUnFRhvaVb6fyXTxIRC2kMoFoKOPnsil20Ih+7ZlhsXGNeUdsMdypAuYoUAlyv
	m8Rxe/cec3DYvedqgJD6PY7kRcJY5cJ1bqjQ3UBvybqVTlbcYwsvmyrFCh7l1Bldv2I0
	Jt5Nql166TSxJ9+GC0CBeBjQ5c0aBb6RR8n1+zR7TG6ElvpTiLOOWUZK/Tn/HJ3LQpm4
	cECA==
X-Gm-Message-State: APjAAAVuTh5MgE8Aqd4yLTLKW9UjdFr3yHjulF4r+IcFJ2ye/xVg8GtX
	2WATVy471qFwLjIFPPGpqFK+qw==
X-Google-Smtp-Source: APXvYqyZXYdIMpD7qPQXNO32eb+KXnVjh8ttclN+lfo1h4u4xDOYE+EOqS9zgNH4/7vtQ3DFRqIyqg==
X-Received: by 2002:aca:5941:: with SMTP id n62mr56672oib.43.1559320385873;
	Fri, 31 May 2019 09:33:05 -0700 (PDT)
Received: from [172.24.12.210] (168.189-204-159.bestelclientes.com.mx.
	[189.204.159.168]) by smtp.gmail.com with ESMTPSA id
	a15sm2146932otl.20.2019.05.31.09.33.04
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 31 May 2019 09:33:05 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190531104432.29379-1-david@redhat.com>
	<20190531104432.29379-6-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <e36e4dcf-790b-f4fa-35b9-00d51e689440@linaro.org>
Date: Fri, 31 May 2019 11:33:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190531104432.29379-6-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: Re: [Qemu-devel] [PATCH v1 05/23] s390x/tcg: Implement VECTOR FP
 COMPARE (AND SIGNAL) SCALAR
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>,
	Denys Vlasenko <dvlasenk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/31/19 5:44 AM, David Hildenbrand wrote:
> As far as I can see, there is only a tiny difference.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/helper.h           |  2 ++
>  target/s390x/insn-data.def      |  4 ++++
>  target/s390x/translate_vx.inc.c | 21 +++++++++++++++++++++
>  target/s390x/vec_fpu_helper.c   | 32 ++++++++++++++++++++++++++++++++
>  4 files changed, 59 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


