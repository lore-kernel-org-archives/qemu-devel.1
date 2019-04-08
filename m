Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F65EC10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 19:07:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7E4820863
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 19:07:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7E4820863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57570 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDZc9-0004sG-3Y
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 15:07:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hDZXh-0001kA-Vk
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 15:02:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hDZXe-0007HN-DL
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 15:02:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57858)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hDZXT-0007C2-MW; Mon, 08 Apr 2019 15:02:39 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0346A8AE41;
	Mon,  8 Apr 2019 19:02:38 +0000 (UTC)
Received: from blue.redhat.com (ovpn-117-110.phx2.redhat.com [10.3.117.110])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 95FAC60C70;
	Mon,  8 Apr 2019 19:02:37 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  8 Apr 2019 14:02:33 -0500
Message-Id: <20190408190233.10321-5-eblake@redhat.com>
In-Reply-To: <20190408190233.10321-1-eblake@redhat.com>
References: <20190408190233.10321-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Mon, 08 Apr 2019 19:02:38 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 4/4] nbd/client: Fix error message for server
 with unusable sizing
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
Cc: Kevin Wolf <kwolf@redhat.com>,
	"open list:Network Block Dev..." <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190408190233.dHjtvZNRt93gd7_9EY2Ar6YKfjf8uWx4mmua2K9namk@z>

Add a missing space to the error message used when giving up on a
server that insists on an alignment which renders the last few bytes
of the export unreadable.

Fixes: 3add3ab78
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20190404145226.32649-1-eblake@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 nbd/client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nbd/client.c b/nbd/client.c
index 427980bdd22..4de30630c73 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -428,7 +428,7 @@ static int nbd_opt_info_or_go(QIOChannel *ioc, uint32=
_t opt,
             }
             if (info->min_block &&
                 !QEMU_IS_ALIGNED(info->size, info->min_block)) {
-                error_setg(errp, "export size %" PRIu64 "is not multiple=
 of "
+                error_setg(errp, "export size %" PRIu64 " is not multipl=
e of "
                            "minimum block size %" PRIu32, info->size,
                            info->min_block);
                 nbd_send_opt_abort(ioc);
--=20
2.20.1


