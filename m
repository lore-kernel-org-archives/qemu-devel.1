Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985ADC41514
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 20:52:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65AF620651
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 20:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="JwLaA09N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65AF620651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hy0Fm-0002fE-FW
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 16:52:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37991)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1hy0CZ-00016a-NU
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 16:49:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lukasstraub2@web.de>) id 1hy0CY-0001Av-Jb
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 16:48:59 -0400
Received: from mout.web.de ([212.227.17.11]:33221)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lukasstraub2@web.de>) id 1hy0CY-00017U-An
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 16:48:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1565815723;
 bh=NYGEs+J8dG1k1ZGIA2w7kyoxLQCzkxirRfKD/rQess0=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=JwLaA09NWVkUmUrEaGVVaPSF13A82g1POwUGyC8f+VTAcjd27IxpGTtzaDlKeobJj
 NkGx1viQ7e6p3SZ9jOFE29eV3yr9PTj1//adUKfhvOJkb8EQVjqPugwXvophzVPR9r
 ILM/CMGzUnnjPUI/ffrRJr+Rh8SdGN69Axtg0nGQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([87.123.206.175]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MT8o6-1hoYHc3K0k-00S41t; Wed, 14
 Aug 2019 22:48:42 +0200
Date: Wed, 14 Aug 2019 22:47:17 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: "Zhang, Chen" <chen.zhang@intel.com>
Message-ID: <1e29ed41743ddf581636ccee0e899c0f3f4680b7.1565814686.git.lukasstraub2@web.de>
In-Reply-To: <cover.1565814686.git.lukasstraub2@web.de>
References: <cover.1565814686.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pqV6qcrevMy+2gvPNMCF/JfEBY+yHtBWer17I1UXxJ10p1tsXrq
 CqD/GJ+ufVnihK8XgtdUcUVBi9ZWfn1YStGVnG5ScIibvJ9cETNkOp4ShM4K/q1Id0Wiw7N
 lrUAZ9kQRHNk+CLFrLoNom8T7P1/drpUPlSXxu2Z4fsMCukWoxdc5lamb2b8nJiTJFpQwKl
 qBDvk/OcXLQryV041+V9w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mM1a7lEkimw=:csnNyDNmmXEQgA2s3Ij+1s
 5Cw8/cZdRVe6BJ+6STa07bSyT8BWenT8I3IhfWrP3hDbbIqE40+17NPyv8g01w5eN4KbgOqJx
 3jJnDuZooi4R8edT7GABbZ6e4GuTqB22qaFDDhwUn/+tFZGtC1eHP7CjHKv4ncbw0fVu0pdjB
 g965im6WnbfF48QFyjtnpYeNQ1fDM5qFbeJ/A2E6YdT1yJMCUqszw/zeb2lnsE2buwy/A6UiT
 ly0eML7ngWzwP/A7GY8IjJ1n+uk41ZXzFZGGBBV66lT2G+zY9bH+Ud7T5+SYRGhAUSRc8+bxA
 WkOoSbjVUapxzk/Di0zP9H5A58BpwVOiyo3rIoIdFViMKD9gfHQTc7YkEmrTR6x7tVuWIMDDM
 2m4D5SsECXhYpDodPJmSlQ+t0AeH24gMGG+aHGoCECY35lhUN4zN6CewJ/rd8SAIZUwZwtxm/
 v6cMpFHXQpjqHdy2nfmLSYu8Tja9vsZQYwCgnSl52O2Uz4il4LLPqWPkRH1CQ4wg4+yBRLNMq
 7R7f49INqjW/CHPaxGhZATCsbht24AbbDty6GKc6eWOkKGbnubNv5UO7G8+Vgx8M4q+bp4iUW
 Hdx/ND02TKsv7bN/0sYz8P0oT3I0TM96HDY4TBpFeah2UClKNwIvRlBvN3KxH4OP+EpmdX/KW
 HIBv/+yh6EGBqD+35d/QgDwrWz/hx4rx4HusmczxY2kBuIiz+3Nt/jT2XFSVEDvhQfalSnvvQ
 dBECAiA4jtPto2AyoEYBLqqTu+o+Qei/9f6mqEjvJTd56KbsnriMlurgdgl35HeisOMLRhO5R
 e6MX+aPGeH0LoSAOkRnHI6TA9Q/F1xS8H10KYrOqIsJ98O194cUXoNvac5jIU2+qgSt43YLQo
 Nmfq7vJIqmrHziPlAfADI3SXCEse4MgjnWgYB0hvr9OLsFsLrOwq55WyjQW+e6x7cO0xBrOaW
 TP5qa6zMmH6x3ejCZmPXXShT2KEoMByJlmj3TIybm9+Fu6PlS+MAISfj6XTW5dY0MwXb9bWhu
 s+QovgOM9mBa4y9JUB1xdWBC5hjf0vc4HZ0K2IxCPCxFOUYPDgyrHeWNGMCOlz5QPwF9wVBIk
 WX/ABqiYNxHWCOZk9QR+oeT8m48qPqT5gehQIhjb31Jf2UXT76MM1vcJuD9Lq7lO0T8oheuKU
 p3qN7Chd0ERtldw21s8eNk7AT9v0W1gG9kriE69Xt1NX34fg==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.11
Subject: [Qemu-devel] [PATCH 1/3] Replication: Ignore requests after failover
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

After failover, the Secondary side of replication shouldn't change state.
Add the necessary checks to ignore requests after failover.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 block/replication.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/block/replication.c b/block/replication.c
index 3d4dedddfc..466d463963 100644
=2D-- a/block/replication.c
+++ b/block/replication.c
@@ -454,6 +454,14 @@ static void replication_start(ReplicationState *rs, R=
eplicationMode mode,
     aio_context_acquire(aio_context);
     s =3D bs->opaque;

+    if (s->stage =3D=3D BLOCK_REPLICATION_DONE || s->stage =3D=3D BLOCK_R=
EPLICATION_FAILOVER) {
+        /* This case happens when a secondary is promoted to primary.
+         * Ignore the request because the secondary side of replication
+         * doesn't have to do anything anymore. */
+        aio_context_release(aio_context);
+        return;
+    }
+
     if (s->stage !=3D BLOCK_REPLICATION_NONE) {
         error_setg(errp, "Block replication is running or done");
         aio_context_release(aio_context);
@@ -529,8 +537,7 @@ static void replication_start(ReplicationState *rs, Re=
plicationMode mode,
                    "Block device is in use by internal backup job");

         top_bs =3D bdrv_lookup_bs(s->top_id, s->top_id, NULL);
-        if (!top_bs || !bdrv_is_root_node(top_bs) ||
-            !check_top_bs(top_bs, bs)) {
+        if (!top_bs || !check_top_bs(top_bs, bs)) {
             error_setg(errp, "No top_bs or it is invalid");
             reopen_backing_file(bs, false, NULL);
             aio_context_release(aio_context);
@@ -577,6 +584,14 @@ static void replication_do_checkpoint(ReplicationStat=
e *rs, Error **errp)
     aio_context_acquire(aio_context);
     s =3D bs->opaque;

+    if (s->stage =3D=3D BLOCK_REPLICATION_DONE || s->stage =3D=3D BLOCK_R=
EPLICATION_FAILOVER) {
+        /* This case happens when a secondary was promoted to primary.
+         * Ignore the request because the secondary side of replication
+         * doesn't have to do anything anymore. */
+        aio_context_release(aio_context);
+        return;
+    }
+
     if (s->mode =3D=3D REPLICATION_MODE_SECONDARY) {
         secondary_do_checkpoint(s, errp);
     }
@@ -592,8 +607,8 @@ static void replication_get_error(ReplicationState *rs=
, Error **errp)
     aio_context =3D bdrv_get_aio_context(bs);
     aio_context_acquire(aio_context);
     s =3D bs->opaque;
-
-    if (s->stage !=3D BLOCK_REPLICATION_RUNNING) {
+
+    if (s->stage =3D=3D BLOCK_REPLICATION_NONE) {
         error_setg(errp, "Block replication is not running");
         aio_context_release(aio_context);
         return;
@@ -635,6 +650,14 @@ static void replication_stop(ReplicationState *rs, bo=
ol failover, Error **errp)
     aio_context_acquire(aio_context);
     s =3D bs->opaque;

+    if (s->stage =3D=3D BLOCK_REPLICATION_DONE || s->stage =3D=3D BLOCK_R=
EPLICATION_FAILOVER) {
+        /* This case happens when a secondary was promoted to primary.
+         * Ignore the request because the secondary side of replication
+         * doesn't have to do anything anymore. */
+        aio_context_release(aio_context);
+        return;
+    }
+
     if (s->stage !=3D BLOCK_REPLICATION_RUNNING) {
         error_setg(errp, "Block replication is not running");
         aio_context_release(aio_context);
=2D-
2.20.1

