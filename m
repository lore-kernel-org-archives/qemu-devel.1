Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8377C54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 13:31:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C34E206D3
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 13:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gkyIMmci"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C34E206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYV0F-0007sa-TL
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 09:31:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYUpU-000199-9w
 for qemu-devel@nongnu.org; Tue, 12 May 2020 09:20:16 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:43793)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYUpS-0002pi-JR
 for qemu-devel@nongnu.org; Tue, 12 May 2020 09:20:15 -0400
Received: by mail-oi1-x242.google.com with SMTP id i22so1565725oik.10
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 06:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/Ng9ofiCVR/pMc737Oysv5QuRpWVXlGZrAJLh6upQdA=;
 b=gkyIMmcizUB3R8TIoSv6KPFUZrkTULqY+nmC9eJIpeC3L2AlCQGsdtuN00N3IL95od
 gadR47Og4oz9FXohxFeKdQpEzs7KORehxq/PyzZWWyjqy9eEQELiTE55+VPNCLbSXTms
 aqMtmTm9nQcmC28e8WBO75l9sgYNm/ezP3g4Ou1HNgoNGbNEZEdtvpv2hrxbJr3oIjPo
 HzM6kKtLgwmnwUnAwl2DgBEbU9FiJj7QHRkWHtnSnF4iBdaE6wLMQft28bwoFya7HuFr
 x1gluW22d7G4DOGmXFWGzNnuUaxxMNBYLTjSnoOwF78baNI+eZe9VSvtk6TCfbu9t1g6
 7l1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/Ng9ofiCVR/pMc737Oysv5QuRpWVXlGZrAJLh6upQdA=;
 b=LiIz8K1UdUIMFZNERIieV2xttN8kh5TRvK5Ks6s0qq4ZALPpDFymfLMHzBmEGp266x
 wR/0IMtJEHHOPKRguJEHOXIS+vvQMGlzdoc+NnN0duwW5rYWoY2IbH3naxBQKtQyMMOz
 3bFp/e7vu2VBwPGUlmc9tXq+yoi1b+nMx7KYHyyKUm8hVanml0ncVZue3mqxpO2GocYR
 rP8QY1YzZFKKwd4+P8zhDYJ/Sihge9IbqPinkrnrEAOU5T1Wz2uDxnQSdHg5lXJrNMz6
 tMKCU7LB9EXe951KBSYKTFBUYoQwHY13B+hSk9vSMBJiV43eKTPHmwks5la7SZxpS1+e
 PT5w==
X-Gm-Message-State: AGi0PuZ4viLj6/5ARDBCs866GWR4XAUq6Bhsq4FKRCeDrz3vnaVq7PZJ
 D3DwSFvn96lBk+VwMY/zSaK534o3P8bwBaOTTw7+ew==
X-Google-Smtp-Source: APiQypK9+nDQjp0uTKD9AjrzQb6HEdUWwDEvsNd330U8Zzwl+FlDgOkHaYF2L0GtfZYZIDMzEYF/Piyug/lVzk/xEq8=
X-Received: by 2002:a54:400c:: with SMTP id x12mr22470007oie.146.1589289612908; 
 Tue, 12 May 2020 06:20:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200508152200.6547-1-richard.henderson@linaro.org>
 <20200508152200.6547-2-richard.henderson@linaro.org>
In-Reply-To: <20200508152200.6547-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 May 2020 14:20:01 +0100
Message-ID: <CAFEAcA_RAOt3z6-FiKtYg2ZXqC8y+H4915Q-0j2KuTKbRZ_YmA@mail.gmail.com>
Subject: Re: [PATCH v3 01/16] target/arm: Create gen_gvec_[us]sra
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 8 May 2020 at 16:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The functions eliminate duplication of the special cases for
> this operation.  They match up with the GVecGen2iFn typedef.
>
> Add out-of-line helpers.  We got away with only having inline
> expanders because the neon vector size is only 16 bytes, and
> we know that the inline expansion will always succeed.
> When we reuse this for SVE, tcg-gvec-op may decide to use an
> out-of-line helper due to longer vector lengths.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

