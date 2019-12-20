Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E29C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:14:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E029D206EC
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q/8TXgUM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E029D206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiJ2s-00032k-DI
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 09:14:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48782)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iiIhm-0004J1-19
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:52:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iiIhk-0008AL-R1
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:52:33 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26390
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iiIhk-000885-IH
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:52:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576849952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OkycvjxGlSDX/OH6Ca4R80SQm4GKcDVxy/0qITwmuWk=;
 b=Q/8TXgUMNFQFrOH4PTcvV/GEmdKUkK/CqRHtVm/Pe/xFCiagEajLhu0Uj8HnW6YuRMUVrT
 /t5lucwmKbC7h815/tWc7de/OJ5tZPgetOBj3ACHclHVa9dVItzio4P9M7oSiyvmOPahfq
 Ur4Ql/swe4o/Ox6VPBEUokNE0Sdy3oI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-xJmBZagBOAKrnIrGiyDx5Q-1; Fri, 20 Dec 2019 08:52:28 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D7C505EB;
 Fri, 20 Dec 2019 13:52:27 +0000 (UTC)
Received: from localhost (ovpn-112-54.ams2.redhat.com [10.36.112.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7F4035C54A;
 Fri, 20 Dec 2019 13:52:24 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 37/37] qdev/qom: remove some TODO limitations now that
 PROP_PTR is gone
Date: Fri, 20 Dec 2019 17:46:01 +0400
Message-Id: <20191220134601.571905-38-marcandre.lureau@redhat.com>
In-Reply-To: <20191220134601.571905-1-marcandre.lureau@redhat.com>
References: <20191220134601.571905-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: xJmBZagBOAKrnIrGiyDx5Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/core/qdev.c     |  8 --------
 qom/qom-qmp-cmds.c | 10 ----------
 2 files changed, 18 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 98e786c50f..9feb81cff2 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -736,14 +736,6 @@ void qdev_property_add_static(DeviceState *dev, Proper=
ty *prop,
     if (prop->info->create) {
         prop->info->create(obj, prop, &local_err);
     } else {
-        /*
-         * TODO qdev_prop_ptr does not have getters or setters.  It must
-         * go now that it can be replaced with links.  The test should be
-         * removed along with it: all static properties are read/write.
-         */
-        if (!prop->info->get && !prop->info->set) {
-            return;
-        }
         object_property_add(obj, prop->name, prop->info->name,
                             prop->info->get, prop->info->set,
                             prop->info->release,
diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
index 236e8e41dd..f4494f98ac 100644
--- a/qom/qom-qmp-cmds.c
+++ b/qom/qom-qmp-cmds.c
@@ -142,16 +142,6 @@ static ObjectPropertyInfo *make_device_property_info(O=
bjectClass *klass,
                 continue;
             }
=20
-            /*
-             * TODO Properties without a parser are just for dirty hacks.
-             * qdev_prop_ptr is the only such PropertyInfo.  It's marked
-             * for removal.  This conditional should be removed along with
-             * it.
-             */
-            if (!prop->info->set && !prop->info->create) {
-                return NULL;           /* no way to set it, don't show */
-            }
-
             info =3D g_malloc0(sizeof(*info));
             info->name =3D g_strdup(prop->name);
             info->type =3D default_type ? g_strdup(default_type)
--=20
2.24.0.308.g228f53135a


