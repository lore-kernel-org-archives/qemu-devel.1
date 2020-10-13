Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA74DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 13:27:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0928723118
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 13:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G3djC+qn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0928723118
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSKKQ-0007rm-T7
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 09:26:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42104)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kSKHa-0005zY-U8
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 09:24:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22283)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kSKHY-0000R4-JV
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 09:24:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602595438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GN75sPmcRc2yrUvtbBpYnfYx6JDNxK2rv4QaSVMBn48=;
 b=G3djC+qnR4Bdte71WCcYtkpc4noxeXCfIkyCYObc3VVTMgeAzBn52W4XavPtG4K2+Td6ti
 p8xNbNcYH9iMz/jwNExd9A7JsUNlfX3aIFfz+pxSkxj1iElgJXfnooSj74t6LZ7odKlYn2
 IPELGx54hJ9IFoJsIiNtaFlQjSEnQto=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-520-Eflz7dyYOjS87Roy5M2yQA-1; Tue, 13 Oct 2020 09:23:56 -0400
X-MC-Unique: Eflz7dyYOjS87Roy5M2yQA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4CD0B879522;
 Tue, 13 Oct 2020 13:23:55 +0000 (UTC)
Received: from localhost (ovpn-114-235.ams2.redhat.com [10.36.114.235])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D219F5D98D;
 Tue, 13 Oct 2020 13:23:54 +0000 (UTC)
Date: Tue, 13 Oct 2020 14:23:45 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Cosmin Chenaru <cosmin.chenaru@gmail.com>
Subject: Re: Using virtio-vhost-user or vhost-pci
Message-ID: <20201013132345.GG164611@stefanha-x1.localdomain>
References: <CADx_CBPzAstC0o9X6CrnyFqYYAtPbw5-XHWxmXTt6+LyYb-U3g@mail.gmail.com>
 <9287d0a2-a3ed-6517-3fa2-07ba75f6414c@arrikto.com>
MIME-Version: 1.0
In-Reply-To: <9287d0a2-a3ed-6517-3fa2-07ba75f6414c@arrikto.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="8S1fMsFYqgBC+BN/"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 03:04:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Nikos Dragazis <ndragazis@arrikto.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--8S1fMsFYqgBC+BN/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2020 at 02:14:22AM +0300, Nikos Dragazis wrote:
> On 12/10/20 10:22 =CE=BC.=CE=BC., Cosmin Chenaru wrote:
> > I am currently running multiple VMs, connected in between by the DPDK v=
host-switch. A VM can start, reboot, shutdown, so much of this is dynamic a=
nd the vhost-switch handles all of these. So these VMs are some sort of "en=
dpoints" (I could not find a better naming).
> >=20
> > The code which runs on the VM endpoints is somehow tied to the vhost-sw=
itch code, and if I change something on the VM which breaks the compatibili=
ty, I need to recompile the vhost-switch and restart. The problem is that m=
ost of the time I forget to update the vhost-switch, and I run into other p=
roblems.
> >=20
> > If I could use a VM as a vhost-switch instead of the DPDK app, then I h=
ope that in my endpoint code which runs on the VM, I can add functionality =
to make it also run as a switch, and forward the packets between the other =
VMs like the current DPDK switch does. Doing so would allow me to catch thi=
s out-of-sync between the VM endpoint code and the switch code at compile t=
ime, since they will be part of the same app.
> >=20
> > This would be a two-phase process. First to run the DPDK vhost-switch i=
nside a guest VM, and then to move the tx-rx part into my app.
> >=20
> > Both Qemu and the DPDK app use "vhost-user". I was happy to see that I =
can start Qemu in vhost-user server mode:
> >=20
> > =C2=A0 =C2=A0 <interface type=3D'vhostuser'>
> > =C2=A0 =C2=A0 =C2=A0 <mac address=3D'52:54:00:9c:3a:e3'/>
> > =C2=A0 =C2=A0 =C2=A0 <source type=3D'unix' path=3D'/home/cosmin/vsocket=
.server' mode=3D'server'/>
> > =C2=A0 =C2=A0 =C2=A0 <model type=3D'virtio'/>
> > =C2=A0 =C2=A0 =C2=A0 <driver queues=3D'2'>
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 <host mrg_rxbuf=3D'on'/>
> > =C2=A0 =C2=A0 =C2=A0 </driver>
> > =C2=A0 =C2=A0 =C2=A0 <address type=3D'pci' domain=3D'0x0000' bus=3D'0x0=
0' slot=3D'0x04' function=3D'0x0'/>
> > =C2=A0 =C2=A0 </interface>
> >=20
> > This would translate to these Qemu arguments:
> >=20
> > -chardev socket,id=3Dcharnet1,path=3D/home/cosmin/vsocket.server,server=
 -netdev type=3Dvhost-user,id=3Dhostnet1,chardev=3Dcharnet1,queues=3D2 -dev=
