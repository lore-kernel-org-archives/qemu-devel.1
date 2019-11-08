Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8435C5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 11:15:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72D1B2084D
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 11:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WPl/ttCg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72D1B2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT2Ek-0006CJ-KR
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 06:15:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59089)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iT2Di-0005h2-Th
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 06:14:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iT2Dg-0003sr-UB
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 06:14:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29098
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iT2Dg-0003sP-Mn
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 06:14:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573211663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cBVvaalvagrd3rW5K/eWcEJPF2+Ok7Yos3jVNlHikt0=;
 b=WPl/ttCgVGpfRhX5uIRmowTqAxksNqMMXSP18XKV4OI69+H92JAD+N2q9CKv7hCzpqPOQP
 vz7pvXPwCCurUzfi6k9SQVyMPZBJK2KFNgXnWDiJ8B9n3jTcdFunIWxuusSntRvSpadmGz
 afwNWbS5thuwZnk2dE44SctDMz539/c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-XXg_9tb1Msah8fCdQMcolg-1; Fri, 08 Nov 2019 06:14:19 -0500
X-MC-Unique: XXg_9tb1Msah8fCdQMcolg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C12FA107ACC3;
 Fri,  8 Nov 2019 11:14:17 +0000 (UTC)
Received: from localhost (ovpn-116-74.ams2.redhat.com [10.36.116.74])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2ACA51001DF0;
 Fri,  8 Nov 2019 11:14:09 +0000 (UTC)
Date: Fri, 8 Nov 2019 12:14:08 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jag Raman <jag.raman@oracle.com>
Subject: Re: [RFC v4 PATCH 49/49] multi-process: add configure and usage
 information
Message-ID: <20191108111408.GC402228@stefanha-x1.localdomain>
References: <cover.1571905346.git.jag.raman@oracle.com>
 <2736d12f29d2c9051966864b5d865ab0f392b8d1.1571905346.git.jag.raman@oracle.com>
 <20191107140220.GI365089@stefanha-x1.localdomain>
 <20191107143900.GG120292@redhat.com>
 <cdc3bd40-a1c4-2f89-b3d3-eff2b661e04f@oracle.com>
MIME-Version: 1.0
In-Reply-To: <cdc3bd40-a1c4-2f89-b3d3-eff2b661e04f@oracle.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="IpbVkmxF4tDyP/Kb"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, john.g.johnson@oracle.com,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, kraxel@redhat.com,
 quintela@redhat.com, mst@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, thuth@redhat.com, ehabkost@redhat.com,
 konrad.wilk@oracle.com, dgilbert@redhat.com, liran.alon@oracle.com,
 rth@twiddle.net, kwolf@redhat.com,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 mreitz@redhat.com, ross.lagerwall@citrix.com, marcandre.lureau@gmail.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--IpbVkmxF4tDyP/Kb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 07, 2019 at 10:53:27AM -0500, Jag Raman wrote:
>=20
>=20
> On 11/7/2019 9:39 AM, Daniel P. Berrang=E9 wrote:
> > On Thu, Nov 07, 2019 at 03:02:20PM +0100, Stefan Hajnoczi wrote:
> > > On Thu, Oct 24, 2019 at 05:09:30AM -0400, Jagannathan Raman wrote:
> > > > From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> > > >=20
> > > > Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> > > > Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> > > > Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> > > > ---
> > > >   docs/qemu-multiprocess.txt | 86 +++++++++++++++++++++++++++++++++=
+++++++++++++
> > > >   1 file changed, 86 insertions(+)
> > > >   create mode 100644 docs/qemu-multiprocess.txt
> > > >=20
> > > > diff --git a/docs/qemu-multiprocess.txt b/docs/qemu-multiprocess.tx=
t
> > > > new file mode 100644
> > > > index 0000000..c29f4df
> > > > --- /dev/null
> > > > +++ b/docs/qemu-multiprocess.txt
> > > > @@ -0,0 +1,86 @@
> > > > +Multi-process QEMU
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > +
> > > > +This document describes how to configure and use multi-process qem=
u.
> > > > +For the design document refer to docs/devel/qemu-multiprocess.
> > > > +
> > > > +1) Configuration
> > > > +----------------
> > > > +
> > > > +To enable support for multi-process add --enable-mpqemu
> > > > +to the list of options for the "configure" script.
> > > > +
> > > > +
> > > > +2) Usage
> > > > +--------
> > > > +
> > > > +To start qemu with devices intended to run in a separate emulation
> > > > +process without libvirtd support, the following should be used on =
QEMU
> > > > +command line. As of now, we only support the emulation of lsi53c89=
5a
> > > > +in a separate process
> > > > +
> > > > +* Since parts of the RAM are shared between QEMU & remote process,=
 a
