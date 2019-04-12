Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862DBC10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 23:51:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DECE2086D
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 23:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eNQQcd3r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DECE2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44217 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hF5x9-0008IW-Fq
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 19:51:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF5wI-0007OH-O6
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 19:50:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF5wH-0002Iq-Pp
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 19:50:34 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:34026)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hF5wH-0002Hm-Cq
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 19:50:33 -0400
Received: by mail-pf1-x443.google.com with SMTP id b3so5865063pfd.1
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 16:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=VsdAlL6Rzgl4cWXYDnTQWXL7dGMukM4yHH1QOWoh1Pw=;
	b=eNQQcd3r7kKdGC8E0auPsHb7TBfKvgxym9saubdMV6CmfE0lYqiRgxWRcOcmHzFuPj
	K3RheTjTn/KB56JwBKI6TlYYrfpPUPBPvD3fF3EdbuAY6SkB6a2hXX+n9DD4LruQkHHG
	CaUD4i5wVCtzOB86Ly7rQbsVqgoq8eYgjWa+6+yLpLItTr2Fazum460FyQ1TQAE9uWGs
	Y3Mg6aSa3vuzkmkm82MTyTni8MWO+AE9/KfwzBIkuFthngRRibR2FvFsjkGh0HCbBbZv
	dDauK08HqaVE5eYeMrIu5950Y3fO2N4X99C+AFTpvrQ3C01SV1vzaBaE2uRE2Tzm8/AL
	VP2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=VsdAlL6Rzgl4cWXYDnTQWXL7dGMukM4yHH1QOWoh1Pw=;
	b=bcdhJW7kvY0AhfWACXMx5mxQEvCkOsqXl2e+Scur28fKn0iljhMpkIyE5JSo+uceXp
	HZKUNPvGafMS6TqAilR26j/MWwmbHkuUBycq1ITh+zR/Qv1czYlddy6UjVlWB3U6/1JZ
	wzNtTwxVEhe63N7pLAOxPp0NvaJASDr/lu383hZz0OStaIEJcKhHZKfuX+wLxeizD1bC
	HzumpSPhFsZvvPKsNRgHGKVnEausuFnSCU+cIGEwgDFRffo6HKM3XZAL+RZILN45nG1p
	i+8oTJNmoB9lGInqj9dmepgcG8IXTozf1uMLrgoGQ6Hb/ZafrOvl6GczkkA0SArV4AIU
	0ypA==
X-Gm-Message-State: APjAAAUZiTBKhYB6/8OVqrfUIv3ZlhufUpuyyyvuW43as/ndXfsnXEyj
	HFFs/oxbIZGr1qBf1gdtCmkG7Q==
X-Google-Smtp-Source: APXvYqxI2WarvQNtyPG243Y2wCL304tcdtypsHoPpKztMnZGIFovxI0AXFM6/LYayAdH83JazzPHmw==
X-Received: by 2002:a63:c45:: with SMTP id 5mr56870849pgm.385.1555113031774;
	Fri, 12 Apr 2019 16:50:31 -0700 (PDT)
Received: from [172.20.98.58] (rrcs-173-197-98-123.west.biz.rr.com.
	[173.197.98.123]) by smtp.gmail.com with ESMTPSA id
	b7sm124291496pfj.67.2019.04.12.16.50.30
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Apr 2019 16:50:31 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-18-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <baebe333-5e28-9fd3-adef-7027c166a599@linaro.org>
Date: Fri, 12 Apr 2019 13:50:27 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-18-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: Re: [Qemu-devel] [PATCH v1 17/41] s390x/tcg: Implement VECTOR LOAD
 POSITIVE
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
Message-ID: <20190412235027.vZ19H5zM-AWpBRFOmq5GNeSgxH1GCbnPIeFmSkbqxLk@z>

On 4/11/19 12:08 AM, David Hildenbrand wrote:
> Similar to VECTOR LOAD COMPLEMENT but unfortunately we don't have a
> gvec helper.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/helper.h           |  2 ++
>  target/s390x/insn-data.def      |  2 ++
>  target/s390x/translate_vx.inc.c | 40 +++++++++++++++++++++++++++++++++
>  target/s390x/vec_int_helper.c   | 14 ++++++++++++
>  4 files changed, 58 insertions(+)

I would be happy to add ABS as a gvec primitive, if you like.
Expandable with MAX or CMP on hosts without ABS.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

