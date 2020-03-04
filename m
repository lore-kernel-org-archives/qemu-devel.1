Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B0BEC3F2CD
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 15:35:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 236A72465D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 15:35:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U5jJ6EIJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 236A72465D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9W3j-0001gM-9H
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 10:35:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45156)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9W1V-0006sU-Fh
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 10:33:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9W1U-0003Rn-JF
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 10:33:25 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57283
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9W1U-0003Pv-Fi
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 10:33:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583336004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=biiTpzltwU1sZnuHfx0nIZ3HPWdcfFfqBiK+XWGwsSg=;
 b=U5jJ6EIJ1Ox5tXqVPybJscwLvQxUaIP4xwwo6MxrSmH5dP8h5XVZH9SG2Nk0Na3s8+fUYM
 VNEefwdHsFjAHDHrsHRez5ZxVM5wkZ6qBPr7R3b92OJkNhd5hfHD/NVHFhG5ib3Umtc7sZ
 P7ZT/Qb8O32ofCirG0fIOgmLrPVnKYE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-mIKbVQxRNP2wYB-ddTaSYA-1; Wed, 04 Mar 2020 10:33:22 -0500
X-MC-Unique: mIKbVQxRNP2wYB-ddTaSYA-1
Received: by mail-wm1-f71.google.com with SMTP id t2so700689wmj.2
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 07:33:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/S7pAhQdbWIOFjZggLKf3SMhfw5UacO71zzf9J+ONfw=;
 b=s72F5V0KABEPmLg6vvYkQAJ/aHXwUzTfN0/KFP0lA/Dx6lN3xS7Cr1H1UOLSTv60If
 58K+ti8OMDQN9bs+HLsidB6ZAAN4Xrcg6YElGLM3aSleKr2uBJn6EuAmQYu9k/hYst9n
 y2Lv5Na60xwYYYVVkDG4MjqiBBD15RbEa408UFWC+bUd8gSQuWgmGLTcmf6u53t2TTMr
 7ciR5/QnukWD18Og4pKpsSZoQjbP+4bCW64Y2nKVI8W6eavKfQlp7wLXx5kv3YmdMb/x
 O4VoTtG0v2MzMpt567NwDUEhZ2+4QsPYGXnn0FghFpePLkP2huYNqlYRlxGoksbZXr87
 Vt1Q==
X-Gm-Message-State: ANhLgQ1w9F9PcKManeckKqCWhMyaCiGW48tEasmTtch8X33Simt5ZQdI
 v139XV0za7g13b51fbggEDXDS9qGQvdccwy8v/WyqhSFj9hjtuhI3ZncUwqoEjHgwiQz0EqCbmu
 REkGZgr5NQKW27ns=
X-Received: by 2002:a1c:43c2:: with SMTP id q185mr4152830wma.176.1583336000625; 
 Wed, 04 Mar 2020 07:33:20 -0800 (PST)
X-Google-Smtp-Source: ADFU+vv4YvXFHj49GK0qRoaSAyFvdBmUg1iPZ3HA2bytMIDt88kEHu39uA0AjmrOMc54DtYusI9Wpg==
X-Received: by 2002:a1c:43c2:: with SMTP id q185mr4152815wma.176.1583336000454; 
 Wed, 04 Mar 2020 07:33:20 -0800 (PST)
Received: from localhost.localdomain (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id c4sm4771137wml.7.2020.03.04.07.33.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2020 07:33:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/5] hw/scsi/viosrp: Add missing 'hw/scsi/srp.h' include
Date: Wed,  4 Mar 2020 16:33:07 +0100
Message-Id: <20200304153311.22959-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200304153311.22959-1-philmd@redhat.com>
References: <20200304153311.22959-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Fam Zheng <fam@euphon.net>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This header use the srp_* structures declared in "hw/scsi/srp.h".

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/scsi/viosrp.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/scsi/viosrp.h b/hw/scsi/viosrp.h
index d8e365db1e..25676c2383 100644
--- a/hw/scsi/viosrp.h
+++ b/hw/scsi/viosrp.h
@@ -34,6 +34,8 @@
 #ifndef PPC_VIOSRP_H
 #define PPC_VIOSRP_H
=20
+#include "hw/scsi/srp.h"
+
 #define SRP_VERSION "16.a"
 #define SRP_MAX_IU_LEN    256
 #define SRP_MAX_LOC_LEN 32
--=20
2.21.1


