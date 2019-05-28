Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F4FC04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 12:54:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 520FE20989
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 12:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ry4vvoqM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 520FE20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34336 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVbcA-0006fo-Jc
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 08:54:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hVbb3-0006AX-7n
	for qemu-devel@nongnu.org; Tue, 28 May 2019 08:52:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hVbb1-0007eQ-9l
	for qemu-devel@nongnu.org; Tue, 28 May 2019 08:52:53 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:46758)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hVbaz-0007cL-F2
	for qemu-devel@nongnu.org; Tue, 28 May 2019 08:52:50 -0400
Received: by mail-oi1-x241.google.com with SMTP id 203so14110505oid.13
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 05:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=m0bOlkivdfwZCFKW4VcJ6PMPlcqCQRxaOILXwjjVmxs=;
	b=Ry4vvoqMOJlTiwRPw0Dou73JQGFFvh1KdOII2Msq07bH7m88NBTB+/MGlWhB4cSthz
	HSUjZ5F7JQYKooe6XV0hoRUW32gB5Dli4GnK1APEf35de48mHwoB0gYBzn6fFSVjNukT
	SD/pi+d0dYxveUqeRw4nLE76KK8XMBAPCoFZQdsuec5NW+skQ0iO9Ypz1rSNHeZMkshY
	Op/kcNq3XDCIlmFIzipjyq6yIWigeK88wDCObsMfakXtaAt0p+mFEAyeEUbnNm4HZzPe
	JaM7/lNtxzDq76qE0SrE229lEEGGRkx0ZAzShD+Fqy7pqQicLe8jbtYSz+htYwmADaYi
	oI2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=m0bOlkivdfwZCFKW4VcJ6PMPlcqCQRxaOILXwjjVmxs=;
	b=j4M+8B5ZLS4YfIbYKemEE7jd8y3i9LEGrbxkH6I32FrcPG69hGYAxpKc4RLfz8K0cj
	eoMKvw02Nz319razeqeIn/F2BZvp/M9jZp5Gbxb5+Bp+PLRdxjL0CPhz5EF4ASfQLayr
	iNmBgurCagl1dsd8k5MllcUnhSZiFe3KUnbroLdd7K298ez2iMla3yCeoszPeSwtW3Po
	x6JDNiY0TImRjPHlksvlbnG1j+9pXPbvLieE/r/Wva3Ro+vu3DYLnA6CBMLNfpH3hZDp
	e3VR4LT/wwBYClEKCJH1fNXIBWXi3SF/UeqPEP3Lg0m8zpY5YEpAh+IT5FO9gl3gqHb3
	sJUw==
X-Gm-Message-State: APjAAAV9WX7QFYknHGDmta3Gx55nVLcSdsxHoJLMvcgrUs91wpQ156dr
	AvD81fJc2uJuZbxhVBmgUWznbw==
X-Google-Smtp-Source: APXvYqwJng8vhrNPebbmc8TAybi0+EQBy3ChsnEiUGbx3BhVs01ztLrr0c7BEnBQmjz0ibmKED9B2w==
X-Received: by 2002:aca:56c9:: with SMTP id k192mr2403611oib.114.1559047967814;
	Tue, 28 May 2019 05:52:47 -0700 (PDT)
Received: from [172.24.12.210] (168.189-204-159.bestelclientes.com.mx.
	[189.204.159.168])
	by smtp.gmail.com with ESMTPSA id r7sm5036935oia.22.2019.05.28.05.52.45
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 28 May 2019 05:52:47 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190524093335.22241-1-david@redhat.com>
	<20190524093335.22241-3-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <b1c8a3b6-8c6e-4f4b-6811-25a14696ee85@linaro.org>
Date: Tue, 28 May 2019 07:52:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190524093335.22241-3-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PATCH v2 2/5] s390x/tcg: Implement VECTOR FIND
 ELEMENT EQUAL
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
	Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/24/19 4:33 AM, David Hildenbrand wrote:
> Core logic courtesy of Richard H.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/helper.h            |  6 ++++
>  target/s390x/insn-data.def       |  2 ++
>  target/s390x/translate_vx.inc.c  | 31 +++++++++++++++++
>  target/s390x/vec_string_helper.c | 57 ++++++++++++++++++++++++++++++++
>  4 files changed, 96 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


