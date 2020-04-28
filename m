Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC950C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 20:19:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92A21206D6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 20:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CEPGYQwL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92A21206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTWhK-0003Ls-O0
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 16:19:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36938)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jTWXU-0007ym-Sv
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 16:11:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jTWTy-0004CB-SU
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 16:09:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54124
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jTWTy-00045Y-DL
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 16:05:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588104326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ax0LkeAAIndsTzhPy/qtr5B9HmLoi+16K/QIUmH7GXo=;
 b=CEPGYQwL+B1TPn3vjHYL7WqKtnlW8ksFUIeX1b3Rt6ZQqBZX4VydWcnI95KBFY0vBaW9Pk
 F4Oy4B1XcK5fJqxHcvG2RZ27fIHuI3bdzHoRll3P4Q6lRExdOYERC0bawn4qn/EsRMkzc1
 2E19AqOHPjmdHavNHkafCviKXiiVbrs=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-rgVETGxTMkuH-CPNebVeuw-1; Tue, 28 Apr 2020 16:05:24 -0400
X-MC-Unique: rgVETGxTMkuH-CPNebVeuw-1
Received: by mail-qt1-f197.google.com with SMTP id g55so25883956qtk.14
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 13:05:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zIiDs+++fCnT9ro6vfnp6r3+ENPC4Cv+8dkOjfioTPY=;
 b=PETmG8u27v6dSsp+PYU3E6XAK2WIS3/C0Gir+ZsHtApLBqjzu+1oPL/R7mBcnR1kwo
 7Kz6n68d6A+rOlqP5ffqVJ1F4X6zIib+ZHZoLiiuiQHAXUiWqKP57mgdcDKQMybD5fqw
 gpsRYE9ZXoMDMiqkQnnsTbweN92iV+1tUm0Gu5QRta6tt6RJdkcrw1ZEh+yeh7blUmv5
 Tb+QqyJ96xGIfp6wxIorRgLufceTO00e5gxuVCIaIzZR/EOChZHdfj6BHtojoXJ8wzJw
 u+EI9HJfdCP7mhdikyQj9TUsNDsBdM0MIPaviHpXmzrSuJMnQYJ/q7TSMfOmNwiZVaXh
 nx4A==
X-Gm-Message-State: AGi0PubkYq/A24hNTHVRfIVZlDWlpSRi6iuPzUDhFflH2n52QNiT893n
 8jTaaV6EKYCD2+L/kknqnE6R9e8a63wTJQTqhTABjVhKj24SkYJbvmKLrmeQAVoQPq9XJMSN6cD
 /99CPP3VQfnRqoSE=
X-Received: by 2002:ac8:4686:: with SMTP id g6mr30198230qto.144.1588104324024; 
 Tue, 28 Apr 2020 13:05:24 -0700 (PDT)
X-Google-Smtp-Source: APiQypKP9578i9pTKJ4igs00fu3uV9qfPDcUtoobMegEnfXR/QTUK/zR9REm2CS9tmuql7cq368q3Q==
X-Received: by 2002:ac8:4686:: with SMTP id g6mr30198207qto.144.1588104323751; 
 Tue, 28 Apr 2020 13:05:23 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id k127sm14106585qkb.35.2020.04.28.13.05.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2020 13:05:23 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC v2 7/9] KVM: Cache kvm slot dirty bitmap size
Date: Tue, 28 Apr 2020 16:05:07 -0400
Message-Id: <20200428200509.13150-5-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200428195707.11980-1-peterx@redhat.com>
References: <20200428195707.11980-1-peterx@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=peterx@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 02:16:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: pbonzini@redhat.com, dgilbert@redhat.com, Peter Xu <peterx@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cache it too because we'll reference it more frequently in the future.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 accel/kvm/kvm-all.c      | 1 +
 include/sysemu/kvm_int.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index dd21b86efa..2d581013cc 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -558,6 +558,7 @@ static void kvm_slot_init_dirty_bitmap(KVMSlot *mem)
     hwaddr bitmap_size =3D ALIGN(((mem->memory_size) >> TARGET_PAGE_BITS),
                                         /*HOST_LONG_BITS*/ 64) / 8;
     mem->dirty_bmap =3D g_malloc0(bitmap_size);
+    mem->dirty_bmap_size =3D bitmap_size;
 }
=20
 /* Sync dirty bitmap from kernel to KVMSlot.dirty_bmap */
diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
index 1a19bfef80..71c9946ecf 100644
--- a/include/sysemu/kvm_int.h
+++ b/include/sysemu/kvm_int.h
@@ -23,6 +23,7 @@ typedef struct KVMSlot
     int old_flags;
     /* Dirty bitmap cache for the slot */
     unsigned long *dirty_bmap;
+    unsigned long dirty_bmap_size;
     /* Cache of the address space ID */
     int as_id;
     /* Cache of the offset in ram address space */
--=20
2.24.1


