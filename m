Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C30C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 11:52:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81F1B21924
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 11:52:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81F1B21924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAuzI-0006V7-LD
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 07:52:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33426)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iAuxm-00055K-Kj
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 07:51:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iAuvf-0006N1-J9
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 07:48:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32970)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iAuvf-0006Mx-EM
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 07:48:55 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9D43C307BCC4;
 Thu, 19 Sep 2019 11:48:54 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-47.ams2.redhat.com
 [10.36.116.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5E3BB19C6A;
 Thu, 19 Sep 2019 11:48:54 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 99BCB17444; Thu, 19 Sep 2019 13:48:53 +0200 (CEST)
Date: Thu, 19 Sep 2019 13:48:53 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190919114853.rz5saa6vzd3amw5c@sirius.home.kraxel.org>
References: <20190919070918.16059-1-kraxel@redhat.com>
 <CAFEAcA9+xzQx0tFuXWzM7CpGFvVEivhZ_d9QMbCaDP2tgmeaOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9+xzQx0tFuXWzM7CpGFvVEivhZ_d9QMbCaDP2tgmeaOg@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Thu, 19 Sep 2019 11:48:54 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 0/4] Ui 20190919 patches
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

On Thu, Sep 19, 2019 at 11:13:30AM +0100, Peter Maydell wrote:
> On Thu, 19 Sep 2019 at 08:11, Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> > The following changes since commit 89ea03a7dc83ca36b670ba7f787802791fcb04b1:
> >
> >   Merge remote-tracking branch 'remotes/huth-gitlab/tags/m68k-pull-2019-09-07' into staging (2019-09-09 09:48:34 +0100)
> >
> > are available in the Git repository at:
> >
> >   git://git.kraxel.org/qemu tags/ui-20190919-pull-request
> >
> > for you to fetch changes up to 6bf21f3d83e95bcc4ba35a7a07cc6655e8b010b0:
> >
> >   vnc: fix memory leak when vnc disconnect (2019-09-17 13:45:10 +0200)
> >
> > ----------------------------------------------------------------
> > ui: add barrier client.
> > ui: bugfixes for vnc & egl.
> >
> > ----------------------------------------------------------------
> >
> > Gerd Hoffmann (2):
> >   ui/egl: fix framebuffer reads
> >   vnc: fix websocket field in events
> >
> > Laurent Vivier (1):
> >   ui: add an embedded Barrier client
> >
> > Li Qiang (1):
> >   vnc: fix memory leak when vnc disconnect
> 
> Dropping this pullreq because Li raised an issue with patch 4.

Discussion here:
 https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg00030.html
  https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg04161.html
   https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg04220.html

Summary: all fine, there is no race.

cheers,
  Gerd


