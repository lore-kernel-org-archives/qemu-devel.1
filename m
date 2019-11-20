Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADACC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 16:04:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE92520714
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 16:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TcnY/z3I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE92520714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXSSf-0001c3-Va
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 11:04:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35231)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iXRxw-00081B-JU
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:32:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iXRxv-0001xz-9n
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:32:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54686
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iXRxv-0001xo-5u
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:32:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574263942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k5kNqIgkaawfSi2YqfCX/8DjAdLrxNrjCKnSySD3uvw=;
 b=TcnY/z3Irb4w6zphBhPeofCPDs5CdzlIZQH5gx8phd64omE6SLQSTjMgT/jE3xyCFhUR5Q
 9RoCi4UNoSjLhMRaIKnUKsGWrAya74jUufLEO0ImhXgCPh9JgrAXq9XLf2i52vtLBqJhuT
 BTzY1mBAwEnQC63FqC9klf/RAAiPSC0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-DA5B1klZNNWfs4FrZ_es2w-1; Wed, 20 Nov 2019 10:32:16 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03E8818B6391;
 Wed, 20 Nov 2019 15:32:16 +0000 (UTC)
Received: from localhost (ovpn-112-56.ams2.redhat.com [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 70B0B104B529;
 Wed, 20 Nov 2019 15:32:06 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 37/37] qdev/qom: remove some TODO limitations now that
 PROP_PTR is gone
Date: Wed, 20 Nov 2019 19:24:42 +0400
Message-Id: <20191120152442.26657-38-marcandre.lureau@redhat.com>
In-Reply-To: <20191120152442.26657-1-marcandre.lureau@redhat.com>
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: DA5B1klZNNWfs4FrZ_es2w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: peter.maydell@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
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
index c79befc865..c7b3f0dec5 100644
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
2.24.0


