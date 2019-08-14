Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BAE5C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 20:57:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7CEC216F4
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 20:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="TkqdvULy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7CEC216F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hy0Kd-0005H2-RK
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 16:57:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38011)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1hy0Ce-00018C-26
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 16:49:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lukasstraub2@web.de>) id 1hy0Cb-0001Eg-S0
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 16:49:04 -0400
Received: from mout.web.de ([217.72.192.78]:58691)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lukasstraub2@web.de>) id 1hy0Cb-00017L-IW
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 16:49:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1565815723;
 bh=Vj5Yz1T195ZbwoJV7LroEOscuPi8lsWZT11FMFdJAYA=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=TkqdvULyqlk+3SaUJLQ1+rTHmztOGl4WhDoR90diWhgQT6eyqa25e6tIuEKPyM8eH
 hIVqJVukzEqjlpPMTvDaAfqGdPFxS4vP3R+qb5K6iMFWiPqj7m6OoZADB6orxKEtu1
 2d4m134qHEsaswM9pBSuOE7y4VVZopZgkAoysIFo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([87.123.206.175]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MKa6N-1hxjDQ19nD-0022ia; Wed, 14
 Aug 2019 22:48:43 +0200
Date: Wed, 14 Aug 2019 22:47:42 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: "Zhang, Chen" <chen.zhang@intel.com>
Message-ID: <73c88a10b6bd19c14bd732126e3bf07527cd7e60.1565814686.git.lukasstraub2@web.de>
In-Reply-To: <cover.1565814686.git.lukasstraub2@web.de>
References: <cover.1565814686.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2QOXj+nFHHGS/NWHMFYijpgOz8XBJPWvvIau42aZ154xWCT9ANS
 ZUeDI2fYeh0hFrGdy9DHwcKqE8a+ey4PfX5/EKpbQZSLh4rC78Fotfrhs2JmlX2oErW+j47
 MwNcjxJXQ96n1qWS6ao4u8b9DaVejKkHi4Qbm3pkPqplpD8QtDrpEgdHqlZFS6mG7rY1N2/
 d1WykebHfSx5hGOI4q40A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:u4+dCo7JoAE=:OPedg4aQjtGiL7lSEmsV1L
 afVZ3uvE4Uv5vQIxQc9TF8g44DMowG0vkZv8ooTpgxkIg4CnNLIblZdgbafv4K/GUrud/vZgQ
 0fnDmhmkP1TeTIeAkhKpXV6sgA5P5KNIzRkWTxobyX13MTX8K7QAsmxoTs4BtnaoQFvOVuwbj
 Vb9PtM6EErUCGoKxvRhQ0ksEsBVT7vBrXQLcqpI/MDUb/+3bighZK2Rl1UVfaoNa5zH160EZS
 0uBDoe/sR6naRg5Cc1Nfe48/Cvuz6vW0Dwl52dvi8AUKZScvmgqhJT3rIFaxPJhBgeSe+XHgh
 Qw28VMp+BQsOnT0PJzo7O9SJn81krTUj6PlwtHgoj3Mc2jHdVrBwMApsTcIL2AtCWul7lej1X
 tHX++va3+HL48/uve5jgWDBFBZWvtHY6xX5FRxkj+m8qMB2bNkOmt5at+Qw6vzS0Ne3uGX1ej
 eyFnwhrQ8o6L4YNABROTMflmEgpzstU19HqnFsG2G/63lwBn5s9NnJ8u/Lz2neeTz6w/WK86Q
 wl4DepAu7lIT4xIoGXyojYAam4xn/tY+bcM+OpVxWVJ/adiK9aVElABjhvqTGUjQII/r1IYjD
 PBnRW6/O0Pxpt+p/JVFZU9fPn3huvIRLyMUJg46cipxr7vIUe/XsMqlmyjBB+BagJLMTUQuPZ
 gjzvLNc11XfoKOyKXBDXeoyZq2u3rgd44M3XBdWDHQrKqPmRag84BfQcN6DsYhG8VGO63VDsu
 wLs9nXG9yVR406EeZv+ww0iXbqv9/mX4klHSwu44nYH1ORR9GHRII7FDK9WbA2gr+Wf8t1Ofu
 77TtXsUgyM+yvRnkDlVii2QRs8DRvFZSWS3wUOSZXLhzGYW1MrdWd08tcmJaoLGvt87/A3v+t
 yz3ex3uKNWORrjCUF/2ZX40qzzqmVksoc0EnEsbm74DFV4xQ/InR7hX3YMb/w3yjMp1UuRYLV
 YniUes+AlzweUbu44GvA44nHh0lNJd2vfTxtAssyop3bIvszEsBi5NwQPhfgt1+dUJkP5+x4j
 NpVZmla7rXMHikSR9nUU/jdAA9DUzs1Jfo4YrHc5CCr2ifP2bmNErKeM81bcKHw3tkt9qxP6N
 mXZ6MkShmFAuiK8gtDvI7DoHfQNrB9CNQnzrl/sSZp0tnGNK3kG0xvXV6PkvocKJBvAblzzDf
 x67M4=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.78
Subject: [Qemu-devel] [PATCH 3/3] Document the qmp commands for continious
 replication
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

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
---
 docs/COLO-FT.txt | 185 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 138 insertions(+), 47 deletions(-)

diff --git a/docs/COLO-FT.txt b/docs/COLO-FT.txt
index ad24680d13..c08bfbd3a8 100644
--- a/docs/COLO-FT.txt
+++ b/docs/COLO-FT.txt
@@ -145,35 +145,64 @@ The diagram just shows the main qmp command, you can =
get the detail
 in test procedure.
=20
 =3D=3D Test procedure =3D=3D
+Note: Here we are running both instances on the same Machine for testing,=
=20
+change the IP Addresses if you want to run it on two Hosts
+
 1. Startup qemu
 Primary:
-# qemu-system-x86_64 -accel kvm -m 2048 -smp 2 -qmp stdio -name primary \
-  -device piix3-usb-uhci -vnc :7 \
-  -device usb-tablet -netdev tap,id=3Dhn0,vhost=3Doff \
-  -device virtio-net-pci,id=3Dnet-pci0,netdev=3Dhn0 \
-  -drive if=3Dvirtio,id=3Dprimary-disk0,driver=3Dquorum,read-pattern=3Dfif=
o,vote-threshold=3D1,\
-         children.0.file.filename=3D1.raw,\
-         children.0.driver=3Draw -S
+# imagefolder=3D"/mnt/vms/colo-test"
+
+# cp --reflink=3Dauto $imagefolder/primary.qcow2 $imagefolder/primary-copy=
.qcow2
+
+# qemu-system-x86_64 -enable-kvm -cpu qemu64,+kvmclock -m 512 -smp 1 -qmp =
stdio \
+   -vnc :0 -k de -device piix3-usb-uhci -device usb-tablet -name primary \
+   -netdev tap,id=3Dhn0,vhost=3Doff,helper=3D/usr/lib/qemu/qemu-bridge-hel=
per \
+   -device rtl8139,id=3De0,netdev=3Dhn0 \
+   -chardev socket,id=3Dmirror0,host=3D127.0.0.1,port=3D9003,server,nowait=
 \
+   -chardev socket,id=3Dcompare1,host=3D127.0.0.1,port=3D9004,server,wait \
+   -chardev socket,id=3Dcompare0,host=3D127.0.0.1,port=3D9001,server,nowai=
t \
+   -chardev socket,id=3Dcompare0-0,host=3D127.0.0.1,port=3D9001 \
+   -chardev socket,id=3Dcompare_out,host=3D127.0.0.1,port=3D9005,server,no=
wait \
+   -chardev socket,id=3Dcompare_out0,host=3D127.0.0.1,port=3D9005 \
+   -object filter-mirror,id=3Dm0,netdev=3Dhn0,queue=3Dtx,outdev=3Dmirror0 \
+   -object filter-redirector,netdev=3Dhn0,id=3Dredire0,queue=3Drx,indev=3D=
compare_out \
+   -object filter-redirector,netdev=3Dhn0,id=3Dredire1,queue=3Drx,outdev=
=3Dcompare0 \
+   -object iothread,id=3Diothread1 \
+   -object colo-compare,id=3Dcomp0,primary_in=3Dcompare0-0,secondary_in=3D=
compare1,\
+outdev=3Dcompare_out0,iothread=3Diothread1 \
+   -drive if=3Dide,id=3Dcolo-disk0,driver=3Dquorum,read-pattern=3Dfifo,vot=
e-threshold=3D1,\
+children.0.file.filename=3D$imagefolder/primary.qcow2,children.0.driver=3D=
qcow2 -S
+
 Secondary:
-# qemu-system-x86_64 -accel kvm -m 2048 -smp 2 -qmp stdio -name secondary \
-  -device piix3-usb-uhci -vnc :7 \
-  -device usb-tablet -netdev tap,id=3Dhn0,vhost=3Doff \
-  -device virtio-net-pci,id=3Dnet-pci0,netdev=3Dhn0 \
-  -drive if=3Dnone,id=3Dsecondary-disk0,file.filename=3D1.raw,driver=3Draw=
,node-name=3Dnode0 \
-  -drive if=3Dvirtio,id=3Dactive-disk0,driver=3Dreplication,mode=3Dseconda=
ry,\
-         file.driver=3Dqcow2,top-id=3Dactive-disk0,\
-         file.file.filename=3D/mnt/ramfs/active_disk.img,\
-         file.backing.driver=3Dqcow2,\
-         file.backing.file.filename=3D/mnt/ramfs/hidden_disk.img,\
-         file.backing.backing=3Dsecondary-disk0 \
-  -incoming tcp:0:8888
+# imagefolder=3D"/mnt/vms/colo-test"
+
+# qemu-img create -f qcow2 $imagefolder/secondary-active.qcow2 10G
+
+# qemu-img create -f qcow2 $imagefolder/secondary-hidden.qcow2 10G
+
+# qemu-system-x86_64 -enable-kvm -cpu qemu64,+kvmclock -m 512 -smp 1 -qmp =
stdio \
+   -vnc :1 -k de -device piix3-usb-uhci -device usb-tablet -name secondary=
 \
+   -netdev tap,id=3Dhn0,vhost=3Doff,helper=3D/usr/lib/qemu/qemu-bridge-hel=
per \
+   -device rtl8139,id=3De0,netdev=3Dhn0 \
+   -chardev socket,id=3Dred0,host=3D127.0.0.1,port=3D9003,reconnect=3D1 \
+   -chardev socket,id=3Dred1,host=3D127.0.0.1,port=3D9004,reconnect=3D1 \
+   -object filter-redirector,id=3Df1,netdev=3Dhn0,queue=3Dtx,indev=3Dred0 \
+   -object filter-redirector,id=3Df2,netdev=3Dhn0,queue=3Drx,outdev=3Dred1=
 \
+   -object filter-rewriter,id=3Drew0,netdev=3Dhn0,queue=3Dall \
+   -drive if=3Dnone,id=3Dparent0,file.filename=3D$imagefolder/primary-copy=
.qcow2,driver=3Dqcow2 \
+   -drive if=3Dnone,id=3Dchilds0,driver=3Dreplication,mode=3Dsecondary,fil=
e.driver=3Dqcow2,\
+top-id=3Dchilds0,file.file.filename=3D$imagefolder/secondary-active.qcow2,\
+file.backing.driver=3Dqcow2,file.backing.file.filename=3D$imagefolder/seco=
ndary-hidden.qcow2,\
+file.backing.backing=3Dparent0 \
+   -drive if=3Dide,id=3Dcolo-disk0,driver=3Dquorum,read-pattern=3Dfifo,vot=
e-threshold=3D1,\
+children.0.file=3Dchilds0,children.0.driver=3Draw \
+   -incoming tcp:0:9998
+
=20
 2. On Secondary VM's QEMU monitor, issue command
 {'execute':'qmp_capabilities'}
-{ 'execute': 'nbd-server-start',
-  'arguments': {'addr': {'type': 'inet', 'data': {'host': 'xx.xx.xx.xx', '=
port': '8889'} } }
-}
-{'execute': 'nbd-server-add', 'arguments': {'device': 'secondary-disk0', '=
writable': true } }
+{'execute': 'nbd-server-start', 'arguments': {'addr': {'type': 'inet', 'da=
ta': {'host': '127.0.0.1', 'port': '9999'} } } }
+{'execute': 'nbd-server-add', 'arguments': {'device': 'parent0', 'writable=
': true } }
=20
 Note:
   a. The qmp command nbd-server-start and nbd-server-add must be run
@@ -184,12 +213,10 @@ Note:
=20
 3. On Primary VM's QEMU monitor, issue command:
 {'execute':'qmp_capabilities'}
-{ 'execute': 'human-monitor-command',
-  'arguments': {'command-line': 'drive_add -n buddy driver=3Dreplication,m=
ode=3Dprimary,file.driver=3Dnbd,file.host=3Dxx.xx.xx.xx,file.port=3D8889,fi=
le.export=3Dsecondary-disk0,node-name=3Dnbd_client0'}}
-{ 'execute':'x-blockdev-change', 'arguments':{'parent': 'primary-disk0', '=
node': 'nbd_client0' } }
-{ 'execute': 'migrate-set-capabilities',
-      'arguments': {'capabilities': [ {'capability': 'x-colo', 'state': tr=
ue } ] } }
-{ 'execute': 'migrate', 'arguments': {'uri': 'tcp:xx.xx.xx.xx:8888' } }
+{'execute': 'human-monitor-command', 'arguments': {'command-line': 'drive_=
add -n buddy driver=3Dreplication,mode=3Dprimary,file.driver=3Dnbd,file.hos=
t=3D127.0.0.1,file.port=3D9999,file.export=3Dparent0,node-name=3Dreplicatio=
n0'}}
+{'execute': 'x-blockdev-change', 'arguments':{'parent': 'colo-disk0', 'nod=
e': 'replication0' } }
+{'execute': 'migrate-set-capabilities', 'arguments': {'capabilities': [ {'=
capability': 'x-colo', 'state': true } ] } }
+{'execute': 'migrate', 'arguments': {'uri': 'tcp:127.0.0.1:9998' } }
=20
   Note:
   a. There should be only one NBD Client for each primary disk.
@@ -199,27 +226,91 @@ Note:
=20
 4. After the above steps, you will see, whenever you make changes to PVM, =
SVM will be synced.
 You can issue command '{ "execute": "migrate-set-parameters" , "arguments"=
:{ "x-checkpoint-delay": 2000 } }'
-to change the checkpoint period time
+to change the idle checkpoint period time
=20
 5. Failover test
-You can kill Primary VM and run 'x_colo_lost_heartbeat' in Secondary VM's
-monitor at the same time, then SVM will failover and client will not detec=
t this
-change.
+You can kill one of the VMs and Failover on the surviving VM:=20
=20
-Before issuing '{ "execute": "x-colo-lost-heartbeat" }' command, we have to
-issue block related command to stop block replication.
-Primary:
-  Remove the nbd child from the quorum:
-  { 'execute': 'x-blockdev-change', 'arguments': {'parent': 'colo-disk0', =
'child': 'children.1'}}
-  { 'execute': 'human-monitor-command','arguments': {'command-line': 'driv=
e_del blk-buddy0'}}
-  Note: there is no qmp command to remove the blockdev now
+=3D=3D Primary Failover =3D=3D
+The Secondary died, resume on the Primary
=20
-Secondary:
-  The primary host is down, so we should do the following thing:
-  { 'execute': 'nbd-server-stop' }
+{'execute': 'x-blockdev-change', 'arguments':{ 'parent': 'colo-disk0', 'ch=
ild': 'children.1'} }
+{'execute': 'human-monitor-command', 'arguments':{ 'command-line': 'drive_=
del replication0' } }
+{'execute': 'object-del', 'arguments':{ 'id': 'comp0' } }
+{'execute': 'object-del', 'arguments':{ 'id': 'iothread1' } }
+{'execute': 'object-del', 'arguments':{ 'id': 'm0' } }
+{'execute': 'object-del', 'arguments':{ 'id': 'redire0' } }
+{'execute': 'object-del', 'arguments':{ 'id': 'redire1' } }
+{'execute': 'x-colo-lost-heartbeat' }
+
+=3D=3D Secondary Failover =3D=3D
+The Primary died, resume on the Secondary and prepare to become the new Pr=
imary
+
+{'execute': 'nbd-server-stop'}
+{'execute': 'x-colo-lost-heartbeat'}
+
+{'execute': 'object-del', 'arguments':{ 'id': 'f2' } }
+{'execute': 'object-del', 'arguments':{ 'id': 'f1' } }
+{'execute': 'chardev-remove', 'arguments':{ 'id': 'red1' } }
+{'execute': 'chardev-remove', 'arguments':{ 'id': 'red0' } }
+
+{'execute': 'chardev-add', 'arguments':{ 'id': 'mirror0', 'backend': {'typ=
e': 'socket', 'data': {'addr': { 'type': 'inet', 'data': { 'host': '127.0.0=
.1', 'port': '9003' } }, 'server': true } } } }
+{'execute': 'chardev-add', 'arguments':{ 'id': 'compare1', 'backend': {'ty=
pe': 'socket', 'data': {'addr': { 'type': 'inet', 'data': { 'host': '127.0.=
0.1', 'port': '9004' } }, 'server': true } } } }
+{'execute': 'chardev-add', 'arguments':{ 'id': 'compare0', 'backend': {'ty=
pe': 'socket', 'data': {'addr': { 'type': 'inet', 'data': { 'host': '127.0.=
0.1', 'port': '9001' } }, 'server': true } } } }
+{'execute': 'chardev-add', 'arguments':{ 'id': 'compare0-0', 'backend': {'=
type': 'socket', 'data': {'addr': { 'type': 'inet', 'data': { 'host': '127.=
0.0.1', 'port': '9001' } }, 'server': false } } } }
+{'execute': 'chardev-add', 'arguments':{ 'id': 'compare_out', 'backend': {=
'type': 'socket', 'data': {'addr': { 'type': 'inet', 'data': { 'host': '127=
.0.0.1', 'port': '9005' } }, 'server': true } } } }
+{'execute': 'chardev-add', 'arguments':{ 'id': 'compare_out0', 'backend': =
{'type': 'socket', 'data': {'addr': { 'type': 'inet', 'data': { 'host': '12=
7.0.0.1', 'port': '9005' } }, 'server': false } } } }
+
+=3D=3D Primary resume replication =3D=3D
+Resume replication after new Secondary is up.
+
+Start the new Secondary, then:
+{'execute': 'drive-mirror', 'arguments':{ 'device': 'colo-disk0', 'job-id'=
: 'resync', 'target': 'nbd://127.0.0.1:9999/parent0', 'mode': 'existing', '=
format': 'raw', 'sync': 'full'} }
+
+Wait until disk is synced, then:
+{'execute': 'stop'}
+{'execute': 'block-job-cancel', 'arguments':{ 'device': 'resync'} }
+
+{'execute': 'human-monitor-command', 'arguments':{ 'command-line': 'drive_=
add -n buddy driver=3Dreplication,mode=3Dprimary,file.driver=3Dnbd,file.hos=
t=3D127.0.0.1,file.port=3D9999,file.export=3Dparent0,node-name=3Dreplicatio=
n0'}}
+{'execute': 'x-blockdev-change', 'arguments':{ 'parent': 'colo-disk0', 'no=
de': 'replication0' } }
+
+{'execute': 'object-add', 'arguments':{ 'qom-type': 'filter-mirror', 'id':=
 'm0', 'props': { 'netdev': 'hn0', 'queue': 'tx', 'outdev': 'mirror0' } } }
+{'execute': 'object-add', 'arguments':{ 'qom-type': 'filter-redirector', '=
id': 'redire0', 'props': { 'netdev': 'hn0', 'queue': 'rx', 'indev': 'compar=
e_out' } } }
+{'execute': 'object-add', 'arguments':{ 'qom-type': 'filter-redirector', '=
id': 'redire1', 'props': { 'netdev': 'hn0', 'queue': 'rx', 'outdev': 'compa=
re0' } } }
+{'execute': 'object-add', 'arguments':{ 'qom-type': 'iothread', 'id': 'iot=
hread1' } }
+{'execute': 'object-add', 'arguments':{ 'qom-type': 'colo-compare', 'id': =
'comp0', 'props': { 'primary_in': 'compare0-0', 'secondary_in': 'compare1',=
 'outdev': 'compare_out0', 'iothread': 'iothread1' } } }
+
+{'execute': 'migrate-set-capabilities', 'arguments':{ 'capabilities': [ {'=
capability': 'x-colo', 'state': true } ] } }
+{'execute': 'migrate', 'arguments':{ 'uri': 'tcp:127.0.0.1:9998' } }
+
+Note:
+If this Primary previously was a Secondary, then we need to insert the=20
+filters before the filter-rewriter by using the=20
+"'insert': 'before', 'position': 'rew0'" Options. See below.
+
+=3D=3D Secondary resume replication =3D=3D
+Become Primary and resume replication after new Secondary is up.
+
+Start the new Secondary, then:
+{'execute': 'drive-mirror', 'arguments':{ 'device': 'colo-disk0', 'job-id'=
: 'resync', 'target': 'nbd://127.0.0.1:9999/parent0', 'mode': 'existing', '=
format': 'raw', 'sync': 'full'} }
+
+Wait until disk is synced, then:
+{'execute': 'stop'}
+{'execute': 'block-job-cancel', 'arguments':{ 'device': 'resync' } }
+
+{'execute': 'human-monitor-command', 'arguments':{ 'command-line': 'drive_=
add -n buddy driver=3Dreplication,mode=3Dprimary,file.driver=3Dnbd,file.hos=
t=3D127.0.0.1,file.port=3D9999,file.export=3Dparent0,node-name=3Dreplicatio=
n0'}}
+{'execute': 'x-blockdev-change', 'arguments':{ 'parent': 'colo-disk0', 'no=
de': 'replication0' } }
+
+{'execute': 'object-add', 'arguments':{ 'qom-type': 'filter-mirror', 'id':=
 'm0', 'props': { 'insert': 'before', 'position': 'rew0', 'netdev': 'hn0', =
'queue': 'tx', 'outdev': 'mirror0' } } }
+{'execute': 'object-add', 'arguments':{ 'qom-type': 'filter-redirector', '=
id': 'redire0', 'props': { 'insert': 'before', 'position': 'rew0', 'netdev'=
: 'hn0', 'queue': 'rx', 'indev': 'compare_out' } } }
+{'execute': 'object-add', 'arguments':{ 'qom-type': 'filter-redirector', '=
id': 'redire1', 'props': { 'insert': 'before', 'position': 'rew0', 'netdev'=
: 'hn0', 'queue': 'rx', 'outdev': 'compare0' } } }
+{'execute': 'object-add', 'arguments':{ 'qom-type': 'iothread', 'id': 'iot=
hread1' } }
+{'execute': 'object-add', 'arguments':{ 'qom-type': 'colo-compare', 'id': =
'comp0', 'props': { 'primary_in': 'compare0-0', 'secondary_in': 'compare1',=
 'outdev': 'compare_out0', 'iothread': 'iothread1' } } }
+
+{'execute': 'migrate-set-capabilities', 'arguments':{ 'capabilities': [ {'=
capability': 'x-colo', 'state': true } ] } }
+{'execute': 'migrate', 'arguments':{ 'uri': 'tcp:127.0.0.1:9998' } }
=20
 =3D=3D TODO =3D=3D
-1. Support continuous VM replication.
-2. Support shared storage.
-3. Develop the heartbeat part.
-4. Reduce checkpoint VM=E2=80=99s downtime while doing checkpoint.
+1. Support shared storage.
+2. Develop the heartbeat part.
+3. Reduce checkpoint VM=E2=80=99s downtime while doing checkpoint.
--=20
2.20.1

