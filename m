Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1165BC31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 19:19:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7B7320B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 19:19:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7B7320B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34462 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb8mE-0006Jo-IH
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 15:19:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36764)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kraxel@redhat.com>) id 1hb8lS-0005ng-Qv
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 15:18:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1hb8lR-0000Qg-PM
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 15:18:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42088)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>)
 id 1hb8lP-0000OL-6J; Wed, 12 Jun 2019 15:18:27 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 42DA0308FC4A;
 Wed, 12 Jun 2019 19:18:21 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-33.ams2.redhat.com
 [10.36.116.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BC866183CD;
 Wed, 12 Jun 2019 19:18:18 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id ED3BE16E05; Wed, 12 Jun 2019 21:18:17 +0200 (CEST)
Date: Wed, 12 Jun 2019 21:18:17 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Sam Eiderman <shmuel.eiderman@oracle.com>
Message-ID: <20190612191817.5bilt2abif2xvcbv@sirius.home.kraxel.org>
References: <20190612115939.23825-1-shmuel.eiderman@oracle.com>
 <20190612130650.xftda65kgnsefyvs@sirius.home.kraxel.org>
 <A3F8BD49-3C35-4A07-8DE2-85F7CC293DC9@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <A3F8BD49-3C35-4A07-8DE2-85F7CC293DC9@oracle.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Wed, 12 Jun 2019 19:18:26 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [QEMU] [PATCH v2 0/8] Add Qemu to SeaBIOS LCHS
 interface
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, arbel.moshe@oracle.com,
 seabios@seabios.org, QEMU <qemu-devel@nongnu.org>, mreitz@redhat.com,
 kevin@koconnor.net, liran.alon@oracle.com, karl.heubaum@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 12, 2019 at 04:30:03PM +0300, Sam Eiderman wrote:
>=20
>=20
> > On 12 Jun 2019, at 16:06, Gerd Hoffmann <kraxel@redhat.com> wrote:
> >=20
> > On Wed, Jun 12, 2019 at 02:59:31PM +0300, Sam Eiderman wrote:
> >> v1:
> >>=20
> >> Non-standard logical geometries break under QEMU.
> >>=20
> >> A virtual disk which contains an operating system which depends on
> >> logical geometries (consistent values being reported from BIOS INT13
> >> AH=3D08) will most likely break under QEMU/SeaBIOS if it has non-sta=
ndard
> >> logical geometries - for example 56 SPT (sectors per track).
> >> No matter what QEMU will guess - SeaBIOS, for large enough disks - w=
ill
> >> use LBA translation, which will report 63 SPT instead.
> >=20
> > --verbose please.
> >=20
> > As far I know seabios switches to LBA mode when the disk is simply to=
o
> > big for LCHS addressing.  So I fail to see which problem is solved by
> > this.  If your guest needs LCHS, why do you assign a disk which can't
> > be fully accessed using LCHS addressing?
>=20
> The scenario is as follows:
>=20
> A user has a disk with 56 spts.
> This disk has been already created under a bios that reported 56 spts.
> When migrating this disk to QEMU/SeaBIOS, SeaBIOS will report 63 spts
> (under LBA translation) - this will break the boot for this guest.

You sayed so already.  I was looking for a real world example.  Guests
which can't deal with LBA should be pretty rare these days.  What kind
of guest?  What other bios?  Or is this a purely theoretical issue?

> >> In addition we can not enforce SeaBIOS to rely on phyiscal geometrie=
s at
> >> all. A virtio-blk-pci virtual disk with 255 phyiscal heads can not
> >> report more than 16 physical heads when moved to an IDE controller, =
the
> >> ATA spec allows a maximum of 16 heads - this is an artifact of
> >> virtualization.
> >=20
> > Well, not really.  Moving disks from one controller to another when t=
he
> > OS depends on LHCS addressing never is a good idea.  That already cau=
sed
> > problems in the 90-ies, when moving scsi disks from one scsi host
> > adapter to another type, *way* before virtualization became a thing.
>=20
> I agree, but this is easily solvable in virtualized environments where =
the
> hypervisor can guess the correct LCHS values by inspecting the MBR,

Yes.  This is exactly what the more clever scsi host adapter int13 rom
implementations ended up doing too.  Look at MBR to figure which LCHS
they should use.

> or letting the user set these values manually.

Why?  Asking the user to deal with the mess is pretty lame if there are
better options.  And IMO doing this fully automatic in seabios is
better.

> > BTW:  One possible way to figure which LCHS layout a disk uses is to
> > check the MBR partition table.  With that we (a) don't need a new
> > interface between qemu and seabios and (b) it is not needed to manual=
ly
> > specify the geometry.
>=20
> In my opinion SeaBIOS is not the correct place for this change since
> =E2=80=9Cenhancing=E2=80=9D the detection of LCHS values in SeaBIOS may=
 cause it to
> suddenly report different values for already existing guests which rely=
 on
> LCHS - thus, breaking compatibility.

I can't see how this can break guests.  It should either have no effect
(guests using LBA) or unbreak guests due to LCHS changing from "wrong"
to "correct".

cheers,
  Gerd


