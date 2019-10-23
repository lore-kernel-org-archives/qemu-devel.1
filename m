Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360AECA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 16:09:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09384205C9
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 16:09:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09384205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNJCi-000263-GC
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 12:09:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40436)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iNIbb-0000Kv-9I
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:31:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iNIbZ-0004Es-Jt
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:31:23 -0400
Received: from indium.canonical.com ([91.189.90.7]:54718)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iNIbZ-0004E0-DJ
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:31:21 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iNIbX-0004kk-EW
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 15:31:19 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 6CC002E8079
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 15:31:19 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Oct 2019 15:04:51 -0000
From: John Snow <1848901@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: d33m0n jnsnow
X-Launchpad-Bug-Reporter: P.O. (d33m0n)
X-Launchpad-Bug-Modifier: John Snow (jnsnow)
References: <157153622475.25094.3691269102491613645.malonedeb@chaenomeles.canonical.com>
Message-Id: <8d4cd62b-c8b2-f9ea-2e67-a2f4ecd357bc@redhat.com>
Subject: Re: [Bug 1848901] [NEW] kvm_mem_ioeventfd_add: error adding
 ioeventfd: No space left on device (28)
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="469f241f4e73cc0bdffa4e30654052a2af068e06";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: fd7c8746a6bd31fcc477d7cebc10c7594412bd29
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 91.189.90.7
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1848901 <1848901@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20191023150451.9BVgB79wynR9CfhmnTKN_HGmzXiB-cSbLpFa0zT_AUc@z>

On 10/19/19 9:50 PM, P.O. wrote:
> Public bug reported:
> =

> =3D> QEMU process has stopped, return code: -6
> =

> Start QEMU with /usr/bin/qemu-system-x86_64 -name CiscoASAv9.8.1-1 -m
> 2048M -smp cpus=3D1 -enable-kvm -machine smm=3Doff -boot order=3Dc -drive
> 'file=3D/home/deemon/GNS3/projects/ASAv my ass/project-files/qemu
> /7725cdea-5e66-4777-b4dd-
> c3905f258394/hda_disk.qcow2,if=3Dvirtio,index=3D0,media=3Ddisk,id=3Ddrive=
0'
> -uuid 7725cdea-5e66-4777-b4dd-c3905f258394 -serial
> telnet:127.0.0.1:5000,server,nowait -monitor
> tcp:127.0.0.1:44629,server,nowait -net none -device
> e1000,mac=3D0c:7a:1d:83:94:00,netdev=3Dgns3-0 -netdev
> socket,id=3Dgns3-0,udp=3D127.0.0.1:10001,localaddr=3D127.0.0.1:10000 -dev=
ice
> e1000,mac=3D0c:7a:1d:83:94:01,netdev=3Dgns3-1 -netdev
> socket,id=3Dgns3-1,udp=3D127.0.0.1:10003,localaddr=3D127.0.0.1:10002 -dev=
ice
> e1000,mac=3D0c:7a:1d:83:94:02,netdev=3Dgns3-2 -netdev
> socket,id=3Dgns3-2,udp=3D127.0.0.1:10005,localaddr=3D127.0.0.1:10004 -dev=
ice
> e1000,mac=3D0c:7a:1d:83:94:03,netdev=3Dgns3-3 -netdev
> socket,id=3Dgns3-3,udp=3D127.0.0.1:10007,localaddr=3D127.0.0.1:10006 -dev=
ice
> e1000,mac=3D0c:7a:1d:83:94:04,netdev=3Dgns3-4 -netdev
> socket,id=3Dgns3-4,udp=3D127.0.0.1:10009,localaddr=3D127.0.0.1:10008 -dev=
ice
> e1000,mac=3D0c:7a:1d:83:94:05,netdev=3Dgns3-5 -netdev
> socket,id=3Dgns3-5,udp=3D127.0.0.1:10011,localaddr=3D127.0.0.1:10010 -dev=
ice
> e1000,mac=3D0c:7a:1d:83:94:06,netdev=3Dgns3-6 -netdev
> socket,id=3Dgns3-6,udp=3D127.0.0.1:10013,localaddr=3D127.0.0.1:10012 -dev=
ice
> e1000,mac=3D0c:7a:1d:83:94:07,netdev=3Dgns3-7 -netdev
> socket,id=3Dgns3-7,udp=3D127.0.0.1:10015,localaddr=3D127.0.0.1:10014
> -nographic
> =


Reminds me of #1813940 https://bugs.launchpad.net/qemu/+bug/1813940

but that fix was in v4.1.0.

>  =

> Execution log:
> kvm_mem_ioeventfd_add: error adding ioeventfd: No space left on device (2=
8)
> =

> and then it just closes...
> =

> =

> [deemon@Zen ~]$ coredumpctl info 8638
>            PID: 8638 (qemu-system-x86)
>            UID: 1000 (deemon)
>            GID: 1000 (deemon)
>         Signal: 6 (ABRT)
>      Timestamp: Sun 2019-10-20 04:27:29 EEST (5min ago)
>   Command Line: /usr/bin/qemu-system-x86_64 -name CiscoASAv9.8.1-1 -m 204=
8M -smp cpus=3D1 -enable-kvm -machine smm=3Doff -boot order=3Dc -drive file=
=3D/home/deemon/GNS3/projects/ASAv my ass/project-files/qemu>
>     Executable: /usr/bin/qemu-system-x86_64
>  Control Group: /user.slice/user-1000.slice/session-2.scope
>           Unit: session-2.scope
>          Slice: user-1000.slice
>        Session: 2
>      Owner UID: 1000 (deemon)
>        Boot ID: cd30f69a8d194359a31889dc7b6b026c
>     Machine ID: d0a2d74a5cd9430797d902f5237c448d
>       Hostname: Zen
>        Storage: /var/lib/systemd/coredump/core.qemu-system-x86.1000.cd30f=
69a8d194359a31889dc7b6b026c.8638.1571534849000000.lz4 (truncated)
>        Message: Process 8638 (qemu-system-x86) of user 1000 dumped core.
>                 =

