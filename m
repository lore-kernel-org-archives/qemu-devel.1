Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857A2C47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 18:46:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E77420679
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 18:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="St/kaTtM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E77420679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIGyq-000842-Eq
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 14:46:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39487)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1iIDiK-0007Of-S3
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 11:17:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lukasstraub2@web.de>) id 1iIDiI-0000F6-Cn
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 11:17:20 -0400
Received: from mout.web.de ([217.72.192.78]:53457)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lukasstraub2@web.de>)
 id 1iIDiC-000093-MY; Wed, 09 Oct 2019 11:17:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1570634198;
 bh=9scTa3yzzsAAhNhN9s+98KPXwDOkyGVypIVbCKhfc0c=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=St/kaTtM9UJRjyYPPl4Efln0WsLp0oFpHRnsu7g7XUDy0zSYKDdtWbfKwg0g+8M0R
 E+DSecAaySLPrIYf5nT8LD7YXjwyQsKkQi18SQfP7WyvJHUG7C0FIExn4VwYjLBLXY
 83k3KfLxKuSAIH/7xPxobwV50LU5foeuvkXdRVp4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.16]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LpO93-1hd5zH0pFd-00fAoh; Wed, 09
 Oct 2019 17:16:38 +0200
Date: Wed, 9 Oct 2019 17:16:35 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: "Zhang, Chen" <chen.zhang@intel.com>
Subject: Re: [PATCH v6 4/4] colo: Update Documentation for continuous
 replication
Message-ID: <20191009171635.0cb4fa12@luklap>
In-Reply-To: <9CFF81C0F6B98A43A459C9EDAD400D78062A7867@shsmsx102.ccr.corp.intel.com>
References: <cover.1570280098.git.lukasstraub2@web.de>
 <23a8a3d00523999e2b6f52074fa0f4c7f3f469ef.1570280098.git.lukasstraub2@web.de>
 <9CFF81C0F6B98A43A459C9EDAD400D78062A7867@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QjYFCkCIfjycFeW7O5zZLTfAiNVl1PEmJM20I74cAGiW/1w96oq
 rC+L31Q9+bXwuP5F0lWCbm8kEEzuXNAOhBpyonv/3Kzwqz9n/s/rUVWcgIGo++qudop2o8w
 D7g10K1laOOCwj9lebX96gyNZlZiAziSLmndAH8w0KZF4UkjlovtB7IxMq2b2AaR3rOqq1F
 kWyI9jeZ0kc65Ov9TmH4Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4rfbb+c+5yo=:pnMrzchEFpoqq+9jUyTSX7
 kG0/160Ug5TQFLbAqtR7sa8tY9IX9Y5xAQ3BGPaXo/TNZCh0LVGgWWX3/wfdjwXKfSSd7BECY
 /weIjs7FKJjlPG1AoS24LY64YopnZg6Sz5FKBVX/V+QyUVGC5JQzN+ADKtnHbq/WxId7IzNcZ
 TIO9v7j/wrjqTkclCP34gXbErcyHn+FJyNobLa5vY0pGNUM0Fb8sK50SqKeW8PWJhigBHV6MN
 og+udU59bJyMSmjmsXYPoH1wXoDqbf+2YPpo5rbfF+omJRH/PzlXBqWLYOJBhr/bIGCahS+OE
 icZcB0WVakczvccRTxr4UNUH/TAPnxXIFWBCsS7ysz/bTml4+9zGsChyJL8oYmzMNKTOlT2xk
 lf1hEh/HK6Zcm1jgLCaoN9dTarInmSoWcO4FXmNDtcwDQ5BfKfZlJsyesIeB4YcZpWmEnIuiw
 GosJTN3VTov54RWYFum6E0mPob+pOrioocKOnWxnEEZ+Xz/zuIGUMytRy7vLv0Roj9tihS6rs
 TSAAC4mFeTJq9tqc/vJC1SfxrQAV2M93KlTR+fgrmsDmZOpNaLv6fESTUkqDtjEjLhPptz016
 SV+j9llxMWMtYBKEr8wWAIFeUupqLZXiWbC5pP8debssFmp57nV6XENjl7xfns8JeEE6Pxkcm
 QoytxBF35IfdchO1MC9YYRlVw56LJ1RkhrcO815ToD3DWCH5HRKDoWID42NyfZK3SQ7hLxWS7
 M6TEPyIh2FhyeOZvIi2aZfjmDZA157QSEXeEnWHg/2hLJF3AP2uXTdTcMuOur9jQ0Cu+Xa/Va
 9rS9T7BNuD4jXfevNbjPljDSBJerthKUmcY8neWXnA4OauSUokPEdplhpGCI9RYzlVFdp+8BC
 bbg2H8YnCZzOUgH8KBWVfO4poWIb6puuMFK+U1/+PiCObegjT/4oawghoylhBErhEKvv/A9Q6
 /QQMTMMWXcwgsyGwMpJWPfIChbqMRquT9Jcx1hNJwDxamBw1Lnx8P0rpa3I4CfZaCnHvU0kBD
 irNUhTUxB/Hzf9E5JzuZzzVdFT9/kmTiNgBz9voYq0nIOgcnraW1js5AnLtETMBHAfrHn2Hwv
 d4vC2JTyXGeu7fV5Fg9z4pWva+CInkjAQu4S7nBburMQ+h8CGSLm/t3duRoInf1xmJWdmT+dI
 y9uDpJ9n3ATsGL0ehbiyTV6tfVj8myLXez2yQgFXmUUC6oqd57lPz+CTMBuDp+fkoD9mnXo5t
 SEnK1uygXKmpkKk+DnSAsVOzizXPAzGGUVWumkSB/RzG4YqpjevRQAAp2Hck=
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block <qemu-block@nongnu.org>,
 Wen Congyang <wencongyang2@huawei.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Xie Changlong <xiechanglong.d@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 9 Oct 2019 08:36:52 +0000
