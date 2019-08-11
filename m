Return-Path: <SRS0=60Ee=WH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BEAC0650F
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 20:51:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D594E20842
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 20:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InjzYchX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D594E20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwuoP-0004Nr-6S
	for qemu-devel@archiver.kernel.org; Sun, 11 Aug 2019 16:51:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53169)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <nirsof@gmail.com>) id 1hwunv-0003tm-80
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 16:51:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nirsof@gmail.com>) id 1hwunt-0005na-UP
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 16:51:03 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:32886)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nirsof@gmail.com>)
 id 1hwunr-0005ht-10; Sun, 11 Aug 2019 16:50:59 -0400
Received: by mail-wm1-x341.google.com with SMTP id p77so9607599wme.0;
 Sun, 11 Aug 2019 13:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hWxFtCpUc/Nanwajer8dQYbcYnjZYwrkhv76c60RyF8=;
 b=InjzYchXD2ATNXPDTbt9yzECg7UaD9jO6wE1/FKZ52u/uvSfIpyoykZ17vYePObn1m
 5WCgRATsTuZAZYlkYvCL42zIlyvdEHCAHjpP2nNdnK+VLy5avwSQk3CI6AOKfjE3cWC9
 SmbfLmWboZSS0ZLwFL4Ly513XI7XleQZuEJ5sDQP++4433X09Fv70+gBI7UOMhJIdd2U
 KUaNf70d77oNzHoubp1RRbUcasihZG5a8xPDdd3ydQQOzWUsGa78BCXMYZiAUqCJ0amk
 0Cp+fwFPzRSAI1uBEziIUenGrBnS+3ReQTJFS47FD7qLZ0JP/zi+spyf8k7Jlq5tAeX+
 SbPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hWxFtCpUc/Nanwajer8dQYbcYnjZYwrkhv76c60RyF8=;
 b=b2pIlLrFTQxKQIGJFMjXF2Q0lmu9m0+ySzM/EJbBgdpAl/6vCFED6TNjchX31kauwQ
 Dh6BMpq5tl5USiyVcvFYQT38KOShBwtWPp+dV4dqs62yjQn1oBqzeoP94YF2w0HCiavQ
 NNQKXsaat8wWVyeuJehj4tf1VICalaoM7S6WYTataSoWjFg/3ONYIBYhjEPTuWFbACXH
 5P6ejmkx9WqncWYvUARSig6CyFBM97VGRGgD3tUCEVOXGMP2rPMnJnTowR8gE12otPGQ
 dzNMkJjzNhgQN68cb0AMBIzXtIUtMaVTBh5G1g0Nx8CMr8HlwpoheU+1e0PMCvpmgoOO
 nVGQ==
X-Gm-Message-State: APjAAAU8ppWpjvuocBjhbvtbY1e/y9G030+Tz4oMqsrVShPxZb/qHRlv
 cgR5WDdGytq3SNrUfApdQmIYMTSuZbg=
X-Google-Smtp-Source: APXvYqz7zzTwMe1t9DuuoNEr+QyAGDZXO7qE551FEYsxqBm/cpuLf71+onlMb+sMcQDgEXALAKVqAw==
X-Received: by 2002:a1c:1bd7:: with SMTP id b206mr23345731wmb.85.1565556656762; 
 Sun, 11 Aug 2019 13:50:56 -0700 (PDT)
Received: from localhost.localdomain (109-186-118-228.bb.netvision.net.il.
 [109.186.118.228])
 by smtp.gmail.com with ESMTPSA id r5sm18633871wmh.35.2019.08.11.13.50.54
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sun, 11 Aug 2019 13:50:55 -0700 (PDT)
From: Nir Soffer <nirsof@gmail.com>
X-Google-Original-From: Nir Soffer <nsoffer@redhat.com>
To: qemu-block@nongnu.org
Date: Sun, 11 Aug 2019 23:50:24 +0300
Message-Id: <20190811205024.19482-1-nsoffer@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH v2] block: posix: Handle undetectable alignment
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

- With Gluster, buf_align cannot be detected since the actual I/O is
  done on Gluster server, and qemu buffer alignment does not matter.

- With local XFS filesystem, buf_align cannot be detected if reading
  from unallocated area.

- With Gluster backed by XFS, request_alignment cannot be detected if
  reading from unallocated area.

- With NFS, the server does not use direct I/O, so both buf_align cannot
  be detected.

These cases seems to work when storage sector size is 512 bytes, because
the current code starts checking align=512. If the check succeeds
because alignment cannot be detected we use 512. But this does not work
for storage with 4k sector size.

Practically the alignment requirements are the same for buffer
alignment, buffer length, and offset in file. So in case we cannot
detect buf_align, we can use request alignment. If we cannot detect
request alignment, we can fallback to a safe value.

With this change:

- Provisioning VM and copying disks on local XFS and Gluster with 4k
  sector size works, resolving bugs [1],[2].

- With NFS we fallback to buf_align and request_alignment of 4096
  instead of 512. This may cause unneeded data copying, but so far I see
  better performance with this change.

[1] https://bugzilla.redhat.com/1737256
[2] https://bugzilla.redhat.com/1738657

Signed-off-by: Nir Soffer <nsoffer@redhat.com>
---

v1 was a minimal hack; this version is a more generic fix that works for
any storage without requiring users to allocate the first block of an
image. Allocting the first block of an image is still a good idea since
it allows detecting the right alignment in some cases.

v1 could also affect cases when we could detect buf_align to use
request_alignment instead; v2 will only affect cases when buf_align or
request_alignment cannot be detected.

v1 was hare:
https://lists.nongnu.org/archive/html/qemu-block/2019-08/msg00133.html

 block/file-posix.c | 40 +++++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index f33b542b33..511468f166 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -323,6 +323,7 @@ static void raw_probe_alignment(BlockDriverState *bs, int fd, Error **errp)
     BDRVRawState *s = bs->opaque;
     char *buf;
     size_t max_align = MAX(MAX_BLOCKSIZE, getpagesize());
+    size_t alignments[] = {1, 512, 1024, 2048, 4096};
 
     /* For SCSI generic devices the alignment is not really used.
        With buffered I/O, we don't have any restrictions. */
@@ -349,25 +350,42 @@ static void raw_probe_alignment(BlockDriverState *bs, int fd, Error **errp)
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
+                /* Fallback to request_aligment or safe value. */
+                s->buf_align = (align != 1)
+                    ? align
+                    : (bs->bl.request_alignment != 0)
+                        ? bs->bl.request_alignment
+                        : max_align;
                 break;
             }
         }
-- 
2.20.1