>                 Stack trace of thread 8642:
>                 #0  0x00007f1a33609f25 n/a (n/a)
> =

> ** Affects: qemu
>      Importance: Undecided
>          Status: New
>

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1848901

Title:
  kvm_mem_ioeventfd_add: error adding ioeventfd: No space left on device
  (28)

Status in QEMU:
  New

Bug description:
  =3D> QEMU process has stopped, return code: -6

  Start QEMU with /usr/bin/qemu-system-x86_64 -name CiscoASAv9.8.1-1 -m
  2048M -smp cpus=3D1 -enable-kvm -machine smm=3Doff -boot order=3Dc -drive
  'file=3D/home/deemon/GNS3/projects/ASAv my ass/project-files/qemu
  /7725cdea-5e66-4777-b4dd-
  c3905f258394/hda_disk.qcow2,if=3Dvirtio,index=3D0,media=3Ddisk,id=3Ddrive=
0'
  -uuid 7725cdea-5e66-4777-b4dd-c3905f258394 -serial
  telnet:127.0.0.1:5000,server,nowait -monitor
  tcp:127.0.0.1:44629,server,nowait -net none -device
  e1000,mac=3D0c:7a:1d:83:94:00,netdev=3Dgns3-0 -netdev
  socket,id=3Dgns3-0,udp=3D127.0.0.1:10001,localaddr=3D127.0.0.1:10000 -dev=
ice
  e1000,mac=3D0c:7a:1d:83:94:01,netdev=3Dgns3-1 -netdev
  socket,id=3Dgns3-1,udp=3D127.0.0.1:10003,localaddr=3D127.0.0.1:10002 -dev=
ice
  e1000,mac=3D0c:7a:1d:83:94:02,netdev=3Dgns3-2 -netdev
  socket,id=3Dgns3-2,udp=3D127.0.0.1:10005,localaddr=3D127.0.0.1:10004 -dev=
ice
  e1000,mac=3D0c:7a:1d:83:94:03,netdev=3Dgns3-3 -netdev
  socket,id=3Dgns3-3,udp=3D127.0.0.1:10007,localaddr=3D127.0.0.1:10006 -dev=
ice
  e1000,mac=3D0c:7a:1d:83:94:04,netdev=3Dgns3-4 -netdev
  socket,id=3Dgns3-4,udp=3D127.0.0.1:10009,localaddr=3D127.0.0.1:10008 -dev=
ice
  e1000,mac=3D0c:7a:1d:83:94:05,netdev=3Dgns3-5 -netdev
  socket,id=3Dgns3-5,udp=3D127.0.0.1:10011,localaddr=3D127.0.0.1:10010 -dev=
ice
  e1000,mac=3D0c:7a:1d:83:94:06,netdev=3Dgns3-6 -netdev
  socket,id=3Dgns3-6,udp=3D127.0.0.1:10013,localaddr=3D127.0.0.1:10012 -dev=
ice
  e1000,mac=3D0c:7a:1d:83:94:07,netdev=3Dgns3-7 -netdev
  socket,id=3Dgns3-7,udp=3D127.0.0.1:10015,localaddr=3D127.0.0.1:10014
  -nographic

   =

  Execution log:
  kvm_mem_ioeventfd_add: error adding ioeventfd: No space left on device (2=
8)

  and then it just closes...


  [deemon@Zen ~]$ coredumpctl info 8638
             PID: 8638 (qemu-system-x86)
             UID: 1000 (deemon)
             GID: 1000 (deemon)
          Signal: 6 (ABRT)
       Timestamp: Sun 2019-10-20 04:27:29 EEST (5min ago)
    Command Line: /usr/bin/qemu-system-x86_64 -name CiscoASAv9.8.1-1 -m 204=
8M -smp cpus=3D1 -enable-kvm -machine smm=3Doff -boot order=3Dc -drive file=
=3D/home/deemon/GNS3/projects/ASAv my ass/project-files/qemu>
      Executable: /usr/bin/qemu-system-x86_64
   Control Group: /user.slice/user-1000.slice/session-2.scope
            Unit: session-2.scope
           Slice: user-1000.slice
         Session: 2
       Owner UID: 1000 (deemon)
         Boot ID: cd30f69a8d194359a31889dc7b6b026c
      Machine ID: d0a2d74a5cd9430797d902f5237c448d
        Hostname: Zen
         Storage: /var/lib/systemd/coredump/core.qemu-system-x86.1000.cd30f=
69a8d194359a31889dc7b6b026c.8638.1571534849000000.lz4 (truncated)
         Message: Process 8638 (qemu-system-x86) of user 1000 dumped core.
                  =

                  Stack trace of thread 8642:
                  #0  0x00007f1a33609f25 n/a (n/a)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1848901/+subscriptions

