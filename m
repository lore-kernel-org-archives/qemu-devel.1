Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1CEC388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 14:32:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2A0B2479B
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 14:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oUpnq3WM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2A0B2479B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXmV9-0007Mr-Iy
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 10:32:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60928)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXmSz-00061U-B8
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 10:30:21 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:39931)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXmSx-0008Hh-5F
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 10:30:20 -0400
Received: by mail-ej1-x643.google.com with SMTP id bn26so7494710ejb.6
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 07:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2KjXWGQ8Qccuzl4ZQQ2J2m7nUEdoDGyeSLeZ1+V8b6U=;
 b=oUpnq3WM+KmZ8CbPeLptYatyXOd5+JOs9nUgYr1aEbD8yszUGy0ou2BTIrokyT6v5E
 aS4ZeIsZSEh0VIAkjbOD27j8SVtW66q4LfDFIa96v1sISlIwqgkWNb/5KR7G/7tE1sS4
 A7DKliEq+ookSZHIiX2xp5jz3hK74Hx3zK7dYrUXqW90qFPfHErlba22RSpDow4gaCkz
 +7nkOXZALgUaYSWsrtpAF8KWiLrCARuh2C3uIeUA3BeoofSwi2ouIKTy97xvhhOxWVjI
 O+6rCCbWOk6huNHOT2bdDUILrWSKBhbndWD2FCgh59bFbQpaJfP33xs0tM9oPBHpkup7
 Oubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2KjXWGQ8Qccuzl4ZQQ2J2m7nUEdoDGyeSLeZ1+V8b6U=;
 b=ighQgZjmXq9/A3ZAUsMskTg7/IhK7lcr7dFDkTu8tqZsc7Y0bV+TILCEKLBn2aJjx0
 vydRihFxNoIbSmmbDz0Zdv1wpXD1zmByi7uqAe8/4yir8P3aWXtb5sdBDdP57seqUD2Z
 3AVpQ2sRSf3SroRD15h3GGf/kMVef1gYXLeRtr47u9JwRZQza9XzAMryoT80GBEuY/LR
 qNBKpx4LftaqB1svwB8sEZKNzAjWPpQAPmLm+Qd7sZ8vJMEsNlyDdzPtawVUGqZ4cGdK
 j6VaXXVPJaCPKOlsSeiDDL53Xs5lfuJTIWdoN3gmvDe+A0ryVA15wvIaTZpZkEsQYqU5
 3TRQ==
X-Gm-Message-State: AOAM533IDREXlQt8xMBBME0bbS6KmynpuVM6Op0TTVaj5hzN2HNEZgUt
 2CEzKXy4LKmodsM8c/OlI8oc9Z6k07QzRIcCDssbzQ==
X-Google-Smtp-Source: ABdhPJzuKoqqm4aCkMOLxtx1SN27r9l/HohBAPZ7hiPorjyutym0ayOzvyVrhM+nfrs6yf4VQDBceEAr9KfEA2K6GlY=
X-Received: by 2002:a17:906:7254:: with SMTP id
 n20mr7460881ejk.382.1603895415567; 
 Wed, 28 Oct 2020 07:30:15 -0700 (PDT)
MIME-Version: 1.0
References: <160385090886.20017.13382256442750027666.stgit@gimli.home>
 <20201028094021.GB3701@work-vm>
In-Reply-To: <20201028094021.GB3701@work-vm>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 28 Oct 2020 14:30:04 +0000
Message-ID: <CAFEAcA8CDjcg0J+cfksp7obY6okn1m7ocOWu=DL-v2vZ4A3zjw@mail.gmail.com>
Subject: Re: [PATCH] Revert series: virtiofsd: Announce submounts to the guest
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x643.google.com
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
Cc: Neo Jia <cjia@nvidia.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Kirti Wankhede <kwankhede@nvidia.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 28 Oct 2020 at 09:40, Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
>
> * Alex Williamson (alex.williamson@redhat.com) wrote:
> > This reverts the following commits due to their basis on a bogus
> > linux kernel header update:
> >
> > c93a656f7b65 ("tests/acceptance: Add virtiofs_submounts.py")
> > 45ced7ca2f27 ("tests/acceptance/boot_linux: Accept SSH pubkey")
> > 08dce386e77e ("virtiofsd: Announce sub-mount points")
> > eba8b096c17c ("virtiofsd: Store every lo_inode's parent_dev")
> > ede24b6be798 ("virtiofsd: Add fuse_reply_attr_with_flags()")
> > e2577435d343 ("virtiofsd: Add attr_flags to fuse_entry_param")
> > 2f10415abfc5 ("virtiofsd: Announce FUSE_ATTR_FLAGS")
> > 97d741cc96dd ("linux/fuse.h: Pull in from Linux")
> >
> > Cc: Max Reitz <mreitz@redhat.com>
> > Cc: Stefan Hajnoczi <stefanha@redhat.com>
> > Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>
> Peter: Can you take this directly please

Applied to master, thanks.

-- PMM