"Zhang, Chen" <chen.zhang@intel.com> wrote:

> > -----Original Message-----
> > From: Lukas Straub <lukasstraub2@web.de>
> > Sent: Saturday, October 5, 2019 9:06 PM
> > To: qemu-devel <qemu-devel@nongnu.org>
> > Cc: Zhang, Chen <chen.zhang@intel.com>; Jason Wang
> > <jasowang@redhat.com>; Wen Congyang <wencongyang2@huawei.com>;
> > Xie Changlong <xiechanglong.d@gmail.com>; Kevin Wolf
> > <kwolf@redhat.com>; Max Reitz <mreitz@redhat.com>; qemu-block
> > <qemu-block@nongnu.org>
> > Subject: [PATCH v6 4/4] colo: Update Documentation for continuous
> > replication
> >=20
> > Document the qemu command-line and qmp commands for continuous
> > replication
> >=20
> > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> > ---
> >  docs/COLO-FT.txt           | 213 +++++++++++++++++++++++++++----------
> >  docs/block-replication.txt |  28 +++--
> >  2 files changed, 174 insertions(+), 67 deletions(-)
> >=20
> > diff --git a/docs/COLO-FT.txt b/docs/COLO-FT.txt index
> > ad24680d13..bc1a0ccb99 100644
> > --- a/docs/COLO-FT.txt
> > +++ b/docs/COLO-FT.txt
> > @@ -145,35 +145,65 @@ The diagram just shows the main qmp command,
> > you can get the detail  in test procedure.
> >=20
> > ...
> >
> > +Note: Here we are running both instances on the same Host for testing,
> > +change the IP Addresses if you want to run it on two Hosts. Initally
> > +127.0.0.1 is the Primary Host and 127.0.0.2 is the Secondary Host.
> > +
> > +=3D=3D Startup qemu =3D=3D
> > +1. Primary:
> > +Note: Initally, $imagefolder/primary.qcow2 needs to be copied to all H=
osts.
> > +# imagefolder=3D"/mnt/vms/colo-test-primary"
> > +
> > +# qemu-system-x86_64 -enable-kvm -cpu qemu64,+kvmclock -m 512 -smp
> > 1 -qmp stdio \
> > +   -device piix3-usb-uhci -device usb-tablet -name primary \
> > +   -netdev tap,id=3Dhn0,vhost=3Doff,helper=3D/usr/lib/qemu/qemu-bridge=
-helper
> > \
> > +   -device rtl8139,id=3De0,netdev=3Dhn0 \
> > +   -chardev socket,id=3Dmirror0,host=3D0.0.0.0,port=3D9003,server,nowa=
it \
> > +   -chardev socket,id=3Dcompare1,host=3D0.0.0.0,port=3D9004,server,wai=
t \ =20
>=20
> We should change the host=3D127.0.0.1 consistent with the expression belo=
w.

Hi,
This (and the IPs below in the QMP commands) needs to be this way, because=
=20
it's a listening port and with 127.0.0.1 it would only listen on the loopba=
ck ip
and wouldn't be reachable from another node for example. With 0.0.0.0 it wi=
ll
listen on all Interfaces.

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
> > +# imagefolder=3D"/mnt/vms/colo-test-secondary"
> > +# primary_ip=3D127.0.0.1
> > +
> > +# qemu-img create -f qcow2 $imagefolder/secondary-active.qcow2 10G
> > +
> > +# qemu-img create -f qcow2 $imagefolder/secondary-hidden.qcow2 10G
> > + =20
>=20
> The active disk and hidden disk just need create one time, we can note th=
at here.

