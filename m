Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BF5C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 09:32:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BA9A20731
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 09:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AWo0qaF2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BA9A20731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTj4S-0001y4-9F
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 05:32:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34042)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jTj3H-000130-4N
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 05:30:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jTj3G-0007Sj-AE
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 05:30:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33697
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jTj3F-0007Sc-SP
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 05:30:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588152645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yMN3EEndEJnm147G0ZrXJChXQsQJD92uKUFbscyR0K0=;
 b=AWo0qaF2J2E9GtHb2+V+h7ClDPBDdUMZutJ+tD706MNug2zscfFnUk0uFgi1X5JGFwSIIa
 hdmV+ORCBuumyuiG6rvA8JeYHINkkWBj0ojpO5oqHHe7vkzNo4qT0XPBFFi8nTrvD2jhpZ
 vOi9DgoP4KFS/35ObFYV+IVrlSK7ueY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-DKjDGLk5PC-JBkr4-QQ_eQ-1; Wed, 29 Apr 2020 05:30:41 -0400
X-MC-Unique: DKjDGLk5PC-JBkr4-QQ_eQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 250FD84B8A1;
 Wed, 29 Apr 2020 09:30:39 +0000 (UTC)
Received: from localhost (ovpn-114-2.ams2.redhat.com [10.36.114.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 931D019634;
 Wed, 29 Apr 2020 09:30:31 +0000 (UTC)
Date: Wed, 29 Apr 2020 10:30:30 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RESEND v6 00/36] Initial support for multi-process qemu
Message-ID: <20200429093030.GD122432@stefanha-x1.localdomain>
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
 <20200428172920.GA111124@stefanha-x1.localdomain>
 <20200428134350-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20200428134350-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5gxpn/Q6ypwruk0T"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:42:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, qemu-devel@nongnu.org, kraxel@redhat.com,
 jag.raman@oracle.com, quintela@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, thanos.makatos@nutanix.com, rth@twiddle.net,
 kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--5gxpn/Q6ypwruk0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2020 at 01:47:24PM -0400, Michael S. Tsirkin wrote:
> On Tue, Apr 28, 2020 at 06:29:20PM +0100, Stefan Hajnoczi wrote:
> > On Wed, Apr 22, 2020 at 09:13:35PM -0700, elena.ufimtseva@oracle.com wr=
ote:
> > > We will post separate patchsets for the following improvements for
> > > the experimental Qemu multi-process:
> > >  - Live migration;
> > >  - Asynchronous communication channel;
> > >  - Libvirt support;
> > >=20
> > > We welcome all your ideas, concerns, and questions for this patchset.
> >=20
> > This patch series does two things:
> > 1. It introduces the remote device infrastructure.
> > 2. It creates the remote device program and the associated build change=
s
> >    (makefiles, stubs, etc).
> >=20
> > There are many patches and it's likely that a bunch more revisions will
> > be necessary before this can be merged.
> >=20
> > I want to share an idea to reduce the scope and get patches merged more
> > quickly.  It looks like the series can be reduced to 21 patches using
> > this approach.
> >=20
> > I suggest dropping the remote device program from this patch series (an=
d
> > maybe never bringing it back).  Instead, use the softmmu target for the
> > remote device.
> >=20
> > Why?  Because the remote device program is just a QEMU that uses the
> > remote machine type and has no vCPUs:
> >=20
> >   $ qemu-system-x86_64 -chardev id=3Dchar0,... \
> >                        -M remote,chardev=3Dchar0 \
> > =09=09       -device lsi53c810 \
> > =09=09       -drive if=3Dnone,id=3Ddrive0,file=3Dvm.img,format=3Draw \
> > =09=09       -device scsi-hd,drive=3Ddrive0
> >=20
> > This will use the remote machine type, interrupt controller, and PCI bu=
s
> > that you have created.
> >=20
> > The remote machine type should default to no vCPUs and no memory
> > creation (the memory comes via the mpqemu link communications channel).
> >=20
> > At this point qemu-system-x86_64 contains a lot of code that you don't
> > want in the final remote device program.  Let's ignore that for a
> > second.
> >=20
> > Now you can submit a 21-patch series containing just the remote device
> > infrastructure.  This will be easier to merge.
> >=20
> > Returning to code size, the next step is to reduce the binary.  QEMU ha=
s
> > a Kconfig-style system for optional features and dependencies.  It's a
> > better approach than creating a separate make target because it
> > eliminates the duplication and mess in the makefiles.
> >=20
> > For example, you can disable TCG and KVM so that your binary has no
> > ability to execute guest code.  Currently ./configure disallows this bu=
t
> > I've tried it and it works.
> >=20
> > You can add a new default-configs/ file that disables CONFIG_ISAPC,
> > CONFIG_I440FX, etc.  When you compile QEMU most of hw/ will not be buil=
t
> > anymore.  At this point you have a smaller binary that is still a
> > softmmu target so the makefiles are shared with the regular
> > qemu-system-x86_64.
> >=20
> > There will be some code for which there is no Kconfig option yet.
> > Further improvements can be made by adding Kconfig options for any code
> > that you wish to eliminate.  Instead of writing makefile changes like
> > you did in this patch series you would be adding Kconfig options.  The
> > nice thing is that this work isn't specific to the remote device progra=
m
> > - anyone can use the new Kconfig options to reduce the size of their
> > QEMU.  So not only is it less messy than duplicating the makefiles,
> > but it also benefits everyone.
> >=20
> > The downside to doing this is that it will take a while to eliminate al=
l
> > code that you don't want via Kconfig.  However, your initial patch
> > series can be merged sooner and I think this direction is also cleaner.
> >=20
> > I hope I've explained the idea properly :).  We can continue reviewing
> > the current series if you prefer, but I think it would be quicker to
> > drop the remote device program.
> >=20
> > Stefan
>=20
> Building QEMU twices just to get the remote is however not very
> attractive. So how about making remote a special target?
> Either remote-softmmu/ or if impossible x86_64-remote-softmmu/

Yes, that's a good idea.  It needs to be the full x86_64-remote-softmmu
because hw/ code depends on the QEMU target :(.

To summarize the big advantage of this approach (besides reducing the
patch series): the existing makefile rules for softmmu will be used to
build the remote device program.  No new main() and no new per-object
file makefile rules are needed.

Stefan

--5gxpn/Q6ypwruk0T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6pSTYACgkQnKSrs4Gr
c8j7CAgAuWdwtEkdK5iLwIPIvRpUZoCq/fcFAEyQx4eT53IT2J7IQJhx26+RliXO
4UhZv+l/50d7Wt1MIrIkqv9Htck9peAbzjjsw9Y/0lZP3kmC/XpTnpzOJIfwE1Bk
Jl8c+1zXjWFYg/pLlOiZ01Qifk/ex9JbrcOMNIY9EVNDAsKUxirdPTIVEd2Uy7YZ
LOzAwUWgqnsA9Oe3opq/UR43AHYira3JoxqrJotVDVbRmtrpId5FNUXj9Zx3/KYb
GKl/jqMIRaLOfv/xfLSr68jsbwHpcP0WDuoppOwlcqs+1PMgjlBaZuK1u4lyZfsf
Mb2kvVdTs19r9DjeJJzL5H4416RBTA==
=GLEm
-----END PGP SIGNATURE-----

--5gxpn/Q6ypwruk0T--


