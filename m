Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A9D7CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 16:01:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5D532064A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 16:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="A40dSzhH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5D532064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNfYF-0002ab-Ey
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 12:01:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39067)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1iNe4m-0001Nl-GJ
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:26:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lukasstraub2@web.de>) id 1iNe4j-0003lv-RB
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:26:56 -0400
Received: from mout.web.de ([212.227.15.14]:57109)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lukasstraub2@web.de>)
 id 1iNe4j-0003jg-Fm; Thu, 24 Oct 2019 10:26:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1571927158;
 bh=cVG1bLY5L9+nYtRj+WO7zWt1Gw2p3nmxFUVahyEkCtk=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=A40dSzhHcSRSrT2ykeDqs98l1c/8KmYRikoN3bc3cez1xMQZPJO0SLcn1LW91SI8e
 II9asTK0vtL1Ml7swEx4VnZU8VjpXtuwI9kPC69vu+8r1G7iJOlB1UryB1aNCXmQHS
 iMMLZZWgLo5bNju5bbB1sISRZrTOxMHNUXjX5asg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.150]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lxf5f-1hvDIr1p0t-017BZs; Thu, 24
 Oct 2019 16:25:58 +0200
Date: Thu, 24 Oct 2019 16:25:57 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v7 4/4] colo: Update Documentation for continuous replication
Message-ID: <ad91341a5cecb103530b303b26de5024b43eaadb.1571925700.git.lukasstraub2@web.de>
In-Reply-To: <cover.1571925699.git.lukasstraub2@web.de>
References: <cover.1571925699.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:L74YIqEB2jOStZaOSWznWkcEJSiMDo3JJ4Tg1lpvkKDiwFwrH4H
 VdwiFo2UI98vbklhUyS99/d+JEujhcSUAOkhzjotrckBU4VCTGbWMWG3eZGuRPKRCHdfXMN
 SrzhD2nObycaOJLbtjpt+loaxkXCPInwhZvQ+rDIFRFPR0Xujn5K/YNe4gNWkT16jDePQyB
 IB1OP4HSpLq+GBJQviotg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NFEqP7UqfmE=:0CujnuMaPTQxD+9DFphV1q
 /rlEMG6P3UT/D5NkiwViT42heAH6qR1jBkX5Hh1nr1v1kqLIWOkOamkvGw94+zPMLu+047WEU
 su58Nusoe99PvV37Tl3IvSR8/Pdi3T86gZ200VxNs2L1uTuepOVta8jTtgLvLTRCFHhm6bboc
 XsyRla/mrIIHj3pJ9AkGCAKCodmfI09sDaB/TEqrau30DIqoEozI4F6x3g6F8Q+JF8LQfwtA0
 rX/HGYO8s70WT4BJedJQS6n0ZoIaPBUijVFNLU4sLRMDyby8jTnmZ1gC80ygXAbFd4IcfHZB+
 V/KRnW8Y21/ARfLa9/2V0bwIjohmXva1El6z9dU+zV1313YiLUv1P6wqrsT4DwHOcC2Ru1zh8
 UmN3Y5Zo6OqtaCqOvkDccV4lDbhxxxd30Qgt1GUc0KqEgGB7eYXE6DD/q1ToVNsY70hlrK/N2
 D4AO0XKakNX9zRAoVlJrxsOzaq12EoSnNk0VsRXzWb00m4AYfOw3je24c89uQqxRDrUvPKe7p
 wF02upRaLWLzCrGkrnwMoNZMXNvgiznnjZOjDHyrglVBhw+V/glNgxG3rRi46x0ZO5Sqz1upP
 BDUOJImC33x9c8mlXQPbhsY1Lf5Us29wsdxQcF6i4gYSafWpxS9O3OxfIIRD1LDYcpuxuwoYC
 am1goNaL6zmipVeUgSGvyBE3jw2BerwxznsQ61tsacG/ihbxHM3myNsc3pWXFHO7YsjWuIHJJ
 CRt4cuGIJUPMgm6u2pwgb9/f5D2LhpOxWigtbBPNO2a+3ufvy72Ub0ombMDDDz2G4aJU3xmEG
 X5Gn+Az8xXOxE7j5MC3CwG7c5b5CJgluRFefXvIKTYJdONo5MEEcRjD+akx9K2B31knKfA9Ei
 J0i+rooKZlu3Z6/Sk5aG8Q9smF9CIRCiZdH+oLniAadJVLUCoVN9G4PMRlKPLcx58+vwE1UoS
 /Q30m02r16oJOgdiZGvGMVhLk9UOyVD1efStfOwmrEf/efjSzF0qZH9owKwq8wGBf1jj04xHd
 5n8T8ccBN5e8wEZZvYCS8umkW9blVF+Y23YQcUehG7T1fEUP3FpVn6eiX1xV3BOIrBywtlX51
 C1unFLC631sYoJn3ez1v3/I9r59v3ypeiXAn7lG8HgU93Ngpuf6bwe9frr9MtwzFf5dlpoZrn
 RbVJRSg0cnb8NfPigBP0+ZSv/JKz5hzci2lvsT4kpMCsCgs3ZaWO3Naz73K1b5y6+ILzQ5qk8
 pbj6nvbBJEiwjtuViEXiNBhp2h5cTdr/x63tw2mmTbGFfI0RvJhzFhbGCxaI=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.15.14
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
 Wen Congyang <wency@cn.fujitsu.com>, Wen Congyang <wencongyang2@huawei.com>,
 Jason Wang <jasowang@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Zhang Chen <chen.zhang@intel.com>, Xie Changlong <xiechanglong.d@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Document the qemu command-line and qmp commands for continuous replication

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
---
 docs/COLO-FT.txt           | 224 +++++++++++++++++++++++++++----------
 docs/block-replication.txt |  28 +++--
 2 files changed, 184 insertions(+), 68 deletions(-)

