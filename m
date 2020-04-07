Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C91C2BA80
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 18:57:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2FE920730
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 18:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="r8ghE5LY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2FE920730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLtPA-0003jh-SJ
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 14:57:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43839)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rvkagan@yandex-team.ru>) id 1jLtOX-0003HF-3x
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 14:56:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rvkagan@yandex-team.ru>) id 1jLtOT-0000z7-Ll
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 14:56:18 -0400
Received: from forwardcorp1p.mail.yandex.net
 ([2a02:6b8:0:1472:2741:0:8b6:217]:37296)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <rvkagan@yandex-team.ru>)
 id 1jLtOS-0000sP-VY
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 14:56:17 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net
 [IPv6:2a02:6b8:0:1a2d::301])
 by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id AD0772E1626;
 Tue,  7 Apr 2020 21:56:11 +0300 (MSK)
Received: from iva4-7c3d9abce76c.qloud-c.yandex.net
 (iva4-7c3d9abce76c.qloud-c.yandex.net [2a02:6b8:c0c:4e8e:0:640:7c3d:9abc])
 by mxbackcorp1o.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 W3gNjfrmvP-uAXCsAoH; Tue, 07 Apr 2020 21:56:11 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1586285771; bh=Cf/eKvQBF69DieKVYZK4q4t4bli6eNxGN7gYpJCl67M=;
 h=In-Reply-To:Message-ID:Subject:To:From:References:Date:Cc;
 b=r8ghE5LYFqMIUHNZJXhVtUdI9w+Exay+CKbqAMNkRRm7ymnKlIS+YARAqd47SG7X9
 64P1Lg1ymZLp2m6i1FdH7ISTumHNY9j3woouJBlOkwsOSbMPLSvT9cJ14IcQTv+6Bg
 izo/y6vBJZ/9ZcFG/LfGfmdQZBqGRKwrlizPDJXE=
Authentication-Results: mxbackcorp1o.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from unknown (unknown [2a02:6b8:b080:9318::1:d])
 by iva4-7c3d9abce76c.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 w78Nkkr9rq-uAXmTXN0; Tue, 07 Apr 2020 21:56:10 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
Date: Tue, 7 Apr 2020 21:56:08 +0300
From: Roman Kagan <rvkagan@yandex-team.ru>
To: Jon Doron <arilou@gmail.com>
Subject: Re: [PATCH v1 5/5] i386: Hyper-V VMBus ACPI DSDT entry
Message-ID: <20200407185608.GA178651@rvkaganb>
Mail-Followup-To: Roman Kagan <rvkagan@yandex-team.ru>,
 Jon Doron <arilou@gmail.com>,
 "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 QEMU <qemu-devel@nongnu.org>,
 Evgeny Yakovlev <eyakovlev@virtuozzo.com>, ehabkost@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>,
 Liran Alon <liran.alon@oracle.com>,
 Roman Kagan <rkagan@virtuozzo.com>
References: <20200403142308.82990-1-arilou@gmail.com>
 <20200403142308.82990-6-arilou@gmail.com>
 <76017793-735b-4bb5-0e69-ecded78af54d@maciej.szmigiero.name>
 <CAP7QCog_EmLJ=O8Xi9Tc4Jst1=z62DXim9ScCyoPv7WugrSyOw@mail.gmail.com>
 <CAP7QCogMdUis-=KsC--0ar2Zt2Vwcpn4HS+qCxPn5khtDTu+mA@mail.gmail.com>
 <9b9c42d3-af9e-25e9-210e-c58ee5975941@maciej.szmigiero.name>
 <472544e7-498a-4e28-06e9-83c102d6436b@maciej.szmigiero.name>
 <20200406073246.GA7707@rvkaganb>
 <CAP7QCojPsOYjw94k3rkH0A3rLFADLeVhgy502N=8X5wrUnoC6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP7QCojPsOYjw94k3rkH0A3rLFADLeVhgy502N=8X5wrUnoC6Q@mail.gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a02:6b8:0:1472:2741:0:8b6:217
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
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Evgeny Yakovlev <eyakovlev@virtuozzo.com>, ehabkost@redhat.com,
 QEMU <qemu-devel@nongnu.org>, Liran Alon <liran.alon@oracle.com>,
 Roman Kagan <rkagan@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Apr 06, 2020 at 11:20:39AM +0300, Jon Doron wrote:
> Well I want it to be merged in :-)

Hmm I'm curious why, it has little to offer over virtio.