Ok, I will Note that. But I will wait until the block changes are reviewed =
before sending the next version.

Regards,
Lukas Straub

> > +# qemu-system-x86_64 -enable-kvm -cpu qemu64,+kvmclock -m 512 -smp
> > 1 -qmp stdio \
> > +   -device piix3-usb-uhci -device usb-tablet -name secondary \
> > +   -netdev tap,id=3Dhn0,vhost=3Doff,helper=3D/usr/lib/qemu/qemu-bridge=
-helper
> > \
> > +   -device rtl8139,id=3De0,netdev=3Dhn0 \
> > +   -chardev socket,id=3Dred0,host=3D$primary_ip,port=3D9003,reconnect=
=3D1 \
> > +   -chardev socket,id=3Dred1,host=3D$primary_ip,port=3D9004,reconnect=
=3D1 \
> > +   -object filter-redirector,id=3Df1,netdev=3Dhn0,queue=3Dtx,indev=3Dr=
ed0 \
> > +   -object filter-redirector,id=3Df2,netdev=3Dhn0,queue=3Drx,outdev=3D=
red1 \
> > +   -object filter-rewriter,id=3Drew0,netdev=3Dhn0,queue=3Dall \
> > +   -drive
> > if=3Dnone,id=3Dparent0,file.filename=3D$imagefolder/primary.qcow2,drive=
r=3Dqcow
> > 2 \
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
> > +   -incoming tcp:0.0.0.0:9998
> > +
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
> > +'data': {'host': '0.0.0.0', 'port': '9999'} } } }
> > +{'execute': 'nbd-server-add', 'arguments': {'device': 'parent0',
> > +'writable': true } }
> >=20
> >  Note:
> >    a. The qmp command nbd-server-start and nbd-server-add must be run
> > @@ -182,44 +212,113 @@ Note:
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
0.0.2,fil
> > +e.port=3D9999,file.export=3Dparent0,node-name=3Dreplication0'}}
> > +{'execute': 'x-blockdev-change', 'arguments':{'parent': 'colo-disk0',
> > +'node': 'replication0' } }
> > +{'execute': 'migrate-set-capabilities', 'arguments': {'capabilities': [
> > +{'capability': 'x-colo', 'state': true } ] } }
> > +{'execute': 'migrate', 'arguments': {'uri': 'tcp:127.0.0.2:9998' } }
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
> > +'0.0.0.0', 'port': '9003' } }, 'server': true } } } } =20
>=20
> Same like I said before.
>=20
> Others statement looks good for me.
>=20
> Thanks
> Zhang Chen
>=20
> > +{'execute': 'chardev-add', 'arguments':{ 'id': 'compare1', 'backend':
> > +{'type': 'socket', 'data': {'addr': { 'type': 'inet', 'data': { 'host':
> > +'0.0.0.0', 'port': '9004' } }, 'server': true } } } }
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
> > +Start the new Secondary (Steps 2 and 3 above), then on the Primary:
> > +{'execute': 'drive-mirror', 'arguments':{ 'device': 'colo-disk0',
> > +'job-id': 'resync', 'target': 'nbd://127.0.0.2:9999/parent0', 'mode':
> > +'existing', 'format': 'raw', 'sync': 'full'} }
> > +
> > +Wait until disk is synced, then:
> > +{'execute': 'stop'}
> > +{'execute': 'block-job-cancel', 'arguments':{ 'device': 'resync'} }
> > +
> > +{'execute': 'human-monitor-command', 'arguments':{ 'command-line':
> > +'drive_add -n buddy
> > +driver=3Dreplication,mode=3Dprimary,file.driver=3Dnbd,file.host=3D127.=
0.0.2,fil
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
> > +{'execute': 'migrate', 'arguments':{ 'uri': 'tcp:127.0.0.2:9998' } }
> > +
> > +Note:
> > +If this Primary previously was a Secondary, then we need to insert the
> > +filters before the filter-rewriter by using the
> > +"'insert': 'before', 'position': 'id=3Drew0'" Options. See below.
> > +
> > +=3D=3D Secondary resume replication =3D=3D
> > +Become Primary and resume replication after new Secondary is up. Note
> > +that now 127.0.0.1 is the Secondary and 127.0.0.2 is the Primary.
> > +
> > +Start the new Secondary (Steps 2 and 3 above, but with
> > +primary_ip=3D127.0.0.2), then on the old Secondary:
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

