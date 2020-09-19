Return-Path: <SRS0=MBD3=C4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E82C43464
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 18:55:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B15A20874
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 18:55:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B15A20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJi0z-00088V-KP
	for qemu-devel@archiver.kernel.org; Sat, 19 Sep 2020 14:55:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kJhrH-00064Q-G9; Sat, 19 Sep 2020 14:45:15 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:47551)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kJhrE-0001Jy-P1; Sat, 19 Sep 2020 14:45:15 -0400
Received: from localhost.localdomain ([82.252.129.222]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mc1hn-1ktscf3Zs7-00dZtP; Sat, 19 Sep 2020 20:45:07 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 04/17] manual: escape backslashes in "parsed-literal" blocks
Date: Sat, 19 Sep 2020 20:44:38 +0200
Message-Id: <20200919184451.2129349-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200919184451.2129349-1-laurent@vivier.eu>
References: <20200919184451.2129349-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:wPI1deLKipJ0MVkN0jQDEBDM9BgJZTNx61/434YAL3vXKmY6oMM
 BT2m/djhLnVFvImmGykPq5nvkUW2iQkO/68j38NqQgTTyCcsdtFOSHXksvR4U0kTEV9kBsA
 XrHjp+DleYd4Bi8FfQZeYebd0mmRFopH3dDKLodXHqZ0Un0iJgtYLGkHuSXzhPWky07XhU2
 +SNpPMdPKEjadZTFC7Yfw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BURtelT40JI=:gdu/L9aTFSGV/kqhShxhA0
 c/fSpKo8zpLCXCFGoEpBKV/WaI61/9REwvkAKTOSc1hSE/C00fq+2cgpVcxNgcqrkUlzZlFxo
 MuE4+CFIAtfuW6Vq4YOE6YRg6jwYAw07quKc4AMW2mD/pWiX9qqcWfW/t44Odw2LuszWTzm1p
 tkRrJT6jpaSlzhbSdkPBqKXsaQCykUG65RTakJkSNmMUon8r1oWDYnZ8ktM34fzS4gmdk1nhh
 dqrQeUjKEIE6m1Wt+CO8X5PbJAmcH7YZinm5UhaMoXIn6Je0ejqLxTzB5KcQE3uHaaR6s3QpG
 /Jvgebs2mjFHTjRah8qdWTfyhU0PEdbvho7Ka0wXUTYhawMjMK9dOmwXtGIJdO+cRvtT4u1sX
 OgsD606+lcDf+mRF1kZHQLqApePyRFknU2c/6Mkc70zWzb7Cn03XFp32YLt/avlZNm/7+ODQn
 yuXO5a0M/h7AKlFS9smuQy4E+1FGGjYNL7FB3RI0+TdPU6ltDhDcgUg5ebuenbLjXaHfDsoLS
 5CeMqdpFFLUkeG5OKnW/pmby6F3fkMspFByFQ7yIAjJXAmi/v7wRSR288l2dcjS3eWcwc4fwY
 BthtYv8iCMSG8cLkfudDGxcXkzCulR33TFGUptNC/XW9E+iURm1/VR87TiIAshFHqCVnLBvPT
 3dttvleEboRU1XsNEQiHKdnWcbj2QwzzPE7GCCmXltGKTCXy5PXrGkqQexcok7/Dex8qqyzdA
 wCGXX/3UCDMMEf0uMbS6ScZPDcLdxIbJ7MIdxha7Sugr+i9AWNRS0kQTGferc06cwMXb5LVAt
 bvexQ4LXC6bewnTR7ktHLXv/fLigTiNgPJeRqg36Vs3IUg+GrME5szV/hH/J2ZcjmvQsBko
Received-SPF: none client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/19 14:45:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Laszlo Ersek <lersek@redhat.com>

According to
<https://docutils.sourceforge.io/docs/ref/rst/directives.html#parsed-literal>,
"inline markup is recognized and there is no protection from parsing.
Backslash-escapes may be necessary to prevent unintended parsing".

The qemu(1) manual page (formatted with Sphinx 2.2.2) has several overlong
lines on my system. A stand-alone backslash at EOL serves as line
continuation in a "parsed-literal" block. Therefore, escape the
backslashes that we want to appear as such in the formatted documentation.

Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200908172111.19072-1-lersek@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 docs/system/device-url-syntax.rst.inc |   8 +-
 qemu-options.hx                       | 108 +++++++++++++-------------
 2 files changed, 58 insertions(+), 58 deletions(-)

