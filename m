Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A5AC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:19:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C77520863
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yW3KQN5g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C77520863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37256 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hToYd-0006JY-O2
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 10:18:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hToTx-0001Wh-09
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:14:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hToTw-00084J-4u
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:14:08 -0400
Received: from mail-vs1-xe2b.google.com ([2607:f8b0:4864:20::e2b]:46614)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hToTv-00083e-VM
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:14:08 -0400
Received: by mail-vs1-xe2b.google.com with SMTP id x8so3652631vsx.13
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 07:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=3x925eKkumSmbnBjUqy1Irvrebu8+3G8lr0rwJRmdAA=;
	b=yW3KQN5gAWS86SMOArRFk5+AiRFU2AN0+Qaf6eR9rHoheO2ro9FD+T/BtSNI692udg
	wNDdMwjXi2lxW1VShj6h02Z9J9neigklz293ecTZsQR0VgQDinp6/p0W4ZgsExEMDg1x
	ToHebqdp64xQFn0xUQA1CEmy70QAMCFmhSACi00KJtQBJHNU1MrgBsdlkaY1fJXP/5gg
	YWesUBbzwTI/jua6WUCZwuaKsG3RxBpGTlt6PVTVErIznu59WvxpMUr5n+QCQmNSNj9H
	OrJizHh+eDJWhD4PClcKCj1MhEjNpnw9N5EQ3lHcxb2lctU1A5BL7o4slg/WaWvEZooA
	1ivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=3x925eKkumSmbnBjUqy1Irvrebu8+3G8lr0rwJRmdAA=;
	b=IZS/jCi6iv/UaRKrLiOndMRo92ArZoGrHzBJKoPKDQ5nVLOiBs1/8pOhW/R/mPHeOk
	LwyfYB3ZGv4IGDYgN4BPaIOaZDQ/gDEAU6Dsflvafsh76oCUw4PYKcQmRtpP3JOmN4Qe
	dSN3gRuSTOKN61mscV1Y5CcgnIQXI9yKfVlMkXqnenTHyeSFQ17HpTI3d1sxXuGJrJEe
	VZpyWydjrG4BKdyckFseRYqb4clfD6VSKpWs6kC1k7DjJKjYv9BMJUZHMjsQ7p0ix8XO
	IWwZNdEB3iUslA/7lqof0x/NlAZZbw7FxrhKJl/BRKPwoR2z2M66gESthKIyeGdawwS5
	42ew==
X-Gm-Message-State: APjAAAViZNE8GpLGwb7dsi7M99Lx7RUwF855cj37+1jYs6AmNoUDf2Aq
	weZqLT1+FX7HoR9M2gTxPnRsS5HRv6q/dQ==
X-Google-Smtp-Source: APXvYqxwENlYcVCMo5W3KD7clp5YZ3Lm8S2LRXqhoOWwVknvdxSRrFm65vsbrOM8fzwyYzN2rhAslA==
X-Received: by 2002:a67:8e8a:: with SMTP id q132mr14038447vsd.41.1558620846951;
	Thu, 23 May 2019 07:14:06 -0700 (PDT)
Received: from [192.168.43.94] (ip-173-130-215-183.orldfl.spcsdns.net.
	[173.130.215.183]) by smtp.gmail.com with ESMTPSA id
	l76sm10248794vke.32.2019.05.23.07.14.05
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 07:14:06 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190523081538.2291-1-armbru@redhat.com>
	<20190523081538.2291-5-armbru@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <08088a2e-657b-6f9b-5ff3-85f45fd18718@linaro.org>
Date: Thu, 23 May 2019 10:14:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523081538.2291-5-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::e2b
Subject: Re: [Qemu-devel] [RFC v4 4/7] Makefile: Reuse all's recursion
 machinery for clean and install
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
Cc: peter.maydell@linaro.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/23/19 4:15 AM, Markus Armbruster wrote:
> Targets "clean" and "install" run make recursively in a for loop.
> This ignores -j and -k.  Target "all" depends on SUBDIR/all to recurse
> into each SUBDIR.  Behaves nicely with -j and -k.  Put that to use for
> "clean" and "install": depend on SUBDIR/clean or SUBDIR/install,
> respectively, and delete the loop.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  Makefile | 53 +++++++++++++++++++++++++----------------------------
>  1 file changed, 25 insertions(+), 28 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


