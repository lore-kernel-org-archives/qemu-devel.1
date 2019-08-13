Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F3AC433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 18:21:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7734620578
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 18:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DD1QjVJ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7734620578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxbQd-00068e-Gh
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 14:21:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43240)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <nirsof@gmail.com>) id 1hxbQD-0005gD-S5
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 14:21:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nirsof@gmail.com>) id 1hxbQC-0006Ns-Aa
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 14:21:25 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:52835)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nirsof@gmail.com>)
 id 1hxbQ9-0006MD-4M; Tue, 13 Aug 2019 14:21:21 -0400
Received: by mail-wm1-x342.google.com with SMTP id o4so2239628wmh.2;
 Tue, 13 Aug 2019 11:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Z2xq2ahvziVly4LRC1W3wVvI1JHARH0E1kCVkG9ipp0=;
 b=DD1QjVJ1vrfIpYO2Vrq1pPa7w5EnLHjMX6FJEyBadDgbW/A4k6w/RYr7zb33fqlXFx
 3NHhvAwfo2gROVgG7AOnJnqhtqLj30A4Lyp5Aa/yNiBzNemDt17iBjDdaWvgeBC+D0te
 ozZg772tZeqUEVdmUHxi1OS5bKQlAuksBWaqOHOjm8W2+CU5/V4KX3LZuBZ0I7vL9iuQ
 GLUsTAys74Eq1Mypp+oIzk5GfbIVO2zfn8l7SaXmABMft16W+VhkJRWC9zcn4jrUHJqF
 CH9522vwJh1qUUg17kQGaQOuhKkHflgLVSCfCh+KsGWzW8SNANfhjKmPcixnKnNnAj8V
 bt8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Z2xq2ahvziVly4LRC1W3wVvI1JHARH0E1kCVkG9ipp0=;
 b=GL8fTwlqBZeyrP7h3o+nzH/5La4ZDHwh7CH5J+iNm5JoN5naSeEqrJNT1MYLcXiaMi
 cxscKMOGHugj7gLbdtMafPvOtGDM3mYQjSlUeuC4hUbhfUE2DVbF+0kZqTSk3J6L99Ab
 C5iDTPmsY4UuHRWLTGLdw7EGTXI4VumL/0ONG4bRBjgNnC6P7VK4k7SPL6luxLSWa1XM
 8veHuMbzYzpiqWMlq+BVg+GX2U6kJ/uBHzzFnLAPetWjFULgIh8DrhBmHIhFbthl8aRs
 gm8GDm6OJO+K1I5pRLzOenTr7fzyQz+tg4ZbcVfRKfddwetX+SNHw4nhf6WY9NbggDIZ
 Qorg==
X-Gm-Message-State: APjAAAWBUzfYI2HyfkDB9W6MNw+B/xIllAdloU93RDLCAbc4Mx8HsJ9X
 oIsJNX8CVBq95px8KRJcflrgfm6bAnw=
X-Google-Smtp-Source: APXvYqy6vJ7rS7SNuSfoweyhRbSVBr46er8Gk19Ryuid1j9Mhtd59OYm7Gea4LcsBliSpnIdc1QWCw==
X-Received: by 2002:a1c:f101:: with SMTP id p1mr4445446wmh.151.1565720478570; 
 Tue, 13 Aug 2019 11:21:18 -0700 (PDT)
Received: from sparse-local.tlv.redhat.com (bzq-82-81-161-50.red.bezeqint.net.
 [82.81.161.50])
 by smtp.gmail.com with ESMTPSA id a18sm6526072wrt.18.2019.08.13.11.21.15
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 13 Aug 2019 11:21:17 -0700 (PDT)
From: Nir Soffer <nirsof@gmail.com>
X-Google-Original-From: Nir Soffer <nsoffer@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 13 Aug 2019 21:21:03 +0300
Message-Id: <20190813182103.8816-1-nsoffer@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH v3] block: posix: Handle undetectable alignment
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
Cc: Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nsoffer@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In some cases buf_align or request_alignment cannot be detected:

1. With Gluster, buf_align cannot be detected since the actual I/O is
   done on Gluster server, and qemu buffer alignment does not matter.
   Since we don't have alignment requirement, buf_align=1 is the best
   value.

2. With local XFS filesystem, buf_align cannot be detected if reading
   from unallocated area. In this we must align the buffer, but we don't
   know what is the correct size. Using the wrong alignment results in
   I/O error.

3. With Gluster backed by XFS, request_alignment cannot be detected if
   reading from unallocated area. In this case we need to use the
   correct alignment, and failing to do so results in I/O errors.

4. With NFS, the server does not use direct I/O, so both buf_align cannot
   be detected. In this case we don't need any alignment so we can use
   buf_align=1 and request_alignment=1.

These cases seems to work when storage sector size is 512 bytes, because
the current code starts checking align=512. If the check succeeds
because alignment cannot be detected we use 512. But this does not work
for storage with 4k sector size.

