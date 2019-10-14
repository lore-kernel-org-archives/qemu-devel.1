Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8799C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 15:49:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AF532133F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 15:49:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AF532133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK2bF-0006xc-8B
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 11:49:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33773)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iK2Yd-0005E3-GN
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 11:46:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iK2YZ-00081p-A1
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 11:46:49 -0400
Received: from 9.mo173.mail-out.ovh.net ([46.105.72.44]:42965)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iK2YR-0007up-3h
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 11:46:45 -0400
Received: from player786.ha.ovh.net (unknown [10.109.146.137])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id 6672411C927
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 17:46:34 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player786.ha.ovh.net (Postfix) with ESMTPSA id 2AA7BB07D0FA;
 Mon, 14 Oct 2019 15:46:28 +0000 (UTC)
Date: Mon, 14 Oct 2019 17:46:26 +0200
From: Greg Kurz <groug@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL v2 0/8] 9p patches 2019-10-10
Message-ID: <20191014174626.76dc4e5c@bahia.lan>
In-Reply-To: <CAFEAcA8tdhYm0EuVGx5OiPv7NuZvrtrPLnK+tz=xoJ0Gn4DCmw@mail.gmail.com>
References: <20191010131809.1284004-1-groug@kaod.org>
 <CAFEAcA8tdhYm0EuVGx5OiPv7NuZvrtrPLnK+tz=xoJ0Gn4DCmw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 10977805568754620689
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrjedugdelgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.72.44
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

On Mon, 14 Oct 2019 15:08:52 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Thu, 10 Oct 2019 at 14:18, Greg Kurz <groug@kaod.org> wrote:
> >
> > The following changes since commit 98b2e3c9ab3abfe476a2b02f8f51813edb90e72d:
> >
> >   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2019-10-08 16:08:35 +0100)
> >
> > are available in the Git repository at:
> >
> >   https://github.com/gkurz/qemu.git tags/9p-next-2019-10-10
> >
> > for you to fetch changes up to e410bbc52a7a246858af54ce1842fadf26f39ff7:
> >
> >   MAINTAINERS: Downgrade status of virtio-9p to "Odd Fixes" (2019-10-10 12:36:28 +0200)
> >
> > ----------------------------------------------------------------
> > The most notable change is that we now detect cross-device setups in the
> > host since it may cause inode number collision and mayhem in the guest.
> > A new fsdev property is added for the user to choose the appropriate
> > policy to handle that: either remap all inode numbers or fail I/Os to
> > another host device or just print out a warning (default behaviour).
> >
> > This is also my last PR as _active_ maintainer of 9pfs.
> >
> > ----------------------------------------------------------------
> 
> 
> Applied, thanks.
> 
> Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
> for any user-visible changes.
> 
> Thanks for all your work on the 9pfs code!
> 

Thanks Peter, and many others, for your valuable help.

As now indicated in MAINTAINERS, I'll stay around for odd fixes, one
of which that comes to mind is to deprecate the "proxy" backend and
its companion virtfs-proxy-helper binary at some point since it isn't
supported by libvirt and will be superseded soon by "virtio-fs".

Cheers,

--
Greg

> -- PMM


