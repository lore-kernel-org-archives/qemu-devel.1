Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37591C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 17:31:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CB2727286
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 17:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czZ7N9K4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CB2727286
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38556 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXqo9-0006sZ-3h
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 13:31:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hXqUV-0007Vj-6T
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:11:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hXqUU-0004dg-0p
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:11:23 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35497)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1hXqUQ-0003rY-91
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:11:20 -0400
Received: by mail-wm1-x341.google.com with SMTP id c6so8963890wml.0
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 10:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=eVwMFZ+KWBK7cXllizTF1Ac4hocoCZRu5KoL6VrLxIY=;
	b=czZ7N9K412S+tYUzSeq0tihlWPMfLRhw4kcNsjd4OMM06MFBw09rXuvOAFJw1XTFIy
	jq5GTDjVobTiN79g0AVaLituZ60V0TLZC8SxqtT5SJJ5xtCN8t1IlMX9PWnp4LjfbQzc
	LCboTW6o1md9ltJTq64WE78Qi/V8EL58NIAKipetuSxteJt9UgHZuzKE+PdoSs1XMc6v
	KqSl/GB2n6wPl+Hih70ZMgn0JcsXDaVVWd2ATfaM1TSRyvrW6IidGM8+medwFx/0S8Pm
	bhDkbuKaPg5fb2DLvULdv1loug0s12/W7AoBP9KjkTdMsFxl5QKfOnNifcSCFrbIlSWO
	p15g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
	:in-reply-to:references;
	bh=eVwMFZ+KWBK7cXllizTF1Ac4hocoCZRu5KoL6VrLxIY=;
	b=n0cW/dHdspaYZiasGVUk0VCxOApNfvec1hwCqEkDhebbofHIv2b3Rge2Skv03Qobvu
	00d7nmr1Wv/XtcXWUNPe9OvNrnTQdYm+0d127HZeRdB4Rv3efzCQ6KK6hgzgy/DSfhnO
	Juxyw24McVhZdWq0Qcu7AWmauRxck1TctRaz7DQtSluh8+9Ugk5AwlYWulSNC2rXRPLM
	RDaB9ELixznXMZ1SI/taBbttPRK99m+7zsV4ULi4errMmo6kZUT5ukCiE5oWb9bbVqBf
	gR+c2anvdTIH7Qew5MxxIx9hEL8Y+4i2s99zen7XLbYcrsbNcQY1ziFWI2oHrcnw2Fp9
	0Y1w==
X-Gm-Message-State: APjAAAWN6EFlydFFZm9qRnPFlLchkM0cXw0Yjz3fdvXciAPN7owWt6uf
	C29RSt1z1/6GwqknuLbd42rnzNGp
X-Google-Smtp-Source: APXvYqxmDEZBu22I9MgJWfCEM6yTIN70ysy5Z0tfpDZAXENTKxLQYi8Shhod3UfHbtmDpkWvfBkcMA==
X-Received: by 2002:a05:600c:2182:: with SMTP id
	e2mr10999857wme.55.1559581852547; 
	Mon, 03 Jun 2019 10:10:52 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	r131sm3325045wmf.4.2019.06.03.10.10.51
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 10:10:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  3 Jun 2019 19:10:25 +0200
Message-Id: <1559581843-3968-7-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1559581843-3968-1-git-send-email-pbonzini@redhat.com>
References: <1559581843-3968-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PULL 06/24] edu: mmio: allow 64-bit access
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Li Qiang <liq3ea@163.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Li Qiang <liq3ea@163.com>

The edu spec says the MMIO area can be accessed by 64-bit.
However currently the 'max_access_size' is not so the MMIO
access dispatch can only access 32-bit one time. This patch fixes
this to respect the spec.

Signed-off-by: Li Qiang <liq3ea@163.com>
Reviewed-by: Philippe Mathieu-Daude <philmd@redhat.com>
Message-Id: <20190510164349.81507-2-liq3ea@163.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/misc/edu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/misc/edu.c b/hw/misc/edu.c
index 91af452..65fc32b 100644
--- a/hw/misc/edu.c
+++ b/hw/misc/edu.c
@@ -289,6 +289,15 @@ static const MemoryRegionOps edu_mmio_ops = {
     .read = edu_mmio_read,
     .write = edu_mmio_write,
     .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 8,
+    },
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 8,
+    },
+
 };
 
 /*
-- 
1.8.3.1