diff --git a/docs/system/device-url-syntax.rst.inc b/docs/system/device-url-syntax.rst.inc
index 88d7a372a748..6f6ec8366b7a 100644
--- a/docs/system/device-url-syntax.rst.inc
+++ b/docs/system/device-url-syntax.rst.inc
@@ -25,8 +25,8 @@ These are specified using a special URL syntax.
 
    .. parsed-literal::
 
-      |qemu_system| -iscsi initiator-name=iqn.2001-04.com.example:my-initiator \
-                       -cdrom iscsi://192.0.2.1/iqn.2001-04.com.example/2 \
+      |qemu_system| -iscsi initiator-name=iqn.2001-04.com.example:my-initiator \\
+                       -cdrom iscsi://192.0.2.1/iqn.2001-04.com.example/2 \\
                        -drive file=iscsi://192.0.2.1/iqn.2001-04.com.example/1
 
    Example (CHAP username/password via URL):
@@ -39,8 +39,8 @@ These are specified using a special URL syntax.
 
    .. parsed-literal::
 
-      LIBISCSI_CHAP_USERNAME="user" \
-      LIBISCSI_CHAP_PASSWORD="password" \
+      LIBISCSI_CHAP_USERNAME="user" \\
+      LIBISCSI_CHAP_PASSWORD="password" \\
       |qemu_system| -drive file=iscsi://192.0.2.1/iqn.2001-04.com.example/1
 
 ``NBD``
diff --git a/qemu-options.hx b/qemu-options.hx
index b0f020594eab..47f64be0c041 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -373,9 +373,9 @@ SRST
 
     .. parsed-literal::
 
-        |qemu_system| \
-         -add-fd fd=3,set=2,opaque="rdwr:/path/to/file" \
-         -add-fd fd=4,set=2,opaque="rdonly:/path/to/file" \
+        |qemu_system| \\
+         -add-fd fd=3,set=2,opaque="rdwr:/path/to/file" \\
+         -add-fd fd=4,set=2,opaque="rdonly:/path/to/file" \\
          -drive file=/dev/fdset/2,index=0,media=disk
 ERST
 
@@ -1338,9 +1338,9 @@ SRST
 
     .. parsed-literal::
 
-        |qemu_system| \
-         -add-fd fd=3,set=2,opaque="rdwr:/path/to/file" \
-         -add-fd fd=4,set=2,opaque="rdonly:/path/to/file" \
+        |qemu_system| \\
+         -add-fd fd=3,set=2,opaque="rdwr:/path/to/file" \\
+         -add-fd fd=4,set=2,opaque="rdonly:/path/to/file" \\
          -drive file=/dev/fdset/2,index=0,media=disk
 
     You can connect a CDROM to the slave of ide0:
@@ -2593,7 +2593,7 @@ SRST
 
         .. parsed-literal::
 
-            |qemu_system| -hda linux.img -boot n -device e1000,netdev=n1 \
+            |qemu_system| -hda linux.img -boot n -device e1000,netdev=n1 \\
                 -netdev user,id=n1,tftp=/path/to/tftp/files,bootfile=/pxelinux.0
 
     ``smb=dir[,smbserver=addr]``
@@ -2703,15 +2703,15 @@ SRST
 
         #launch a QEMU instance with two NICs, each one connected
         #to a TAP device
-        |qemu_system| linux.img \
-                -netdev tap,id=nd0,ifname=tap0 -device e1000,netdev=nd0 \
+        |qemu_system| linux.img \\
+                -netdev tap,id=nd0,ifname=tap0 -device e1000,netdev=nd0 \\
                 -netdev tap,id=nd1,ifname=tap1 -device rtl8139,netdev=nd1
 
     .. parsed-literal::
 
         #launch a QEMU instance with the default network helper to
         #connect a TAP device to bridge br0
-        |qemu_system| linux.img -device virtio-net-pci,netdev=n1 \
+        |qemu_system| linux.img -device virtio-net-pci,netdev=n1 \\
                 -netdev tap,id=n1,"helper=/path/to/qemu-bridge-helper"
 
 ``-netdev bridge,id=id[,br=bridge][,helper=helper]``
@@ -2749,12 +2749,12 @@ SRST
     .. parsed-literal::
 
         # launch a first QEMU instance
-        |qemu_system| linux.img \
-                         -device e1000,netdev=n1,mac=52:54:00:12:34:56 \
+        |qemu_system| linux.img \\
+                         -device e1000,netdev=n1,mac=52:54:00:12:34:56 \\
                          -netdev socket,id=n1,listen=:1234
         # connect the network of this instance to the network of the first instance
