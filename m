Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93033C3F68F
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 12:27:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62D16206D4
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 12:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bwawL77E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62D16206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw3Uh-000473-Jv
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 07:27:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35468)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iw3OD-0000jM-Vp
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 07:21:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iw3OC-0006wR-Ir
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 07:21:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51732
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iw3OC-0006wI-GU
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 07:21:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580127672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CGluW5iqejwG7DeKJme/BLxyORrWws2kTLRoEn1h2m8=;
 b=bwawL77Euj3vsue9e+wV+hfwPh/W0o70MURqEfb+qi5Lhy3ahWPhw0IVhK3a91hYMy3JnK
 leC5SQd/sxELrTyqXcUIJ3BGjEHg5NjDJy7GaJsZI2RmDQUjoocTt+PdE2lFt3T1n1izTn
 n/2zb8X32Yy3MV3ijX7k3vw3RBnDxbg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119-H7m74h8tM6O3hkBp4JT3AA-1; Mon, 27 Jan 2020 07:21:08 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D5441005514;
 Mon, 27 Jan 2020 12:21:07 +0000 (UTC)
Received: from localhost (ovpn-116-220.ams2.redhat.com [10.36.116.220])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 61BC785735;
 Mon, 27 Jan 2020 12:21:04 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 14/15] hw/s390x: Add a more verbose comment about
 get_machine_class() and the wrappers
Date: Mon, 27 Jan 2020 13:20:15 +0100
Message-Id: <20200127122016.18752-15-cohuck@redhat.com>
In-Reply-To: <20200127122016.18752-1-cohuck@redhat.com>
References: <20200127122016.18752-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: H7m74h8tM6O3hkBp4JT3AA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

While working on the "Enable adapter interruption suppression again"
recently, I had to discover that the meaning of get_machine_class()
and the related *_allowed() wrappers is not very obvious. Add a more
verbose comment here to clarify how these should be used.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20200123170256.12386-1-thuth@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index e0e28139a263..e759eb5f83cf 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -505,6 +505,19 @@ static inline void machine_set_dea_key_wrap(Object *ob=
j, bool value,
=20
 static S390CcwMachineClass *current_mc;
=20
+/*
+ * Get the class of the s390-ccw-virtio machine that is currently in use.
+ * Note: libvirt is using the "none" machine to probe for the features of =
the
+ * host CPU, so in case this is called with the "none" machine, the functi=
on
+ * returns the TYPE_S390_CCW_MACHINE base class. In this base class, all t=
he
+ * various "*_allowed" variables are enabled, so that the *_allowed() wrap=
pers
+ * below return the correct default value for the "none" machine.
+ *
+ * Attention! Do *not* add additional new wrappers for CPU features (e.g. =
like
+ * the ri_allowed() wrapper) via this mechanism anymore. CPU features shou=
ld
+ * be handled via the CPU models, i.e. checking with cpu_model_allowed() d=
uring
+ * CPU initialization and s390_has_feat() later should be sufficient.
+ */
 static S390CcwMachineClass *get_machine_class(void)
 {
     if (unlikely(!current_mc)) {
@@ -521,19 +534,16 @@ static S390CcwMachineClass *get_machine_class(void)
=20
 bool ri_allowed(void)
 {
-    /* for "none" machine this results in true */
     return get_machine_class()->ri_allowed;
 }
=20
 bool cpu_model_allowed(void)
 {
-    /* for "none" machine this results in true */
     return get_machine_class()->cpu_model_allowed;
 }
=20
 bool hpage_1m_allowed(void)
 {
-    /* for "none" machine this results in true */
     return get_machine_class()->hpage_1m_allowed;
 }
=20
--=20
2.21.1