> > > > +  memory-backend-file is required to facilitate this, as follows:
> > > > +
> > > > +  -object memory-backend-file,id=3Dmem,mem-path=3D/dev/shm/,size=
=3D4096M,share=3Don
> > > > +
> > > > +* The devices to be emulated in the separate process are defined a=
s
> > > > +  before with addition of "rid" suboption that serves as a remote =
group
> > > > +  identificator.
> > > > +
> > > > +  -device <device options>,rid=3D"remote process id"
> > > > +
> > > > +  For exmaple, for non multi-process qemu:
> > >=20
> > > s/exmaple/example/
> > >=20
> > > > +    -device lsi53c895a,id=3Dscsi0 device
> > > > +    -device scsi-hd,drive=3Ddrive0,bus=3Dscsi0.0,scsi-id=3D0
> > > > +    -drive id=3Ddrive0,file=3Ddata-disk.img
> > > > +
> > > > +  and for multi-process qemu and no libvirt
> > > > +  support (i.e. QEMU forks child processes):
> > > > +    -device lsi53c895a,id=3Dscsi0,rid=3D0
> > > > +    -device scsi-hd,drive=3Ddrive0,bus=3Dscsi0.0,scsi-id=3D0,rid=
=3D"0"
> > > > +
> > > > +* The command-line options for the remote process is added to the =
"command"
> > >=20
> > > s/is added/are added/
> > >=20
> > > > +  suboption of the newly added "-remote" option.
> > > > +
> > > > +   -remote [socket],rid=3D,command=3D"..."
> > > > +
> > > > +  The drives to be emulated by the remote process are specified as=
 part of
> > > > +  this command sub-option. The device to be used to connect to the=
 monitor
