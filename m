Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF31BC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:09:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AA5F206D4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YnM7Wy7t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AA5F206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iufz7-0003hi-5W
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 12:09:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53104)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iucuZ-0001f1-Da
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:52:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iucuY-0001NK-BT
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:52:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36468
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iucuY-0001NA-8D
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:52:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579787562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NKbz01lsGRxXpu6cWnR890EpjJmf3tFFbUXHubunYW0=;
 b=YnM7Wy7teydgQbC4F/Wxvh19hw4Nsl4K+/n2XsUfNvZagAm/LONVB4okOtrW9N2z80G7Nt
 HsSH50t+4fVhBuHhGs6/Qr91c3YheUjYsd6gu/B+ehVBrpg9/MZEJc5nzMBEJsx629mJAT
 mBK5L25gTDrtsFyx5Myx/EsIYrD0sYw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-kXkEFJ6FO-mCEC9FzBN_3A-1; Thu, 23 Jan 2020 08:52:40 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45C15100EC93
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 13:52:39 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.112.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 44ABE85782;
 Thu, 23 Jan 2020 13:52:38 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 52/59] vl: print default value in object help
Date: Thu, 23 Jan 2020 14:50:42 +0100
Message-Id: <1579787449-27599-53-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
References: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: kXkEFJ6FO-mCEC9FzBN_3A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.120
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

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20200110153039.1379601-23-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qom/object_interfaces.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index 46cd6ea..edb4cc4 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -185,6 +185,7 @@ bool user_creatable_print_help(const char *type, QemuOp=
ts *opts)
         object_class_property_iter_init(&iter, klass);
         while ((prop =3D object_property_iter_next(&iter))) {
             GString *str;
+            char *defval;
=20
             if (!prop->set) {
                 continue;
@@ -192,6 +193,11 @@ bool user_creatable_print_help(const char *type, QemuO=
pts *opts)
=20
             str =3D g_string_new(NULL);
             g_string_append_printf(str, "  %s=3D<%s>", prop->name, prop->t=
ype);
+            defval =3D object_property_get_default(prop);
+            if (defval) {
+                g_string_append_printf(str, " (default: %s)", defval);
+                g_free(defval);
+            }
             if (prop->description) {
                 if (str->len < 24) {
                     g_string_append_printf(str, "%*s", 24 - (int)str->len,=
 "");
--=20
1.8.3.1



