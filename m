Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C05CC432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 14:39:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF5372146E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 14:39:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF5372146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD8S4-0000UX-Ng
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 10:39:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51753)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iD8JE-0000lw-JT
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 10:30:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iD8JD-00075J-HL
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 10:30:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:64681)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iD8JD-00073B-9D
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 10:30:23 -0400
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7AD2AE252C
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 14:30:21 +0000 (UTC)
Received: by mail-qt1-f200.google.com with SMTP id x25so6088417qtq.2
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 07:30:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=zzjcHdlX9leECy0KiDZ5U7TTGK9Vo7rZfBUw1mJW1Qc=;
 b=rbBa/3GsWIMC/7aUGONtbgLQFadxiaLzduhc3O26dsGmsI5MWn2E138d31gSe7/2fJ
 RLZkqvUzCvSQTe6d/xKzdR69HwucD25TODQXulcCIiBiOHzWy9WuUf5NFz9zHTssF3IT
 nFI2VHjNLa+kqhQ6sPZnYMKIGo88TcfBIfPQ7isk97zZE6jGESpGIKnJph5npWRWiy8w
 N/ZJVtdt2mUroBBXE57c9He4I/Mu6wjF3v/1OwA4itdRJHN4h60AGwEiJaqq+H4n0ADp
 IPa4joe5QJv9HcWgqSiHmt6G7jTu/swGeJFqih9cTgNkw2BpDpM3+4TgOmaLHpwNGSK9
 r98g==
X-Gm-Message-State: APjAAAVEndx/TlQYqp0Ol3JS8Xn+wPbtwynKBivoHuyZDcfO3JhN2MKt
 hoXyRcPhGS/xd5huCW6hSeJmKClZ47e4z/Jx6jMkfJS4Bc/YgQWK/zDCY85getwpGTd46cRRVSk
 aOlH6sDmYBrDBELo=
X-Received: by 2002:ac8:550d:: with SMTP id j13mr9279501qtq.338.1569421820239; 
 Wed, 25 Sep 2019 07:30:20 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyx/EE3XKTPGcI7WpfI/mwGDrb5YIMHN/GzcFLLYQJ4HAxCrzF9FL+u241QXSIHyJLYr93Bkw==
X-Received: by 2002:ac8:550d:: with SMTP id j13mr9279480qtq.338.1569421820088; 
 Wed, 25 Sep 2019 07:30:20 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
 by smtp.gmail.com with ESMTPSA id d127sm3074283qke.54.2019.09.25.07.30.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2019 07:30:19 -0700 (PDT)
Date: Wed, 25 Sep 2019 10:30:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/3] memory: Provide an equality function for
 MemoryRegionSections
Message-ID: <20190814175535.2023-3-dgilbert@redhat.com>
References: <20190925142910.26529-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190925142910.26529-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190925143015.NbfIbBD-VlKxFmSt2RyPaN7p6MqBtjcjijPmaW8g-Uc@z>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Provide a comparison function that checks all the fields are the same.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20190814175535.2023-3-dgilbert@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/exec/memory.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index a1e6d846cc..6e67043ee0 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -504,6 +504,18 @@ struct MemoryRegionSection {
     bool nonvolatile;
 };
=20
+static inline bool MemoryRegionSection_eq(MemoryRegionSection *a,
+                                          MemoryRegionSection *b)
+{
+    return a->mr =3D=3D b->mr &&
+           a->fv =3D=3D b->fv &&
+           a->offset_within_region =3D=3D b->offset_within_region &&
+           a->offset_within_address_space =3D=3D b->offset_within_addres=
s_space &&
+           int128_eq(a->size, b->size) &&
+           a->readonly =3D=3D b->readonly &&
+           a->nonvolatile =3D=3D b->nonvolatile;
+}
+
 /**
  * memory_region_init: Initialize a memory region
  *
--=20
MST


