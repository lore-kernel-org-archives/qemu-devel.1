Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450DEC5B57D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 09:47:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B64F21850
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 09:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WBcvXRIm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B64F21850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjKop-000846-RC
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 05:47:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44935)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hjKoI-0007Zy-1c
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 05:47:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hjKoG-0006mf-Of
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 05:47:17 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:45554)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hjKoG-0006lA-DR
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 05:47:16 -0400
Received: by mail-ot1-x342.google.com with SMTP id x21so8457227otq.12
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 02:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xyit1HMBTMuI9ohOMfFE5nLsQhAK5F5C0ylNMav3By0=;
 b=WBcvXRImnEYUyOOmQ5TOqneKWSFRSzXyeoGJNoM1FJbUMoW0KPVjb9LMZeD5uNak1K
 d1wi7gcODBQUSxWk85jKKTVt/NGOuRaK5qN2035KxK4lNglJQim6olGKhLSeYhgnx0dp
 FbP8HFjaLkD/UFPmiJRC371X0TOHhBK3E8sNV/nw5+zUT+QZ9G6yf6VVlnv5EXxmD2fR
 Di7hB/t1NnecNArk2MofHsukrp7n2JU2rhj45nUlENjHUv2scVaAuX05lu6plffZA1TB
 xAlHyDIp55h53zvbVSwo/HlPzQQGZHUKJflKY+0121r/qS+98mTGJ2aFPOsOpGgYG2zv
 agWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xyit1HMBTMuI9ohOMfFE5nLsQhAK5F5C0ylNMav3By0=;
 b=jZtL6lmrxZYN5iS6aDj6HjRBl6HK6JI2AyfiEdaADsVwm1ChKqEaeXoxeK2VikECdQ
 2jTDw+RxB7wctY2Cc5bOpHfq2/Jc2X0ZGsKTo0hi0N4vQM5V7qB88FQ6L+6Fdpg4sRUq
 Aj6oC28WfwCqPu6J/ARRIH3/oOGEw+6yQFvL1WrJbbdQD28k3EnOHHQt/y/lTVUnIHl+
 VCbOE/3LyxJks7cJx3k8Uggds2BJP6C94GcxC/+D9dh3uo3fbw8NMEmBs3JmnavGXqWo
 eBhC2rTNupDQUGlO8fsx4YE9Z6JSH+h7IBRz3dvprRxvSrLvp610blvutDn+9F6t1Pek
 ssJA==
X-Gm-Message-State: APjAAAUkJ1aky790kP7I9AsOTsVSxM90iauxJP7vUVBeEXW+8W3b3FwD
 Cl60chc/CZEW92zSnRfoya9XTcvtJ3QF+ZRy5HJsDw==
X-Google-Smtp-Source: APXvYqygyjg+bEq7XOS1z9g0W3Q3UIihcGkqy0jevf3urvgbKlcnbgwfuvdQrAUlJ+mEtTc1ZGjZ+WJ/rl+705q1UmA=
X-Received: by 2002:a9d:7245:: with SMTP id a5mr656891otk.232.1562320035251;
 Fri, 05 Jul 2019 02:47:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190702150606.24851-1-mst@redhat.com>
 <CAFEAcA8ZAHK4bMMUqNU++9h3AN3arOLMcZgUStd5OP_JCEzObQ@mail.gmail.com>
 <20190704172822-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190704172822-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Jul 2019 10:47:04 +0100
Message-ID: <CAFEAcA-8YS6=EK4tKdDv=rz00HGgOJ2bryT4WU7yOGHT8seAtQ@mail.gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PULL 00/22] virtio, pc, pci: features, fixes,
 cleanups
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

On Thu, 4 Jul 2019 at 22:29, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Jul 04, 2019 at 10:25:48AM +0100, Peter Maydell wrote:
> > On Tue, 2 Jul 2019 at 16:06, Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > The following changes since commit 7fec76a02267598a4e437ddfdaeaeb6de09b92f3:
> > >
> > >   Merge remote-tracking branch 'remotes/maxreitz/tags/pull-block-2019-06-24' into staging (2019-07-01 11:28:28 +0100)
> > >
> > > are available in the Git repository at:
> > >
> > >   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> > >
> > > for you to fetch changes up to a360cd11de5ae59db55e128fd209290c777eb177:
> > >
> > >   docs: avoid vhost-user-net specifics in multiqueue section (2019-07-01 10:39:35 -0400)
> > >
> > > ----------------------------------------------------------------
> > > virtio, pc, pci: features, fixes, cleanups
> > >
> > > virtio-pmem support.
> > > libvhost user mq support.
> > > A bunch of fixes all over the place.
> > >
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > >
> >
> > This fails to build on all the non-Linux platforms:
> >
> > In file included from
> > /Users/pm215/src/qemu-for-merges/hw/virtio/virtio-pmem.c:21:
> > /Users/pm215/src/qemu-for-merges/include/standard-headers/linux/virtio_pmem.h:13:10:
> > fatal error: 'linux/types.h' file not found
> > #include <linux/types.h>
> >          ^~~~~~~~~~~~~~~
> >
> > thanks
> > -- PMM
>
> Amended and re-pushed. Pls try again, sorry about that.
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