-        |qemu_system| linux.img \
-                         -device e1000,netdev=n2,mac=52:54:00:12:34:57 \
+        |qemu_system| linux.img \\
+                         -device e1000,netdev=n2,mac=52:54:00:12:34:57 \\
                          -netdev socket,id=n2,connect=127.0.0.1:1234
 
 ``-netdev socket,id=id[,fd=h][,mcast=maddr:port[,localaddr=addr]]``
@@ -2776,16 +2776,16 @@ SRST
     .. parsed-literal::
 
         # launch one QEMU instance
-        |qemu_system| linux.img \
-                         -device e1000,netdev=n1,mac=52:54:00:12:34:56 \
+        |qemu_system| linux.img \\
+                         -device e1000,netdev=n1,mac=52:54:00:12:34:56 \\
                          -netdev socket,id=n1,mcast=230.0.0.1:1234
         # launch another QEMU instance on same "bus"
-        |qemu_system| linux.img \
-                         -device e1000,netdev=n2,mac=52:54:00:12:34:57 \
+        |qemu_system| linux.img \\
+                         -device e1000,netdev=n2,mac=52:54:00:12:34:57 \\
                          -netdev socket,id=n2,mcast=230.0.0.1:1234
         # launch yet another QEMU instance on same "bus"
-        |qemu_system| linux.img \
-                         -device e1000,netdev=n3,mac=52:54:00:12:34:58 \
+        |qemu_system| linux.img \\
+                         -device e1000,netdev=n3,mac=52:54:00:12:34:58 \\
                          -netdev socket,id=n3,mcast=230.0.0.1:1234
 
     Example (User Mode Linux compat.):
@@ -2793,8 +2793,8 @@ SRST
     .. parsed-literal::
 
         # launch QEMU instance (note mcast address selected is UML's default)
-        |qemu_system| linux.img \
-                         -device e1000,netdev=n1,mac=52:54:00:12:34:56 \
+        |qemu_system| linux.img \\
+                         -device e1000,netdev=n1,mac=52:54:00:12:34:56 \\
                          -netdev socket,id=n1,mcast=239.192.168.1:1102
         # launch UML
         /path/to/linux ubd0=/path/to/root_fs eth0=mcast
@@ -2803,8 +2803,8 @@ SRST
 
     .. parsed-literal::
 
-        |qemu_system| linux.img \
-                         -device e1000,netdev=n1,mac=52:54:00:12:34:56 \
+        |qemu_system| linux.img \\
+                         -device e1000,netdev=n1,mac=52:54:00:12:34:56 \\
                          -netdev socket,id=n1,mcast=239.192.168.1:1102,localaddr=1.2.3.4
 
 ``-netdev l2tpv3,id=id,src=srcaddr,dst=dstaddr[,srcport=srcport][,dstport=dstport],txsession=txsession[,rxsession=rxsession][,ipv6][,udp][,cookie64][,counter][,pincounter][,txcookie=txcookie][,rxcookie=rxcookie][,offset=offset]``
@@ -2860,9 +2860,9 @@ SRST
 
         # Setup tunnel on linux host using raw ip as encapsulation
         # on 1.2.3.4
-        ip l2tp add tunnel remote 4.3.2.1 local 1.2.3.4 tunnel_id 1 peer_tunnel_id 1 \
+        ip l2tp add tunnel remote 4.3.2.1 local 1.2.3.4 tunnel_id 1 peer_tunnel_id 1 \\
             encap udp udp_sport 16384 udp_dport 16384
-        ip l2tp add session tunnel_id 1 name vmtunnel0 session_id \
+        ip l2tp add session tunnel_id 1 name vmtunnel0 session_id \\
             0xFFFFFFFF peer_session_id 0xFFFFFFFF
         ifconfig vmtunnel0 mtu 1500
         ifconfig vmtunnel0 up
@@ -2872,7 +2872,7 @@ SRST
         # on 4.3.2.1
         # launch QEMU instance - if your network has reorder or is very lossy add ,pincounter
 
-        |qemu_system| linux.img -device e1000,netdev=n1 \
+        |qemu_system| linux.img -device e1000,netdev=n1 \\
             -netdev l2tpv3,id=n1,src=4.2.3.1,dst=1.2.3.4,udp,srcport=16384,dstport=16384,rxsession=0xffffffff,txsession=0xffffffff,counter
 
 ``-netdev vde,id=id[,sock=socketpath][,port=n][,group=groupname][,mode=octalmode]``
@@ -4627,8 +4627,8 @@ SRST
 
         .. parsed-literal::
 
