Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94882C4363C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 17:45:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20241206A5
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 17:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhYyxNjR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20241206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOP80-0001M0-Ur
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 13:45:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kOOyX-0000Xb-9Q
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 13:36:09 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44719)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kOOyV-0003K4-32
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 13:36:08 -0400
Received: by mail-wr1-x441.google.com with SMTP id s12so2661347wrw.11
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 10:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nBtGQHWCtBz1UuRn2EA9dhKJU3PmW9+7UuhXaOrWq6I=;
 b=OhYyxNjRLPiEoT83UGLbnp3gPXfjJ0Pfuc/rSTH0ivA07LOudVpCmrv1fbM4B20qQf
 7nKeVSbtPRpyykiFFc8V/Tupj181FG/Fpj81dWRsn99njPnM9NdtfHGrv4SCrvboPuMW
 jgzLB/Yg8Sezfu0/9hbPro4Nukt5sWA9asrks/4TuoYNZJRWzz7pZbwEmyZjz+DFn7gG
 tUwTgLHnfTm7wBHSO064ttkut8s6a8MNIhS3qVgf6kILClD48CY5EmGdJ62pQEe+6JJA
 2G/l87eh7JXsrHg/Mkjf9wv20BfRQtA1fOJMm56mZP/ib0DWbygP/dEKPlTQQc9A473a
 OB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=nBtGQHWCtBz1UuRn2EA9dhKJU3PmW9+7UuhXaOrWq6I=;
 b=Jz4p5mnjMwapV/R2R4iTyKtZcKixydcOGqo91vSSGZt+dmJom9T3cb3nAnp31tPQqX
 r29Mb/qPGic9pSNUy25SZ0MqwvOc8FvKO3Y0V8JGvi6YdN3f+Ug1oftway3g59SWUlqQ
 C9rrvces9xtaae6ZlTos8A6fYspPxY8UOC0+MjoiG0cdytGzwfkFiHRg0kQbsiqzZ7+M
 L+8ZUJUxjmU5z5eyJrpkjCEyhxClbm0Tzw0Trk4ri30WIhfl6PIKnUawbLNAUlAw4v6d
 +p4+oTbqmxZ7ggR/HqhrL6wQEwOaCumNA848+LaQycRSm+qNs+5BVUtrwI67osbgHIQE
 rLDg==
X-Gm-Message-State: AOAM533H0OiytmUf+D/QfJ6bqoRwNI7TID8lL40IR7THfZWIHOx3KNE9
 S8PSQ8ouvVhICIF+BDZdkFwH+x425fk=
X-Google-Smtp-Source: ABdhPJxAViXAdzabs5RKv6eu0Kq6o/5hBqjl+nVRGuJkCTVP/4YRUZRRjwWIO9KImhGGMMthLYFp8w==
X-Received: by 2002:adf:e292:: with SMTP id v18mr4251306wri.256.1601660165528; 
 Fri, 02 Oct 2020 10:36:05 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:47e0:e742:75ba:b84d])
 by smtp.gmail.com with ESMTPSA id
 l8sm2516454wrx.22.2020.10.02.10.36.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 10:36:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 06/10] device-core: use atomic_set on .realized property
Date: Fri,  2 Oct 2020 19:35:54 +0200
Message-Id: <20201002173558.232960-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201002173558.232960-1-pbonzini@redhat.com>
References: <20201002173558.232960-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Maxim Levitsky <mlevitsk@redhat.com>

Some code might race with placement of new devices on a bus.
We currently first place a (unrealized) device on the bus
and then realize it.

As a workaround, users that scan the child device list, can
check the realized property to see if it is safe to access such a device.
Use an atomic write here too to aid with this.

A separate discussion is what to do with devices that are unrealized:
It looks like for this case we only call the hotplug handler's unplug
callback and its up to it to unrealize the device.
An atomic operation doesn't cause harm for this code path though.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20200913160259.32145-6-mlevitsk@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/qdev.c         | 19 ++++++++++++++++++-
 include/hw/qdev-core.h |  2 ++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 59e5e710b7..fc4daa36fa 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -946,7 +946,25 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
             }
        }
 
+       qatomic_store_release(&dev->realized, value);
+
     } else if (!value && dev->realized) {
+
+        /*
+         * Change the value so that any concurrent users are aware
+         * that the device is going to be unrealized
+         *
+         * TODO: change .realized property to enum that states
+         * each phase of the device realization/unrealization
+         */
+
+        qatomic_set(&dev->realized, value);
+        /*
+         * Ensure that concurrent users see this update prior to
+         * any other changes done by unrealize.
+         */
+        smp_wmb();
+
         QLIST_FOREACH(bus, &dev->child_bus, sibling) {
             qbus_unrealize(bus);
         }
@@ -961,7 +979,6 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
     }
 
     assert(local_err == NULL);
-    dev->realized = value;
     return;
 
 child_realize_fail:
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 2c6307e3ed..868973319e 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -163,6 +163,8 @@ struct NamedClockList {
 /**
  * DeviceState:
  * @realized: Indicates whether the device has been fully constructed.
+ *            When accessed outsize big qemu lock, must be accessed with
+ *            atomic_load_acquire()
  * @reset: ResettableState for the device; handled by Resettable interface.
  *
  * This structure should not be accessed directly.  We declare it here
-- 
2.26.2



