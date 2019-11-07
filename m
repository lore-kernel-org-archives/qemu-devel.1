Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C8BC5DF60
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 14:51:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D03952178F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 14:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P66FU0yJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D03952178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSj7w-0003YY-Ql
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 09:51:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49980)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iSiwn-00010W-OJ
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 09:39:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iSiwl-0008Ib-1M
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 09:39:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44830
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iSiwk-0008I3-RG
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 09:39:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573137577;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=98NucmLNVdE7K89wW7h4kCCTtbZHUQUe91gonbU6ShA=;
 b=P66FU0yJRQgP5Dbu19QtwIor26nljLbrThLA5t5LOeT8u6Ilg8H+h6AtPtzObfR7BHjvKA
 BlBN919xUxgJ3bBl4/c6xY+buviZ/h/tKgq+9TaxxkWZ/Y+iSm0fi+uIla6lygJJ1IdCKV
 81nzxiZhptTZ+kIia4GjiMCKOaZh+FY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-FPMXKYvmPmqT4-V9N4Zpyg-1; Thu, 07 Nov 2019 09:39:33 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 843F7800C61;
 Thu,  7 Nov 2019 14:39:31 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 812575D6D8;
 Thu,  7 Nov 2019 14:39:02 +0000 (UTC)
Date: Thu, 7 Nov 2019 14:39:00 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [RFC v4 PATCH 49/49] multi-process: add configure and usage
 information
Message-ID: <20191107143900.GG120292@redhat.com>
References: <cover.1571905346.git.jag.raman@oracle.com>
 <2736d12f29d2c9051966864b5d865ab0f392b8d1.1571905346.git.jag.raman@oracle.com>
 <20191107140220.GI365089@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20191107140220.GI365089@stefanha-x1.localdomain>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: FPMXKYvmPmqT4-V9N4Zpyg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, john.g.johnson@oracle.com,
 qemu-devel@nongnu.org, kraxel@redhat.com,
 Jagannathan Raman <jag.raman@oracle.com>, quintela@redhat.com, mst@redhat.com,
 armbru@redhat.com, kanth.ghatraju@oracle.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, stefanha@redhat.com, rth@twiddle.net, kwolf@redhat.com,
 mreitz@redhat.com, ross.lagerwall@citrix.com, marcandre.lureau@gmail.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 07, 2019 at 03:02:20PM +0100, Stefan Hajnoczi wrote:
