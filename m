Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 914E4C10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 23:25:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 569CB2084D
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 23:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="np0RBTnx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 569CB2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43981 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hF5XX-0000z4-Fq
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 19:24:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF5WL-0000Nf-Dk
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 19:23:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF5WK-0004t2-E1
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 19:23:45 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432]:34328)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hF5WK-0004sH-5r
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 19:23:44 -0400
Received: by mail-pf1-x432.google.com with SMTP id b3so5844133pfd.1
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 16:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=CCaX0gHcv7ptFXPrWUHIh3Y+8gHOfVdUCszaWqRCoVM=;
	b=np0RBTnxPQ4+vJRiMLjxmGQXxJhxjZv1s1gHL4o6ks2h9Zk14mwh1LZvtfDF5zfYy6
	l4JpmergHLByB0El3EoFgl2X7TTnOa3yma0JbLartMPPmFUlXNG8mE0LnlJiz1mgLhGT
	zPPc1DyoGf7B6KJqYb/dLe7OA67nQr0DmFGKXUprRcLYxhLTZ7aXfIgSCNL7lkLI3Nnb
	eCyXwnhz9tB9UeZ2PbBiVV6RniR2xh9sj/F9FOvTKyCoYIH8cJ2f4jN+ijaojgHJ4EoR
	OwmLQf0+zzF9ciCrPaA1cVzmo7SgXAgIeMZ33i+ErNYfA2xx4xYo7R8tcXfE41VuZZ5s
	HGiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=CCaX0gHcv7ptFXPrWUHIh3Y+8gHOfVdUCszaWqRCoVM=;
	b=gozcOVHx2ZbHo0HvYZtfNEqn/PUBvjqmS6LGAYFMdtkD4SQMTviasdfn3kUL68+/sI
	D6b0vz2tt0+34O0YrURPZNTncDMEUKZjoOlTLLfLlH7c70lEMawHzHOx4CATrFIZDUtI
	xixhLlfNkUAktix/fIqAJVSXW0BqP5M0fowupAac/waKKQ5nXUWRrgKXLyII/9M1Obf/
	1v8lSUN8eTj0q0XfyQrpAO+fJbOqMhG3p3EwZJx2J7C9C93zps5YfzopHUvRWIcnf6Ys
	bYmpvhXkyVO9kSlNmU5QiRTRSrOZlcfTrMeHDMDUmjc/998NXOV4Ddg4rJcwrf8jazPg
	oICQ==
X-Gm-Message-State: APjAAAVRObozgdgDnANC9kRYklZahVAE5WUHzPTBdkJx8/TPXR4ExjSp
	Y+aqe1F3DBntj6BDthGqd6TNBDMuUPM=
X-Google-Smtp-Source: APXvYqxjjW3TISjQlb+CbK7xQDEfj0HojZRRNdfyYFdztGGon0Fh359CtBx4He0qJ5ourPK9eiWilw==
X-Received: by 2002:aa7:82cb:: with SMTP id f11mr60574784pfn.0.1555111423171; 
	Fri, 12 Apr 2019 16:23:43 -0700 (PDT)
Received: from [172.20.98.58] (rrcs-173-197-98-123.west.biz.rr.com.
	[173.197.98.123]) by smtp.gmail.com with ESMTPSA id
	p81sm70071253pfi.186.2019.04.12.16.23.41
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Apr 2019 16:23:42 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-15-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <a2334025-6523-7230-9c6d-de3adf8f99a0@linaro.org>
Date: Fri, 12 Apr 2019 13:23:39 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-15-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::432
Subject: Re: [Qemu-devel] [PATCH v1 14/41] s390x/tcg: Implement VECTOR
 EXCLUSIVE OR
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
Message-ID: <20190412232339.9h3FCP9sdD1Z3YtKTsl8vZlOA-P7dxOlxNlE0ErJI9Y@z>

On 4/11/19 12:08 AM, David Hildenbrand wrote:
> Easy, we can reuse an existing gvec helper.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def      | 2 ++
>  target/s390x/translate_vx.inc.c | 7 +++++++
>  2 files changed, 9 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

