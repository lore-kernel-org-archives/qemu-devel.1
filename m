Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5831AC35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 21:52:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1161214AF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 21:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="EAYH1tHU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1161214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izp4a-000473-Iw
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 16:52:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37755)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <n54@gmx.com>) id 1izomN-0008Cq-4B
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:33:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <n54@gmx.com>) id 1izomL-0006CU-NJ
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:33:42 -0500
Received: from mout.gmx.net ([212.227.17.20]:52781)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <n54@gmx.com>) id 1izomL-00063R-8g
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:33:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1581024806;
 bh=VeqDDBiI9TAaybJiI99EGupz0BlbLh++UmOohkP2lqg=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=EAYH1tHU4F9gX0K2YrgIpK19C5LIk1ompsAtGZYsaC3ksFPEcoG6xUfko86mohbO2
 PrstuXihtWGD9G2RK2AG+eUrqPuPOV7MO4LLIH7N4WJ8Nahl29W3kIAFuhtgruqpOj
 q4dJBJ09jk352Iy02PmacexxZDH114jBLdyXzE+0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([89.71.135.231]) by mail.gmx.com
 (mrgmx105 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1N0oBx-1jlKtP04FZ-00wo6F; Thu, 06 Feb 2020 22:33:26 +0100
From: Kamil Rytarowski <n54@gmx.com>
To: rth@twiddle.net, ehabkost@redhat.com, slp@redhat.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, philmd@redhat.com, max@m00nbsd.net,
 jmcneill@invisible.ca
Subject: [PATCH v4 0/4] Implements the NetBSD Virtual Machine Monitor
 accelerator
Date: Thu,  6 Feb 2020 22:32:28 +0100
Message-Id: <20200206213232.1918-1-n54@gmx.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200206115731.13552-1-n54@gmx.com>
References: <20200206115731.13552-1-n54@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PzMUPTHQteCIsgCfSCT2s0SKsSIyHh1XF0DKpMFww2AQlhNhaYf
 oQR+ZOxkMJuxWMV9Ef+3rIMeHF+/YAAqr3ykKQ+8VLQLdNo4PxPLBnchd/IiU5NifuOejGB
 sO8ttJLw3pPrGoP7nS/KskgcmYdPMAPIq7UntvZ5qszHBF+e83mUw0D/YXC+OSp8zfmxcS8
 2GhIwrWdtenG/9TMcCiHg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1EmbGsqM3Ws=:6mskKEy9OkDo/rQwh0yJro
 MXg6ynnUZaoJDg3crCIh3P32C+Oq7TDTksuSVmS5giqdaLkuk+fuQNosv+kH7pW37DX96NqkJ
 vfE2skZeiBNyx/ZOsSjgv55a5JIUK/up80Lmdt5RQTFnLkI7XWMp/rX/WfJHpPXdke6m5RnQc
 zmdJa4Zy5hK1eZQ+TLo/rvvV8jRSW6wUXGtL0Wb8CRYmLqe+/4cG0JYJXsNSV0Gf4hrkxhY7X
 U0AIrM1EntJN9YRs355jwnXfZ6HFR6FdB1QuS2wThwUYkS5A7E5XBYAMpCHMlbIy23zojY1WM
 pUDemfOztDjhFp10MlwtixMb9TGYxvgzwSoyWdokDQk+TAt8CqNxhkGXpdBFefxs4KOS4uSSB
 8UZk989ijO5kL+99++UY1Y8q2CFR+67k1uALzB/IWaKCQTxPWcSVEK98S+PKHBvouWvp/ZwS8
 qMbauyInpftzXOHpjCHtW9f+F7pFR3WPNy5V+NxhJQDjj+DEPvmo7ywiPMIvglQQf5U2osdIW
 XysbX9BQYUGFIlkuELUwXONHj2ZrnOh5iQso5/BACZE7Pti5cBD8lOT4znRKLZ0Y9agrTD/S9
 4vR1DKRXD0ekG+99W8KjgScE+ZopSGMbLtGhGwzbv7uQyxIhKJqO2r9aVG7BhgyT9YwriZE3U
 eGOxKV3ATevzZ5m1h31I2a6ponKk5VVzSgDFXlBpiRzLDFh/zn79Vbr0EdQQ6MtmlHghF8jQ8
 Pxo6ouIJPE7jfGXkBNEkWCpjxctUmR5D43wZ+PACtiLIfhE8O0u8WoA2mEYvZ3fh+Mxf/x1Bh
 zbcDE2VCX/2R4bCwmDpmYMAEz+bY4b6TIjueKD1rN9FsmLo21VASUSiJWru0tol/czEXZigK/
 PVb72kfHytOMwNtKEIkU2EQNQ5WZ5vi6P3gOVmKCPxDntopCaHYkdtpLaZrleig3VLohFqgPH
 C+j/6hKvgG5/X/3CmDAMULkbbpg0+1/bVDspEh3x8Q3yKDF1eCkG9Ia1GQ/znDV7VwSMi1HBc
 gn9NTpc0PMN3aXlkGTceRRt+YLtQJtnU0OuMXHWRSZiT3ifmUVCMN89IRxc1jmtc9ckqlCkS0
 0IVHVOClhIqc+zNj620M/1kvf5PCX4Zx3AdiYMGMnwKijQKp4/pIslhsL3OPu5cEwvDz/Qpxy
 UUYsqlyN/CaEpaXnioUcr0n89TaimqvOJht6staGrvKGFnPpH3ThoQHs9XvR7xF0SimrA=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.20
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
Cc: Kamil Rytarowski <n54@gmx.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello QEMU Community!

Over the past year the NetBSD team has been working hard on a new user-mod=
e API
for our hypervisor that will be released as part of the upcoming NetBSD 9.=
0.
This new API adds user-mode capabilities to create and manage virtual mach=
ines,
configure memory mappings for guest machines, and create and control execu=
tion
of virtual processors.

With this new API we are now able to bring our hypervisor to the QEMU
community! The following patches implement the NetBSD Virtual Machine Moni=
tor
accelerator (NVMM) for QEMU on NetBSD 9.0 and newer hosts.

When compiling QEMU for x86_64 passing the --enable-nvmm flag will compile=
 the
accelerator for use. At runtime using the '-accel nvmm' should see a
significant performance improvement over emulation, much like when using '=
hax'
on NetBSD.

The documentation for this new API is visible at https://man.netbsd.org un=
der
the libnvmm(3) and nvmm(4) pages.

NVMM was designed and implemented by Maxime Villard.

Thank you for your feedback.

Refrences:
https://m00nbsd.net/4e0798b7f2620c965d0dd9d6a7a2f296.html

Test plan:

1. Download a NetBSD 9.0 pre-release snapshot:
http://nycdn.netbsd.org/pub/NetBSD-daily/netbsd-9/latest/images/NetBSD-9.0=
_RC1-amd64.iso

2. Install it natively on a not too old x86_64 hardware (Intel or AMD).

There is no support for nested virtualization in NVMM.

3. Setup the system.

 export PKG_PATH=3Dhttp://www.ki.nu/pkgsrc/packages/current/NetBSD-9.0_RC1=
/All
 pkg_add git gmake python37 glib2 bison pkgconf pixman

Install mozilla-rootcerts and follow post-install instructions.

 pkg_add mozilla-rootcerts

More information: https://wiki.qemu.org/Hosts/BSD#NetBSD

4. Build qemu

 mkdir build
 cd build
 ../configure --python=3Dpython3.7
 gmake
 gmake check

5. Test

 qemu -accel nvmm ...


History:
v3 -> v4:
 - Correct build warning by adding a missing include
 - Do not set R8-R16 registers unless TARGET_X86_64
v2 -> v3:
 - Register nvmm in targetos NetBSD check
 - Stop including hw/boards.h
 - Rephrase old code comments (remove XXX)
v1 -> v2:
 - Included the testing plan as requested by Philippe Mathieu-Daude
 - Formatting nit fix in qemu-options.hx
 - Document NVMM in the accel section of qemu-options.hx

Maxime Villard (4):
  Add the NVMM vcpu API
  Add the NetBSD Virtual Machine Monitor accelerator.
  Introduce the NVMM impl
  Add the NVMM acceleration enlightenments

 accel/stubs/Makefile.objs |    1 +
 accel/stubs/nvmm-stub.c   |   43 ++
 configure                 |   37 ++
 cpus.c                    |   58 ++
 include/sysemu/hw_accel.h |   14 +
 include/sysemu/nvmm.h     |   35 ++
 qemu-options.hx           |   16 +-
 target/i386/Makefile.objs |    1 +
 target/i386/helper.c      |    2 +-
 target/i386/nvmm-all.c    | 1226 +++++++++++++++++++++++++++++++++++++
 10 files changed, 1424 insertions(+), 9 deletions(-)
 create mode 100644 accel/stubs/nvmm-stub.c
 create mode 100644 include/sysemu/nvmm.h
 create mode 100644 target/i386/nvmm-all.c

=2D-
2.25.0