diff --git a/docs/COLO-FT.txt b/docs/COLO-FT.txt
index ad24680d13..c8e1740935 100644
--- a/docs/COLO-FT.txt
+++ b/docs/COLO-FT.txt
@@ -145,81 +145,189 @@ The diagram just shows the main qmp command, you can=
 get the detail
 in test procedure.
=20
 =3D=3D Test procedure =3D=3D
-1. Startup qemu
-Primary:
-# qemu-system-x86_64 -accel kvm -m 2048 -smp 2 -qmp stdio -name primary \
-  -device piix3-usb-uhci -vnc :7 \
-  -device usb-tablet -netdev tap,id=3Dhn0,vhost=3Doff \
-  -device virtio-net-pci,id=3Dnet-pci0,netdev=3Dhn0 \
-  -drive if=3Dvirtio,id=3Dprimary-disk0,driver=3Dquorum,read-pattern=3Dfif=
o,vote-threshold=3D1,\
-         children.0.file.filename=3D1.raw,\
-         children.0.driver=3Draw -S
-Secondary:
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
-
-2. On Secondary VM's QEMU monitor, issue command
+Note: Here we are running both instances on the same host for testing,
+change the IP Addresses if you want to run it on two hosts. Initally
+127.0.0.1 is the Primary Host and 127.0.0.2 is the Secondary Host.
+
+=3D=3D Startup qemu =3D=3D
+1. Primary:
+Note: Initally, $imagefolder/primary.qcow2 needs to be copied to all hosts.
+You don't need to change any IP's here, because 0.0.0.0 listens on any
+interface. The chardev's with 127.0.0.1 IP's loopback to the local qemu
+instance.
+
+# imagefolder=3D"/mnt/vms/colo-test-primary"
+
+# qemu-system-x86_64 -enable-kvm -cpu qemu64,+kvmclock -m 512 -smp 1 -qmp =
stdio \
+   -device piix3-usb-uhci -device usb-tablet -name primary \
+   -netdev tap,id=3Dhn0,vhost=3Doff,helper=3D/usr/lib/qemu/qemu-bridge-hel=
per \
+   -device rtl8139,id=3De0,netdev=3Dhn0 \
+   -chardev socket,id=3Dmirror0,host=3D0.0.0.0,port=3D9003,server,nowait \
+   -chardev socket,id=3Dcompare1,host=3D0.0.0.0,port=3D9004,server,wait \
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
+2. Secondary:
+Note: Active and hidden images need to be created only once and the
+size should be the same as primary.qcow2. Again, you don't need to change
+any IP's here, except for the $primary_ip variable.
+
+# imagefolder=3D"/mnt/vms/colo-test-secondary"
+# primary_ip=3D127.0.0.1
+
+# qemu-img create -f qcow2 $imagefolder/secondary-active.qcow2 10G
+
+# qemu-img create -f qcow2 $imagefolder/secondary-hidden.qcow2 10G
+
+# qemu-system-x86_64 -enable-kvm -cpu qemu64,+kvmclock -m 512 -smp 1 -qmp =
stdio \
+   -device piix3-usb-uhci -device usb-tablet -name secondary \
+   -netdev tap,id=3Dhn0,vhost=3Doff,helper=3D/usr/lib/qemu/qemu-bridge-hel=
per \
+   -device rtl8139,id=3De0,netdev=3Dhn0 \
+   -chardev socket,id=3Dred0,host=3D$primary_ip,port=3D9003,reconnect=3D1 \
+   -chardev socket,id=3Dred1,host=3D$primary_ip,port=3D9004,reconnect=3D1 \
+   -object filter-redirector,id=3Df1,netdev=3Dhn0,queue=3Dtx,indev=3Dred0 \
+   -object filter-redirector,id=3Df2,netdev=3Dhn0,queue=3Drx,outdev=3Dred1=
 \
