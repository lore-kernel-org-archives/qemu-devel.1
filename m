Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75AAEC7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 11:59:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51827229ED
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 11:59:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51827229ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqFvW-0000T9-DW
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 07:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36608)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hqFuh-0005YJ-It
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 07:58:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hqFug-0004cw-LE
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 07:58:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49926)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hqFug-0004cX-FD
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 07:58:30 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C7F3533645;
 Wed, 24 Jul 2019 11:58:29 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-166.ams2.redhat.com
 [10.36.117.166])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EF62A600D1;
 Wed, 24 Jul 2019 11:58:28 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	pbonzini@redhat.com,
	pavel.dovgaluk@ispras.ru
Date: Wed, 24 Jul 2019 12:58:22 +0100
Message-Id: <20190724115823.4199-4-dgilbert@redhat.com>
In-Reply-To: <20190724115823.4199-1-dgilbert@redhat.com>
References: <20190724115823.4199-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Wed, 24 Jul 2019 11:58:29 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [for 4.2 PATCH v2 3/4] replay: Remove host_clock_last
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Now we're not using the 'last' field in the timer, remove it from
replay.

Bump the version number of the replay structure since we've
removed the field.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 replay/replay-snapshot.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/replay/replay-snapshot.c b/replay/replay-snapshot.c
index 756f48bc02..3a58734b9a 100644
--- a/replay/replay-snapshot.c
+++ b/replay/replay-snapshot.c
@@ -24,7 +24,6 @@ static int replay_pre_save(void *opaque)
 {
     ReplayState *state =3D opaque;
     state->file_offset =3D ftell(replay_file);
-    state->host_clock_last =3D qemu_clock_get_last(QEMU_CLOCK_HOST);
=20
     return 0;
 }
@@ -34,7 +33,6 @@ static int replay_post_load(void *opaque, int version_i=
d)
     ReplayState *state =3D opaque;
     if (replay_mode =3D=3D REPLAY_MODE_PLAY) {
         fseek(replay_file, state->file_offset, SEEK_SET);
-        qemu_clock_set_last(QEMU_CLOCK_HOST, state->host_clock_last);
         /* If this was a vmstate, saved in recording mode,
            we need to initialize replay data fields. */
         replay_fetch_data_kind();
@@ -50,8 +48,8 @@ static int replay_post_load(void *opaque, int version_i=
d)
=20
 static const VMStateDescription vmstate_replay =3D {
     .name =3D "replay",
-    .version_id =3D 1,
-    .minimum_version_id =3D 1,
+    .version_id =3D 2,
+    .minimum_version_id =3D 2,
     .pre_save =3D replay_pre_save,
     .post_load =3D replay_post_load,
     .fields =3D (VMStateField[]) {
@@ -62,7 +60,6 @@ static const VMStateDescription vmstate_replay =3D {
         VMSTATE_UINT32(has_unread_data, ReplayState),
         VMSTATE_UINT64(file_offset, ReplayState),
         VMSTATE_UINT64(block_request_id, ReplayState),
-        VMSTATE_UINT64(host_clock_last, ReplayState),
         VMSTATE_INT32(read_event_kind, ReplayState),
         VMSTATE_UINT64(read_event_id, ReplayState),
         VMSTATE_INT32(read_event_checkpoint, ReplayState),
--=20
2.21.0