-             # |qemu_system| \
-                 -object tls-cipher-suites,id=mysuite0,priority=@SYSTEM \
+             # |qemu_system| \\
+                 -object tls-cipher-suites,id=mysuite0,priority=@SYSTEM \\
                  -fw_cfg name=etc/edk2/https/ciphers,gen_id=mysuite0
 
     ``-object filter-buffer,id=id,netdev=netdevid,interval=t[,queue=all|rx|tx][,status=on|off][,position=head|tail|id=<id>][,insert=behind|before]``
@@ -4791,10 +4791,10 @@ SRST
 
         .. parsed-literal::
 
-             # |qemu_system| \
-               [...] \
-                   -object cryptodev-backend-builtin,id=cryptodev0 \
-                   -device virtio-crypto-pci,id=crypto0,cryptodev=cryptodev0 \
+             # |qemu_system| \\
+               [...] \\
+                   -object cryptodev-backend-builtin,id=cryptodev0 \\
+                   -device virtio-crypto-pci,id=crypto0,cryptodev=cryptodev0 \\
                [...]
 
     ``-object cryptodev-vhost-user,id=id,chardev=chardevid[,queues=queues]``
@@ -4810,11 +4810,11 @@ SRST
 
         .. parsed-literal::
 
-             # |qemu_system| \
-               [...] \
-                   -chardev socket,id=chardev0,path=/path/to/socket \
-                   -object cryptodev-vhost-user,id=cryptodev0,chardev=chardev0 \
-                   -device virtio-crypto-pci,id=crypto0,cryptodev=cryptodev0 \
+             # |qemu_system| \\
+               [...] \\
+                   -chardev socket,id=chardev0,path=/path/to/socket \\
+                   -object cryptodev-vhost-user,id=cryptodev0,chardev=chardev0 \\
+                   -device virtio-crypto-pci,id=crypto0,cryptodev=cryptodev0 \\
                [...]
 
     ``-object secret,id=id,data=string,format=raw|base64[,keyid=secretid,iv=string]``
@@ -4892,9 +4892,9 @@ SRST
 
         .. parsed-literal::
 
-             # |qemu_system| \
-                 -object secret,id=secmaster0,format=base64,file=key.b64 \
-                 -object secret,id=sec0,keyid=secmaster0,format=base64,\
+             # |qemu_system| \\
+                 -object secret,id=secmaster0,format=base64,file=key.b64 \\
+                 -object secret,id=sec0,keyid=secmaster0,format=base64,\\
                      data=$SECRET,iv=$(<iv.b64)
 
     ``-object sev-guest,id=id,cbitpos=cbitpos,reduced-phys-bits=val,[sev-device=string,policy=policy,handle=handle,dh-cert-file=file,session-file=file]``
@@ -4941,10 +4941,10 @@ SRST
 
         .. parsed-literal::
 
-             # |qemu_system_x86| \
-                 ......
-                 -object sev-guest,id=sev0,cbitpos=47,reduced-phys-bits=5 \
-                 -machine ...,memory-encryption=sev0
+             # |qemu_system_x86| \\
+                 ...... \\
+                 -object sev-guest,id=sev0,cbitpos=47,reduced-phys-bits=5 \\
+                 -machine ...,memory-encryption=sev0 \\
                  .....
 
     ``-object authz-simple,id=id,identity=string``
@@ -4962,9 +4962,9 @@ SRST
 
         .. parsed-literal::
 
-             # |qemu_system| \
-                 ...
-                 -object 'authz-simple,id=auth0,identity=CN=laptop.example.com,,O=Example Org,,L=London,,ST=London,,C=GB' \
+             # |qemu_system| \\
+                 ... \\
+                 -object 'authz-simple,id=auth0,identity=CN=laptop.example.com,,O=Example Org,,L=London,,ST=London,,C=GB' \\
                  ...
 
         Note the use of quotes due to the x509 distinguished name
@@ -5013,9 +5013,9 @@ SRST
 
         .. parsed-literal::
 
-             # |qemu_system| \
-                 ...
-                 -object authz-simple,id=auth0,filename=/etc/qemu/vnc-sasl.acl,refresh=yes
+             # |qemu_system| \\
+                 ... \\
+                 -object authz-simple,id=auth0,filename=/etc/qemu/vnc-sasl.acl,refresh=yes \\
                  ...
 
     ``-object authz-pam,id=id,service=string``
@@ -5032,9 +5032,9 @@ SRST
 
         .. parsed-literal::
 
-             # |qemu_system| \
-                 ...
-                 -object authz-pam,id=auth0,service=qemu-vnc
+             # |qemu_system| \\
+                 ... \\
+                 -object authz-pam,id=auth0,service=qemu-vnc \\
                  ...
 
         There would then be a corresponding config file for PAM at
-- 
2.26.2


