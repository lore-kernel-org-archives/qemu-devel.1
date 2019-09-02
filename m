Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A230FC3A59E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 21:30:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CF6A2168B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 21:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="bu1WqbeP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CF6A2168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4tub-0002Y4-8F
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 17:30:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37003)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1i4tot-0000rQ-Ut
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 17:25:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lukasstraub2@web.de>) id 1i4tor-00015V-Ek
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 17:25:03 -0400
Received: from mout.web.de ([212.227.15.3]:40585)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lukasstraub2@web.de>) id 1i4tor-000140-1q
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 17:25:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1567459478;
 bh=TohTCrYWDYQY8GuouXNnWoo2wlS69QKCP1VUczY3BvQ=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=bu1WqbePhSJYV8XnwqVepYtzSK1Pb13XH+Q60leccTyL8hwxIeZ3pOHOBBg4Ikxf2
 oDfP3cyxJrS/f1B6tgTj8w1Tn4ufEUXRoyKJGWpEmvbVy3VqPicoSn8QOGt5opqR/t
 h0jFJrNXoRfLhheKZLxvjxqFydrF2lTA0TyQQRwg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([87.123.206.43]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LaCqs-1iSRT61WPe-00m19R; Mon, 02
 Sep 2019 23:24:38 +0200
Date: Mon, 2 Sep 2019 23:24:35 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: "Zhang, Chen" <chen.zhang@intel.com>
Message-ID: <20190902232435.0b67a5d1@luklap>
In-Reply-To: <9CFF81C0F6B98A43A459C9EDAD400D7806250B3B@shsmsx102.ccr.corp.intel.com>
References: <cover.1565894837.git.lukasstraub2@web.de>
 <4a5ef4f67b6e40d65d71bbaa0e70796f0edea3a4.1565894837.git.lukasstraub2@web.de>
 <9CFF81C0F6B98A43A459C9EDAD400D7806250B3B@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0/stJza+DulYfPUN4udLY7aykwe06M2/GpvZYHlr6FhcYfnS3om
 vKYkoHJ5st9b8FCbBMBzmWzE1tCeakx7C45NxctggGMGNiJaua7x3gCJGd27dKMrmfJH3ZR
 YtNNRrNgy+VVbXnUWVQQLXSq6gPR/Wp73Bj0wa4RpGger267XVEwWzvzMan26Kq/pQSklTp
 FKZbnnRbFEI/JB4ys2EMA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ExXjt/YHQWw=:DVy3zIVPSJwB0A0iBTuky+
 HIxi+X6gyi/+188w8AogsAiBWGZK20obdq2E43/+Q9Us0UP48VgQDxmMGbnfmJhJb0jp/Uy6v
 3oiDxauG+jdy1sqZVClo59kFcHa/BI8iGvTHqPWXTg7mb56295xWTmwEZmJJBc0RsC7p+fME2
 6Sllc0YYprtgoCbEc3LO9yweOIMP30wqQXEP8omOmaffnpDIlw4aI++PPoIQW18e9Xv6wvN85
 Z46jNgTCxxNGPOhcz2c2sBVMkWYg0pChg/iyTeCuzJlVbwpr8pFx4ZSEgA9PNyO2g5PBNz07l
 /9BaSXeZBxVfpJf0mJFyQR2AdPtixmlNjpItrLzeIRj8iVipVE5hBi/qxT3H+Ajb8jmtZJf4v
 Mp4vJwQIRX8lIX+weDP29yX0rO0qHZabQLChRXNZNf6HX8M4KpXxN/5EFEDrQlgZd5pe0OYcH
 e7k3OLfjwLz/X/4C8Oj3Bz6KlLv21kftUQ2lE46c91lvZaSf6aD4kvTuuoBY+cMyzfy1yFEoo
 BU1E6X441n5MfllY/P333xxGavlUeZGegc73Qaqn2SQf6fvkwJeNzbFSYiXY5NhqRNvr3EYPW
 HapBoaAv1MABXKIBuOjKkViWLxepbHObJvi/n0TrXfbaH7Auk8kc9/9xeT0dyVhvpcoBfaUPW
 X117Be7MJeorcG1r7TvlyBbVodAfKbRETGPrzhHno2oCwdBNZhSCgHNBs2HLvg1BkClwV1tdl
 wqfjN/PxqLu5l3mlsZ4MwHUI+RGZFuT51K96x9fbp+OP9agP9DNZJZ2LQhPXu3rnwImYeX6EB
 k69nAXKmnfKPn17hbirUr72aoBIgEOOgONli7oezonLEbu/yTzv8bRbe3tWdTCGPKrBHdAeiE
 S6TdonBTOUa71zA7YsdKQJkUcWbnVWe3bDyyv7QUffgRT8LVjixEC5QCNdJApdsEw5Iz45pIi
 ZavTcw9OivwCBpuGL6ebr2i4yx6cafoDAwGGmtaHqTJ+ZrPusXRdxIsiY8Z7jbsgDv6PJ0NxO
 bNuuc6jUJ5lISeF0/KbvCCa6pn5nS5QQXfxNXrHkpv3MNhZ8Bw3DwiN3liXPzOfwfJmxJfVo7
 Hq/2VJ/L9YYo1xFrMRxOnOp801+j3HsblU39HL7gfC9tjRleM8HM2WarbRfgNHk9zZ+hFJyHz
 2pyT0vcLuu3QsaZWXQUQCkq439+6DLfQP0eiEHmdgkFrx/zw==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.15.3
Subject: Re: [Qemu-devel] [PATCH v2 3/3] Update Documentation
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
Cc: Wen Congyang <wencongyang2@huawei.com>, Jason Wang <jasowang@redhat.com>,
 Xie Changlong <xiechanglong.d@gmail.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2 Sep 2019 12:17:43 +0000
"Zhang, Chen" <chen.zhang@intel.com> wrote:

> Hi Lukas,
>=20
> Please address Markus's comments change this patch's name in next version.
> And I wrote some comments behind, please check it.
> Firstly, Please remove all the trailing whitespace in this patch.
>=20
>=20
> > -----Original Message-----
> > From: Lukas Straub <lukasstraub2@web.de>
> > Sent: Friday, August 16, 2019 2:49 AM
> > To: qemu-devel <qemu-devel@nongnu.org>
> > Cc: Zhang, Chen <chen.zhang@intel.com>; Jason Wang
> > <jasowang@redhat.com>; Wen Congyang <wencongyang2@huawei.com>;
> > Xie Changlong <xiechanglong.d@gmail.com>
> > Subject: [PATCH v2 3/3] Update Documentation
> >=20
> > Document the qemu command-line and qmp commands for continious
> > replication
> >=20
> > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> > ---
> >  docs/COLO-FT.txt | 185 +++++++++++++++++++++++++++++++++++--------
> > ----
> >  1 file changed, 138 insertions(+), 47 deletions(-)
> >=20
> > diff --git a/docs/COLO-FT.txt b/docs/COLO-FT.txt index
> > ad24680d13..c08bfbd3a8 100644
> > --- a/docs/COLO-FT.txt
> > +++ b/docs/COLO-FT.txt
> > @@ -145,35 +145,64 @@ The diagram just shows the main qmp command,
> > you can get the detail  in test procedure.
> >=20
> >  =3D=3D Test procedure =3D=3D
> > +Note: Here we are running both instances on the same Machine for
> > +testing, change the IP Addresses if you want to run it on two Hosts
> > +
> >  1. Startup qemu
> >  Primary:
> > -# qemu-system-x86_64 -accel kvm -m 2048 -smp 2 -qmp stdio -name
> > primary \
> > -  -device piix3-usb-uhci -vnc :7 \
> > -  -device usb-tablet -netdev tap,id=3Dhn0,vhost=3Doff \
> > -  -device virtio-net-pci,id=3Dnet-pci0,netdev=3Dhn0 \
> > -  -drive if=3Dvirtio,id=3Dprimary-disk0,driver=3Dquorum,read-pattern=
=3Dfifo,vote-
> > threshold=3D1,\
> > -         children.0.file.filename=3D1.raw,\
> > -         children.0.driver=3Draw -S
> > +# imagefolder=3D"/mnt/vms/colo-test"
> > +
> > +# cp --reflink=3Dauto $imagefolder/primary.qcow2
> > +$imagefolder/primary-copy.qcow2 =20
>=20
> I think you can tell other people here that we need two same disk image b=
efore COLO startup.
> The name "primary and primary-copy" will make reader very confused.
>=20
> > +
> > +# qemu-system-x86_64 -enable-kvm -cpu qemu64,+kvmclock -m 512 -smp
> > 1 -qmp stdio \
> > +   -vnc :0 -k de -device piix3-usb-uhci -device usb-tablet -name prima=
ry \ =20
>=20
> What's mean of the "-k de" ?
Hi,

Oops, thats for German Keyboard layout, will remove.

> > +   -netdev tap,id=3Dhn0,vhost=3Doff,helper=3D/usr/lib/qemu/qemu-bridge=
-helper
> > \
> > +   -device rtl8139,id=3De0,netdev=3Dhn0 \
> > +   -chardev socket,id=3Dmirror0,host=3D127.0.0.1,port=3D9003,server,no=
wait \
> > +   -chardev socket,id=3Dcompare1,host=3D127.0.0.1,port=3D9004,server,w=
ait \
> > +   -chardev socket,id=3Dcompare0,host=3D127.0.0.1,port=3D9001,server,n=
owait \
> > +   -chardev socket,id=3Dcompare0-0,host=3D127.0.0.1,port=3D9001 \
> > +   -chardev socket,id=3Dcompare_out,host=3D127.0.0.1,port=3D9005,serve=
r,nowait
> > \
> > +   -chardev socket,id=3Dcompare_out0,host=3D127.0.0.1,port=3D9005 \
> > +   -object filter-mirror,id=3Dm0,netdev=3Dhn0,queue=3Dtx,outdev=3Dmirr=
or0 \
> > +   -object filter-
> > redirector,netdev=3Dhn0,id=3Dredire0,queue=3Drx,indev=3Dcompare_out \
> > +   -object filter-
> > redirector,netdev=3Dhn0,id=3Dredire1,queue=3Drx,outdev=3Dcompare0 \
> > +   -object iothread,id=3Diothread1 \
> > +   -object
> > +colo-compare,id=3Dcomp0,primary_in=3Dcompare0-
> > 0,secondary_in=3Dcompare1,\
> > +outdev=3Dcompare_out0,iothread=3Diothread1 \ =20
>=20
> Please keep the space style.
>=20
> > +   -drive
> > +if=3Dide,id=3Dcolo-disk0,driver=3Dquorum,read-pattern=3Dfifo,vote-thre=
shold=3D1,\
> > +children.0.file.filename=3D$imagefolder/primary.qcow2,children.0.drive=
r=3Dq
> > +cow2 -S
> > +
> >  Secondary:
> > -# qemu-system-x86_64 -accel kvm -m 2048 -smp 2 -qmp stdio -name
> > secondary \
> > -  -device piix3-usb-uhci -vnc :7 \
> > -  -device usb-tablet -netdev tap,id=3Dhn0,vhost=3Doff \
> > -  -device virtio-net-pci,id=3Dnet-pci0,netdev=3Dhn0 \
> > -  -drive if=3Dnone,id=3Dsecondary-disk0,file.filename=3D1.raw,driver=
=3Draw,node-
> > name=3Dnode0 \
> > -  -drive if=3Dvirtio,id=3Dactive-disk0,driver=3Dreplication,mode=3Dsec=
ondary,\
> > -         file.driver=3Dqcow2,top-id=3Dactive-disk0,\
> > -         file.file.filename=3D/mnt/ramfs/active_disk.img,\
> > -         file.backing.driver=3Dqcow2,\
> > -         file.backing.file.filename=3D/mnt/ramfs/hidden_disk.img,\
> > -         file.backing.backing=3Dsecondary-disk0 \
> > -  -incoming tcp:0:8888
> > +# imagefolder=3D"/mnt/vms/colo-test"
> > +
> > +# qemu-img create -f qcow2 $imagefolder/secondary-active.qcow2 10G
> > +
> > +# qemu-img create -f qcow2 $imagefolder/secondary-hidden.qcow2 10G
> > +
> > +# qemu-system-x86_64 -enable-kvm -cpu qemu64,+kvmclock -m 512 -smp
> > 1 -qmp stdio \
> > +   -vnc :1 -k de -device piix3-usb-uhci -device usb-tablet -name secon=
dary \
> > +   -netdev tap,id=3Dhn0,vhost=3Doff,helper=3D/usr/lib/qemu/qemu-bridge=
-helper
> > \
> > +   -device rtl8139,id=3De0,netdev=3Dhn0 \
> > +   -chardev socket,id=3Dred0,host=3D127.0.0.1,port=3D9003,reconnect=3D=
1 \
> > +   -chardev socket,id=3Dred1,host=3D127.0.0.1,port=3D9004,reconnect=3D=
1 \
> > +   -object filter-redirector,id=3Df1,netdev=3Dhn0,queue=3Dtx,indev=3Dr=
ed0 \
> > +   -object filter-redirector,id=3Df2,netdev=3Dhn0,queue=3Drx,outdev=3D=
red1 \
> > +   -object filter-rewriter,id=3Drew0,netdev=3Dhn0,queue=3Dall \
> > +   -drive if=3Dnone,id=3Dparent0,file.filename=3D$imagefolder/primary-
> > copy.qcow2,driver=3Dqcow2 \
> > +   -drive
> > +if=3Dnone,id=3Dchilds0,driver=3Dreplication,mode=3Dsecondary,file.driv=
er=3Dqcow2,
> > +\
> > +top-id=3Dchilds0,file.file.filename=3D$imagefolder/secondary-active.qc=
ow2,\
> > +file.backing.driver=3Dqcow2,file.backing.file.filename=3D$imagefolder/=
secon
> > +dary-hidden.qcow2,\
> > +file.backing.backing=3Dparent0 \ =20
>=20
> Please keep the space style.

The Idea here is that this can simply be copy-pasted into a Terminal and it=
 will just=20
work without having to edit it manually.

> > +   -drive
> > +if=3Dide,id=3Dcolo-disk0,driver=3Dquorum,read-pattern=3Dfifo,vote-thre=
shold=3D1,\
> > +children.0.file=3Dchilds0,children.0.driver=3Draw \
> > +   -incoming tcp:0:9998
> > + =20
>=20
> Here, you changed the original block design, can you explain the reasons =
why we need to do this?
> Please draw a ASCII diagram to describe COLO block detail.

will do.

> >=20
> >  2. On Secondary VM's QEMU monitor, issue command
> > {'execute':'qmp_capabilities'} -{ 'execute': 'nbd-server-start',
> > -  'arguments': {'addr': {'type': 'inet', 'data': {'host': 'xx.xx.xx.xx=
', 'port':
> > '8889'} } } -}
> > -{'execute': 'nbd-server-add', 'arguments': {'device': 'secondary-disk0=
',
> > 'writable': true } }
> > +{'execute': 'nbd-server-start', 'arguments': {'addr': {'type': 'inet',
> > +'data': {'host': '127.0.0.1', 'port': '9999'} } } }
> > +{'execute': 'nbd-server-add', 'arguments': {'device': 'parent0',
> > +'writable': true } }
> >=20
> >  Note:
> >    a. The qmp command nbd-server-start and nbd-server-add must be run
> > @@ -184,12 +213,10 @@ Note:
> >=20
> >  3. On Primary VM's QEMU monitor, issue command:
> >  {'execute':'qmp_capabilities'}
> > -{ 'execute': 'human-monitor-command',
> > -  'arguments': {'command-line': 'drive_add -n buddy
> > driver=3Dreplication,mode=3Dprimary,file.driver=3Dnbd,file.host=3Dxx.xx=
.xx.xx,file.p
> > ort=3D8889,file.export=3Dsecondary-disk0,node-name=3Dnbd_client0'}}
> > -{ 'execute':'x-blockdev-change', 'arguments':{'parent': 'primary-disk0=
',
> > 'node': 'nbd_client0' } } -{ 'execute': 'migrate-set-capabilities',
> > -      'arguments': {'capabilities': [ {'capability': 'x-colo', 'state'=
: true } ] } }
> > -{ 'execute': 'migrate', 'arguments': {'uri': 'tcp:xx.xx.xx.xx:8888' } }
> > +{'execute': 'human-monitor-command', 'arguments': {'command-line':
> > +'drive_add -n buddy
> > +driver=3Dreplication,mode=3Dprimary,file.driver=3Dnbd,file.host=3D127.=
0.0.1,fil
> > +e.port=3D9999,file.export=3Dparent0,node-name=3Dreplication0'}}
> > +{'execute': 'x-blockdev-change', 'arguments':{'parent': 'colo-disk0',
> > +'node': 'replication0' } }
> > +{'execute': 'migrate-set-capabilities', 'arguments': {'capabilities': [
> > +{'capability': 'x-colo', 'state': true } ] } }
> > +{'execute': 'migrate', 'arguments': {'uri': 'tcp:127.0.0.1:9998' } }
> >=20
> >    Note:
> >    a. There should be only one NBD Client for each primary disk.
> > @@ -199,27 +226,91 @@ Note:
> >=20
> >  4. After the above steps, you will see, whenever you make changes to P=
VM,
> > SVM will be synced.
> >  You can issue command '{ "execute": "migrate-set-parameters" ,
> > "arguments":{ "x-checkpoint-delay": 2000 } }'
> > -to change the checkpoint period time
> > +to change the idle checkpoint period time
> >=20
> >  5. Failover test
> > -You can kill Primary VM and run 'x_colo_lost_heartbeat' in Secondary V=
M's -
> > monitor at the same time, then SVM will failover and client will not de=
tect
> > this -change.
> > +You can kill one of the VMs and Failover on the surviving VM:
> >=20
> > -Before issuing '{ "execute": "x-colo-lost-heartbeat" }' command, we ha=
ve to
> > -issue block related command to stop block replication.
> > -Primary:
> > -  Remove the nbd child from the quorum:
> > -  { 'execute': 'x-blockdev-change', 'arguments': {'parent': 'colo-disk=
0', 'child':
> > 'children.1'}}
> > -  { 'execute': 'human-monitor-command','arguments': {'command-line':
> > 'drive_del blk-buddy0'}}
> > -  Note: there is no qmp command to remove the blockdev now
> > +=3D=3D Primary Failover =3D=3D
> > +The Secondary died, resume on the Primary
> >=20
> > -Secondary:
> > -  The primary host is down, so we should do the following thing:
> > -  { 'execute': 'nbd-server-stop' }
> > +{'execute': 'x-blockdev-change', 'arguments':{ 'parent': 'colo-disk0',
> > +'child': 'children.1'} }
> > +{'execute': 'human-monitor-command', 'arguments':{ 'command-line':
> > +'drive_del replication0' } }
> > +{'execute': 'object-del', 'arguments':{ 'id': 'comp0' } }
> > +{'execute': 'object-del', 'arguments':{ 'id': 'iothread1' } }
> > +{'execute': 'object-del', 'arguments':{ 'id': 'm0' } }
> > +{'execute': 'object-del', 'arguments':{ 'id': 'redire0' } }
> > +{'execute': 'object-del', 'arguments':{ 'id': 'redire1' } }
> > +{'execute': 'x-colo-lost-heartbeat' }
> > +
> > +=3D=3D Secondary Failover =3D=3D
> > +The Primary died, resume on the Secondary and prepare to become the
> > new
> > +Primary
> > +
> > +{'execute': 'nbd-server-stop'}
> > +{'execute': 'x-colo-lost-heartbeat'}
> > +
> > +{'execute': 'object-del', 'arguments':{ 'id': 'f2' } }
> > +{'execute': 'object-del', 'arguments':{ 'id': 'f1' } }
> > +{'execute': 'chardev-remove', 'arguments':{ 'id': 'red1' } }
> > +{'execute': 'chardev-remove', 'arguments':{ 'id': 'red0' } }
> > +
> > +{'execute': 'chardev-add', 'arguments':{ 'id': 'mirror0', 'backend':
> > +{'type': 'socket', 'data': {'addr': { 'type': 'inet', 'data': { 'host':
> > +'127.0.0.1', 'port': '9003' } }, 'server': true } } } }
> > +{'execute': 'chardev-add', 'arguments':{ 'id': 'compare1', 'backend':
> > +{'type': 'socket', 'data': {'addr': { 'type': 'inet', 'data': { 'host':
> > +'127.0.0.1', 'port': '9004' } }, 'server': true } } } }
> > +{'execute': 'chardev-add', 'arguments':{ 'id': 'compare0', 'backend':
> > +{'type': 'socket', 'data': {'addr': { 'type': 'inet', 'data': { 'host':
> > +'127.0.0.1', 'port': '9001' } }, 'server': true } } } }
> > +{'execute': 'chardev-add', 'arguments':{ 'id': 'compare0-0', 'backend':
> > +{'type': 'socket', 'data': {'addr': { 'type': 'inet', 'data': { 'host':
> > +'127.0.0.1', 'port': '9001' } }, 'server': false } } } }
> > +{'execute': 'chardev-add', 'arguments':{ 'id': 'compare_out',
> > +'backend': {'type': 'socket', 'data': {'addr': { 'type': 'inet',
> > +'data': { 'host': '127.0.0.1', 'port': '9005' } }, 'server': true } } }
> > +}
> > +{'execute': 'chardev-add', 'arguments':{ 'id': 'compare_out0',
> > +'backend': {'type': 'socket', 'data': {'addr': { 'type': 'inet',
> > +'data': { 'host': '127.0.0.1', 'port': '9005' } }, 'server': false } }
> > +} }
> > +
> > +=3D=3D Primary resume replication =3D=3D
> > +Resume replication after new Secondary is up.
> > +
> > +Start the new Secondary, then:
> > +{'execute': 'drive-mirror', 'arguments':{ 'device': 'colo-disk0',
> > +'job-id': 'resync', 'target': 'nbd://127.0.0.1:9999/parent0', 'mode':
> > +'existing', 'format': 'raw', 'sync': 'full'} } =20
>=20
> I think the original secondary node has stopped the nbd server in failove=
r:
> > +{'execute': 'nbd-server-stop'}
> > +{'execute': 'x-colo-lost-heartbeat'} =20
>=20
> Why you can connect to it?

Oh, I meant it differently. You execute this only if you killed the Seconda=
ry.

Thats what I meant with "You can kill one of the VMs and Failover on=20
the surviving VM" above.

If you killed the Secondary, then you start a new Secondary (using the Seco=
ndary
commandline above, start nbd server and add the disk to the nbd server )=20
then execute the commands here under "Primary resume replication". After th=
at,=20
if you want to resume the replication, follow "Primary resume replication"

I will try to clarify this.

> And please add new Secondary node start up script here,
> I think it is different with original secondary node script.
> same issue in resume secondary.

No, Just the initial Primary cmdline is different. The Secondary cmdline is
always the same as above. Except if you run both on the same node, then you
need to choose a different Image than primary-copy.qcow2, I will clarify th=
is.

Regards,
Lukas Straub

> > +
> > +Wait until disk is synced, then:
> > +{'execute': 'stop'}
> > +{'execute': 'block-job-cancel', 'arguments':{ 'device': 'resync'} }
> > +
> > +{'execute': 'human-monitor-command', 'arguments':{ 'command-line':
> > +'drive_add -n buddy
> > +driver=3Dreplication,mode=3Dprimary,file.driver=3Dnbd,file.host=3D127.=
0.0.1,fil
> > +e.port=3D9999,file.export=3Dparent0,node-name=3Dreplication0'}}
> > +{'execute': 'x-blockdev-change', 'arguments':{ 'parent': 'colo-disk0',
> > +'node': 'replication0' } }
> > +
> > +{'execute': 'object-add', 'arguments':{ 'qom-type': 'filter-mirror',
> > +'id': 'm0', 'props': { 'netdev': 'hn0', 'queue': 'tx', 'outdev':
> > +'mirror0' } } }
> > +{'execute': 'object-add', 'arguments':{ 'qom-type':
> > +'filter-redirector', 'id': 'redire0', 'props': { 'netdev': 'hn0',
> > +'queue': 'rx', 'indev': 'compare_out' } } }
> > +{'execute': 'object-add', 'arguments':{ 'qom-type':
> > +'filter-redirector', 'id': 'redire1', 'props': { 'netdev': 'hn0',
> > +'queue': 'rx', 'outdev': 'compare0' } } }
> > +{'execute': 'object-add', 'arguments':{ 'qom-type': 'iothread', 'id':
> > +'iothread1' } }
> > +{'execute': 'object-add', 'arguments':{ 'qom-type': 'colo-compare',
> > +'id': 'comp0', 'props': { 'primary_in': 'compare0-0', 'secondary_in':
> > +'compare1', 'outdev': 'compare_out0', 'iothread': 'iothread1' } } }
> > +
> > +{'execute': 'migrate-set-capabilities', 'arguments':{ 'capabilities': [
> > +{'capability': 'x-colo', 'state': true } ] } }
> > +{'execute': 'migrate', 'arguments':{ 'uri': 'tcp:127.0.0.1:9998' } }
> > +
> > +Note:
> > +If this Primary previously was a Secondary, then we need to insert the
> > +filters before the filter-rewriter by using the
> > +"'insert': 'before', 'position': 'rew0'" Options. See below.
> > +
> > +=3D=3D Secondary resume replication =3D=3D
> > +Become Primary and resume replication after new Secondary is up.
> > +
> > +Start the new Secondary, then:
> > +{'execute': 'drive-mirror', 'arguments':{ 'device': 'colo-disk0',
> > +'job-id': 'resync', 'target': 'nbd://127.0.0.1:9999/parent0', 'mode':
> > +'existing', 'format': 'raw', 'sync': 'full'} } =20
>=20
> Same issue as primary resume.
>=20
> I want to re-tested the resume function but got stuck here.
>=20
> Thanks
> Zhang Chen
>=20
> > +
> > +Wait until disk is synced, then:
> > +{'execute': 'stop'}
> > +{'execute': 'block-job-cancel', 'arguments':{ 'device': 'resync' } }
> > +
> > +{'execute': 'human-monitor-command', 'arguments':{ 'command-line':
> > +'drive_add -n buddy
> > +driver=3Dreplication,mode=3Dprimary,file.driver=3Dnbd,file.host=3D127.=
0.0.1,fil
> > +e.port=3D9999,file.export=3Dparent0,node-name=3Dreplication0'}}
> > +{'execute': 'x-blockdev-change', 'arguments':{ 'parent': 'colo-disk0',
> > +'node': 'replication0' } }
> > +
> > +{'execute': 'object-add', 'arguments':{ 'qom-type': 'filter-mirror',
> > +'id': 'm0', 'props': { 'insert': 'before', 'position': 'rew0',
> > +'netdev': 'hn0', 'queue': 'tx', 'outdev': 'mirror0' } } }
> > +{'execute': 'object-add', 'arguments':{ 'qom-type':
> > +'filter-redirector', 'id': 'redire0', 'props': { 'insert': 'before',
> > +'position': 'rew0', 'netdev': 'hn0', 'queue': 'rx', 'indev':
> > +'compare_out' } } }
> > +{'execute': 'object-add', 'arguments':{ 'qom-type':
> > +'filter-redirector', 'id': 'redire1', 'props': { 'insert': 'before',
> > +'position': 'rew0', 'netdev': 'hn0', 'queue': 'rx', 'outdev':
> > +'compare0' } } }
> > +{'execute': 'object-add', 'arguments':{ 'qom-type': 'iothread', 'id':
> > +'iothread1' } }
> > +{'execute': 'object-add', 'arguments':{ 'qom-type': 'colo-compare',
> > +'id': 'comp0', 'props': { 'primary_in': 'compare0-0', 'secondary_in':
> > +'compare1', 'outdev': 'compare_out0', 'iothread': 'iothread1' } } }
> > +
> > +{'execute': 'migrate-set-capabilities', 'arguments':{ 'capabilities': [
> > +{'capability': 'x-colo', 'state': true } ] } }
> > +{'execute': 'migrate', 'arguments':{ 'uri': 'tcp:127.0.0.1:9998' } }
> >=20
> >  =3D=3D TODO =3D=3D
> > -1. Support continuous VM replication.
> > -2. Support shared storage.
> > -3. Develop the heartbeat part.
> > -4. Reduce checkpoint VM=E2=80=99s downtime while doing checkpoint.
> > +1. Support shared storage.
> > +2. Develop the heartbeat part.
> > +3. Reduce checkpoint VM=E2=80=99s downtime while doing checkpoint.
> > --
> > 2.20.1 =20


