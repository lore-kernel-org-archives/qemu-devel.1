Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16502C11D3D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 19:10:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8BF724692
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 19:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gm2M8GLM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8BF724692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7OYV-0006Dq-3I
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 14:10:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42242)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7OXh-0005Z8-Rn
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 14:09:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7OXh-0002jS-0Y
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 14:09:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34395
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7OXg-0002jJ-Tk
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 14:09:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582830592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8JrELPM42f56E7q79C9gTRfwQ6hDBnTqR4QEUvYMZ44=;
 b=gm2M8GLMyEj8lcGrWKY8CGlbMkLkUe+atd6OZdVCdBZO8uN6Dy+dnCySsWJE5CARmKfALs
 blKtTNQnQYXhKIrRtFVv7ejTHf0+FMIVwiuEQq9pfgpXQ/VWTlpPmXaBgzTUl2SoAKY9En
 q52WYC45EWVeLMK5QPC9qf+PLM0ZH1c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-G8ooeuq4NraYOrAX4nfEtQ-1; Thu, 27 Feb 2020 14:09:48 -0500
X-MC-Unique: G8ooeuq4NraYOrAX4nfEtQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA8CC800D5A;
 Thu, 27 Feb 2020 19:09:47 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-195.brq.redhat.com [10.40.205.195])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 591A05C54A;
 Thu, 27 Feb 2020 19:09:45 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] qom/object: Comment to use g_slist_free on
 object_class_get_list result
Date: Thu, 27 Feb 2020 20:09:42 +0100
Message-Id: <20200227190942.8834-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org,
 Pan Nengyuan <pannengyuan@huawei.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Document the list returned by object_class_get_list() must be
released with g_slist_free() to avoid memory leaks.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/qom/object.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index 29546496c1..5517b56508 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -984,6 +984,9 @@ void object_class_foreach(void (*fn)(ObjectClass *klass=
, void *opaque),
  * @include_abstract: Whether to include abstract classes.
  *
  * Returns: A singly-linked list of the classes in reverse hashtable order=
.
+ *
+ * The returned list must be released with g_slist_free()
+ * when no longer required.
  */
 GSList *object_class_get_list(const char *implements_type,
                               bool include_abstract);
@@ -995,6 +998,9 @@ GSList *object_class_get_list(const char *implements_ty=
pe,
  *
  * Returns: A singly-linked list of the classes in alphabetical
  * case-insensitive order.
+ *
+ * The returned list must be released with g_slist_free()
+ * when no longer required.
  */
 GSList *object_class_get_list_sorted(const char *implements_type,
                               bool include_abstract);
--=20
2.21.1


