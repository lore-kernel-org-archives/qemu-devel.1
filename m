Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F92AC04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 23:15:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 331372171F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 23:15:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 331372171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43361 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSrV1-0002Bv-CB
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 19:15:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hSrQR-0006uN-6S
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:10:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hSrQQ-0007po-AN
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:10:35 -0400
Received: from mail-qt1-f177.google.com ([209.85.160.177]:37105)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hSrQQ-0007pA-6D
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:10:34 -0400
Received: by mail-qt1-f177.google.com with SMTP id o7so18383479qtp.4
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 16:10:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:content-transfer-encoding
	:in-reply-to;
	bh=D9bFlV1mFhqIN7vSvELu+0BvpSNRsw3rERLU4meV1WU=;
	b=p5fPuhCxEaCw33eZsB46fDOOEbq+rUD/BrY7IsrgR7v/tb5XR2mK/vfuRTE7/rYBYM
	IaPNorzK4pesqdsIo/sMxa5Z5w6af8R8BXDZ6Ey6zxV5vxOP3DoUGL0hpSMs7GgLZbVz
	mpZwNC4k5wuA8e/nK6MxsfvWUayVsFPV90S4mkFbel3cR0rd9cmVJ4tlm9xdEw9au14Y
	VsfKD0Y3ByzA8wI1Y2UJWvoNMZZ+S3Xruy0x28IJvbzRkaY3Tzlmr4p/8LDcVMCS/qEK
	xS97YMlF/DbtxxBGt4pwNg38j8Xl9nej6UQg5Y0N2P3CyDBOy3ZA2kyIAfbEYJOJv+gX
	VcyA==
X-Gm-Message-State: APjAAAUDbukLXB0SIo3FI7emw1O4YXJpCH4YSZPf8KbINTtWVzJQAuuz
	7E41X0b6PtBDTyMnfNubO+twSAzTajM=
X-Google-Smtp-Source: APXvYqwLTzXjvTIxMKkBywnHPU76WHCDjgDUgWuvjOInlRjriorTyJcrSzye0bsxjdGJUNLg0CMtbg==
X-Received: by 2002:aed:2428:: with SMTP id r37mr64395094qtc.213.1558393832561;
	Mon, 20 May 2019 16:10:32 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net.
	[173.76.105.71]) by smtp.gmail.com with ESMTPSA id
	c32sm5793908qtd.61.2019.05.20.16.10.31
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Mon, 20 May 2019 16:10:31 -0700 (PDT)
Date: Mon, 20 May 2019 19:10:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190215103239.28640-3-berrange@redhat.com>
References: <20190520231008.20140-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190520231008.20140-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.177
Subject: [Qemu-devel] [PULL v2 02/36] Revert "globals: Allow global
 properties to be optional"
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
	Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190520231030.C7uccTFANBkamcEcAUMLWDTMJGthAGyV2a8Xd_EZdKY@z>

From: Daniel P. Berrangé <berrange@redhat.com>

This reverts commit d7741743f4f3d2683d1bb6938f88dc0167c21afa.

Relying on setting properties on parents types which may not
be relevant to certain sub-classes had unexpected side-effects
causing bugs in device config defaults. It is preferrable to
be explicit about which devices get which properties, even if
this needs repetition.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20190215103239.28640-3-berrange@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/qdev-core.h | 3 ---
 qom/object.c           | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 33ed3b8dde..fa55dc10ae 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -251,8 +251,6 @@ struct PropertyInfo {
 /**
  * GlobalProperty:
  * @used: Set to true if property was used when initializing a device.
- * @optional: If set to true, GlobalProperty will be skipped without errors
- *            if the property doesn't exist.
  *
  * An error is fatal for non-hotplugged devices, when the global is applied.
  */
@@ -261,7 +259,6 @@ typedef struct GlobalProperty {
     const char *property;
     const char *value;
     bool used;
-    bool optional;
 } GlobalProperty;
 
 static inline void
diff --git a/qom/object.c b/qom/object.c
index d3412e7fdc..99c4fa707e 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -385,9 +385,6 @@ void object_apply_global_props(Object *obj, const GPtrArray *props, Error **errp
         if (object_dynamic_cast(obj, p->driver) == NULL) {
             continue;
         }
-        if (p->optional && !object_property_find(obj, p->property, NULL)) {
-            continue;
-        }
         p->used = true;
         object_property_parse(obj, p->value, p->property, &err);
         if (err != NULL) {
-- 
MST