> On Thu, Oct 24, 2019 at 05:09:30AM -0400, Jagannathan Raman wrote:
> > From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> >=20
> > Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> > Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> > Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> > ---
> >  docs/qemu-multiprocess.txt | 86 ++++++++++++++++++++++++++++++++++++++=
++++++++
> >  1 file changed, 86 insertions(+)
> >  create mode 100644 docs/qemu-multiprocess.txt
> >=20
> > diff --git a/docs/qemu-multiprocess.txt b/docs/qemu-multiprocess.txt
> > new file mode 100644
> > index 0000000..c29f4df
> > --- /dev/null
> > +++ b/docs/qemu-multiprocess.txt
> > @@ -0,0 +1,86 @@
> > +Multi-process QEMU
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +This document describes how to configure and use multi-process qemu.
> > +For the design document refer to docs/devel/qemu-multiprocess.
> > +
> > +1) Configuration
> > +----------------
> > +
> > +To enable support for multi-process add --enable-mpqemu
> > +to the list of options for the "configure" script.
> > +
> > +
> > +2) Usage
> > +--------
> > +
> > +To start qemu with devices intended to run in a separate emulation
> > +process without libvirtd support, the following should be used on QEMU
> > +command line. As of now, we only support the emulation of lsi53c895a
> > +in a separate process
> > +
> > +* Since parts of the RAM are shared between QEMU & remote process, a
> > +  memory-backend-file is required to facilitate this, as follows:
> > +
> > +  -object memory-backend-file,id=3Dmem,mem-path=3D/dev/shm/,size=3D409=
6M,share=3Don
> > +
> > +* The devices to be emulated in the separate process are defined as
> > +  before with addition of "rid" suboption that serves as a remote grou=
p
> > +  identificator.
> > +
> > +  -device <device options>,rid=3D"remote process id"
> > +
> > +  For exmaple, for non multi-process qemu:
>=20
> s/exmaple/example/
>=20
> > +    -device lsi53c895a,id=3Dscsi0 device
> > +    -device scsi-hd,drive=3Ddrive0,bus=3Dscsi0.0,scsi-id=3D0
> > +    -drive id=3Ddrive0,file=3Ddata-disk.img
> > +
> > +  and for multi-process qemu and no libvirt
> > +  support (i.e. QEMU forks child processes):
> > +    -device lsi53c895a,id=3Dscsi0,rid=3D0
> > +    -device scsi-hd,drive=3Ddrive0,bus=3Dscsi0.0,scsi-id=3D0,rid=3D"0"
> > +
> > +* The command-line options for the remote process is added to the "com=
mand"
>=20
> s/is added/are added/
>=20
> > +  suboption of the newly added "-remote" option.=20
> > +
> > +   -remote [socket],rid=3D,command=3D"..."
> > +
> > +  The drives to be emulated by the remote process are specified as par=
t of
> > +  this command sub-option. The device to be used to connect to the mon=
itor
> > +  is also specified as part of this suboption.
> > +
> > +  For example, the following option adds a drive and monitor to the re=
mote
> > +  process:
> > +  -remote rid=3D0,command=3D"-drive id=3Ddrive0,,file=3Ddata-disk.img =
-monitor unix:/home/qmp-sock,,server,,nowait"
> > +
> > +  Note: There's an issue with this "command" subtion which we are in t=
he
>=20
> s/subtion/sub-option/
>=20
> > +  process of fixing. To work around this issue, it requires additional
> > +  "comma" characters as illustrated above, and in the example below.
> > +
> > +* Example QEMU command-line to launch lsi53c895a in a remote process
> > +
> > +  #/bin/sh
> > +  qemu-system-x86_64 \
> > +  -name "OL7.4" \
> > +  -machine q35,accel=3Dkvm \
> > +  -smp sockets=3D1,cores=3D1,threads=3D1 \
> > +  -cpu host \
> > +  -m 2048 \
> > +  -object memory-backend-file,id=3Dmem,mem-path=3D/dev/shm/,size=3D2G,=
share=3Don \
> > +  -numa node,memdev=3Dmem \
> > +  -device virtio-scsi-pci,id=3Dvirtio_scsi_pci0 \
> > +  -drive id=3Ddrive_image1,if=3Dnone,format=3Draw,file=3D/root/ol7.qco=
w2 \
> > +  -device scsi-hd,id=3Dimage1,drive=3Ddrive_image1,bus=3Dvirtio_scsi_p=
ci0.0 \
> > +  -boot d \
> > +  -monitor stdio \
> > +  -vnc :0 \
> > +  -device lsi53c895a,id=3Dlsi0,remote,rid=3D8,command=3D"qemu-scsi-dev=
" \
> > +  -device scsi-hd,id=3Ddrive2,drive=3Ddrive_image2,bus=3Dlsi0.0,scsi-i=
d=3D0,remote,rid=3D8,command=3D"qemu-scsi-dev"\
> > +  -remote rid=3D8,command=3D"-drive id=3Ddrive_image2,,file=3D/root/re=
mote-process-disk.img -monitor unix:/home/qmp-sock,,server,,nowait"
> > +
> > +  We could connect to the monitor using the following command:
> > +  socat /home/qmp-sock stdio
> > +
> > +  After hotplugging disks to the remote process, please execute the
> > +  following command in the guest to refresh the list of storage device=
s:
> > +  rescan_scsi_bus.sh -a
>=20
> This documentation suggests that QEMU spawns the remote processes.  How
> do this work with unprivileged QEMU?  Is there an additional step where
> QEMU drops privileges after having spawned remote processes?

This syntax is for the simple case without privilege separation.
If differing privilege levels are needed, then whatever spawns QEMU
should spawn the remote helper process ahead of time, and then just
pass the UNIX socket path to the -remote arg, instead of using
the 'command' parameter.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


