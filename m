Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F111C47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:52:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDFAA206A5
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G5zgwBnW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDFAA206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVy0C-0007oQ-0v
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 09:52:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51464)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jVxxz-0004G2-IQ
 for qemu-devel@nongnu.org; Tue, 05 May 2020 09:50:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58801
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jVxxy-0002jB-IP
 for qemu-devel@nongnu.org; Tue, 05 May 2020 09:50:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588686633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hv2XPVgR5bcCP2jOSsAKNHO0+sgNNB4i7e2WRC6VVUw=;
 b=G5zgwBnWGNPHjAjPpMgjJvUFpLrvAIBiIS1+IDvbL/MzX/9mTQRmQ9674Cwhq5iZbdESR0
 oHH9UkCe4zd7bMs8vk+HNP1lwqTAF8M49LIVa4F6aC6Myl9Q+8XFym/bt5dcPUfqC4uF/B
 LDUCWrIGzsNvwBGQjCrKDq8hpL26UGc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-lOHxZUf7MHyOD3rRDxI0IA-1; Tue, 05 May 2020 09:50:32 -0400
X-MC-Unique: lOHxZUf7MHyOD3rRDxI0IA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 85A3E1005510;
 Tue,  5 May 2020 13:50:31 +0000 (UTC)
Received: from localhost (ovpn-112-219.ams2.redhat.com [10.36.112.219])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 29FF263F96;
 Tue,  5 May 2020 13:50:31 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: qemu-s390x@nongnu.org
Subject: [PATCH 1/3] docs/s390x: document the virtual css
Date: Tue,  5 May 2020 15:50:23 +0200
Message-Id: <20200505135025.14614-2-cohuck@redhat.com>
In-Reply-To: <20200505135025.14614-1-cohuck@redhat.com>
References: <20200505135025.14614-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 03:48:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add some hints about "devno" rules.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 docs/system/s390x/css.rst    | 64 ++++++++++++++++++++++++++++++++++++
 docs/system/target-s390x.rst |  1 +
 2 files changed, 65 insertions(+)
 create mode 100644 docs/system/s390x/css.rst

diff --git a/docs/system/s390x/css.rst b/docs/system/s390x/css.rst
new file mode 100644
index 000000000000..8e18194a2f0a
--- /dev/null
+++ b/docs/system/s390x/css.rst
@@ -0,0 +1,64 @@
+The virtual channel subsystem
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
+
+QEMU implements a virtual channel subsystem with subchannels, (mostly
+functionless) channel paths, and channel devices (virtio-ccw, 3270, and
+devices passed via vfio-ccw). It supports multiple subchannel sets (MSS) a=
nd
+multiple channel subsystems extended (MCSS-E).
+
+All channel devices support the ``devno`` property, which takes a paramete=
r
+in the form ``<cssid>.<ssid>.<device number>``.
+
+The default channel subsystem image id (``<cssid>``) is ``0xfe``. Devices =
in
+there will show up in channel subsystem image ``0`` to guests that do not
+enable MCSS-E. Note that devices with a different cssid will not be visibl=
e
+if the guest OS does not enable MCSS-E (which is true of all supported gue=
st
+operating systems today).
+
+Supported values for the subchannel set id (``<ssid>``) range from ``0-3``=
.
+Devices with a ssid that is not ``0`` will not be visible if the guest OS
+does not enable MSS (any Linux version that supports virtio also enables M=
SS).
+Any device may be put into any subchannel set, there is no restriction by
+device type.
+
+The device number can range from ``0-0xffff``.
+
+If the ``devno`` property is not specified for a device, QEMU will choose =
the
+next free device number in subchannel set 0, skipping to the next subchann=
el
+set if no more device numbers are free.
+
+QEMU places a device at the first free subchannel in the specified subchan=
nel
+set. If a device is hotunplugged and later replugged, it may appear at a
+different subchannel. (This is similar to how z/VM works.)
+
+
+Examples
+--------
+
+* a virtio-net device, cssid/ssid/devno automatically assigned::
+
+    -device virtio-net-ccw
+
+  In a Linux guest (without default devices and no other devices specified
+  prior to this one), this will show up as ``0.0.0000`` under subchannel
+  ``0.0.0000``.
+
+* a virtio-rng device in subchannel set ``0``::
+
+    -device virtio-rng-ccw,devno=3Dfe.0.0042
+
+  If added to the same Linux guest as above, it would show up as ``0.0.004=
2``
+  under subchannel ``0.0.0001``.
+
+* a virtio-gpu device in subchannel set ``2``::
+
+    -device virtio-gpu-ccw,devno=3Dfe.2.1111
+
+  If added to the same Linux guest as above, it would show up as ``0.2.111=
1``
+  under subchannel ``0.2.0000``.
+
+* a virtio-mouse device in a non-standard channel subsystem::
+
+    -device virtio-mouse-ccw,devno=3D2.0.2222
+
+  This would not show up in a standard Linux guest.
diff --git a/docs/system/target-s390x.rst b/docs/system/target-s390x.rst
index 7d76ae97b401..37ca032d98ef 100644
--- a/docs/system/target-s390x.rst
+++ b/docs/system/target-s390x.rst
@@ -23,6 +23,7 @@ or vfio-ap is also available.
=20
 .. toctree::
    s390x/vfio-ap
+   s390x/css
=20
 Architectural features
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--=20
2.21.3


