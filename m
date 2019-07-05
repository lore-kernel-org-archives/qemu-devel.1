Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C777C4649B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 15:29:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FC6421721
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 15:29:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FC6421721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjQ9j-0004RB-UI
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 11:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33340)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hjQ8Z-0003qr-P1
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 11:28:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hjQ8V-0001Nz-RP
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 11:28:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:27524)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hjQ8O-0000EP-FM; Fri, 05 Jul 2019 11:28:24 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B1125330265;
 Fri,  5 Jul 2019 15:28:18 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-152.phx2.redhat.com [10.3.116.152])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3B21A80A33;
 Fri,  5 Jul 2019 15:28:18 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  5 Jul 2019 10:28:12 -0500
Message-Id: <20190705152812.26438-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Fri, 05 Jul 2019 15:28:18 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH for-4.1] qcow2: Allow -o compat=v3 during
 qemu-img amend
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
Cc: Kevin Wolf <kwolf@redhat.com>, "open list:qcow2" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit b76b4f60 allowed '-o compat=3Dv3' as an alias for the
less-appealing '-o compat=3D1.1' for 'qemu-img create' since we want to
use the QMP form as much as possible, but forgot to do likewise for
qemu-img amend.  Also, it doesn't help that '-o help' doesn't list our
new preferred spellings.

Signed-off-by: Eric Blake <eblake@redhat.com>
---

I'm arguing that the lack of consistency is a bug, even though the bug
has been present since 2.12.

 block/qcow2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 2a59eb27febb..039bdc2f7e79 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4823,9 +4823,9 @@ static int qcow2_amend_options(BlockDriverState *bs=
, QemuOpts *opts,
             compat =3D qemu_opt_get(opts, BLOCK_OPT_COMPAT_LEVEL);
             if (!compat) {
                 /* preserve default */
-            } else if (!strcmp(compat, "0.10")) {
+            } else if (!strcmp(compat, "0.10") || !strcmp(compat, "v2"))=
 {
                 new_version =3D 2;
-            } else if (!strcmp(compat, "1.1")) {
+            } else if (!strcmp(compat, "1.1") || !strcmp(compat, "v3")) =
{
                 new_version =3D 3;
             } else {
                 error_setg(errp, "Unknown compatibility level %s", compa=
t);
@@ -5098,7 +5098,7 @@ static QemuOptsList qcow2_create_opts =3D {
         {
             .name =3D BLOCK_OPT_COMPAT_LEVEL,
             .type =3D QEMU_OPT_STRING,
-            .help =3D "Compatibility level (0.10 or 1.1)"
+            .help =3D "Compatibility level (v2 [0.10] or v3 [1.1])"
         },
         {
             .name =3D BLOCK_OPT_BACKING_FILE,
--=20
2.20.1


