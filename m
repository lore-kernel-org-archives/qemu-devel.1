Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E156DC433E5
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 14:56:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF85C2245A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 14:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vv2ejH4I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF85C2245A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvMLl-0008W7-Vd
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 10:56:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jvMLB-00085N-5j
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 10:55:29 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:37241)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jvML9-00056K-76
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 10:55:28 -0400
Received: by mail-ot1-x344.google.com with SMTP id w17so13253023otl.4
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 07:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XKZChAnIt0R8bhArHGhZ2dZkaprsODCYp7nm3Zoyp6k=;
 b=Vv2ejH4IoAIK4I2nSHe0oEc1qvQDJBvnaYR0H81CURqDFbNE7Tofz6EwA08PckTp/F
 WxkbYQwfVyQax6i+P0SS7UksNTtZ+YoLffPpL9LftcG44u5a3N971ZM65VUT7oALT804
 szDMN/K2gz6b6Lu/nzTJBGTfj5R/GJ2W6CQefuUhGhVc3hJJY67F/UGKbT5+3A7kKk61
 Knwv8f549lpqPkuMwBlFLpTOGD1fvGMz4uBhuJi8jiB5FfGmlda6KVW2SJACui/EesH7
 RH5R2UPRcgj2olENJd1jbX1lEMYZNIiuVw0fmzzatWkm+p0+fG+WKad2veb4CHbBtfq4
 X5Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XKZChAnIt0R8bhArHGhZ2dZkaprsODCYp7nm3Zoyp6k=;
 b=aPNAFOnYVO7t0hhB996VbzPvVNWSklPwj/Il7b66LSbOSOUsTEJaguWkjRoslVo/fN
 u+RvAb3uvaDW7ZbgO6rPjhPOBBPrMdDstAHUffliUKXhJb1cueiUuYmeaDkpiti3Rm4p
 ZHyS0kdIb9Oruuja/T2QdD+4HnEOGgBGD+rq7QPemBgm1Smw9E/WxsAMFM5DUUBInqNh
 mdcC6v8xYh28v7efMq8fg/PrcFmXbdE/b8VbJ3Nc30IgDhkK3NQc3S7Ipc6Q+CB6ZXQA
 6XhP6EP1cll3UsBiooA9m+n35MM7AP5qXOB+ukRs1O2DFsKDicogssKsz4tfS4rOhoJE
 jYDQ==
X-Gm-Message-State: AOAM532EN2y9Lr7uuOBsYT8xyZe7eTrOKil1io7rCAnS6CIZ5Kk3/IuK
 K+Blkh4iF66Zddts0RrX4LGqtsoy2QDQIkyXdL6FTA==
X-Google-Smtp-Source: ABdhPJwCtnNwmv+usa7Ai8V8HNtOI+PrixMc9WArleIvgiqNRKACn2Q0LtbCQOLnqE2u+evtqFkUCm1Z20bbJ50l/hY=
X-Received: by 2002:a05:6830:1bd3:: with SMTP id
 v19mr4394492ota.91.1594738525454; 
 Tue, 14 Jul 2020 07:55:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200713141104.5139-1-peter.maydell@linaro.org>
 <CAFEAcA-ULj8BGkm6k2f9ye-ovg9FCKrHg6BRMuKf+F7O3sJtFQ@mail.gmail.com>
 <DM5PR11MB183361CB8C55AA9E1057402D8D610@DM5PR11MB1833.namprd11.prod.outlook.com>
In-Reply-To: <DM5PR11MB183361CB8C55AA9E1057402D8D610@DM5PR11MB1833.namprd11.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Jul 2020 15:55:14 +0100
Message-ID: <CAFEAcA_4ipxWBYcF59bNSecL6nHhGF5ezCLAn_9sh-gxFLm3dA@mail.gmail.com>
Subject: Re: [PULL 00/25] target-arm queue
To: "Wu, Wentong" <wentong.wu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 14 Jul 2020 at 15:52, Wu, Wentong <wentong.wu@intel.com> wrote:
>
> > On Mon, 13 Jul 2020 at 15:11, Peter Maydell <peter.maydell@linaro.org> wrote:
> > > ----------------------------------------------------------------
> > > target-arm queue:
> > >  * hw/arm/bcm2836: Remove unused 'cpu_type' field
> > >  * target/arm: Fix mtedesc for do_mem_zpz
> > >  * Add the ability to change the FEC PHY MDIO device number on i.MX25/i.MX6/i.MX7
> > >  * target/arm: Don't do raw writes for PMINTENCLR
> > >  * virtio-iommu: Fix coverity issue in virtio_iommu_handle_command()
> > >  * build: Fix various issues with building on Haiku
> > >  * target/nios2: fix wrctl behaviour when using icount
> > >  * hw/arm/tosa: Encapsulate misc GPIO handling in a device
> > >  * hw/arm/palm.c: Encapsulate misc GPIO handling in a device
> > >  * hw/arm/aspeed: Do not create and attach empty SD cards by default
> >
> >
> > Applied, thanks.
> >
> > Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
> > for any user-visible changes.
>
> Who will be responsible updating the changelog? Patch author or
> the person who has the special access for that wiki page?

Usually it's the person who sends the pullrequest (me in this case),
unless they specifically ask a patch author to write some changelog
text. In this case I didn't think anything in this set of patches
needed a changelog entry except for the empty-SD-card change.
If you think there's some text worth adding I can add it for you.

The changelog wiki page, incidentally, can be edited by anybody
with a wiki account. We don't have an automatic account-creation
process because it was heavily hit by spammers, but anybody with
an existing wiki account can create one for developers who want one.

thanks
-- PMM

