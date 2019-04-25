Received: from eggs.gnu.org ([209.51.188.92]:51408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJdpl-0000Hz-I3
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 08:50:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJdpj-0004ip-Ly
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 08:50:37 -0400
Received: from indium.canonical.com ([91.189.90.7]:60760)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hJdpi-0004gg-AU
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 08:50:34 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hJdpg-00046S-K6
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 12:50:32 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 95CBD2E80C9
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 12:50:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Apr 2019 12:44:16 -0000
From: Adrian Luca <1826401@bugs.launchpad.net>
Reply-To: Bug 1826401 <1826401@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <155619625636.14250.4864237510034054943.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1826401] [NEW] qemu-system-aarch64 has a high cpu
 usage on windows
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

Running qemu-system-aarch64 leads to a high CPU consumption on windows
10.

Tested with qemu: 4.0.0-rc4 & 3.1.0 & 2.11.0

Command: qemu_start_command =3D [
        qemu-system-aarch64,
        "-pidfile",
        target_path + "/qemu" + str(instance) + ".pid",
        "-machine",
        "virt",
        "-cpu",
        "cortex-a57",
        "-nographic",
        "-smp",
        "2",
        "-m",
        "2048",
        "-kernel",
        kernel_path,
        "--append",
        "console=3DttyAMA0 root=3D/dev/vda2 rw ipx=3D" + qemu_instance_ip +=
 "/64 net.ifnames=3D0 biosdevname=3D0",
        "-drive",
        "file=3D" + qemu_instance_img_path + ",if=3Dnone,id=3Dblk",
        "-device",
        "virtio-blk-device,drive=3Dblk",
        "-netdev",
        "socket,id=3Dmynet0,udp=3D127.0.0.1:2000,localaddr=3D127.0.0.1:" + =
qemu_instance_port,
        "-device",
        "virtio-net-device,netdev=3Dmynet0",
        "-serial",
        "file:" + target_path + "/qemu" + str(instance) + ".log"
    ]

*The cpu consumption is ~70%.
*No acceleration used.
*This CPU consumption is obtained only by running the above command. No wor=
kload on the guest OS.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1826401

Title:
  qemu-system-aarch64 has a high cpu usage on windows

Status in QEMU:
  New

Bug description:
  Running qemu-system-aarch64 leads to a high CPU consumption on windows
  10.

  Tested with qemu: 4.0.0-rc4 & 3.1.0 & 2.11.0

  Command: qemu_start_command =3D [
          qemu-system-aarch64,
          "-pidfile",
          target_path + "/qemu" + str(instance) + ".pid",
          "-machine",
          "virt",
          "-cpu",
          "cortex-a57",
          "-nographic",
          "-smp",
          "2",
          "-m",
          "2048",
          "-kernel",
          kernel_path,
          "--append",
          "console=3DttyAMA0 root=3D/dev/vda2 rw ipx=3D" + qemu_instance_ip=
 + "/64 net.ifnames=3D0 biosdevname=3D0",
          "-drive",
          "file=3D" + qemu_instance_img_path + ",if=3Dnone,id=3Dblk",
          "-device",
          "virtio-blk-device,drive=3Dblk",
          "-netdev",
          "socket,id=3Dmynet0,udp=3D127.0.0.1:2000,localaddr=3D127.0.0.1:" =
+ qemu_instance_port,
          "-device",
          "virtio-net-device,netdev=3Dmynet0",
          "-serial",
          "file:" + target_path + "/qemu" + str(instance) + ".log"
      ]

  *The cpu consumption is ~70%.
  *No acceleration used.
  *This CPU consumption is obtained only by running the above command. No w=
orkload on the guest OS.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1826401/+subscriptions
