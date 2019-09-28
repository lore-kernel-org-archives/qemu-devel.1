Return-Path: <SRS0=JFFZ=XX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44F8C4360C
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Sep 2019 13:33:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 901A620815
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Sep 2019 13:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="b57vfFC5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 901A620815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iECqX-0005ot-Th
	for qemu-devel@archiver.kernel.org; Sat, 28 Sep 2019 09:33:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41254)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1iECjT-0003me-SK
 for qemu-devel@nongnu.org; Sat, 28 Sep 2019 09:25:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lukasstraub2@web.de>) id 1iECjQ-0004Ki-OZ
 for qemu-devel@nongnu.org; Sat, 28 Sep 2019 09:25:55 -0400
Received: from mout.web.de ([217.72.192.78]:58949)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lukasstraub2@web.de>) id 1iECjQ-0004Iz-6z
 for qemu-devel@nongnu.org; Sat, 28 Sep 2019 09:25:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1569677122;
 bh=EFCHJvbwaR62BdNYv+yVrs8ySnWVlIFqv1n0btEycLI=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=b57vfFC5+K1481PPL0RoWs1A2E3eVNjhD9f+FcOiWLZ/oEUjnCe6njXHuHKKKinoW
 VY1f07IqiTwwLm4srru58J56MAqyWeps15MhOLG/Yk1qCJVyyIrfZsMstQIkFBualx
 21hLv+HdGikpRJ7VDDMcU5z26rRAC+DZSq1lFm9E=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.13]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Llna8-1hf91O28h6-00ZSKu; Sat, 28
 Sep 2019 15:25:22 +0200
Date: Sat, 28 Sep 2019 15:25:14 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: "Zhang, Chen" <chen.zhang@intel.com>
Subject: Re: [PATCH v5 4/4] colo: Update Documentation for continuous
 replication