Anyway the series you've posted seems to be based on a fairly old
version.

The one in openvz repo is more recent.  It's still in need for
improvement, too, but should be testable at least.

Thanks,
Roman.

> On Mon, Apr 6, 2020, 10:32 Roman Kagan <rvkagan@yandex-team.ru> wrote:
> 
> > On Fri, Apr 03, 2020 at 11:00:27PM +0200, Maciej S. Szmigiero wrote:
> > > It seems to me that Roman might not be getting our e-mails since his
> > > new e-mail address seems to be "rvkagan@yandex-team.ru".
> >
> > Indeed.  I'm subscribed with my new address to qemu-devel ML but must
> > have missed this series.
> >
> > > @Roman, are you with us?
> >
> > Yes ;)
> >
> > So what are your plans regarding this patchset?
> >
> > Thanks,
> > Roman.
> >
> > > On 03.04.2020 19:18, Maciej S. Szmigiero wrote:
> > > > Hi Jon,
> > > >
> > > > The patches are available here:
> > > > https://github.com/maciejsszmigiero/qemu.git in "vmbus-patches"
> > branch.
> > > >
> > > > Please note that these patches don't have Roman's "Signed-off-by:"
> > tags,
> > > > so I haven't applied mine, either.
> > > >
> > > > If you are able to establish a proper SoB chain then please also add:
> > > > "Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>".
> > > >
> > > > Thanks for the effort,
> > > > Maciej
> > > >
> > > > On 03.04.2020 17:30, Jon Doron wrote:
> > > >>  Thank you Maciej it seems like your version is really ahead I'll do
> > > >> the required work and merge it so i can submit a v2 with the latest
> > > >> patchset from Roman
> > > >>
> > > >> On Fri, Apr 3, 2020 at 6:06 PM Jon Doron <arilou@gmail.com> wrote:
> > > >>>
> > > >>> Thank you Maciej, I based it on top of what Denis (den@openvz.org)
> > gave me
> > > >>> which was this:
> > > >>>
> > https://ftp.openvz.org/virtuozzo/releases/openvz-7.0.12-288/source/SRPMS/q/qemu-kvm-vz-2.12.0-33.vz7.14.4.src.rpm
> > > >>>
> > > >>> Do you think you have a more recent version I dont mind diffing and
> > > >>> resubmitting a new version of the patchset?
> > > >>>
> > > >>> Thanks,
> > > >>> -- Jon.
> > > >>>
> > > >>> On Fri, Apr 3, 2020 at 5:56 PM Maciej S. Szmigiero
> > > >>> <mail@maciej.szmigiero.name> wrote:
> > > >>>>
> > > >>>> Hi Jon,
> > > >>>>
> > > >>>> On 03.04.2020 16:23, Jon Doron wrote:
> > > >>>>> Guest OS uses ACPI to discover vmbus presence.  Add a corresponding
> > > >>>>> entry to DSDT in case vmbus has been enabled.
> > > >>>>>
> > > >>>>> Experimentally Windows guests were found to require this entry to
> > > >>>>> include two IRQ resources, so this patch adds two semi-arbitrarily
> > > >>>>> chosen ones (7 and 13).  This results, in particular, in parallel
> > port
> > > >>>>> conflicting with vmbus.
> > > >>>>>
> > > >>>>> TODO: discover and use spare IRQs to avoid conflicts.
> > > >>>>>
> > > >>>>> Signed-off-by: Evgeny Yakovlev <eyakovlev@virtuozzo.com>
> > > >>>>> Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
> > > >>>>> Signed-off-by: Jon Doron <arilou@gmail.com>
> > > >>>>
> > > >>>> Nice work, thanks!
> > > >>>>
> > > >>>> However, it seems to be based on the code version that was posted in
> > > >>>> February 2018, and not the latest version in OpenVZ qemu repository
> > > >>>> dated October 2019:
> > > >>>>
> > https://src.openvz.org/projects/UP/repos/qemu/commits?until=refs%2Fheads%2Fvmbus
> > > >>>>
> > > >>>> This newer version has slightly different API here and there.
> > > >>>> Any particular reason for selecting that older version for porting?
> > > >>>>
> > > >>>> I have actually rebased this latest version on the top of the
> > current
> > > >>>> QEMU master, and it basically seems to work fine.
> > > >>>> However, I haven't done extensive tests whether there isn't a
> > memory leak
> > > >>>> somewhere or so on.
> > > >>>>
> > > >>>> Maciej
> > > >
> > >
> >

