Return-Path: <SRS0=e36u=CI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5655DC433E2
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 06:26:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29CE02087D
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 06:26:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29CE02087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCGnG-0000wl-B5
	for qemu-devel@archiver.kernel.org; Sun, 30 Aug 2020 02:26:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53146)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kCGma-0000S6-Gi
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 02:25:40 -0400
Received: from indium.canonical.com ([91.189.90.7]:34732)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kCGmY-0000pR-2p
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 02:25:40 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kCGmW-0004B8-8H
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2020 06:25:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 38A732E802A
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2020 06:25:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2020 06:18:39 -0000
From: mst <1892540@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: sparc testcase
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: gson laurent-vivier mst-0 philmd
X-Launchpad-Bug-Reporter: Andreas Gustafsson (gson)
X-Launchpad-Bug-Modifier: mst (mst-0)
References: <159803735569.2614.10182276398047269277.malonedeb@chaenomeles.canonical.com>
 <20200822142127.1316231-1-f4bug@amsat.org>
Message-ID: <20200830021257-mutt-send-email-mst@kernel.org>
Subject: Re: [Bug 1892540] [RFC PATCH v2] hw/display/tcx: Allow 64-bit
 accesses to framebuffer stippler and blitter
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="195cbfa84cb75815472f69dd83d46f006869050b"; Instance="production"
X-Launchpad-Hash: ea6cfa27aa93f7057e13772e49e7f192bfc4e003
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/30 02:25:36
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_HI=-5,
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
Reply-To: Bug 1892540 <1892540@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20200830061839.NW8QbuP-IJ93npHMZUx40X-xIzLXVHuFzIO9B8Y_gBc@z>

On Sat, Aug 22, 2020 at 02:21:27PM -0000, Philippe Mathieu-Daud=C3=83=C2=A9=
 wrote:
> The S24/TCX datasheet is listed as "Unable to locate" on [1].
> =

> However the NetBSD revision 1.32 of the driver introduced
> 64-bit accesses to the stippler and blitter [2]. It is safe
> to assume these memory regions are 64-bit accessible.
> QEMU implementation is 32-bit, so fill the 'impl' fields.
> =

> [1] http://web.archive.org/web/20111209011516/http://wikis.sun.com/displa=
y/FOSSdocs/Home
> [2] http://cvsweb.netbsd.org/bsdweb.cgi/src/sys/dev/sbus/tcx.c.diff?r1=3D=
1.31&r2=3D1.32
> =

> Reported-by: Andreas Gustafsson <gson@gson.org>
> Buglink: https://bugs.launchpad.net/bugs/1892540
> Fixes: 55d7bfe2293 ("tcx: Implement hardware acceleration")
> Signed-off-by: Philippe Mathieu-Daud=C3=83=C2=A9 <f4bug@amsat.org>

Philippe, did you submit the patch on the mailing list
normally too? I don't seem to see it there.

the patch seems to work for me:

Tested-by: Michael S. Tsirkin <mst@redhat.com>


CC Nathan who reported a similar failure.

Nathan, does the patch below fix the issue for you?

> ---
> Since v1:
> - added missing uncommitted staged changes... (tcx_blit_ops)
> ---
 hw/display/tcx.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/hw/display/tcx.c b/hw/display/tcx.c