To determine if we can detect the alignment, we probe first with
align=1. If probing succeeds, maybe there are no alignment requirement
(cases 1, 4) or we are probing unallocated area (cases 2, 3). Since we
don't have any way to tell, we treat this as undetectable alignment. If
probing with align=1 fails with EINVAL, but probing with one of the
expected alignments succeeds, we know that we found a working alignment.

Practically the alignment requirements are the same for buffer
alignment, buffer length, and offset in file. So in case we cannot
detect buf_align, we can use request alignment. If we cannot detect
request alignment, we can fallback to a safe value. To use this logic,
we probe first request alignment instead of buf_align.

Here is a table showing the behaviour with current code (the value in
parenthesis is the optimal value).

Case    Sector    buf_align (opt)   request_alignment (opt)     result
======================================================================
1       512       512   (1)          512   (512)                 OK
1       4096      512   (1)          4096  (4096)                FAIL
----------------------------------------------------------------------
2       512       512   (512)        512   (512)                 OK
2       4096      512   (4096)       4096  (4096)                FAIL
----------------------------------------------------------------------
3       512       512   (1)          512   (512)                 OK
3       4096      512   (1)          512   (4096)                FAIL
----------------------------------------------------------------------
4       512       512   (1)          512   (1)                   OK
4       4096      512   (1)          512   (1)                   OK

Same cases with this change:

Case    Sector    buf_align (opt)   request_alignment (opt)     result
======================================================================
1       512       512   (1)          512   (512)                 OK
1       4096      4096  (1)          4096  (4096)                OK
----------------------------------------------------------------------
2       512       512   (512)        512   (512)                 OK
2       4096      4096  (4096)       4096  (4096)                OK
----------------------------------------------------------------------
3       512       4096  (1)          4096  (512)                 OK
3       4096      4096  (1)          4096  (4096)                OK
----------------------------------------------------------------------
4       512       4096  (1)          4096  (1)                   OK
4       4096      4096  (1)          4096  (1)                   OK

I tested that provisioning VMs and copying disks on local XFS and
Gluster with 4k bytes sector size work now, resolving bugs [1],[2].
I tested also on XFS, NFS, Gluster with 512 bytes sector size.

[1] https://bugzilla.redhat.com/1737256
[2] https://bugzilla.redhat.com/1738657

Signed-off-by: Nir Soffer <nsoffer@redhat.com>
---

Changes since v2
- Improve the commit message (Kevin)
- Remove unneeded 2-level ternary (Kevin)

v2 was here:
https://lists.nongnu.org/archive/html/qemu-block/2019-08/msg00426.html

 block/file-posix.c | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index f33b542b33..9baade65f4 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -323,6 +323,7 @@ static void raw_probe_alignment(BlockDriverState *bs, int fd, Error **errp)
     BDRVRawState *s = bs->opaque;
     char *buf;
     size_t max_align = MAX(MAX_BLOCKSIZE, getpagesize());
+    size_t alignments[] = {1, 512, 1024, 2048, 4096};
 
     /* For SCSI generic devices the alignment is not really used.
        With buffered I/O, we don't have any restrictions. */
@@ -349,25 +350,38 @@ static void raw_probe_alignment(BlockDriverState *bs, int fd, Error **errp)
     }
 #endif
 
-    /* If we could not get the sizes so far, we can only guess them */
-    if (!s->buf_align) {
+    /*
+     * If we could not get the sizes so far, we can only guess them. First try
+     * to detect request alignment, since it is more likely to succeed. Then
+     * try to detect buf_align, which cannot be detected in some cases (e.g.
+     * Gluster). If buf_align cannot be detected, we fallback to the value of
+     * request_alignment.
+     */
+
+    if (!bs->bl.request_alignment) {
+        int i;
         size_t align;
-        buf = qemu_memalign(max_align, 2 * max_align);
-        for (align = 512; align <= max_align; align <<= 1) {
-            if (raw_is_io_aligned(fd, buf + align, max_align)) {
-                s->buf_align = align;
+        buf = qemu_memalign(max_align, max_align);
+        for (i = 0; i < ARRAY_SIZE(alignments); i++) {
+            align = alignments[i];
+            if (raw_is_io_aligned(fd, buf, align)) {
+                /* Fallback to safe value. */
+                bs->bl.request_alignment = (align != 1) ? align : max_align;
                 break;
             }
         }
         qemu_vfree(buf);
     }
 
-    if (!bs->bl.request_alignment) {
+    if (!s->buf_align) {
+        int i;
         size_t align;
-        buf = qemu_memalign(s->buf_align, max_align);
-        for (align = 512; align <= max_align; align <<= 1) {
-            if (raw_is_io_aligned(fd, buf, align)) {
-                bs->bl.request_alignment = align;
+        buf = qemu_memalign(max_align, 2 * max_align);
+        for (i = 0; i < ARRAY_SIZE(alignments); i++) {
+            align = alignments[i];
+            if (raw_is_io_aligned(fd, buf + align, max_align)) {
+                /* Fallback to request_aligment. */
+                s->buf_align = (align != 1) ? align : bs->bl.request_alignment;
                 break;
             }
         }
-- 
2.20.1


