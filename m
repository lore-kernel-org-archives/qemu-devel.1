Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC166C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 15:32:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1CE2206A3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 15:32:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1CE2206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsqaO-0003XH-Oz
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 11:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57055)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hsqZA-0002r4-Vh
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 11:31:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hsqZ9-00083E-Eg
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 11:31:00 -0400
Received: from indium.canonical.com ([91.189.90.7]:39694)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hsqZ9-00082T-8c
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 11:30:59 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hsqZ6-0006Qj-05
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 15:30:56 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 464712E80E8
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 15:30:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 31 Jul 2019 15:23:55 -0000
From: Hans Peter <1838312@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Invalid; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=virt-manager;
 component=universe; status=Incomplete; importance=Undecided; assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: green-world78 paelzer
X-Launchpad-Bug-Reporter: Hans Peter (green-world78)
X-Launchpad-Bug-Modifier: Hans Peter (green-world78)
References: <156441781649.17826.2889969380137011138.malonedeb@gac.canonical.com>
Message-Id: <156458663585.27167.3448253531165883976.malone@gac.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19012";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 8f3fae4b4fcac22b045ac6040a49d7a3357a4acf
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1838312] Re: Qemu virt-manager Segmentation fault
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
Reply-To: Bug 1838312 <1838312@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

@ Christian, I delete all files in /var/crash and
run virt-manager again in terminal...

Segmentation fault is present.


I did this, too:

# sudo su
# PYTHONDEVMODE=3D1 virt-manager --no-fork

Fatal Python error: Segmentation fault

Current thread 0x00007f2309805740 (most recent call first):
  File "<frozen importlib._bootstrap>", line 219 in _call_with_frames_remov=
ed
  File "<frozen importlib._bootstrap_external>", line 1043 in create_module
  File "<frozen importlib._bootstrap>", line 583 in module_from_spec
  File "<frozen importlib._bootstrap>", line 670 in _load_unlocked
  File "<frozen importlib._bootstrap>", line 967 in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 983 in _find_and_load
  File "/usr/lib/python3.7/lzma.py", line 27 in <module>
  File "<frozen importlib._bootstrap>", line 219 in _call_with_frames_remov=
ed
  File "<frozen importlib._bootstrap_external>", line 728 in exec_module
  File "<frozen importlib._bootstrap>", line 677 in _load_unlocked
  File "<frozen importlib._bootstrap>", line 967 in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 983 in _find_and_load
  File "/usr/lib/python3.7/shutil.py", line 29 in <module>
  File "<frozen importlib._bootstrap>", line 219 in _call_with_frames_remov=
ed
  File "<frozen importlib._bootstrap_external>", line 728 in exec_module
  File "<frozen importlib._bootstrap>", line 677 in _load_unlocked
  File "<frozen importlib._bootstrap>", line 967 in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 983 in _find_and_load
  File "/usr/lib/python3.7/tempfile.py", line 44 in <module>
  File "<frozen importlib._bootstrap>", line 219 in _call_with_frames_remov=
ed
  File "<frozen importlib._bootstrap_external>", line 728 in exec_module
  File "<frozen importlib._bootstrap>", line 677 in _load_unlocked
  File "<frozen importlib._bootstrap>", line 967 in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 983 in _find_and_load
  File "/usr/lib/python3/dist-packages/apport/report.py", line 12 in <modul=
e>
  File "<frozen importlib._bootstrap>", line 219 in _call_with_frames_remov=
ed
  File "<frozen importlib._bootstrap_external>", line 728 in exec_module
  File "<frozen importlib._bootstrap>", line 677 in _load_unlocked
  File "<frozen importlib._bootstrap>", line 967 in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 983 in _find_and_load
  File "/usr/lib/python3/dist-packages/apport/__init__.py", line 5 in <modu=
le>
  File "<frozen importlib._bootstrap>", line 219 in _call_with_frames_remov=
ed
  File "<frozen importlib._bootstrap_external>", line 728 in exec_module
  File "<frozen importlib._bootstrap>", line 677 in _load_unlocked
  File "<frozen importlib._bootstrap>", line 967 in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 983 in _find_and_load
  File "<frozen importlib._bootstrap>", line 219 in _call_with_frames_remov=
ed
  File "<frozen importlib._bootstrap>", line 953 in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 983 in _find_and_load
  File "/usr/lib/python3/dist-packages/apport_python_hook.py", line 63 in a=
pport_excepthook
Segmentation fault

I don't know how to fix that.

Can you do anything with that @ Christian?

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1838312

Title:
  Qemu virt-manager Segmentation fault

Status in QEMU:
  Invalid
Status in virt-manager package in Ubuntu:
  Incomplete

Bug description:
  Hi!

  I installed all these packages:

  sudo apt install qemu
  sudo apt install ipxe-qemu-256k-compat-efi-roms libspice-server1 libbluet=
ooth3
  sudo apt install libbrlapi0.6 libcacard0 libfdt1 libusbredirparser1 libvi=
rglrenderer0 libxen-4.9 libxenstore3.0
  sudo apt install cpu-checker ibverbs-providers ipxe-qemu libibverbs1 libi=
scsi7 libnl-route-3-200 librados2 librbd1 librdmacm1 msr-tools sharutils
  sudo apt install qemu-block-extra qemu-system-common qemu-system-data qem=
u-system-gui qemu-utils
  sudo apt install --no-install-recommends qemu-kvm qemu-system-x86
  sudo apt install libauparse0 ebtables gir1.2-gtk-vnc-2.0 gir1.2-libosinfo=
-1.0 gir1.2-libvirt-glib-1.0 gir1.2-spiceclientglib-2.0 gir1.2-spiceclientg=
tk-3.0 libvde0 libvdeplug2 libgovirt-common libgovirt2 libgtk-vnc-2.0-0 lib=
gvnc-1.0-0 libosinfo-1.0-0 libphodav-2.0-0 libphodav-2.0-common libspice-cl=
ient-glib-2.0-8 libspice-client-gtk-3.0-5 libusbredirhost1 libvirt-clients =
libvirt-daemon libvirt-daemon-driver-storage-rbd libvirt-daemon-system libv=
irt-glib-1.0-0 libvirt0 osinfo-db python3-libvirt python3-libxml2 spice-cli=
ent-glib-usb-acl-helper vde2 vde2-cryptcab virt-viewer virtinst virt-manager

  without the i386 packages for Qemu because I want only 64 bit.

  I installed all these packages without error, but when I run

  # virt-manager

  Output: ...shows me:

  Segmentation fault

  =

  My hardware is 100% ok.
  Maybee a broken lib?


  How can I fix that?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1838312/+subscriptions

