Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56224C4646B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 07:52:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31541205ED
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 07:52:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31541205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg2jY-000586-G0
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 03:52:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36846)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@redhat.com>) id 1hg2fz-00006I-Q8
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 03:49:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1hg2fy-00057c-NT
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 03:49:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57172)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1hg2fy-000576-Hk
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 03:49:06 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A65D930821F4;
 Wed, 26 Jun 2019 07:49:05 +0000 (UTC)
Received: from localhost (ovpn-116-164.ams2.redhat.com [10.36.116.164])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1FD7B1001B10;
 Wed, 26 Jun 2019 07:49:03 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 26 Jun 2019 08:48:15 +0100
Message-Id: <20190626074815.19994-5-stefanha@redhat.com>
In-Reply-To: <20190626074815.19994-1-stefanha@redhat.com>
References: <20190626074815.19994-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Wed, 26 Jun 2019 07:49:05 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 4/4] docs: avoid vhost-user-net specifics in
 multiqueue section
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Sebastien Boeuf <sebastien.boeuf@intel.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The "Multiple queue support" section makes references to vhost-user-net
"queue pairs".  This is confusing for two reasons:
1. This actually applies to all device types, not just vhost-user-net.
2. VHOST_USER_GET_QUEUE_NUM returns the number of virtqueues, not the
   number of queue pairs.

Reword the section so that the vhost-user-net specific part is relegated
to the very end: we acknowledge that vhost-user-net historically
automatically enabled the first queue pair.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 docs/interop/vhost-user.rst | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index dc0ff9211f..5750668aba 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -324,19 +324,20 @@ must support changing some configuration aspects on=
 the fly.
 Multiple queue support
 ----------------------
=20
-Multiple queue is treated as a protocol extension, hence the slave has
-to implement protocol features first. The multiple queues feature is
-supported only when the protocol feature ``VHOST_USER_PROTOCOL_F_MQ``
-(bit 0) is set.
+Multiple queue support allows the slave to advertise the maximum number =
of
+queues.  This is treated as a protocol extension, hence the slave has to
+implement protocol features first. The multiple queues feature is suppor=
ted
+only when the protocol feature ``VHOST_USER_PROTOCOL_F_MQ`` (bit 0) is s=
et.
=20
-The max number of queue pairs the slave supports can be queried with
-message ``VHOST_USER_GET_QUEUE_NUM``. Master should stop when the
-number of requested queues is bigger than that.
+The max number of queues the slave supports can be queried with message
+``VHOST_USER_GET_QUEUE_NUM``. Master should stop when the number of requ=
ested
+queues is bigger than that.
=20
 As all queues share one connection, the master uses a unique index for e=
ach
-queue in the sent message to identify a specified queue. One queue pair
-is enabled initially. More queues are enabled dynamically, by sending
-message ``VHOST_USER_SET_VRING_ENABLE``.
+queue in the sent message to identify a specified queue.
+
+The master enables queues by sending message ``VHOST_USER_SET_VRING_ENAB=
LE``.
+vhost-user-net has historically automatically enabled the first queue pa=
ir.
=20
 Migration
 ---------
--=20
2.21.0