ice virtio-net-pci,mrg_rxbuf=3Don,mq=3Don,vectors=3D6,netdev=3Dhostnet1,id=
=3Dnet1,mac=3D52:54:00:9c:3a:e3,bus=3Dpci.0,addr=3D0x4
> >=20
> > But at this point Qemu will not boot the VM until there is a vhost-user=
 client connecting to Qemu. I even tried adding the "nowait" argument, but =
Qemu still waits. This will not work in my case, as the endpoint VMs could =
start and stop at any time, and I don't even know how many network interfac=
es the endpoint VMs will have.

The "server" mode simply creates a listen socket instead of connecting.
It does not mean that QEMU acts as the vhost-user device backend. QEMU
is still the frontend. The UNIX domain socket "client" and "server"
relationship is independent of the vhost-user protocol frontend
(previously called "master") and device backend (previously called
"slave") relationship.

> >=20
> > I then found the virtio-vhost-user transport protocol [2], and was=C2=
=A0thinking that I could at least start the packet-switching VM, and then l=
et the DPDK app inside it do the forwarding of the packets. But from what I=
 understand, this creates a single network interface inside the VM on which=
 the DPDK app can bind. The limitation here is that if another VM wants to =
connect to the packet-switching VM, I need to manually add another virtio-v=
host-user-pci device (and a new vhost-user.sock) before this packet-switchi=
ng VM starts, so this is not dynamic.

Yes, each switch port needs its own virtio-vhost-user device because it
is the partner to a VM's virtio-net device.

It is possible to write a guest application that:

1. Opens multiple virtio-vhost-user devices and handles the connection
   lifecycle so that devices may be disconnected some of the time.

and/or

2. Reacts to virtio-vhost-user hotplug (i.e. udev/uevents) to
   dynamically add/remove ports.

> > The second approach for me would be to use vhost-pci [3], which I could=
 not fully understand how it=C2=A0works, but I think it presents a network =
interface to the guest kernel after another VM connects to the first one.

This also requires multiple vhost-pci device instances if you want
multiple switch ports.

> > I realize I made a big story and probably don't make too much sense, bu=
t one more thing. The ideal solution for me would be a combination of the v=
host-user socket and the vhost-pci socket. The Qemu will start the VM and t=
he socket will wait in the background for vhost-user connections. When a ne=
w connection is established, Qemu should create a hot-plugable PCI network =
card and either the guest kernel or the DPDK app inside to handle the vhost=
-user messages.

vhost-pci and virtio-vhost-user don't present a network card to the
switch. Instead the switch acts as the device emulator for the
virtio-net NICs that other VMs are using. This has performance
advantages because no data copy and extra packet queuing is necessary
when there is just 1 NIC instead of 2 point-to-point NICs.

Stefan

--8S1fMsFYqgBC+BN/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+FqmEACgkQnKSrs4Gr
c8jS4Qf/ZQKloaybCIFlteR7aLJNN6G+v1T0xPbSB9+0wnOqMJw+dQupHh+oLc2c
LYzquwgxy1bU72msPN4nJyC6qs/OaYO4e6HhHIz0CvA+G/pO5zCbE7xdhboH6DB0
JlJDhwOnkrGwvjUHocFiAdjz6rNlioil+7sEohrI1An440bNOtqQR5eJ7tHreILT
azhc10OOYdO/yd+0C1yErAT2IW8ux07PjVVRWDMzwhzCbrAXbsGrT8T6AOUnhCq8
ANOPpKgVMlmZktN1N0VGCo7F8i0uWGEJBqXFz7Qv1uYcts3YETRyXE8YU2GCNP9y
zpshru2dJkiXluwl2ICdzeM+ju7G5Q==
=nZjJ
-----END PGP SIGNATURE-----

--8S1fMsFYqgBC+BN/--


