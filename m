Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522E4C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 16:44:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 083A42072A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 16:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qc7v6BpC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 083A42072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAG51-0001jj-7L
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 11:44:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54441)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jAG47-00013T-Dq
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 11:43:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jAG45-0007q3-Pm
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 11:43:10 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26935
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jAG45-0007nh-HM
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 11:43:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583512988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fDODrePrkT9nqUWcNW4xVEQs8r2GEs5sWXvCHbj4BJM=;
 b=Qc7v6BpCqjfQj6FbJl6J3Xf68D33EweomTf8jzDtMrXRuSS/6iKAbyX6bLxmQ9K0PQyLYI
 9BTceKlWYzYHKwDDV+99eQiICPspoJYCk0MpAyPol2nsvDX344sroWHWpoJdelAY76tLtq
 VxgkI35z1QT2Sn63MddqU0bSK4jyoek=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-xhJytotcMcGC4FUk6RKIpw-1; Fri, 06 Mar 2020 11:43:05 -0500
X-MC-Unique: xhJytotcMcGC4FUk6RKIpw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B66E818A5507;
 Fri,  6 Mar 2020 16:43:02 +0000 (UTC)
Received: from localhost (unknown [10.36.118.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 97FF491D8A;
 Fri,  6 Mar 2020 16:42:49 +0000 (UTC)
Date: Fri, 6 Mar 2020 16:42:48 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: Re: [PATCH v5 50/50] multi-process: add configure and usage
 information
Message-ID: <20200306164248.GC1438162@stefanha-x1.localdomain>
References: <cover.1582576372.git.jag.raman@oracle.com>
 <bbba8cdef9f876ec6d194f3e1974347860eca732.1582576372.git.jag.raman@oracle.com>
 <20200227165804.GE315098@stefanha-x1.localdomain>
 <20200228184343.GB25838@flaka>
MIME-Version: 1.0
In-Reply-To: <20200228184343.GB25838@flaka>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="uh9ZiVrAOUUm9fzH"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: fam@euphon.net, john.g.johnson@oracle.com, swapnil.ingle@nutanix.com,
 mst@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com,
 Jagannathan Raman <jag.raman@oracle.com>, quintela@redhat.com,
 armbru@redhat.com, kanth.ghatraju@oracle.com, felipe@nutanix.com,
 thuth@redhat.com, ehabkost@redhat.com, konrad.wilk@oracle.com,
 dgilbert@redhat.com, liran.alon@oracle.com, thanos.makatos@nutanix.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--uh9ZiVrAOUUm9fzH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2020 at 10:43:44AM -0800, Elena Ufimtseva wrote:
> On Thu, Feb 27, 2020 at 04:58:04PM +0000, Stefan Hajnoczi wrote:
> > On Mon, Feb 24, 2020 at 03:55:41PM -0500, Jagannathan Raman wrote:
> > > +* The devices to be emulated in the separate process are defined as
> > > +  before with addition of "rid" suboption that serves as a remote gr=
oup
> > > +  identificator.
> > > +
> > > +  -device <device options>,rid=3D"remote process id"
> > > +
> > > +  For example, for non multi-process qemu:
> > > +    -device lsi53c895a,id=3Dscsi0 device
> > > +    -device scsi-hd,drive=3Ddrive0,bus=3Dscsi0.0,scsi-id=3D0
> > > +    -drive id=3Ddrive0,file=3Ddata-disk.img
> > > +
> > > +  and for multi-process qemu and no libvirt
> > > +  support (i.e. QEMU forks child processes):
> > > +    -device lsi53c895a,id=3Dscsi0,rid=3D0
> > > +    -device scsi-hd,drive=3Ddrive0,bus=3Dscsi0.0,scsi-id=3D0,rid=3D0
> >=20
> > This approach is invasive:
> >  * lsi53c895a should not need to be modified with a new rid=3D option.
> >  * QEMU should not know about the scsi-hd device or drive0.  Only the
> >    device emulation process needs to know about scsi-hd.
> >=20
> > In order to cleanly separate QEMU and the device emulation process
> > syntax like this is needed:
> >=20
> >   -object remote-device,id=3Drid0,...
> >   -device remote-pci-device,id=3Dscsi0,remote-device=3Drid0
> >=20
> > The "remote-device" object could be part of remote-pci-device, but
> > keeping it separate may be useful in the future in order to support
> > things like reconnection.
> >=20
> > The generic "remote-pci-device" device handles any remote PCI device,
> > not just the LSI SCSI controller.
> >=20
> > Do you agree with this approach?
> >=20
>=20
> We discussed these changes and they seem to be along the lines with
> the future work on vfio over socket approach we will be working on later.
>=20
> Could we for this experimental version have the changes you propose here
> with one modification - instead of having generic remote-pci-device imply=
 that that is LSI
> device? And while we work towards vfio over socket this will become any r=
emote
> PCI device?

Yes, that sounds good.

> > > +  The drives to be emulated by the remote process are specified as p=
art of
> > > +  this command sub-option. The device to be used to connect to the m=
onitor
> > > +  is also specified as part of this suboption.
> > > +
> > > +  For example, the following option adds a drive and monitor to the =
remote
> > > +  process:
> > > +  -remote rid=3D0,exec=3D"qemu-scsi-dev",command=3D"-drive id=3Ddriv=
e0,,file=3Ddata-disk.img -monitor unix:/home/qmp-sock,,server,,nowait"
> > > +
> > > +  Note: There's an issue with this "command" sub-option which we are=
 in the
> > > +  process of fixing. To work around this issue, it requires addition=
al
> > > +  "comma" characters as illustrated above, and in the example below.
> >=20
> > command=3D (which could be called args=3D for clarity) will be difficul=
t to
> > use not just because of comma escaping but also because of double-quote
> > escaping.  How do you pass a command-line argument that contains spaces=
?
>=20
> Yes, this is not great. And spaces are the problem at the moment.
> I am looking if the -object has some properties that can allow for arbitr=
ary
> strings. Maybe such as data for "secret" object  would do?

I'm not aware of a way to avoid the comma escaping.  The space escaping
is a question of how the remote process is spawned.  If the command-line
is processed by a shell like with system(3) then backslash can be used
to escape spaces.

Stefan

--uh9ZiVrAOUUm9fzH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5ifYgACgkQnKSrs4Gr
c8hCBAf/d7+5+qufheB2wuJIIeVxgTuVIqGMEtNesBk/225W0XXSF+dA3X9tmhLX
QvT5JTzAHgfFQyqJsFwPo3ydMlIzb1ilWLwVvhyJ5y/0tJmQbdnmRM6AoM2LaN2N
iAqHpKhmcqdKZoGGnyBpQheugJF+pN1lIx4Z3IWxAvLH40fam1TdsJ5rE9P/jRs3
sxH5VBlLzGNlxT6N5rk+NL9e8/9X5NizGGEjIDNg6tE6Hn6tJ/GrOndZt1sqQYbu
DsYeZTfjQfCVUgvzszDY+2llTyykzhpSE7hZCIOTMDyghrSHZKHZ5DnmVNuPO4U5
/APVtJtXl+Dx3T6ed2n0C+hGk52o1w==
=FEeU
-----END PGP SIGNATURE-----

--uh9ZiVrAOUUm9fzH--


