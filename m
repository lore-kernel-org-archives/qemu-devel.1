Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F8BC04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:19:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06F8A20833
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:19:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06F8A20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53707 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRFML-0000Kb-1h
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 08:19:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hRFKe-0007oY-Vh
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:18:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hRFKb-0000wZ-3g
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:17:56 -0400
Received: from mail-qk1-f176.google.com ([209.85.222.176]:41405)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hRFKb-0000w9-0w
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:17:53 -0400
Received: by mail-qk1-f176.google.com with SMTP id g190so2058937qkf.8
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 05:17:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:content-transfer-encoding
	:in-reply-to;
	bh=D9bFlV1mFhqIN7vSvELu+0BvpSNRsw3rERLU4meV1WU=;
	b=C/dTx7avd0DpsCNcw8sbQYNwS3ScMBk3wdUe906yDsVxC5XHSCmUaG3yoITO4555wi
	xYmBHLR4PW2ug6OhTD9gQdPs+3X0j3M1yogSTixCWss4DlqBz+OnHdBmGm0T4nRGy2sy
	sAgHPJjCFnUqwBJkm3ki0QAc1X2TEfUbyh2dL43+UZXsq+qdlBZdmjdAZ9SmvzxODrH+
	h4RJkyLBNz8fwZDH61M/Xz7kq8y6hBTI00zwKp4ONcuMN/uXlXHs5oQW+4h2bJtmyWYn
	Lji0RMqecZUSp6O1aMMhP+JP7J/B/HbBUCr2sYIFEs4vXQdedSxfTcyLHbDOUL3pc/E5
	Ipbg==
X-Gm-Message-State: APjAAAVgl8mYZDJqdy8+c2A/ZQwJ1A9Om29RTDf/nGLNYM7GDpPhFz9X
	eegOHg57UvHX2l++S6rw0o1PcX+eEfE=
X-Google-Smtp-Source: APXvYqzPRaowj5FtoCswZ40+ACXTQce3SxuzvaNpcijl7zH/ZgAXrGC6cYLS7di2Q2CED2xfC1VMbA==
X-Received: by 2002:a37:6658:: with SMTP id a85mr8356248qkc.350.1558009071187; 
	Thu, 16 May 2019 05:17:51 -0700 (PDT)
Received: from redhat.com ([185.54.206.10])
	by smtp.gmail.com with ESMTPSA id u5sm2962276qtj.95.2019.05.16.05.17.49
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 16 May 2019 05:17:50 -0700 (PDT)
Date: Thu, 16 May 2019 08:17:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190215103239.28640-3-berrange@redhat.com>
References: <20190515121146.7248-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190515121146.7248-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.222.176
Subject: [Qemu-devel] [PULL 02/37] Revert "globals: Allow global properties
 to be optional"
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
Message-ID: <20190516121748.LwCab89dk_o9pdAP6fOp2lQsPvH0Z8OWduANMx0oC2Q@z>

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


