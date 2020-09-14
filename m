Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2F3C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 10:32:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A26432076C
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 10:32:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A26432076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHlmK-0001Rq-NC
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 06:32:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kHll7-0000ys-Nn
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 06:30:53 -0400
Received: from indium.canonical.com ([91.189.90.7]:43544)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kHll5-0001S8-Lv
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 06:30:53 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kHll3-0002Vm-G0
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 10:30:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 776D72E80DB
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 10:30:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2020 10:21:03 -0000
From: Daniel Berrange <1893691@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: berrange dgilbert-h piotrjurkiewicz
X-Launchpad-Bug-Reporter: Piotr Jurkiewicz (piotrjurkiewicz)
X-Launchpad-Bug-Modifier: Daniel Berrange (berrange)
References: <159890390988.14589.1084059668441088626.malonedeb@gac.canonical.com>
Message-Id: <160007886342.18019.2139188610969580048.malone@soybean.canonical.com>
Subject: [Bug 1893691] Re: Chardev logfile is not written (regression between
 5.0 and 5.1)
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="83bdf6c8a3a5f87722c8927e54838522f3e57504"; Instance="production"
X-Launchpad-Hash: 0370373898b5345a37a4d29ae6c0e0ba10b41730
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 05:55:43
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Reply-To: Bug 1893691 <1893691@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This regression is specific to the "socket" chardev and was caused by
this commit:

commit 271094474b65de1ad7aaf729938de3d9b9d0d36f (refs/bisect/bad)
Author: Dima Stepanov <dimastep@yandex-team.ru>
Date:   Thu May 28 12:11:18 2020 +0300

    char-socket: return -1 in case of disconnect during tcp_chr_write
    =

    During testing of the vhost-user-blk reconnect functionality the qemu
    SIGSEGV was triggered:
     start qemu as:
     x86_64-softmmu/qemu-system-x86_64 -m 1024M -M q35 \
       -object memory-backend-file,id=3Dram-node0,size=3D1024M,mem-path=3D/=
dev/shm/qemu,share=3Don \
       -numa node,cpus=3D0,memdev=3Dram-node0 \
       -chardev socket,id=3Dchardev0,path=3D./vhost.sock,noserver,reconnect=
=3D1 \
       -device vhost-user-blk-pci,chardev=3Dchardev0,num-queues=3D4 --enabl=
e-kvm
     start vhost-user-blk daemon:
     ./vhost-user-blk -s ./vhost.sock -b test-img.raw
    =

    If vhost-user-blk will be killed during the vhost initialization
    process, for instance after getting VHOST_SET_VRING_CALL command, then
    QEMU will fail with the following backtrace:
    =

    Thread 1 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
    0x00005555559272bb in vhost_user_read (dev=3D0x7fffef2d53e0, msg=3D0x7f=
ffffffd5b0)
        at ./hw/virtio/vhost-user.c:260
    260         CharBackend *chr =3D u->user->chr;
    =

     #0  0x00005555559272bb in vhost_user_read (dev=3D0x7fffef2d53e0, msg=
=3D0x7fffffffd5b0)
        at ./hw/virtio/vhost-user.c:260
     #1  0x000055555592acb8 in vhost_user_get_config (dev=3D0x7fffef2d53e0,=
 config=3D0x7fffef2d5394 "", config_len=3D60)
        at ./hw/virtio/vhost-user.c:1645
     #2  0x0000555555925525 in vhost_dev_get_config (hdev=3D0x7fffef2d53e0,=
 config=3D0x7fffef2d5394 "", config_len=3D60)
        at ./hw/virtio/vhost.c:1490
     #3  0x00005555558cc46b in vhost_user_blk_device_realize (dev=3D0x7fffe=
f2d51a0, errp=3D0x7fffffffd8f0)
        at ./hw/block/vhost-user-blk.c:429
     #4  0x0000555555920090 in virtio_device_realize (dev=3D0x7fffef2d51a0,=
 errp=3D0x7fffffffd948)
        at ./hw/virtio/virtio.c:3615
     #5  0x0000555555a9779c in device_set_realized (obj=3D0x7fffef2d51a0, v=
