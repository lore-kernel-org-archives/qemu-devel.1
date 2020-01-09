Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9255C282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 18:45:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9118F20678
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 18:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MTmZEDRd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9118F20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipcoV-00075J-MC
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 13:45:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51710)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ipcnb-0006eI-LP
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 13:44:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ipcnZ-0001qD-5I
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 13:44:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29691
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ipcnY-0001iz-Lr
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 13:44:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578595487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T2yQJ0aIXq3Jo/D787D4QPXtK6GPb4i0EFc8e15p+ag=;
 b=MTmZEDRdw5fLYE1v8B27kQmeDWLhqwyJNDqPiaN1Bos0QbdxZFcV+z37YSybazd7qle8gm
 wfJ5T/KXUB2Kk0b/haPYnN5sPEeJzvtWsiO8HyVX3EXoWBVmgSvtzSFsQk9i/DnDKfg0g/
 k1oXAxcQb3DvE+C90UG60DJFJy2zGsg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-oNFym2VNPJaMdaxwgK-SwQ-1; Thu, 09 Jan 2020 13:44:44 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 61E5610054E3;
 Thu,  9 Jan 2020 18:44:43 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ACC8C60FC2;
 Thu,  9 Jan 2020 18:44:42 +0000 (UTC)
Date: Thu, 9 Jan 2020 18:44:40 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Peter Lieven <pl@kamp.de>
Subject: Re: qemu-4.0.1: vhost_region_add_section:Section rounded to 0 prior
 to previous a0000
Message-ID: <20200109184440.GR6795@work-vm>
References: <985fea06-ede6-dcb7-8829-a48a9416bc09@kamp.de>
 <20200108150458.GC3184@work-vm>
 <ca222a5f-1ec6-477c-ed83-6ef52ea9e97f@kamp.de>
MIME-Version: 1.0
In-Reply-To: <ca222a5f-1ec6-477c-ed83-6ef52ea9e97f@kamp.de>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: oNFym2VNPJaMdaxwgK-SwQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Peter Lieven (pl@kamp.de) wrote:
> Am 08.01.20 um 16:04 schrieb Dr. David Alan Gilbert:
> > * Peter Lieven (pl@kamp.de) wrote:
> > > Hi,
> > >=20
> > >=20
> > > I have a Qemu 4.0.1 machine with vhost-net network adapter, thats pol=
luting the log with the above message.
> > >=20
> > > Is this something known? Googling revealed the following patch in Nem=
u (with seems to be a Qemu fork from Intel):
> > >=20
> > > https://github.com/intel/nemu/commit/03940ded7f5370ce7492c619dccced11=
4ef7f56e
> > >=20
> > >=20
> > > The network stopped functioning. After a live-migration the vServer i=
s reachable again.
> > >=20
> > >=20
> > > Any ideas?
> > What guest are you running and what does your qemu commandline look
> > like?
>=20
>=20
> Its running debian9. We have hundreds of other VMs with identical setup. =
Do not know why this one makes trouble.

Could you extract an 'info mtree' from it - particularly the
'address-space: memory' near the top.


> Here is the cmdline:
>=20
>=20
> /usr/bin/qemu-4.0.0=A0 -enable-kvm=A0 -M pc-i440fx-2.9=A0 -nodefaults -ne=
tdev
> type=3Dtap,id=3Dguest0,script=3Dno,downscript=3Dno,ifname=3Dtap0,vhost=3D=
on,vnet_hdr=3Don
> -device virtio-net-pci,netdev=3Dguest0,mac=3D52:54:00:80:07:bc -iscsi
> initiator-name=3Diqn.2005-03.org.virtual-core:0025b51f006c,timeout=3D30 -=
object
> rng-random,filename=3D/dev/urandom,id=3Drng0 -device
> virtio-rng-pci,rng=3Drng0,max-bytes=3D65536,period=3D1000=A0 -drive forma=
t=3Draw,discard=3Don,detect-zeroes=3Doff,file=3DXXX,if=3Dnone,cache=3Dwrite=
back,aio=3Dnative,id=3Ddisk0
> -device virtio-scsi-pci=A0 -device scsi-hd,drive=3Ddisk0=A0 -serial null=
=A0
> -parallel null=A0 -m 1024,slots=3D16,maxmem=3D393216M=A0 -smp
> 1,sockets=3D64,cores=3D1,threads=3D1,maxcpus=3D64=A0 -monitor
> tcp:0:4001,server,nowait,nodelay -vnc :1 -qmp
> tcp:0:3001,server,nowait,nodelay=A0 -name 'debian9'=A0 -drive
> index=3D2,media=3Dcdrom,if=3Dide,aio=3Dnative,readonly=3Don=A0 -boot orde=
r=3Dc,menu=3Doff=A0
> -k de=A0 -pidfile /var/run/qemu/vm-5182.pid -mem-path /hugepages=A0
> -mem-prealloc=A0 -cpu Westmere,+pcid,enforce -rtc base=3Dutc -usb -device
> usb-tablet -no-hpet -vga vmware -chardev
> socket,host=3D127.0.0.1,port=3D2001,id=3Dqga0,server,nowait,nodelay -devi=
ce
> virtio-serial -device
> virtserialport,chardev=3Dqga0,name=3Dorg.qemu.guest_agent.0

All pretty boring stuff. hmm.

Dave

>=20
> Thanks,
>=20
> Peter
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


