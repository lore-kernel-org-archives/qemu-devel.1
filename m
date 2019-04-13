Return-Path: <SRS0=HErD=SP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4B1C10F11
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 05:50:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D9DD20850
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 05:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bRtg3vYd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D9DD20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47158 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFBZ1-0007Ep-E2
	for qemu-devel@archiver.kernel.org; Sat, 13 Apr 2019 01:50:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hFBWx-00061b-P6
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 01:48:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hFBWv-0006ix-K0
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 01:48:47 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a]:44626)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hFBWt-0006fm-LN
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 01:48:43 -0400
Received: by mail-pf1-x42a.google.com with SMTP id y13so6107727pfm.11
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 22:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=Ru8hUs6D20EddQym9lLfU0svsuzs3d79jWXlkpt9e7A=;
	b=bRtg3vYdd6O8PPDCdBmeP62ZNNzRnm66nBPtgdfF86+FS9ATavKQqFZ1iMIEXuoQPU
	1dIWuIdolHUCpOr5MwUBr74yamRCXIJUTlTbNHbHiBeXTGiBsIJiW3JBOTvLKsVz8Mhr
	DNDQgSfKma62/4cGrhG+5+ESKzKMJpp6IKktSsPsrVcZgt1+q2ZVgXNcVtNn/90CJZFI
	cVFZzVW22g2sZDTWbWrCybam+ztNzw+4AtmiPwYC7HABaLEcV4SWfM3mUwNhhplWoRsx
	iPdUYJxzfvCMDDu6OrPE9MzxGgDXfHu1BLIioz1MGdsnXsHaYC9X48muq1uW0TMSJgQL
	1GHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=Ru8hUs6D20EddQym9lLfU0svsuzs3d79jWXlkpt9e7A=;
	b=V0cLPXt6GXKbQKuIwudvN42tfWM8qrwhuJ7eflxz6OrAbNckVflHio5eAaovH7DV2W
	BS7pkBilVzIV6HG4dEl04WIBZpX8xJnjefg547tW6tTNTMjzuOf+9K7paKiqegEKDYxn
	kmOaacMCM0m8SsF2YrsXLEqX19coWaVm20yCEqnZIP2kBvF7uDvgjGZFClB/3R2Fwgn7
	H3aOKI+8y9UUnOPjZU/dj4KkBwpK/GIQF9P/ZqVoEaTOQhBJOUT1OnB0uflyO8X/ntEE
	hXDX3ZJT3mIAt6TWPNEQIywvr1JIdE/Yi+1FHwWVq7ahd6UhU4DUX6/RrhVpowi9qW2+
	eqyw==
X-Gm-Message-State: APjAAAVTL6cyodvKhF8JyVL0sgkspRZSJAEc9X3whNtn6C2sHP5/Z9PY
	jrSVVfAulX+eDS0Np/CUHfc2Mg==
X-Google-Smtp-Source: APXvYqzCmOhSk0RBaeriMz/JOewI0ogDLWRyYknvx8G4YjXfQq8OG+Fg2SQwfvyc2iA0nDIWWs/D4g==
X-Received: by 2002:a63:87c1:: with SMTP id
	i184mr58260508pge.265.1555134521384; 
	Fri, 12 Apr 2019 22:48:41 -0700 (PDT)
Received: from [172.20.98.58] (rrcs-173-197-98-123.west.biz.rr.com.
	[173.197.98.123]) by smtp.gmail.com with ESMTPSA id
	e7sm37296428pfc.132.2019.04.12.22.48.39
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Apr 2019 22:48:40 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-34-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <3b1cf982-0357-a9e0-93d0-827c1a096c44@linaro.org>
Date: Fri, 12 Apr 2019 19:48:37 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-34-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::42a
Subject: Re: [Qemu-devel] [PATCH v1 33/41] s390x/tcg: Implement VECTOR SHIFT
 RIGHT LOGICAL *
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
Message-ID: <20190413054837.8AeqcRhi7zLcHzjW30gBCgwzGtH8zquUHsiItnGyQ4U@z>

On 4/11/19 12:08 AM, David Hildenbrand wrote:
> Similar to VECTOR SHIFT RIGHT ARITHMETICAL.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/helper.h           |  1 +
>  target/s390x/insn-data.def      |  4 ++++
>  target/s390x/translate_vx.inc.c | 17 +++++++++++++++++
>  target/s390x/vec_int_helper.c   |  6 ++++++
>  4 files changed, 28 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


