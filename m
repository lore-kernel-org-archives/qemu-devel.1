Received: from eggs.gnu.org ([2001:4830:134:3::10]:39772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cXMNW-00027P-K5
	for qemu-devel@nongnu.org; Sat, 28 Jan 2017 01:20:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cXMNT-0000Z0-E1
	for qemu-devel@nongnu.org; Sat, 28 Jan 2017 01:20:50 -0500
Received: from indium.canonical.com ([91.189.90.7]:34302)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cXMNT-0000Yq-7x
	for qemu-devel@nongnu.org; Sat, 28 Jan 2017 01:20:47 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cXMNR-0003EJ-Cb
	for <qemu-devel@nongnu.org>; Sat, 28 Jan 2017 06:20:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4CB0B2E80C6
	for <qemu-devel@nongnu.org>; Sat, 28 Jan 2017 06:20:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 28 Jan 2017 06:08:34 -0000
From: Icenowy Zheng <1660010@bugs.launchpad.net>
Reply-To: Bug 1660010 <1660010@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <20170128060834.11421.45757.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1660010] [NEW] AArch64 system emulation cannot
 execute virt uefi in 2.7 or 2.8
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

The UEFI firmware file is retrieved from
http://snapshots.linaro.org/components/kernel/linaro-
edk2/latest/release/qemu64/QEMU_EFI.fd .

The error is:
```
TODO /var/lib/abbs/build/tmp.p2dMBBlJ0D/qemu-2.7.0/tci.c:1049: tcg_qemu_tb_=
exec()
/var/lib/abbs/build/tmp.p2dMBBlJ0D/qemu-2.7.0/tci.c:1049: tcg fatal error
```

(both 2.7.0 and 2.8.0 are tested to fail, 2.6.1 works)

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1660010

Title:
  AArch64 system emulation cannot execute virt uefi in 2.7 or 2.8

Status in QEMU:
  New

Bug description:
  The UEFI firmware file is retrieved from
  http://snapshots.linaro.org/components/kernel/linaro-
  edk2/latest/release/qemu64/QEMU_EFI.fd .

  The error is:
  ```
  TODO /var/lib/abbs/build/tmp.p2dMBBlJ0D/qemu-2.7.0/tci.c:1049: tcg_qemu_t=
b_exec()
  /var/lib/abbs/build/tmp.p2dMBBlJ0D/qemu-2.7.0/tci.c:1049: tcg fatal error
  ```

  (both 2.7.0 and 2.8.0 are tested to fail, 2.6.1 works)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1660010/+subscriptions