alue=3Dtrue, errp=3D0x7fffffffdb88)
        at ./hw/core/qdev.c:891
     ...
    =

    The problem is that vhost_user_write doesn't get an error after
    disconnect and try to call vhost_user_read(). The tcp_chr_write()
    routine should return -1 in case of disconnect. Indicate the EIO error
    if this routine is called in the disconnected state.
    =

    Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
    Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
    Message-Id: <aeb7806bfc945faadf09f64dcfa30f59de3ac053.1590396396.git.di=
mastep@yandex-team.ru>
    Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
    Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1893691

Title:
  Chardev logfile is not written (regression between 5.0 and 5.1)

Status in QEMU:
  New

Bug description:
  After update from version 5.0 to 5.1, logfile stopped being populated
  with console output. The file is being created, but remains empty.

  Relevant command line options:

  -mon chardev=3Dchar0
  -serial chardev:char0
  -chardev socket,host=3D127.0.0.10,port=3D2323,server,nowait,telnet,mux=3D=
on,id=3Dchar0,logfile=3D/home/jurkiew/.machiner/runs/2020-08-31T21:46:55-0/=
internal/log

  =

  Full command line:

  qemu-system-x86_64
  -nodefaults
  -no-user-config
  -snapshot
  -enable-kvm
  -cpu
  host
  -nographic
  -echr
  17
  -mon
  chardev=3Dchar0
  -serial
  chardev:char0
  -rtc
  clock=3Dvm
  -object
  rng-random,filename=3D/dev/urandom,id=3Drng0
  -device
  virtio-rng-pci,rng=3Drng0,max-bytes=3D512,period=3D1000
  -name
  2020-08-31T21:46:55-0,debug-threads=3Don
  -smp
  sockets=3D1,cores=3D9,threads=3D2
  -m
  251G
  -overcommit
  cpu-pm=3Don
  -pidfile
  /home/jurkiew/.machiner/runs/2020-08-31T21:46:55-0/internal/pid
  -net
  nic,model=3Dvirtio
  -net
  user,hostfwd=3Dtcp:127.0.0.10:2222-:22,hostfwd=3Dtcp:127.0.0.10:8000-:800=
0,hostfwd=3Dtcp:127.0.0.10:9000-:9000
  -fsdev
  local,id=3Dmachiner_internal_dir,security_model=3Dnone,path=3D/home/jurki=
ew/.machiner/runs/2020-08-31T21:46:55-0/internal
  -device
  virtio-9p-pci,fsdev=3Dmachiner_internal_dir,mount_tag=3Dmachiner_internal=
_dir
  -fsdev
  local,id=3Dmachiner_lower_dir,security_model=3Dnone,readonly,path=3D.
  -device
  virtio-9p-pci,fsdev=3Dmachiner_lower_dir,mount_tag=3Dmachiner_lower_dir
  -fsdev
  local,id=3Dmachiner_upper_dir,security_model=3Dmapped-xattr,fmode=3D0777,=
dmode=3D0777,path=3D/home/jurkiew/.machiner/runs/2020-08-31T21:46:55-0
  -device
  virtio-9p-pci,fsdev=3Dmachiner_upper_dir,mount_tag=3Dmachiner_upper_dir
  -device
  virtio-scsi
  -drive
  if=3Dnone,file=3D/home/jurkiew/.machiner/images/famtar/image.qcow2,discar=
d=3Don,id=3Dfamtar
  -device
  scsi-hd,drive=3Dfamtar
  -chardev
  socket,host=3D127.0.0.10,port=3D2323,server,nowait,telnet,mux=3Don,id=3Dc=
har0,logfile=3D/home/jurkiew/.machiner/runs/2020-08-31T21:46:55-0/internal/=
log

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1893691/+subscriptions

