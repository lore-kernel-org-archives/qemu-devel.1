Return-Path: <SRS0=9/5m=53=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F740C2BA2B
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 09:16:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E17D20857
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 09:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IpVlLhWw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E17D20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNCFI-0006ff-AF
	for qemu-devel@archiver.kernel.org; Sat, 11 Apr 2020 05:16:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38333)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNCEB-0005VH-NR
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 05:15:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNCEA-0005aW-14
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 05:15:03 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:36845)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNCE9-0005a8-RQ; Sat, 11 Apr 2020 05:15:01 -0400
Received: by mail-wr1-x433.google.com with SMTP id u13so4251354wrp.3;
 Sat, 11 Apr 2020 02:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NjdvKrAHp3uRuP1Lr8qH05RaCpkw8jwbaOYNARGlieo=;
 b=IpVlLhWwr9GBCWcs1wVn9jFgy+ngvzuSLdtvUUrK3upHDy57uYMS+HdE8R9oHx2NBm
 pFTeXYS+xL8N37C4ICX14pvmeTz5cLq1IcdTNcvQ2fOMxLnOsGmXlW645wQaoTVco90v
 Hq/4XJ3OPiX3hqUMKtglx30sFxq7AY34veixwMlCS11XkRMkH5P1V66cxd1rlHt9/bEj
 mAxJV5ufHvoMdRRk/DjYIesEowu966Bs6cI3DX6b8DUa9qVliExkdvTq3R1nybSEXGzU
 lZ7cnXVNg9n7Zrr2FyhYyqAHLkK2mk7/jovp4m5HHDtoC68/2wzFXz29suknpVfIihIx
 NVig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=NjdvKrAHp3uRuP1Lr8qH05RaCpkw8jwbaOYNARGlieo=;
 b=ZvRoc7NzIjjjxvtKH8PHOoi9HV9zAg18ssjTHLtxXeOrmKqA5D8dHaqiC5/pUkS2Lb
 py3k1zXJ8adtQmbEzjLartRqmNPYWMQBO7rYvnhH0VdPZdX11bSo7wH7i9TcHkN6FSNq
 gAQiTnNlJhQIk4No4OmsxOsIc6M6Anii9HjM3ZtYezwOa357kUd49Y8moSIHfeTQ4TS3
 RlurAmvyvFdDVRyuAsPMBus/yDJDXdcezw+AnJtNZV7ZjBbDYVzpdYiThYKJDI6nh4kH
 L6+hoJCtImWMqY2KBPgvw3g5UkLBss/glFNCfahlddDypSF6X7U2/EbEv7umCUnAuuVI
 forg==
X-Gm-Message-State: AGi0PuYpbcmkp8jguedJNe3FuYwBFRjP1bsULMaYre+6Cyn6RGAnHvc/
 QrGb100mncaA42WW++CSgM7O+ZyVoaU=
X-Google-Smtp-Source: APiQypItl2PCiCV+lsrQsg1Mj1IS3xu4Gt1TLJhp2F3IOtJ0t3/5wSd3YWL+L7FZS9m8r6D46iu5Yg==
X-Received: by 2002:adf:f34e:: with SMTP id e14mr8962197wrp.80.1586596500339; 
 Sat, 11 Apr 2020 02:15:00 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id f83sm6073301wmf.42.2020.04.11.02.14.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2020 02:14:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH-for-5.0 1/2] hw/display/sm501: Avoid heap overflow in
 sm501_2d_operation()
Date: Sat, 11 Apr 2020 11:14:52 +0200
Message-Id: <20200411091453.30371-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200411091453.30371-1-f4bug@amsat.org>
References: <20200411091453.30371-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Zhang Zi Ming <1015138407@qq.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Zhang Zi Ming reported a heap overflow in the Drawing Engine of
the SM501 companion chip model, in particular in the COPY_AREA()
macro in sm501_2d_operation().

As I have no idea what this code is supposed to do, add a simple
check to avoid the heap overflow. This fixes:

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

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1786026
Reported-by: Zhang Zi Ming <1015138407@qq.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Per the links on
https://bugzilla.redhat.com/show_bug.cgi?id=1808510 there is probably
a CVE assigned to this, but I don't have access to the information,
https://bugzilla.redhat.com/show_bug.cgi?id=1786593 only show:

  You are not authorized to access bug #1786593.
  Most likely the bug has been restricted for internal development processes and we cannot grant access.
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