index 1fb45b1aab8..96c6898b149 100644
--- a/hw/display/tcx.c
+++ b/hw/display/tcx.c
@@ -548,20 +548,28 @@ static const MemoryRegionOps tcx_stip_ops =3D {
     .read =3D tcx_stip_readl,
     .write =3D tcx_stip_writel,
     .endianness =3D DEVICE_NATIVE_ENDIAN,
-    .valid =3D {
+    .impl =3D {
         .min_access_size =3D 4,
         .max_access_size =3D 4,
     },
+    .valid =3D {
+        .min_access_size =3D 4,
+        .max_access_size =3D 8,
+    },
 };
 =

 static const MemoryRegionOps tcx_rstip_ops =3D {
     .read =3D tcx_stip_readl,
     .write =3D tcx_rstip_writel,
     .endianness =3D DEVICE_NATIVE_ENDIAN,
-    .valid =3D {
+    .impl =3D {
         .min_access_size =3D 4,
         .max_access_size =3D 4,
     },
+    .valid =3D {
+        .min_access_size =3D 4,
+        .max_access_size =3D 8,
+    },
 };
 =

 static uint64_t tcx_blit_readl(void *opaque, hwaddr addr,
@@ -650,10 +658,14 @@ static const MemoryRegionOps tcx_rblit_ops =3D {
     .read =3D tcx_blit_readl,
     .write =3D tcx_rblit_writel,
     .endianness =3D DEVICE_NATIVE_ENDIAN,
-    .valid =3D {
+    .impl =3D {
         .min_access_size =3D 4,
         .max_access_size =3D 4,
     },
+    .valid =3D {
+        .min_access_size =3D 4,
+        .max_access_size =3D 8,
+    },
 };
 =

 static void tcx_invalidate_cursor_position(TCXState *s)


-----------------------------------------------------------

I think you shouldn't specify .min_access_size in impl, since
that also allows 1 and 2 byte accesses from guest.


> -- =

> 2.26.2
> =

> -- =

> You received this bug notification because you are subscribed to the bug
> report.
> https://bugs.launchpad.net/bugs/1892540
> =

> Title:
>   qemu can no longer boot NetBSD/sparc
> =

> Status in QEMU:
>   New
> =

> Bug description:
>   Booting NetBSD/sparc in qemu no longer works.  It broke between qemu
>   version 5.0.0 and 5.1.0, and a bisection identified the following as
>   the offending commit:
> =

>     [5d971f9e672507210e77d020d89e0e89165c8fc9] memory: Revert "memory:
>   accept mismatching sizes in memory_region_access_valid"
> =

>   It's still broken as of 7fd51e68c34fcefdb4d6fd646ed3346f780f89f4.
> =

>   To reproduce, run
> =

>     wget http://ftp.netbsd.org/pub/NetBSD/NetBSD-9.0/images/NetBSD-9.0-sp=
arc.iso
>     qemu-system-sparc -nographic -cdrom NetBSD-9.0-sparc.iso -boot d
> =

>   The expected behavior is that the guest boots to the prompt
> =

>     Installation medium to load the additional utilities from:
> =

>   The observed behavior is a panic:
> =

>     [   1.0000050] system[0]: trap 0x29: pc=3D0xf0046b14 sfsr=3D0xb6 sfva=
=3D0x54000000
>     [   1.0000050] cpu0: data fault: pc=3D0xf0046b14 addr=3D0x54000000 sf=
sr=3D0xb6<PERR=3D0x0,LVL=3D0x0,AT=3D0x5,FT=3D0x5,FAV,OW>
>     [   1.0000050] panic: kernel fault
>     [   1.0000050] halted
> =

> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1892540/+subscriptions

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1892540

Title:
  qemu can no longer boot NetBSD/sparc

Status in QEMU:
  New

Bug description:
  Booting NetBSD/sparc in qemu no longer works.  It broke between qemu
  version 5.0.0 and 5.1.0, and a bisection identified the following as
  the offending commit:

    [5d971f9e672507210e77d020d89e0e89165c8fc9] memory: Revert "memory:
  accept mismatching sizes in memory_region_access_valid"

  It's still broken as of 7fd51e68c34fcefdb4d6fd646ed3346f780f89f4.

  To reproduce, run

    wget http://ftp.netbsd.org/pub/NetBSD/NetBSD-9.0/images/NetBSD-9.0-spar=
c.iso
    qemu-system-sparc -nographic -cdrom NetBSD-9.0-sparc.iso -boot d

  The expected behavior is that the guest boots to the prompt

    Installation medium to load the additional utilities from:

  The observed behavior is a panic:

    [   1.0000050] system[0]: trap 0x29: pc=3D0xf0046b14 sfsr=3D0xb6 sfva=
=3D0x54000000
    [   1.0000050] cpu0: data fault: pc=3D0xf0046b14 addr=3D0x54000000 sfsr=
=3D0xb6<PERR=3D0x0,LVL=3D0x0,AT=3D0x5,FT=3D0x5,FAV,OW>
    [   1.0000050] panic: kernel fault
    [   1.0000050] halted

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1892540/+subscriptions