Message-ID: <20190928152514.5e9dea19@luklap>
In-Reply-To: <9CFF81C0F6B98A43A459C9EDAD400D780627E6DC@shsmsx102.ccr.corp.intel.com>
References: <cover.1568574478.git.lukasstraub2@web.de>
 <ff0563b90eb28856cc1bf04e04a99f74784e8efc.1568574479.git.lukasstraub2@web.de>
 <9CFF81C0F6B98A43A459C9EDAD400D780627E6DC@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6ynWxegRvutFTgwuV/CgJbVjH4eqyqo+HKael0g9Q1LQZNDSQMP
 OtemNzNDrX7+aF5OMxZ2kpUOTJGYFq4/q0EYegmfPiVNGWrtz0UK5xI/TvFTagym9ADCs2V
 kAxj0FWFX1PCFxNo7KsnDkbaMZwG6gn/hSgpNlHKlc09DNwmkqKQjr79yGHnVDoqbahxiLi
 K93e93xFT9cQDsPv0HAMw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WP5HuqCqk1k=:zrkxj1w+XBn9/ew/q/Bc2v
 1hUPqeQQ45R3xV7/0cxGMwqxWTB5A/LpJqlzdIMzL9FsvNmatc7UEwW3rDkAVstsJ4odkJIiB
 kplAlszBzE5RK1DUGFzN0bW6Pv8gCxWkS7OgNwDfhApTdxOw2Z0I0U1rzXqoT1hrfodiWiydT
 M53ous4FLlmb5joZ6G95Z7yMs/Os6YtUrYsDwnSyEnHn7hCkaRmJAmC4IvNUAd6PEyxd3khya
 APNYcKDGFY3ZRhcJgzsB0KKPw78ep3gNfYtCzPiaJz4avYJw20pavg4LtJZUIJo8+ZYF9SAYw
 YkuZ6KALItVk+UMMjCjSgSgpo2IKmqwpHO6NzFkiMPLgijoFacSoeEs8cpXb7sFoJYTlQCutA
 G/1bFiJ0v04Qp73cagE/PM/WS9sJoWXX7rpjGjYiqRvZ0bRMFRGgiqwkRYKr/wbzCPwFx0e5b
 bF0jHm/IsDxTFDOgewpii9Z2tVNAfjp0JezlbL21r8JuTegqjbtCkrYKDjwGyRdpSL2+1O6DZ
 Ycw5v5DOY5XukZsEdjyUSGgsWGOIzU9uouMVvnrjQwi8p00u8agd+k2lV6QYi/Ha7Axu7qErN
 wQ/9UReUpQ2qjSS7VtedH5ykifSh1NMwXLo/BbVMVoXXoH6hnPXsNMdgNNAVwys6m3YaXAaAF
 2hBvqM55Q1PrMrkMmk+MdtA7bNPMQOtv2R16gxDlrcDnFH563UgMWTMvHYot4P9iBkywt67AW
 IDuPLeiUfSYeakIjIVkJZG2l9AhEMiDkraU97Aw8VGrGxJyyFvDYrjgr4iheW/E+XF7I9JMtp
 Lhuz+oH54D3wFYzAhLJcseAqHDMgAB90j5RzEaBjUMPh623TU0WLNQVeKZjwu88HO5bgEgYv7
 iszxSvxFBaGUii2oIRey7APH/gwKE2ArbV7zvL7+xqYxDldcsq6Dhxs15cQhDaVdJod2kf5ST
 Xq3ByurFcNcaTRYP7LWbU3JuPbGLWAt41Vs2UZ30Vr//nubVZh7UubUZKEDRB3ifGxMjB6hNk
 12pz2qNrOlpZmQM6eU5BnIWRYJL1RawbjTpKKDNexXAM2aI/aifxM1Srg4ad1JT4kvCnKj/60
 9qV6KpNmEAZ8BqoyznBiaua74dwi+qaAN7mEjKtRpNW5CsiQILHpD+Hfc/UGlc5OleiT/0Y+P
 HUs4tt6JTBpJiS9kkhrUXzipoN02GAgSvowk1PGewUPeOFO36Ol4nwxK9ewXwU+dgxbUNEkrR
 XdX8dACdon3LsfUHPXjpQkLavfYaqWjI2ut1zZW9GDv4J92S3ZWFNfKOqf3Y=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 217.72.192.78
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, "mreitz@redhat.com" <mreitz@redhat.com>,
 Xie Changlong <xiechanglong.d@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 26 Sep 2019 17:27:35 +0000
"Zhang, Chen" <chen.zhang@intel.com> wrote:

> > -----Original Message-----
> > From: Lukas Straub <lukasstraub2@web.de>
> > Sent: Monday, September 16, 2019 3:20 AM
> > To: qemu-devel <qemu-devel@nongnu.org>
> > Cc: Zhang, Chen <chen.zhang@intel.com>; Jason Wang
> > <jasowang@redhat.com>; Wen Congyang <wencongyang2@huawei.com>;
> > Xie Changlong <xiechanglong.d@gmail.com>; kwolf@redhat.com;
> > mreitz@redhat.com
> > Subject: [PATCH v5 4/4] colo: Update Documentation for continuous
> > replication
> >=20
> > Document the qemu command-line and qmp commands for continuous
> > replication
> >=20
> > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> > ---
> >  docs/COLO-FT.txt           | 212 +++++++++++++++++++++++++++----------
> >  docs/block-replication.txt |  28 +++--
> >  2 files changed, 173 insertions(+), 67 deletions(-)
> >=20
> > diff --git a/docs/COLO-FT.txt b/docs/COLO-FT.txt index
> > ad24680d13..e98c95ca2b 100644
> > --- a/docs/COLO-FT.txt
> > +++ b/docs/COLO-FT.txt
> > @@ -145,35 +145,65 @@ The diagram just shows the main qmp command,
> > you can get the detail  in test procedure.
> >=20
> >  =3D=3D Test procedure =3D=3D
> > -1. Startup qemu
> > -Primary:
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
> > -Secondary:
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
> > -
> > -2. On Secondary VM's QEMU monitor, issue command
> > +Note: Here we are running both instances on the same Machine for
> > +testing, change the IP Addresses if you want to run it on two Hosts
> > +
> > +=3D=3D Startup qemu =3D=3D
> > +1. Primary:
> > +# imagefolder=3D"/mnt/vms/colo-test"
> > +
> > +The disks for the primary and secondary need to be the same before
> > +starting colo # cp --reflink=3Dauto $imagefolder/primary.qcow2
> > +$imagefolder/primary-copy.qcow2
> > +
> > +# qemu-system-x86_64 -enable-kvm -cpu qemu64,+kvmclock -m 512 -smp
> > 1 -qmp stdio \
> > +   -vnc :0 -device piix3-usb-uhci -device usb-tablet -name primary \
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
> > +outdev=3Dcompare_out0,iothread=3Diothread1 \
> > +   -drive
> > +if=3Dide,id=3Dcolo-disk0,driver=3Dquorum,read-pattern=3Dfifo,vote-thre=
shold=3D1,\
> > +children.0.file.filename=3D$imagefolder/primary.qcow2,children.0.drive=
r=3Dq
> > +cow2 -S
> > +
> > +2. Secondary:
> > +# imagefolder=3D"/mnt/vms/colo-test"
> > +
> > +# qemu-img create -f qcow2 $imagefolder/secondary-active.qcow2 10G
> > +
> > +# qemu-img create -f qcow2 $imagefolder/secondary-hidden.qcow2 10G
> > +
> > +# qemu-system-x86_64 -enable-kvm -cpu qemu64,+kvmclock -m 512 -smp
> > 1 -qmp stdio \
> > +   -vnc :1 -device piix3-usb-uhci -device usb-tablet -name secondary \
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
> > +file.backing.backing=3Dparent0 \
> > +   -drive
> > +if=3Dide,id=3Dcolo-disk0,driver=3Dquorum,read-pattern=3Dfifo,vote-thre=
shold=3D1,\
> > +children.0=3Dchilds0 \
> > +   -incoming tcp:0:9998
> > + =20
>=20
> I know in your COLO test environment, all the node running in same physic=
al machine,
> but current COLO start parameter demo easy to misunderstand users.
> I think we can introduce primary node as 192.168.1.1, secondary node as 1=
92.168.1.2.
> Same issue for the VM image, we should avoid the "primary-copy.qow2".=20
> Make two node independent is more clear.=20
>=20

Ok, I will remove the primary-copy stuff. But I have a better idea for the =
IP addresses:
Using 127.0.0.1 for Primary and 127.0.0.2 for Secondary. Both point to loca=
lhost, making
quick testing by simple copy-paste possible when using different values for=
 the imagefolder
Variable. At the same time Users see which IP to substitute for the remote =
node when using=20
multiple Hosts and we avoid the confusion with primary-copy.
What do you think?

>=20
> > +
> > +3. On Secondary VM's QEMU monitor, issue command
> >  {'execute':'qmp_capabilities'}
> > -{ 'execute': 'nbd-server-start',
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
> > @@ -182,44 +212,112 @@ Note:
> >       same.
> >    c. It is better to put active disk and hidden disk in ramdisk.
> >=20
> > -3. On Primary VM's QEMU monitor, issue command:
> > +4. On Primary VM's QEMU monitor, issue command:
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
> > -  b. xx.xx.xx.xx is the secondary physical machine's hostname or IP
> > -  c. The qmp command line must be run after running qmp command line in
> > +  b. The qmp command line must be run after running qmp command line in
> >       secondary qemu.
> >=20
> > -4. After the above steps, you will see, whenever you make changes to P=
VM,
> > SVM will be synced.
> > +5. After the above steps, you will see, whenever you make changes to P=
VM,
> > SVM will be synced.
> >  You can issue command '{ "execute": "migrate-set-parameters" ,
> > "arguments":{ "x-checkpoint-delay": 2000 } }'
> > -to change the checkpoint period time
> > +to change the idle checkpoint period time
> > +
> > +6. Failover test
> > +You can kill one of the VMs and Failover on the surviving VM:
> > +
> > +If you killed the Secondary, then follow "Primary Failover". After
> > +that, if you want to resume the replication, follow "Primary resume
> > replication"
> > +
> > +If you killed the Primary, then follow "Secondary Failover". After
> > +that, if you want to resume the replication, follow "Secondary resume
> > replication"
> > +
> > +=3D=3D Primary Failover =3D=3D
> > +The Secondary died, resume on the Primary
> > +
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
> > +Start the new Secondary (Steps 2 and 3 above), then: =20
>=20
> Please note here the "then" is the original secondary node.
> It is easy to misunderstand here.

