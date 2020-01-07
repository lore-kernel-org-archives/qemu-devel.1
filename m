Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F09C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 13:28:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F32B207E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 13:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="jvgiLs+F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F32B207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioouH-0001S6-8L
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 08:28:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35845)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <n54@gmx.com>) id 1iooNm-0003SW-R8
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:54:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <n54@gmx.com>) id 1iooNl-0000rs-DY
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:54:50 -0500
Received: from mout.gmx.net ([212.227.15.19]:49057)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <n54@gmx.com>) id 1iooNl-0000pp-0V
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:54:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1578401683;
 bh=PcERl262TeVj2M3QgBH1unkb+D/qsJJsIchSNao9H0c=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=jvgiLs+F50gqxoO57T3Iz+GFZ5HuS/9Kg5W4OnjpPwH3qYQQryFCTbsPhX4pbnGO6
 1Kz6ncZUZALgIcqiGj2Wf7sbm80dL8CDuQeThAI4HnLfAvQ3/8HotxoFDzhERQUt8M
 9HrGhXW8Uf5r2OqeicDfyZfvaL9G4ciFhxYHsq5A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([89.71.135.231]) by mail.gmx.com
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MF3He-1ivLpb0lIW-00FUYT; Tue, 07 Jan 2020 13:54:43 +0100
From: Kamil Rytarowski <n54@gmx.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/4] Implements the NetBSD Virtual Machine Monitor accelerator
Date: Tue,  7 Jan 2020 13:53:57 +0100
Message-Id: <20200107125401.18126-1-n54@gmx.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kv7PXygsM+7QKxU9FVA5sp91WWBmYwOxMy5J7gASuxvYuvEvFDi
 XtBudhWJ0D33OOUiW++Rqdfk/4bZgDOGtsuSFkB/NDk1uS0m5HTLOqzJvhODUba2urq/Sum
 V6eTMGco2CQIEgnHjLHWDGzOS3X1RKzy9bn8OBon7dl9+j86ZeRJ+pzeVf3OlpW8gpw/0lG
 ObR53H1LL7qzpGEVsJqOA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8YuVoUIGsJw=:7SHs1S6EMxEVO8T9ZVCViX
 ZnX8y3stAwGjOJd/HohrFbwWmybUZ9UdEWDvj1V6wLVHDOkWUjz6Xu3vFYX0ylDbcMh5dkWaa
 1No5ughaBBnXjIDJbZLA6lBLnCmTP8ZJk/5kkg/FCGzjDWOD7ch+RpF0ciKJ/7htgDUPDn8Rb
 jBh23vjvJmDHuNG0nVtioQ9BaTBT3ZZTMMyEy+MkqPF4VMeBtsW2bWh7iYLEnlseB57tQYSeO
 lbSXPNBi/lLcsMImha8sxlHG0OMHpdpeLqyIytmmIIWbnVKbgUbU3N+3FPon5FIwfvwJIk6xr
 DF6BVhEyiB5ZgzHn924H1lOf9A+cXn1yczqxn4gAxAIaFDkVP+qv+Y3jjK+B/e15jpDXqKOQG
 CdWmbc7lJzAM8ww8vtvgvEpIFvydZrpFrZuB0ZLC7FMzMLZPuZlrWIIBq3zwxXPDtVNrQWifo
 Cds6CuzTv50NfGxhplSkctx9ZDx3Hj4/ADpGAjlEpCipsT/kP0qa4ICbRZfrvlDTYP2ywBUv8
 UrVfaOazn6zyAyxLvx47UyPNf/D8sXUtAEHwEvUNz+4j7woDb06rTqOYgpMryHG/49G8Jqjsj
 g7kWcZKo7Lhu77Xab9DESJf6n6ED1IpL/l1yNSpi7yXUcSrTJHKsA08MFwe/N3sVUwHFddldK
 ERKsO9xuJJtb8REo52M+7J3IBWM3lkXXnfUmlw3sp7+Q0g8BiSC1amCZYOh3tlqWwI5ywLipq
 Q/AmMQhx3OsvY6g+p/qy8qgq03Ev9Z8UQS34cbQe+PZZR2UegpEA4ZVWimXFPR6JZwM2FfBTV
 96Mj9OMjinpnsycnogSr/pWEsNYaKlRgynWfxvLhneOJUuYFSEHHfr95QjsY2w02GbTQIocCx
 qG0vRKZqCqzbGzMCD+FYkbyz+iO/cm0dSSAseTO8ZSBiqUvD5q99/BZN3v5rTJNk0sdz/Kjtu
 3b8oWNRH3ZSf9mEQaEn0r/QyperqRqg5L0ypq/WF+Yu0mXIc3WepaPXQK984hsT+xP41TuZTi
 H7cVAAELXepZvc4uniOZC9igsHw7qpRp4eL0dkE39IZldlNkUY7pZCjhunan1zOb3iEhCFy0i
 /y82dsRPoVODM4nGYRlslFgYSPlv6A/u2UphYBB0EFuF4tb7ce3mjFVkXxJnjjBP5RH3uCI6q
 8OZU7rZmPLo9ltz5eeLwWvLxhCr9+RLYrFz3xEhK+gpCTqmUAxNhd/Ze/DKgAOj5yZzLICzN1
 cC45QGbHEKvMMA21bNH2wP+fFzZpHXqagZNXdSg==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.15.19
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
Cc: pbonzini@redhat.com, Kamil Rytarowski <n54@gmx.com>,
 peter.maydell@linaro.org
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
 qemu-options.hx           |    4 +-
 target/i386/Makefile.objs |    1 +
 target/i386/helper.c      |    2 +-
 target/i386/nvmm-all.c    | 1222 +++++++++++++++++++++++++++++++++++++
 10 files changed, 1413 insertions(+), 3 deletions(-)
 create mode 100644 accel/stubs/nvmm-stub.c
 create mode 100644 include/sysemu/nvmm.h
 create mode 100644 target/i386/nvmm-all.c

=2D-
2.24.0

