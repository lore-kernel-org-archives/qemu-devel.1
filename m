Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97FB2C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 14:14:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 647332468E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 14:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="iiSpAt5K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 647332468E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwRdB-0004ZI-GZ
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 09:14:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44215)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <n54@gmx.com>) id 1iwRa3-0003B5-4p
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 09:11:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <n54@gmx.com>) id 1iwRa1-0005Qh-Rv
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 09:11:02 -0500
Received: from mout.gmx.net ([212.227.15.15]:37429)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <n54@gmx.com>) id 1iwRa1-0005Nf-EU
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 09:11:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1580220651;
 bh=5T5EeHP93+UFDJyj4hGYbu4E19lxTL0aMpGCbkzXAMw=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=iiSpAt5Ksv9d3FKvHXsFaIGOjLI++6gEzk3iQU2Aoqgk2rr1u3zndaaoXu3NeN5k0
 QPSyR/i2bQO1EojGP+v+Czo91KNhoA/9iOOo8asbrmyLO/3orIVaon7hMOY4kLhNJz
 dbHZCiERCrHSMcCffYGxVfFIIIWUH4TPB9z24Y6Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([89.71.135.231]) by mail.gmx.com
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1N9Mta-1jbGUI3xfo-015Kbn; Tue, 28 Jan 2020 15:10:51 +0100
From: Kamil Rytarowski <n54@gmx.com>
To: rth@twiddle.net, ehabkost@redhat.com, philmd@redhat.com, slp@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, max@m00nbsd.net
Subject: [PATCH v2 0/4] Implements the NetBSD Virtual Machine Monitor
 accelerator
Date: Tue, 28 Jan 2020 15:09:41 +0100
Message-Id: <20200128140945.929-1-n54@gmx.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107124903.16505-1-n54@gmx.com>
References: <20200107124903.16505-1-n54@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0d9yom2QoLaFN43T/E9x9LQgEEC8AKxlTwCRhpWaxeYQZkWPDjQ
 GRUsVLxxlUigipA7v+S4lgqAkqbVkJjkkFK0E8O+j6aTkziSrHjbmv0gMMEvpaHyddJDnzJ
 H4x3mFG/PNiuk649d6u/RPodUcPoJniWbzlFV3Cax9H2UALWqoUtwYLuVzGz26EOC3jCewQ
 iemx9I5XGy/rmPN0OOrIw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HlazbCzbTJA=:KdbB6nZvisnDVYrCMxJn8O
 GRfqNWss16Ib8ARMM7S1LuGmpJ/LbIMlivCAbJ753D8J62NJff4OUAq1JeiKugPg3AFbi4vCV
 fqXV1hw5RHQ85KMZj0eIBSZwhZiwAgU0u0QJRMo0vpHGAPS3mScutPIcHGKnmOVIzIKHMDZWq
 wZ/eLpr8JqUWQ+BBQF41WyzTXHS3keKMCg6jppXU/7ufwggH5Q7OpMb/4DtN9V04ejJ3oYpXd
 XioM7S2oIxdNR65S7LtOKmBZ/ycIsizDp4bVAaDw373EWjmNEFN2KrvWWr0XM4TPL3gpGLWS6
 n/bsF7I7luF4HYd8H6gGbcx+Pq+/YTz7hNGxLoUPCZB/XAfZqQvM0M1XSJsmjlxnk7w9IRGOU
 Sf69uHDbkcvI5wJ8spmr0y2fxRkJ8wopK11OmREeXR/vYow82E71Vwk15lFQPywWrLZMu1cCy
 btRk2AHDiueSEDdZwn8P58rpSfrLE7vBLR2I373J8khBykGvXK8QiO6s3JY8PIqaazP2pi0Ax
 ebZnfJZ2j0NK7XIhL1tJa/C0cdy14Qd0bf4Ukoy0/QYu0wRjRZ74pN0MGNmYCla+xGxwzSqtk
 AQz7kBXmD2s+ftjppJYpQwgSi5lEkEmVOpeBvlfzLz8oQyVAyKOboL6s7qBFL96m2oWP6vYsM
 cAs1mkUsAbs9WoLmyT0/KHcHXkb/BKxbeQmzHd5npxJrg4wI8ChcseQHfOq6iKMIydu5AKBog
 LQl1XNCtQk5G/EqAyRk90hOVEjMKL7Lude+6XUzVTzBZMKhhz6q3DODHCb++yV9KlSd2NVnw9
 0WQn2qKQJu/ZCg/09urTYJG82RujQ+qu7gSXn2VVvj9z42hckozmy+g+OPhmTy/Vhyqdp0daT
 bPdJt+3KMdgAtdboR6WWCtJFa8fmNIeYvCcWs05BdvB/TfBfKH91hgSX6QFCpA4MXX4S8JZf8
 XtzphWf56BcDxcFyitMpaBz2CtirsD4tWVo9Ej5DBUPsSpscSYGkFar1jLYORba188xTfNj6f
 Aj3qUQVdGLvFCgZPS2tSZdIDV/SR7SyvfVbt4SN8XUY5kAyMHabwc2zvVoPslX67AGe6TQ5nJ
 ygdWfnDn16Lg62GiE0tUDD1hgSsNtqBUq2v1QpwRiY3zLQTURXbnSTcoQsI4ZglDbF1OQ1O8m
 oe2ttns/WwNO3uDYoFTLzYZTAHVyMPjI76yyJhvx7e0ZYfgW/13vkjs96snSAopL4hEEY=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.15.15
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
 configure                 |   36 ++
 cpus.c                    |   58 ++
 include/sysemu/hw_accel.h |   14 +
 include/sysemu/nvmm.h     |   35 ++
 qemu-options.hx           |   16 +-
 target/i386/Makefile.objs |    1 +
 target/i386/helper.c      |    2 +-
 target/i386/nvmm-all.c    | 1222 +++++++++++++++++++++++++++++++++++++
 10 files changed, 1419 insertions(+), 9 deletions(-)
 create mode 100644 accel/stubs/nvmm-stub.c
 create mode 100644 include/sysemu/nvmm.h
 create mode 100644 target/i386/nvmm-all.c

=2D-
2.24.1