Ok, I will make this more clear.

> > +{'execute': 'drive-mirror', 'arguments':{ 'device': 'colo-disk0',
> > +'job-id': 'resync', 'target': 'nbd://127.0.0.1:9999/parent0', 'mode':
> > +'existing', 'format': 'raw', 'sync': 'full'} }
> > + =20
>=20
> As I mentioned before, the 'nbd://127.0.0.1:9999/parent0' is very confusi=
ng, user don't know which node will be connected.
>=20
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
> > + =20
>=20
> The guest network have issues here in my test, I can't ping the guest fro=
m the host.
> Is it works in your test environment?

Yes, it works for me (based on v4.1.0). I simply copy-paste everything here=
 1:1
for testing.

Regards,
Lukas Straub

> By the way, after finish this doc we can sync it to Qemu COLO WIKI page.
>=20
> Thanks
> Zhang Chen
>=20
>=20
> > +Note:
> > +If this Primary previously was a Secondary, then we need to insert the
> > +filters before the filter-rewriter by using the
> > +"'insert': 'before', 'position': 'rew0'" Options. See below.
> > +
> > +=3D=3D Secondary resume replication =3D=3D
> > +Become Primary and resume replication after new Secondary is up.
> > +
> > +Start the new Secondary (Steps 2 and 3 above, but with different image
> > +than
> > +primary-copy.qcow2 and different VNC port), then:
> > +{'execute': 'drive-mirror', 'arguments':{ 'device': 'colo-disk0',
> > +'job-id': 'resync', 'target': 'nbd://127.0.0.1:9999/parent0', 'mode':
> > +'existing', 'format': 'raw', 'sync': 'full'} }
> > +
> > +Wait until disk is synced, then:
> > +{'execute': 'stop'}
> > +{'execute': 'block-job-cancel', 'arguments':{ 'device': 'resync' } }
> >=20
> > -5. Failover test
> > -You can kill Primary VM and run 'x_colo_lost_heartbeat' in Secondary V=
M's -
> > monitor at the same time, then SVM will failover and client will not de=
tect
> > this -change.
> > +{'execute': 'human-monitor-command', 'arguments':{ 'command-line':
> > +'drive_add -n buddy
> > +driver=3Dreplication,mode=3Dprimary,file.driver=3Dnbd,file.host=3D127.=
0.0.1,fil
> > +e.port=3D9999,file.export=3Dparent0,node-name=3Dreplication0'}}
> > +{'execute': 'x-blockdev-change', 'arguments':{ 'parent': 'colo-disk0',
> > +'node': 'replication0' } }
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
> > +{'execute': 'object-add', 'arguments':{ 'qom-type': 'filter-mirror',
> > +'id': 'm0', 'props': { 'insert': 'before', 'position': 'id=3Drew0',
> > +'netdev': 'hn0', 'queue': 'tx', 'outdev': 'mirror0' } } }
> > +{'execute': 'object-add', 'arguments':{ 'qom-type':
> > +'filter-redirector', 'id': 'redire0', 'props': { 'insert': 'before',
> > +'position': 'id=3Drew0', 'netdev': 'hn0', 'queue': 'rx', 'indev':
> > +'compare_out' } } }
> > +{'execute': 'object-add', 'arguments':{ 'qom-type':
> > +'filter-redirector', 'id': 'redire1', 'props': { 'insert': 'before',
> > +'position': 'id=3Drew0', 'netdev': 'hn0', 'queue': 'rx', 'outdev':
> > +'compare0' } } }
> > +{'execute': 'object-add', 'arguments':{ 'qom-type': 'iothread', 'id':
> > +'iothread1' } }
> > +{'execute': 'object-add', 'arguments':{ 'qom-type': 'colo-compare',
> > +'id': 'comp0', 'props': { 'primary_in': 'compare0-0', 'secondary_in':
> > +'compare1', 'outdev': 'compare_out0', 'iothread': 'iothread1' } } }
> >=20
> > -Secondary:
> > -  The primary host is down, so we should do the following thing:
> > -  { 'execute': 'nbd-server-stop' }
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
> > diff --git a/docs/block-replication.txt b/docs/block-replication.txt in=
dex
> > 6bde6737fb..108e9166a8 100644
> > --- a/docs/block-replication.txt
> > +++ b/docs/block-replication.txt
> > @@ -65,12 +65,12 @@ blocks that are already in QEMU.
> >               ^            ||                            .----------
> >               |            ||                            | Secondary
> >          1 Quorum          ||                            '----------
> > -         /      \         ||
> > -        /        \        ||
> > -   Primary    2 filter
> > -     disk         ^                                                   =
          virtio-blk
> > -                  |                                                   =
               ^
> > -                3 NBD  ------->  3 NBD                                =
               |
> > +         /      \         ||                                          =
                 virtio-blk
> > +        /        \        ||                                          =
                     ^
> > +   Primary    2 filter                                                =
                     |
> > +     disk         ^                                                   =
                7 Quorum
> > +                  |                                                   =
                 /
> > +                3 NBD  ------->  3 NBD                                =
                /
> >                  client    ||     server                               =
           2 filter
> >                            ||        ^                                 =
               ^
> >  --------.                 ||        |                                 =
               |
> > @@ -106,6 +106,10 @@ any state that would otherwise be lost by the
> > speculative write-through  of the NBD server into the secondary disk. So
> > before block replication,  the primary disk and secondary disk should c=
ontain
> > the same data.
> >=20
> > +7) The secondary also has a quorum node, so after secondary failover it
> > +can become the new primary and continue replication.
> > +
> > +
> >  =3D=3D Failure Handling =3D=3D
> >  There are 7 internal errors when block replication is running:
> >  1. I/O error on primary disk
> > @@ -171,16 +175,18 @@ Primary:
> >       leading whitespace.
> >    5. The qmp command line must be run after running qmp command line in
> >       secondary qemu.
> > -  6. After failover we need remove children.1 (replication driver).
> > +  6. After primary failover we need remove children.1 (replication dri=
ver).
> >=20
> >  Secondary:
> >    -drive if=3Dnone,driver=3Draw,file.filename=3D1.raw,id=3Dcolo1 \
> > -  -drive if=3Dxxx,id=3Dtopxxx,driver=3Dreplication,mode=3Dsecondary,to=
p-
> > id=3Dtopxxx\
> > +  -drive
> > + if=3Dnone,id=3Dchilds1,driver=3Dreplication,mode=3Dsecondary,top-id=
=3Dchilds1
> >           file.file.filename=3Dactive_disk.qcow2,\
> >           file.driver=3Dqcow2,\
> >           file.backing.file.filename=3Dhidden_disk.qcow2,\
> >           file.backing.driver=3Dqcow2,\
> >           file.backing.backing=3Dcolo1
> > +  -drive if=3Dxxx,driver=3Dquorum,read-pattern=3Dfifo,id=3Dtop-disk1,\
> > +         vote-threshold=3D1,children.0=3Dchilds1
> >=20
> >    Then run qmp command in secondary qemu:
> >      { 'execute': 'nbd-server-start',
> > @@ -234,6 +240,8 @@ Secondary:
> >    The primary host is down, so we should do the following thing:
> >    { 'execute': 'nbd-server-stop' }
> >=20
> > +Promote Secondary to Primary:
> > +  see COLO-FT.txt
> > +
> >  TODO:
> > -1. Continuous block replication
> > -2. Shared disk
> > +1. Shared disk
> > --
> > 2.20.1 =20


