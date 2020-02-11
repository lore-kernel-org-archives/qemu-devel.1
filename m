Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A100BC352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 08:42:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AC4C2070A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 08:42:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AC4C2070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1R88-0006pb-JE
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 03:42:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51539)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1j1R7a-0006OF-9i
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 03:42:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1j1R7Z-0003ZK-10
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 03:42:18 -0500
Received: from 15.mo4.mail-out.ovh.net ([91.121.62.11]:44308)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1j1R7Y-0003DP-Qp
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 03:42:16 -0500
Received: from player792.ha.ovh.net (unknown [10.110.208.89])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id 595A42246CA
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 09:42:08 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player792.ha.ovh.net (Postfix) with ESMTPSA id A3AD8F44E51A;
 Tue, 11 Feb 2020 08:42:05 +0000 (UTC)
Date: Tue, 11 Feb 2020 09:42:01 +0100
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PULL 0/6] 9p patches 2020-02-08
Message-ID: <20200211094201.33b35260@bahia.lan>
In-Reply-To: <1679063.kJpWnTDlLf@silver>
References: <20200208104506.2727882-1-groug@kaod.org>
 <CAFEAcA_b0y6qX9LExsuNFEDivZN2y6-zbcrTLhX1djqPiYoA5A@mail.gmail.com>
 <1679063.kJpWnTDlLf@silver>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 7556758703985367360
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedriedvgdduvddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpqhgvmhhurdhorhhgnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejledvrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.121.62.11
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 11 Feb 2020 09:15:41 +0100
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Montag, 10. Februar 2020 18:08:38 CET Peter Maydell wrote:
> > On Sat, 8 Feb 2020 at 10:45, Greg Kurz <groug@kaod.org> wrote:
> > > The following changes since commit 
> 42ccca1bd9456568f996d5646b2001faac96944b:
> > >   Merge remote-tracking branch
> > >   'remotes/berrange/tags/misc-fixes-pull-request' into staging
> > >   (2020-02-07 15:01:23 +0000)> 
> > > are available in the Git repository at:
> > >   https://github.com/gkurz/qemu.git tags/9p-next-2020-02-08
> > > 
> > > for you to fetch changes up to 2822602cbe2be98229b882101dfdb9d3a738c611:
> > >   MAINTAINERS: 9pfs: Add myself as reviewer (2020-02-08 09:29:04 +0100)
> > > 
> > > ----------------------------------------------------------------
> > > 9p patches:
> > > - some more protocol sanity checks
> > > - qtest for readdir
> > > - Christian Schoenebeck now official reviewer
> > > 
> > > ----------------------------------------------------------------
> > 
> > Applied, thanks.
> > 
> > Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
> > for any user-visible changes.
> > 
> > -- PMM
> 
> I.e. msize >= 4096 now being required. AFAICS I cannot update the wiki myself.
> 

I've updated the wiki.

> Best regards,
> Christian Schoenebeck
> 
> 


