Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D539C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 14:32:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5942B2313B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 14:32:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5942B2313B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3KSV-00081q-Gu
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 10:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k3KRL-0007ao-5K
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 10:30:47 -0400
Received: from indium.canonical.com ([91.189.90.7]:38804)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k3KRI-0001Hs-I4
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 10:30:46 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k3KRG-0002s6-D0
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 14:30:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 5B92D2E805D
 for <qemu-devel@nongnu.org>; Wed,  5 Aug 2020 14:30:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2020 14:24:27 -0000
From: Greg Kurz <1890290@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: nested powerpc
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: gkurz sathnaga
X-Launchpad-Bug-Reporter: Satheesh Rajendran (sathnaga)
X-Launchpad-Bug-Modifier: Greg Kurz (gkurz)
References: <159655059319.10948.7356744312155765003.malonedeb@chaenomeles.canonical.com>
Message-Id: <159663746717.2548.1739338882333406256.malone@gac.canonical.com>
Subject: [Bug 1890290] Re: PowerPC L2(nested virt) kvm guest fails to boot
 with ic-mode=dual, kernel-irqchip=on - `KVM is too old to support ic-mode=dual,
 kernel-irqchip=on`
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="a24057fea7e4c6a98c0220d5f878da0f3c783699";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: d41ccbe0456255b2c6723dddf449b7a53fb8e29d
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 10:30:42
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Bug 1890290 <1890290@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hmm... the documentation might need an update. I'll have a look.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1890290

Title:
  PowerPC L2(nested virt) kvm guest fails to boot with ic-mode=3Ddual
  ,kernel-irqchip=3Don - `KVM is too old to support ic-mode=3Ddual,kernel-
  irqchip=3Don`

Status in QEMU:
  New

Bug description:
  Env:
  HW: Power 9 DD2.3
  Host L0: 5.8.0-rc5-g8ba4ffcd8
  Qemu: 5.0.50 (v5.0.0-533-gdebe78ce14)
  Libvirt: 6.4.0
  L1: 5.8.0-rc5-ge9919e11e
  qemu_version': '5.0.50 (v5.1.0-rc2-dirty)
  libvirt_version': '6.4.0'
  L2: 5.8.0-rc7-g6ba1b005f

  =

  1. boot a L2 KVM guest with `ic-mode=3Ddual,kernel-irqchip=3Don`

  /usr/bin/virt-install --connect=3Dqemu:///system --hvm --accelerate --nam=
e 'vm1' --machine pseries --memory=3D8192 --vcpu=3D8,maxvcpus=3D8,sockets=
=3D1,cores=3D2,t
  hreads=3D4 --import --nographics --serial pty --memballoon model=3Dvirtio=
 --disk path=3D/home/tests/data/avocado-vt/images/f31-ppc64le.qcow2,bus=3Dv=
irtio,size=3D10,format=3Dqcow2 --network
  =3Dbridge=3Dvirbr0,model=3Dvirtio,mac=3D52:54:00:e6:fe:f6 --mac=3D52:54:0=
0:e6:fe:f6 --boot emulator=3D/usr/share/avocado-plugins-vt/bin/qemu,kernel=
=3D/tmp/linux/vmlinux,kernel_args=3D"root=3D/de
  v/vda2 rw console=3Dtty0 console=3DttyS0,115200 init=3D/sbin/init initcal=
l_debug selinux=3D0" --noautoconsole --qemu-commandline=3D" -M pseries,ic-m=
ode=3Ddual,kernel-irqchip=3Don"

  =

  ERROR    internal error: process exited while connecting to monitor: 2020=
-08-04T11:12:53.304482Z qemu: KVM is too old to support ic-mode=3Ddual,kern=
el-irqchip=3Don


  =

  Qemu Log:
  ```
  /usr/share/avocado-plugins-vt/bin/qemu \
  -name guest=3Dvm1,debug-threads=3Don \
  -S \
  -object secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvirt/qemu/=
domain-5-vm1/master-key.aes \
  -machine pseries-5.1,accel=3Dkvm,usb=3Doff,dump-guest-core=3Doff \
  -cpu POWER9 \
  -m 8192 \
  -overcommit mem-lock=3Doff \
  -smp 8,sockets=3D1,dies=3D1,cores=3D2,threads=3D4 \
  -uuid 20a3351b-2776-4e75-9059-c070fe3dd44b \
  -display none \
  -no-user-config \
  -nodefaults \
  -chardev socket,id=3Dcharmonitor,fd=3D34,server,nowait \
  -mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol \
  -rtc base=3Dutc \
  -no-shutdown \
  -boot strict=3Don \
  -kernel /tmp/linux/vmlinux \
  -append 'root=3D/dev/vda2 rw console=3Dtty0 console=3DttyS0,115200 init=
=3D/sbin/init initcall_debug selinux=3D0' \
  -device qemu-xhci,p2=3D15,p3=3D15,id=3Dusb,bus=3Dpci.0,addr=3D0x2 \
  -device virtio-serial-pci,id=3Dvirtio-serial0,bus=3Dpci.0,addr=3D0x3 \
  -blockdev '{"driver":"file","filename":"/home/tests/data/avocado-vt/image=
s/f31-ppc64le.qcow2","node-name":"libvirt-1-storage","auto-read-only":true,=
"discard":"unmap"}' \
  -blockdev '{"node-name":"libvirt-1-format","read-only":false,"driver":"qc=
ow2","file":"libvirt-1-storage","backing":null}' \
  -device virtio-blk-pci,bus=3Dpci.0,addr=3D0x4,drive=3Dlibvirt-1-format,id=
=3Dvirtio-disk0,bootindex=3D1 \
  -netdev tap,fd=3D37,id=3Dhostnet0,vhost=3Don,vhostfd=3D38 \
  -device virtio-net-pci,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:e6:fe:f=
6,bus=3Dpci.0,addr=3D0x1 \
  -chardev pty,id=3Dcharserial0 \
  -device spapr-vty,chardev=3Dcharserial0,id=3Dserial0,reg=3D0x30000000 \
  -chardev socket,id=3Dcharchannel0,fd=3D39,server,nowait \
  -device virtserialport,bus=3Dvirtio-serial0.0,nr=3D1,chardev=3Dcharchanne=
l0,id=3Dchannel0,name=3Dorg.qemu.guest_agent.0 \
  -device virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x5 \
  -M pseries,ic-mode=3Ddual,kernel-irqchip=3Don \
  -msg timestamp=3Don
  2020-08-04 11:12:53.169+0000: Domain id=3D5 is tainted: custom-argv
  2020-08-04 11:12:53.179+0000: 11120: info : libvirt version: 6.4.0, packa=
ge: 1.fc31 (Unknown, 2020-06-02-05:09:40, ltc-wspoon4.aus.stglabs.ibm.com)
  2020-08-04 11:12:53.179+0000: 11120: info : hostname: atest-guest
  2020-08-04 11:12:53.179+0000: 11120: info : virObjectUnref:347 : OBJECT_U=
NREF: obj=3D0x7fff0c117c40
  char device redirected to /dev/pts/0 (label charserial0)
  2020-08-04T11:12:53.304482Z qemu: KVM is too old to support ic-mode=3Ddua=
l,kernel-irqchip=3Don
  2020-08-04 11:12:53.694+0000: shutting down, reason=3Dfailed
  ```

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1890290/+subscriptions

