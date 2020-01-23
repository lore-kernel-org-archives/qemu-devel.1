Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75065C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:21:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 407C721734
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VItPUOK7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 407C721734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iufEq-0004CY-Q2
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 11:21:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51623)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrZ-0005Fl-JY
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrY-0003tP-Ix
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:37 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:54627)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iucrY-0003pw-Ce
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:36 -0500
Received: by mail-wm1-x331.google.com with SMTP id b19so2629274wmj.4
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 05:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kb+EYMV7I0i7u1W/G6zmMLHU6IYUgpjoqADdG+CD2XM=;
 b=VItPUOK7AulvllwpzmXLbubCZhFtLOdA9WKq4zE/vxoFCTkh/pVZkf2YWODXyEtv1+
 g97Rz7B66fkkwkkk6X2d2UwYnayFFO7StZ03aY6AJR2aSERoGzFRw9gTElboYM9WJ4Bt
 1SAWbb4uTx3LtpaYOFJh2Cpbx4dHe9oON2HseadjJLPwC9QVQ3DsUEGunVL/l/xudQWY
 yj4CRshabQYpDBAoLOZoiqPJsx2uEj6GP1JxSBsHrOApXB8MyttYhZ8tnESr/M2plMwf
 EXLV9XM4rnHSacLcwNYu4rF7qO7L5OBFE2KKLFD3NiIgQGdFGeUkRj1zja/KnYEvMhJi
 9AFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=kb+EYMV7I0i7u1W/G6zmMLHU6IYUgpjoqADdG+CD2XM=;
 b=QJB1U6pXq2QT5nVMh8/PVNhdAaSFQHyF4s5KJgOFkMNjEFXokGjiksimuBvMPiIuoY
 XCT6IDVhe5tZIRYD+pxJTV2jLjw8pjxDnpr5xsC/vztlFckzAbKy2xmVgKy3PKKZaVbU
 S69eCV9vSkhETscs4UDwMbUnLIDlSHc1BznHXhROHk9RwLu+1OePM0bpWd+hOvMT+mVk
 bMg11dsixUxq6VNZa2s5Zr7b58/wBeGhC8eJIyACQQZh7HLP7soFQCmSBEP0mgg1wC5q
 VeMNq6SB36UYAeuccooBFToX1IWWujUJYModYrFq+1uhGgpbUJdd60D06egSpGxFHqkG
 8dng==
X-Gm-Message-State: APjAAAW8KEdjVC6x1RTe/dH7TfFeJdBpHjF1YR7ZVyvMs149tgUE7CLM
 KNKNJz8McDS4x865hMS8nBmzRjda
X-Google-Smtp-Source: APXvYqxenBqB4yj/vIAoRLi8rqhZkB1O1gpLvrw2n+HX2ASui1FPQGCuEFkXdX6Rb5mvPItT6mBPjQ==
X-Received: by 2002:a05:600c:d5:: with SMTP id
 u21mr1204530wmm.98.1579787375204; 
 Thu, 23 Jan 2020 05:49:35 -0800 (PST)
Received: from 640k.localdomain.com ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id s15sm3073171wrp.4.2020.01.23.05.49.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 23 Jan 2020 05:49:34 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 32/59] qdev: remove duplicated qdev_property_add_static() doc
Date: Thu, 23 Jan 2020 14:48:35 +0100
Message-Id: <1579787342-27146-33-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
References: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The function is already documented in the header.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20200110153039.1379601-3-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/qdev.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 58e87d3..b47dc07 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -717,16 +717,6 @@ static void qdev_property_add_legacy(DeviceState *dev, Property *prop,
     g_free(name);
 }
 
-/**
- * qdev_property_add_static:
- * @dev: Device to add the property to.
- * @prop: The qdev property definition.
- * @errp: location to store error information.
- *
- * Add a static QOM property to @dev for qdev property @prop.
- * On error, store error in @errp.  Static properties access data in a struct.
- * The type of the QOM property is derived from prop->info.
- */
 void qdev_property_add_static(DeviceState *dev, Property *prop,
                               Error **errp)
 {
-- 
1.8.3.1