+   -object filter-rewriter,id=3Drew0,netdev=3Dhn0,queue=3Dall \
+   -drive if=3Dnone,id=3Dparent0,file.filename=3D$imagefolder/primary.qcow=
2,driver=3Dqcow2 \
+   -drive if=3Dnone,id=3Dchilds0,driver=3Dreplication,mode=3Dsecondary,fil=
e.driver=3Dqcow2,\
+top-id=3Dcolo-disk0,file.file.filename=3D$imagefolder/secondary-active.qco=
w2,\
+file.backing.driver=3Dqcow2,file.backing.file.filename=3D$imagefolder/seco=
ndary-hidden.qcow2,\
+file.backing.backing=3Dparent0 \
+   -drive if=3Dide,id=3Dcolo-disk0,driver=3Dquorum,read-pattern=3Dfifo,vot=
e-threshold=3D1,\
+children.0=3Dchilds0 \
+   -incoming tcp:0.0.0.0:9998
+
+
+3. On Secondary VM's QEMU monitor, issue command
 {'execute':'qmp_capabilities'}
-{ 'execute': 'nbd-server-start',
-  'arguments': {'addr': {'type': 'inet', 'data': {'host': 'xx.xx.xx.xx', '=
port': '8889'} } }
-}
-{'execute': 'nbd-server-add', 'arguments': {'device': 'secondary-disk0', '=
writable': true } }
+{'execute': 'nbd-server-start', 'arguments': {'addr': {'type': 'inet', 'da=
ta': {'host': '0.0.0.0', 'port': '9999'} } } }
+{'execute': 'nbd-server-add', 'arguments': {'device': 'parent0', 'writable=
': true } }
=20
 Note:
   a. The qmp command nbd-server-start and nbd-server-add must be run
      before running the qmp command migrate on primary QEMU
   b. Active disk, hidden disk and nbd target's length should be the
      same.
-  c. It is better to put active disk and hidden disk in ramdisk.
+  c. It is better to put active disk and hidden disk in ramdisk. They
+     will be merged into the parent disk on failover.
=20
-3. On Primary VM's QEMU monitor, issue command:
+4. On Primary VM's QEMU monitor, issue command:
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
t=3D127.0.0.2,file.port=3D9999,file.export=3Dparent0,node-name=3Dreplicatio=
n0'}}
+{'execute': 'x-blockdev-change', 'arguments':{'parent': 'colo-disk0', 'nod=
e': 'replication0' } }
+{'execute': 'migrate-set-capabilities', 'arguments': {'capabilities': [ {'=
capability': 'x-colo', 'state': true } ] } }
+{'execute': 'migrate', 'arguments': {'uri': 'tcp:127.0.0.2:9998' } }
=20
   Note:
   a. There should be only one NBD Client for each primary disk.
-  b. xx.xx.xx.xx is the secondary physical machine's hostname or IP
-  c. The qmp command line must be run after running qmp command line in
+  b. The qmp command line must be run after running qmp command line in
      secondary qemu.
=20
-4. After the above steps, you will see, whenever you make changes to PVM, =
SVM will be synced.
+5. After the above steps, you will see, whenever you make changes to PVM, =
SVM will be synced.
 You can issue command '{ "execute": "migrate-set-parameters" , "arguments"=
:{ "x-checkpoint-delay": 2000 } }'
-to change the checkpoint period time
+to change the idle checkpoint period time
+
+6. Failover test
+You can kill one of the VMs and Failover on the surviving VM:
+
+If you killed the Secondary, then follow "Primary Failover". After that,
+if you want to resume the replication, follow "Primary resume replication"
+
+If you killed the Primary, then follow "Secondary Failover". After that,
+if you want to resume the replication, follow "Secondary resume replicatio=
n"
+
+=3D=3D Primary Failover =3D=3D
+The Secondary died, resume on the Primary
+
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
e': 'socket', 'data': {'addr': { 'type': 'inet', 'data': { 'host': '0.0.0.0=
', 'port': '9003' } }, 'server': true } } } }
+{'execute': 'chardev-add', 'arguments':{ 'id': 'compare1', 'backend': {'ty=
pe': 'socket', 'data': {'addr': { 'type': 'inet', 'data': { 'host': '0.0.0.=
0', 'port': '9004' } }, 'server': true } } } }
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
+Start the new Secondary (Steps 2 and 3 above), then on the Primary:
+{'execute': 'drive-mirror', 'arguments':{ 'device': 'colo-disk0', 'job-id'=
: 'resync', 'target': 'nbd://127.0.0.2:9999/parent0', 'mode': 'existing', '=
format': 'raw', 'sync': 'full'} }
+
+Wait until disk is synced, then:
+{'execute': 'stop'}
+{'execute': 'block-job-cancel', 'arguments':{ 'device': 'resync'} }
+
+{'execute': 'human-monitor-command', 'arguments':{ 'command-line': 'drive_=
add -n buddy driver=3Dreplication,mode=3Dprimary,file.driver=3Dnbd,file.hos=
t=3D127.0.0.2,file.port=3D9999,file.export=3Dparent0,node-name=3Dreplicatio=
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
+{'execute': 'migrate', 'arguments':{ 'uri': 'tcp:127.0.0.2:9998' } }
+
+Note:
+If this Primary previously was a Secondary, then we need to insert the
+filters before the filter-rewriter by using the
+"'insert': 'before', 'position': 'id=3Drew0'" Options. See below.
+
+=3D=3D Secondary resume replication =3D=3D
+Become Primary and resume replication after new Secondary is up. Note
+that now 127.0.0.1 is the Secondary and 127.0.0.2 is the Primary.
+
+Start the new Secondary (Steps 2 and 3 above, but with primary_ip=3D127.0.=
0.2),
+then on the old Secondary:
+{'execute': 'drive-mirror', 'arguments':{ 'device': 'colo-disk0', 'job-id'=
: 'resync', 'target': 'nbd://127.0.0.1:9999/parent0', 'mode': 'existing', '=
format': 'raw', 'sync': 'full'} }
+
+Wait until disk is synced, then:
+{'execute': 'stop'}
+{'execute': 'block-job-cancel', 'arguments':{ 'device': 'resync' } }
=20
-5. Failover test
-You can kill Primary VM and run 'x_colo_lost_heartbeat' in Secondary VM's
-monitor at the same time, then SVM will failover and client will not detec=
t this
-change.
+{'execute': 'human-monitor-command', 'arguments':{ 'command-line': 'drive_=
add -n buddy driver=3Dreplication,mode=3Dprimary,file.driver=3Dnbd,file.hos=
t=3D127.0.0.1,file.port=3D9999,file.export=3Dparent0,node-name=3Dreplicatio=
n0'}}
+{'execute': 'x-blockdev-change', 'arguments':{ 'parent': 'colo-disk0', 'no=
de': 'replication0' } }
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
+{'execute': 'object-add', 'arguments':{ 'qom-type': 'filter-mirror', 'id':=
 'm0', 'props': { 'insert': 'before', 'position': 'id=3Drew0', 'netdev': 'h=
n0', 'queue': 'tx', 'outdev': 'mirror0' } } }
+{'execute': 'object-add', 'arguments':{ 'qom-type': 'filter-redirector', '=
id': 'redire0', 'props': { 'insert': 'before', 'position': 'id=3Drew0', 'ne=
tdev': 'hn0', 'queue': 'rx', 'indev': 'compare_out' } } }
+{'execute': 'object-add', 'arguments':{ 'qom-type': 'filter-redirector', '=
id': 'redire1', 'props': { 'insert': 'before', 'position': 'id=3Drew0', 'ne=
tdev': 'hn0', 'queue': 'rx', 'outdev': 'compare0' } } }
+{'execute': 'object-add', 'arguments':{ 'qom-type': 'iothread', 'id': 'iot=
hread1' } }
+{'execute': 'object-add', 'arguments':{ 'qom-type': 'colo-compare', 'id': =
'comp0', 'props': { 'primary_in': 'compare0-0', 'secondary_in': 'compare1',=
 'outdev': 'compare_out0', 'iothread': 'iothread1' } } }
=20
-Secondary:
-  The primary host is down, so we should do the following thing:
-  { 'execute': 'nbd-server-stop' }
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
diff --git a/docs/block-replication.txt b/docs/block-replication.txt
index 6bde6737fb..108e9166a8 100644
--- a/docs/block-replication.txt
+++ b/docs/block-replication.txt
@@ -65,12 +65,12 @@ blocks that are already in QEMU.
              ^            ||                            .----------
              |            ||                            | Secondary
         1 Quorum          ||                            '----------
-         /      \         ||
-        /        \        ||
-   Primary    2 filter
-     disk         ^                                                       =
      virtio-blk
-                  |                                                       =
           ^
-                3 NBD  ------->  3 NBD                                    =
           |
+         /      \         ||                                              =
             virtio-blk
+        /        \        ||                                              =
                 ^
+   Primary    2 filter                                                    =
                 |
+     disk         ^                                                       =
            7 Quorum
+                  |                                                       =
             /
+                3 NBD  ------->  3 NBD                                    =
            /
                 client    ||     server                                   =
       2 filter
                           ||        ^                                     =
           ^
 --------.                 ||        |                                     =
           |
@@ -106,6 +106,10 @@ any state that would otherwise be lost by the speculat=
ive write-through
 of the NBD server into the secondary disk. So before block replication,
 the primary disk and secondary disk should contain the same data.
=20
+7) The secondary also has a quorum node, so after secondary failover it
+can become the new primary and continue replication.
+
+
 =3D=3D Failure Handling =3D=3D
 There are 7 internal errors when block replication is running:
 1. I/O error on primary disk
@@ -171,16 +175,18 @@ Primary:
      leading whitespace.
   5. The qmp command line must be run after running qmp command line in
      secondary qemu.
-  6. After failover we need remove children.1 (replication driver).
+  6. After primary failover we need remove children.1 (replication driver).
=20
 Secondary:
   -drive if=3Dnone,driver=3Draw,file.filename=3D1.raw,id=3Dcolo1 \
-  -drive if=3Dxxx,id=3Dtopxxx,driver=3Dreplication,mode=3Dsecondary,top-id=
=3Dtopxxx\
+  -drive if=3Dnone,id=3Dchilds1,driver=3Dreplication,mode=3Dsecondary,top-=
id=3Dchilds1
          file.file.filename=3Dactive_disk.qcow2,\
          file.driver=3Dqcow2,\
          file.backing.file.filename=3Dhidden_disk.qcow2,\
          file.backing.driver=3Dqcow2,\
          file.backing.backing=3Dcolo1
+  -drive if=3Dxxx,driver=3Dquorum,read-pattern=3Dfifo,id=3Dtop-disk1,\
+         vote-threshold=3D1,children.0=3Dchilds1
=20
   Then run qmp command in secondary qemu:
     { 'execute': 'nbd-server-start',
@@ -234,6 +240,8 @@ Secondary:
   The primary host is down, so we should do the following thing:
   { 'execute': 'nbd-server-stop' }
=20
+Promote Secondary to Primary:
+  see COLO-FT.txt
+
 TODO:
-1. Continuous block replication
-2. Shared disk
+1. Shared disk
--=20
2.20.1

