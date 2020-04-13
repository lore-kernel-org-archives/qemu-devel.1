Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31FFC2BA2B
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 22:02:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A148820663
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 22:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PlvfKGHW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A148820663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jO79q-0000Ff-RW
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 18:02:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43797)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jO78f-00080U-56
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 18:01:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jO78d-00011J-NM
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 18:01:09 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39655)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jO78d-000117-FB; Mon, 13 Apr 2020 18:01:07 -0400
Received: by mail-wr1-x444.google.com with SMTP id b11so537478wrs.6;
 Mon, 13 Apr 2020 15:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ndokyy4SYgAG7QOUdFdg+00Xo7krv/bNWzSSpTC1RKg=;
 b=PlvfKGHW5lph8jS/zLLpggTq65ser2sW7PTMTta29+Zftavz8aCwQHCfOpRHUQzCDs
 yZjQaCMGJ2spSQJWOtYgrmcbc4tt1fbGtQhzZLcWXyQBOik9FrASCUUkoHZVV3NQCU2r
 nonPTo0ggQTVg2XfITB/SJyNsiSMEOGAajZdbpwBEAiUP7LzlJNqkvUtO0fXUk1YTKyr
 B8wCIaqVdekrKIKp+B5lrdcsDJ6feFL3TG0g86G5J/cBNUEHjmY1AAJOVN8eRcSOk0nP
 oQ4bLNnFthgzStsK206c3b2LZhGgVtNY+liaVGufAoKmlWIDIk7V3rQCcdP2tqsYUuIW
 4SLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=ndokyy4SYgAG7QOUdFdg+00Xo7krv/bNWzSSpTC1RKg=;
 b=nJNPyAeWkFZawdAZF25sKj2jqpbAzj9BCbiznYQYAUnSxe2tfyENKiu5JB7p5HhiZE
 42Yp5i9MnnOnAPD4fAbR3YkbgRD8ReyLB9ebRzXNntEBLGadjNQ5QUOnLekZV+yFHrJ6
 xnt6Dg0epdSyo/TUyJHULrcOBsnwDV1Eg/5C0cvtwALTaChaJiP483MaxERZntv82C75
 U8ooaoxcCgl0E7M3iOTqnEPrVNonMP1GHssfNrK35YVKZ/E7I7CLcU+PCVEKUhauH5L/
 eKBQOjX/URezyslTeuzKQztXLmls6jaKWKN1i+Z0zSi0Uf3/XgX4nC3OwzEixiAk5wy1
 tTmA==
X-Gm-Message-State: AGi0PuZ6JzRqKqdD6Vg0If1I0MXxjRPWX+L9js8GssQrqs3oCknpldRx
 ePu6NJQ7ejVjCht2XGbWZY8hlfd8a9N/1g==
X-Google-Smtp-Source: APiQypJmlFu5UEHS/EsX9/xZ9jdp2Qr/mbGLqyWR6YCIaIdyFQiEdSrkOKnTSzRBEK6MZzEKOu/V4g==
X-Received: by 2002:a5d:4fc6:: with SMTP id h6mr15711249wrw.277.1586815264928; 
 Mon, 13 Apr 2020 15:01:04 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id 36sm612327wrc.35.2020.04.13.15.01.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2020 15:01:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 v2] hw/display/sm501: Avoid heap overflow in
 sm501_2d_operation()
Date: Tue, 14 Apr 2020 00:01:00 +0200
Message-Id: <20200413220100.18628-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, qemu-stable@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Zhang Zi Ming <1015138407@qq.com>,
 qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Zhang Zi Ming reported a heap overflow in the Drawing Engine of
the SM501 companion chip model, in particular in the COPY_AREA()
macro in sm501_2d_operation().

Add a simple check to avoid the heap overflow.

