Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF35C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 15:47:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1C0D20663
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 15:47:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1C0D20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiL0b-00039o-S7
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 11:47:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58923)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hiKP8-0008LR-Jr
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:09:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hiKP6-0001h1-Fh
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:09:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52838)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hiKP6-0001gE-99
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:09:08 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9051F8553A;
 Tue,  2 Jul 2019 15:09:07 +0000 (UTC)
Received: from redhat.com (ovpn-124-209.rdu2.redhat.com [10.10.124.209])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 78D9E422C;
 Tue,  2 Jul 2019 15:09:00 +0000 (UTC)
Date: Tue, 2 Jul 2019 11:08:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190626074815.19994-5-stefanha@redhat.com>
References: <20190702150606.24851-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190702150606.24851-1-mst@redhat.com>
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Tue, 02 Jul 2019 15:09:07 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 22/22] docs: avoid vhost-user-net specifics in
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190702150859.vSxqKOTxyoVi3_7xFJ2X_XZVfpICDOikuHp2KCYsu4U@z>

From: Stefan Hajnoczi <stefanha@redhat.com>

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
Message-Id: <20190626074815.19994-5-stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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
MST


