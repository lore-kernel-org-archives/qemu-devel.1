Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D595EC3403B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 14:15:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A615021D56
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 14:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jVqq90Tz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A615021D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j43fE-0007JS-RF
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 09:15:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53064)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j43Xx-0007Ue-B6
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:08:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j43Xw-0001ZD-CH
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:08:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57181
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j43Xw-0001Yq-8b
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:08:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582034899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kg/gtVjgasX6YBZQ9tbl6OopJgSdvR3JoyNZ98E49As=;
 b=jVqq90Tzji1DZh5yQK4zCm/1qdNmcfnkseKHU/vRqEzJG1DChKzfR/UNy6zialv3M5Awcj
 /sxmgZjoeuM2x4eWwzqtyps2l8j8xpgMmlxxfsgOIlSmNbjn/eZYmt+4ujnkyvFoaEVfBv
 0R0wPNdLSWtKs7K9jEYZlE0N8v0Ccao=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-BLkpqNSPMPOb0dcaUyp74w-1; Tue, 18 Feb 2020 09:08:14 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 41E6618FE861;
 Tue, 18 Feb 2020 14:08:13 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-181.ams2.redhat.com
 [10.36.117.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 35B1119E9C;
 Tue, 18 Feb 2020 14:08:12 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 16/36] block: Remove superfluous semicolons
Date: Tue, 18 Feb 2020 15:07:02 +0100
Message-Id: <20200218140722.23876-17-kwolf@redhat.com>
In-Reply-To: <20200218140722.23876-1-kwolf@redhat.com>
References: <20200218140722.23876-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: BLkpqNSPMPOb0dcaUyp74w-1
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Fixes: 132ada80c4a
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20200218094402.26625-4-philmd@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block.c b/block.c
index 9c810534d6..9db0b973fe 100644
--- a/block.c
+++ b/block.c
@@ -2435,13 +2435,13 @@ BdrvChild *bdrv_root_attach_child(BlockDriverState =
*child_bs,
     if (bdrv_get_aio_context(child_bs) !=3D ctx) {
         ret =3D bdrv_try_set_aio_context(child_bs, ctx, &local_err);
         if (ret < 0 && child_role->can_set_aio_ctx) {
-            GSList *ignore =3D g_slist_prepend(NULL, child);;
+            GSList *ignore =3D g_slist_prepend(NULL, child);
             ctx =3D bdrv_get_aio_context(child_bs);
             if (child_role->can_set_aio_ctx(child, ctx, &ignore, NULL)) {
                 error_free(local_err);
                 ret =3D 0;
                 g_slist_free(ignore);
-                ignore =3D g_slist_prepend(NULL, child);;
+                ignore =3D g_slist_prepend(NULL, child);
                 child_role->set_aio_ctx(child, ctx, &ignore);
             }
             g_slist_free(ignore);
--=20
2.20.1


