Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A21C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 16:42:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D186B20714
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 16:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jSZ4NELS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D186B20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1v5u-0004zT-WD
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 11:42:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36575)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j1v4x-0003Bv-RT
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:41:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j1v4w-0001aD-PK
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:41:35 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:44969)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j1v4w-0001Y0-Ii
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:41:34 -0500
Received: by mail-wr1-x429.google.com with SMTP id m16so3169620wrx.11
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 08:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=l/AgXBV6DaQrKl5QgbkJnKxXBovTmb0GOhwB0Jdunvg=;
 b=jSZ4NELS3N5ZQHNUZStq1QI/1oxM94YeVO3gRLCkC67cqSUldMrrgybtFgQMaAQwAH
 YVyqCfAxTqFrV4kGm8CbhfohgMG/obUxBh0DiNBRtMlIYVyIB27QBWhe8DOgE6Z+uIEY
 wBfqFm2AVWKlsMhdibPh7FhZvfe51mp3usfIT6JBG3TN9GEvGlxRX5XTZjRhpvotrjAK
 2i4knTHDMiMobvXJ0FzSIOvtt5Xy90SCufBi6qLKXLXlA16GSnBQ7YyAew8wssXJZBsV
 dTbfufe8BPvdYmt0kKD2xBzW9uVFz9GDgnu78B5KvLWOd/Vjpkphvt5YhhVMyVgxGToz
 SpNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=l/AgXBV6DaQrKl5QgbkJnKxXBovTmb0GOhwB0Jdunvg=;
 b=j89lnLqUcFfUvP8Xm1ghgae3ZYQ6bn/hBDXtIlT4EtFdICPbhvjbOcDV80L97EvwBS
 F0CU9cvNsoGGeb4CH4eKSbgVbetS+SG31OLffy/zFELC6UOorqdhTIyweGiqGgleS5NO
 4W255776mapkPvo7ZyH6A6tZFG6WI/Pl4ckSmmVM+ZobEzgh7lt8FPTWT+TvJLf3z7/G
 CziNwC6JjaYaSRRurMAHXzo4PY9Ciz6pL7GlLz8LITTHZbRqC9utXdNdwEY2RA8ZAnj7
 bFDiPRV5ctml8K2hEIrXeV/dgxMTRGvO78Efmr9+bCWbu0cq9JgVDwen7L+4IazOORrk
 Mm7g==
X-Gm-Message-State: APjAAAXRCYRpEcCacC442TpDYAwyqumjsvKNnsNPEnEAJuix0/GBP3H5
 68NQg5xWf6GLfjIu8tujkHTpCK4u
X-Google-Smtp-Source: APXvYqzBu7Z+ywm1OvreW9HDbBFrfeBKev83gXRZumjYLb5gC6JszamV4ybcZk8MLia+9IsATDSZKA==
X-Received: by 2002:adf:ec83:: with SMTP id z3mr15538203wrn.133.1581525693355; 
 Wed, 12 Feb 2020 08:41:33 -0800 (PST)
Received: from donizetti.fritz.box ([151.30.86.140])
 by smtp.gmail.com with ESMTPSA id a16sm1195122wrt.30.2020.02.12.08.41.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2020 08:41:32 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/9] seqlock: fix seqlock_write_unlock_impl function
Date: Wed, 12 Feb 2020 17:41:22 +0100
Message-Id: <20200212164129.6968-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200212164129.6968-1-pbonzini@redhat.com>
References: <20200212164129.6968-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::429
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Luc Michel <luc.michel@greensocs.com>

The seqlock write unlock function was incorrectly calling
seqlock_write_begin() instead of seqlock_write_end(), and was releasing
the lock before incrementing the sequence. This could lead to a race
condition and a corrupted sequence number becoming odd even though the
lock is not held.

Signed-off-by: Luc Michel <luc.michel@greensocs.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200129144948.2161551-1-luc.michel@greensocs.com>
Fixes: 988fcafc73 ("seqlock: add QemuLockable support", 2018-08-23)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/seqlock.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/qemu/seqlock.h b/include/qemu/seqlock.h
index fd408b7ec5..8b6b4ee4bb 100644
--- a/include/qemu/seqlock.h
+++ b/include/qemu/seqlock.h
@@ -55,11 +55,11 @@ static inline void seqlock_write_lock_impl(QemuSeqLock *sl, QemuLockable *lock)
 #define seqlock_write_lock(sl, lock) \
     seqlock_write_lock_impl(sl, QEMU_MAKE_LOCKABLE(lock))
 
-/* Lock out other writers and update the count.  */
+/* Update the count and release the lock.  */
 static inline void seqlock_write_unlock_impl(QemuSeqLock *sl, QemuLockable *lock)
 {
+    seqlock_write_end(sl);
     qemu_lockable_unlock(lock);
-    seqlock_write_begin(sl);
 }
 #define seqlock_write_unlock(sl, lock) \
     seqlock_write_unlock_impl(sl, QEMU_MAKE_LOCKABLE(lock))
-- 
2.21.0



