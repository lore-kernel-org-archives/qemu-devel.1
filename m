Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1A2C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 15:27:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C33B21919
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 15:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="K8Gc9jhG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C33B21919
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmIvQ-0001Wj-F8
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 11:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miklos@szeredi.hu>) id 1jmIuq-0000zz-TG
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 11:26:53 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:43343)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <miklos@szeredi.hu>) id 1jmIuo-0002qQ-DW
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 11:26:52 -0400
Received: by mail-ej1-x641.google.com with SMTP id l12so10602328ejn.10
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 08:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szeredi.hu; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ezYfCp7rMSCdCycRYPJgIax1dV1358jvQsgEOQjDekY=;
 b=K8Gc9jhGS0MVQy9vMkRFmG4D4kxf0IcAe5Irm674JuBHGP4yU8ENNr3a/vWVgAwVgA
 t2MiZSTLBSfSy4LqcF3uJz4RmURBBSJFyeFx6POunrbqZteh4w5kvFrQRcIqejK0PRr2
 PAnxLnVgyyEOIqxnSHMKoJfic4mH2l098ARPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ezYfCp7rMSCdCycRYPJgIax1dV1358jvQsgEOQjDekY=;
 b=iryb+NofaNTdw1+WaYZQs10YmKDXXiHwUzr1EqYX2+hfKvGZnVNOLlYGSSzeW7w12U
 AcDyF49A4HVt21lwbOdxa7jn7hb24+TG7395gEtnM0jLkJg9Kpw38uAEQZZubQb1GFHp
 GSu1Abpeg5JP/e1BRtwzgVdGw8CzoIQCexyKKiL/pZ/T2y04DUM4FdLlovZ2uiNBbTj+
 U8rNjpHKRTDqYfI1eUcoMKSa2LnaX9IR7iTkwR3NxXBcB0DieOZNBDpHr/dIY1zS+7ml
 m5wB3+eNiZQbnuDOXY4OkV1lrtfiXfkW2MK9H8U/gfxwcaClYxsyRTph+kfU245YrBAm
 LWqw==
X-Gm-Message-State: AOAM530Hf/+C7r6S9kiaO/4kTa9H9qmuB7Ff07dWZpfYfGqeD8eyiUHZ
 zm8ByuASZoXAP60aOwAJdQyIR+57OiBLzKCwL8ky3w==
X-Google-Smtp-Source: ABdhPJwSr+ON7KFyhmMJKrWr+mQiADgNGFkNWRk3MMcm0kurFYNtDYiR9EKq3iVZEpW1s1w90th9vtX23QXMHnaB8GY=
X-Received: by 2002:a17:906:a402:: with SMTP id
 l2mr4364363ejz.14.1592580408038; 
 Fri, 19 Jun 2020 08:26:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200416164907.244868-1-stefanha@redhat.com>
 <20200618190816.GD3814@redhat.com>
 <CAJfpegsfqADmK6foDyuQQnvMDh_jE0rNUCBRuxPchSSirrb04Q@mail.gmail.com>
 <20200619142508.GB3154@redhat.com>
In-Reply-To: <20200619142508.GB3154@redhat.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 19 Jun 2020 17:26:37 +0200
Message-ID: <CAJfpeguhS3w-AZTpyzO2QqcX_7F1qDm__5C8r3pBnCgPoxTKmQ@mail.gmail.com>
Subject: Re: [Virtio-fs] [PATCH 0/2] virtiofsd: drop Linux capabilities(7)
To: Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=miklos@szeredi.hu; helo=mail-ej1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: virtio-fs-list <virtio-fs@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 19, 2020 at 4:25 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Fri, Jun 19, 2020 at 04:16:30PM +0200, Miklos Szeredi wrote:
> > On Thu, Jun 18, 2020 at 9:08 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > >
> > > On Thu, Apr 16, 2020 at 05:49:05PM +0100, Stefan Hajnoczi wrote:
> > > > virtiofsd doesn't need of all Linux capabilities(7) available to root.  Keep a
> > > > whitelisted set of capabilities that we require.  This improves security in
> > > > case virtiofsd is compromised by making it hard for an attacker to gain further
> > > > access to the system.
> > >
> > > Hi Stefan,
> > >
> > > I just noticed that this patch set breaks overlayfs on top of virtiofs.
> >
> > How so?  Virtiofs isn't mounting overlayfs, is it?  Only the mounter
> > requires CAP_SYS_ADMIN, not the accessor.
>
> virtiofsd needs CAP_SYS_ADMIN, otherwise fsetxattr(trusted.overlay.opaque)
> fails in lo_setxattr().
>
> This is triggered when we mount overlayfs on top of virtiofs and overlayfs
> tries to set OVL_XATTR_OPAQUE on upper to check if trusted xattrs are
> supported or not.

Ah, right.

Plan is to use "user.*" xattr for unprivileged overlay.  This would be
a good way to eliminate this attack surface in the overlay on virtiofs
case as well.

Other ways to minimize risk is to separate operations requiring
CAP_SYS_ADMIN into a separate process, preferably a separate
executable, that communicates with virtiofsd using a pipe and contains
the minimum amount of code.

Thanks,
Miklos

