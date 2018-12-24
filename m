Received: from eggs.gnu.org ([208.118.235.92]:41212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gbZkw-0000kO-IA
	for qemu-devel@nongnu.org; Mon, 24 Dec 2018 18:35:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gbZks-0007fn-Lp
	for qemu-devel@nongnu.org; Mon, 24 Dec 2018 18:35:30 -0500
Received: from indium.canonical.com ([91.189.90.7]:58804)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gbZks-0007f4-GH
	for qemu-devel@nongnu.org; Mon, 24 Dec 2018 18:35:26 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gbZkr-0005HF-6g
	for <qemu-devel@nongnu.org>; Mon, 24 Dec 2018 23:35:25 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 22C912E80D0
	for <qemu-devel@nongnu.org>; Mon, 24 Dec 2018 23:35:25 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Dec 2018 23:26:15 -0000
From: Timothy Pearson <kb9vqf@pearsoncomputing.net>
Reply-To: Bug 1809684 <1809684@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <154569397586.26258.18132613460124027534.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1809684] [NEW] amdgpu passthrough on POWER9
 (ppc64el) not working
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

When attempting to pass a Vega 56 GPU to a virtualized guest using QEMU
3.1 on ppc64el (POWER9), the guest is unable to initialize the GPU.
Further digging reveals the driver attempting to allocate a large BAR,
which then fails:

[    6.058544] [drm] PCI I/O BAR is not found.
<snip uninteresting bits>
[    6.679193] amdgpu 0000:00:03.0: BAR 2: releasing [mem 0x210400000000-0x=
2104001fffff pref]
[    6.679306] amdgpu 0000:00:03.0: BAR 0: releasing [mem 0x210200000000-0x=
2103ffffffff pref]
[    6.679361] amdgpu 0000:00:03.0: BAR 0: no space for [mem size 0x2000000=
00 pref]
[    6.679403] amdgpu 0000:00:03.0: BAR 0: failed to assign [mem size 0x200=
000000 pref]
[    6.679444] amdgpu 0000:00:03.0: BAR 2: assigned [mem 0x200080200000-0x2=
000803fffff pref]
[    6.681420] amdgpu 0000:00:03.0: VRAM: 8176M 0x000000F400000000 - 0x0000=
00F5FEFFFFFF (8176M used)
[    6.681507] amdgpu 0000:00:03.0: GART: 512M 0x0000000000000000 - 0x00000=
0001FFFFFFF
[    6.681594] amdgpu 0000:00:03.0: AGP: 267419648M 0x000000F800000000 - 0x=
0000FFFFFFFFFFFF
[    6.681653] [drm] Detected VRAM RAM=3D8176M, BAR=3D0M
[    6.681688] [drm] RAM width 2048bits HBM
[    6.681885] [TTM] Zone  kernel: Available graphics memory: 4176288 kiB
[    6.681978] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[    6.682043] [TTM] Initializing pool allocator
[    6.682159] [drm] amdgpu: 8176M of VRAM memory ready
[    6.682249] [drm] amdgpu: 6117M of GTT memory ready.
[    6.682387] [drm] GART: num cpu pages 8192, num gpu pages 131072
[    6.682466] amdgpu 0000:00:03.0: (-22) kernel bo map failed
[    6.682539] [drm:amdgpu_device_init [amdgpu]] *ERROR* amdgpu_vram_scratc=
h_init failed -22
[    6.682592] amdgpu 0000:00:03.0: amdgpu_device_ip_init failed
[    6.682636] amdgpu 0000:00:03.0: Fatal error during GPU init

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1809684

Title:
  amdgpu passthrough on POWER9 (ppc64el) not working

Status in QEMU:
  New

Bug description:
  When attempting to pass a Vega 56 GPU to a virtualized guest using
  QEMU 3.1 on ppc64el (POWER9), the guest is unable to initialize the
  GPU.  Further digging reveals the driver attempting to allocate a
  large BAR, which then fails:

  [    6.058544] [drm] PCI I/O BAR is not found.
  <snip uninteresting bits>
  [    6.679193] amdgpu 0000:00:03.0: BAR 2: releasing [mem 0x210400000000-=
0x2104001fffff pref]
  [    6.679306] amdgpu 0000:00:03.0: BAR 0: releasing [mem 0x210200000000-=
0x2103ffffffff pref]
  [    6.679361] amdgpu 0000:00:03.0: BAR 0: no space for [mem size 0x20000=
0000 pref]
  [    6.679403] amdgpu 0000:00:03.0: BAR 0: failed to assign [mem size 0x2=
00000000 pref]
  [    6.679444] amdgpu 0000:00:03.0: BAR 2: assigned [mem 0x200080200000-0=
x2000803fffff pref]
  [    6.681420] amdgpu 0000:00:03.0: VRAM: 8176M 0x000000F400000000 - 0x00=
0000F5FEFFFFFF (8176M used)
  [    6.681507] amdgpu 0000:00:03.0: GART: 512M 0x0000000000000000 - 0x000=
000001FFFFFFF
  [    6.681594] amdgpu 0000:00:03.0: AGP: 267419648M 0x000000F800000000 - =
0x0000FFFFFFFFFFFF
  [    6.681653] [drm] Detected VRAM RAM=3D8176M, BAR=3D0M
  [    6.681688] [drm] RAM width 2048bits HBM
  [    6.681885] [TTM] Zone  kernel: Available graphics memory: 4176288 kiB
  [    6.681978] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB
  [    6.682043] [TTM] Initializing pool allocator
  [    6.682159] [drm] amdgpu: 8176M of VRAM memory ready
  [    6.682249] [drm] amdgpu: 6117M of GTT memory ready.
  [    6.682387] [drm] GART: num cpu pages 8192, num gpu pages 131072
  [    6.682466] amdgpu 0000:00:03.0: (-22) kernel bo map failed
  [    6.682539] [drm:amdgpu_device_init [amdgpu]] *ERROR* amdgpu_vram_scra=
tch_init failed -22
  [    6.682592] amdgpu 0000:00:03.0: amdgpu_device_ip_init failed
  [    6.682636] amdgpu 0000:00:03.0: Fatal error during GPU init

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1809684/+subscriptions