This fixes:

  =================================================================
  ==20518==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x7f6f4c3fffff at pc 0x55b1e1d358f0 bp 0x7ffce464dfb0 sp 0x7ffce464dfa8
  READ of size 1 at 0x7f6f4c3fffff thread T0
      #0 0x55b1e1d358ef in sm501_2d_operation hw/display/sm501.c:788:13
      #1 0x55b1e1d32c38 in sm501_2d_engine_write hw/display/sm501.c:1466:13
      #2 0x55b1e0cd19d8 in memory_region_write_accessor memory.c:483:5
      #3 0x55b1e0cd1404 in access_with_adjusted_size memory.c:544:18
      #4 0x55b1e0ccfb9d in memory_region_dispatch_write memory.c:1476:16
      #5 0x55b1e0ae55a8 in flatview_write_continue exec.c:3125:23
      #6 0x55b1e0ad3e87 in flatview_write exec.c:3165:14
      #7 0x55b1e0ad3a24 in address_space_write exec.c:3256:18

  0x7f6f4c3fffff is located 4194303 bytes to the right of 4194304-byte region [0x7f6f4bc00000,0x7f6f4c000000)
  allocated by thread T0 here:
      #0 0x55b1e0a6e715 in __interceptor_posix_memalign (ppc64-softmmu/qemu-system-ppc64+0x19c0715)
      #1 0x55b1e31c1482 in qemu_try_memalign util/oslib-posix.c:189:11
      #2 0x55b1e31c168c in qemu_memalign util/oslib-posix.c:205:27
      #3 0x55b1e11a00b3 in spapr_reallocate_hpt hw/ppc/spapr.c:1560:23
      #4 0x55b1e11a0ce4 in spapr_setup_hpt hw/ppc/spapr.c:1593:5
      #5 0x55b1e11c2fba in spapr_machine_reset hw/ppc/spapr.c:1644:9
      #6 0x55b1e1368b01 in qemu_system_reset softmmu/vl.c:1391:9
      #7 0x55b1e1375af3 in qemu_init softmmu/vl.c:4436:5
      #8 0x55b1e2fc8a59 in main softmmu/main.c:48:5
      #9 0x7f6f8150bf42 in __libc_start_main (/lib64/libc.so.6+0x23f42)

  SUMMARY: AddressSanitizer: heap-buffer-overflow hw/display/sm501.c:788:13 in sm501_2d_operation
  Shadow bytes around the buggy address:
    0x0fee69877fa0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
    0x0fee69877fb0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
    0x0fee69877fc0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
    0x0fee69877fd0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
    0x0fee69877fe0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  =>0x0fee69877ff0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa[fa]
    0x0fee69878000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    0x0fee69878010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    0x0fee69878020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    0x0fee69878030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    0x0fee69878040: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  Shadow byte legend (one shadow byte represents 8 application bytes):
    Addressable:           00
    Partially addressable: 01 02 03 04 05 06 07
    Heap left redzone:       fa
    Freed heap region:       fd
    Poisoned by user:        f7
    ASan internal:           fe
  ==20518==ABORTING

Cc: qemu-stable@nongnu.org
Fixes: 07d8a50cb0e ("sm501: add 2D engine copyrect support")
Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1786026
Reported-by: Zhang Zi Ming <1015138407@qq.com>
Acked-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Since v1: Reword description & add Zoltan's A-b.

Test to verify this bug:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg695421.html

Per the links on
https://bugzilla.redhat.com/show_bug.cgi?id=1808510 there is probably
a CVE assigned to this, but I don't have access to the information,
https://bugzilla.redhat.com/show_bug.cgi?id=1786593 only show:

  You are not authorized to access bug #1786593.
  Most likely the bug has been restricted for internal development processes and we cannot grant access.

Anyway as this code is not used in conjunction with a hypervisor,
it is not a 'security bug' as described in
https://www.qemu.org/contribute/security-process/ and
https://www.qemu.org/docs/master/system/security.html#non-virtualization-use-case
---
 hw/display/sm501.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index de0ab9d977..902acb3875 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -726,6 +726,12 @@ static void sm501_2d_operation(SM501State *s)
     int crt = (s->dc_crt_control & SM501_DC_CRT_CONTROL_SEL) ? 1 : 0;
     int fb_len = get_width(s, crt) * get_height(s, crt) * get_bpp(s, crt);
 
+    if (rtl && (src_x < operation_width || src_y < operation_height)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "sm501: Illegal RTL address (%i, %i)\n",
+                      src_x, src_y);
+        return;
+    }
+
     if (addressing != 0x0) {
         printf("%s: only XY addressing is supported.\n", __func__);
         abort();
-- 
2.21.1