> > > > +  is also specified as part of this suboption.
> > > > +
> > > > +  For example, the following option adds a drive and monitor to th=
e remote
> > > > +  process:
> > > > +  -remote rid=3D0,command=3D"-drive id=3Ddrive0,,file=3Ddata-disk.=
img -monitor unix:/home/qmp-sock,,server,,nowait"
> > > > +
> > > > +  Note: There's an issue with this "command" subtion which we are =
in the
> > >=20
> > > s/subtion/sub-option/
> > >=20
> > > > +  process of fixing. To work around this issue, it requires additi=
onal
> > > > +  "comma" characters as illustrated above, and in the example belo=
w.
> > > > +
> > > > +* Example QEMU command-line to launch lsi53c895a in a remote proce=
ss
> > > > +
> > > > +  #/bin/sh
> > > > +  qemu-system-x86_64 \
> > > > +  -name "OL7.4" \
> > > > +  -machine q35,accel=3Dkvm \
> > > > +  -smp sockets=3D1,cores=3D1,threads=3D1 \
> > > > +  -cpu host \
> > > > +  -m 2048 \
> > > > +  -object memory-backend-file,id=3Dmem,mem-path=3D/dev/shm/,size=
=3D2G,share=3Don \
> > > > +  -numa node,memdev=3Dmem \
> > > > +  -device virtio-scsi-pci,id=3Dvirtio_scsi_pci0 \
> > > > +  -drive id=3Ddrive_image1,if=3Dnone,format=3Draw,file=3D/root/ol7=
.qcow2 \
> > > > +  -device scsi-hd,id=3Dimage1,drive=3Ddrive_image1,bus=3Dvirtio_sc=
si_pci0.0 \
> > > > +  -boot d \
> > > > +  -monitor stdio \
> > > > +  -vnc :0 \
> > > > +  -device lsi53c895a,id=3Dlsi0,remote,rid=3D8,command=3D"qemu-scsi=
-dev" \
> > > > +  -device scsi-hd,id=3Ddrive2,drive=3Ddrive_image2,bus=3Dlsi0.0,sc=
si-id=3D0,remote,rid=3D8,command=3D"qemu-scsi-dev"\
> > > > +  -remote rid=3D8,command=3D"-drive id=3Ddrive_image2,,file=3D/roo=
t/remote-process-disk.img -monitor unix:/home/qmp-sock,,server,,nowait"
> > > > +
> > > > +  We could connect to the monitor using the following command:
> > > > +  socat /home/qmp-sock stdio
> > > > +
> > > > +  After hotplugging disks to the remote process, please execute th=
e
> > > > +  following command in the guest to refresh the list of storage de=
vices:
> > > > +  rescan_scsi_bus.sh -a
> > >=20
> > > This documentation suggests that QEMU spawns the remote processes.  H=
ow
> > > do this work with unprivileged QEMU?  Is there an additional step whe=
re
> > > QEMU drops privileges after having spawned remote processes?
> >=20
> > This syntax is for the simple case without privilege separation.
> > If differing privilege levels are needed, then whatever spawns QEMU
> > should spawn the remote helper process ahead of time, and then just
> > pass the UNIX socket path to the -remote arg, instead of using
> > the 'command' parameter.
> >=20
> > Regards,
> > Daniel
>=20
> Thank You, Stefan, Michael & Daniel, for your comments. I had a chance
> to sit down with my teammates to understand the feedback you gave at the
> KVM Forum. Thank you for that, as well.
>=20
> We currently support two ways of launching the remote process - one is
> self-launch through QEMU, as outlined in this patch series. The other
> approach is using an Orchestrator like libvirt (we haven't had the
> chance to submit those patches for review yet).
>=20
> In the case where libvirt is involved, it would assume the
> responsibility of spawning the remote process first and pass in the info
> required to connect to the remote process via command-line arguments to
> QEMU. This support in QEMU is available in the current series. We
> haven't sent the libvirt side of patches out for review yet. It would be
> easier to upstream libvirt once the QEMU side of things is firmed up.
>=20
> In the case of self-launch, our understanding is that QEMU has the
> privilege to fork() the remote process until the "-sandbox" argument is
> processed. However, if an Orchestrator prohibits QEMU from spawning
> other processes from the get-go, then the Orchestrator would assume the
> responsibility of spawning the remote process as well - like Daniel just
> pointed out.
>=20
> In both cases, we intend to apply the security policies required to
> confine the remote process externally - probably through SELinux. We
> haven't had the chance to upstream the SELinux policies yet, but we
> previously sent a sample of the policies for your comments. Like Michael
> pointed out earlier, the SELinux policies are per binary.

Sounds good, please document -remote socket=3D as an alternative to
-remote command=3D so it's clear that both approaches are supported.

Stefan

--IpbVkmxF4tDyP/Kb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3FTgAACgkQnKSrs4Gr
c8iHeQgAneqKyMitT1xL+qfY6ZV+IZtKPaDRhTBkfw9RwdVHNNFo1SQgihmHrzQI
OLTfcb8k8EwBrVch1988YbltpTcOVLbigKue31FzNuiutWpWvhlb2nMOUA1bBUTp
63E4nKrgEvaAzINovauQfqUmklJVVZBrScVQ4kSVwQwyuWkF0X9aMmliB1VN8GoH
hi8KH9r7VUjw2KgQbJk9pwEVcTgSQ08iSOlCajwbQLCdi8diaBoVVRtU9x8d0h1x
emF+B7GNjG6l+zYdBhuRHWb5XEGYPGRgt7whdzx11SqsYVMchu0ed1LhhIIX1U+f
pSEyqlcLiCPNMaxXNCedMT6K/+BD+Q==
=h75W
-----END PGP SIGNATURE-----

--IpbVkmxF4tDyP/Kb--


