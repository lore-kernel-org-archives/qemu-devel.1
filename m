Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BCDC3403B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 14:14:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36F5D21D56
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 14:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K6daM5Wg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36F5D21D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j43eM-0005L6-C6
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 09:14:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52933)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j43Xq-0007AS-CL
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:08:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j43Xp-0001Up-6o
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:08:14 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40460
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j43Xp-0001Uf-2b
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:08:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582034892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=msAvC+41r2UmZVKXxbjfQjZ0Cbz3+CbvBo6GFcYto0Q=;
 b=K6daM5Wgl68pyd9nEmSuci9eqxHzclgo5rhkH9A8yvfqR5c5MG0wN12CxdJMUlrt+/i8zn
 uICpQh2If4htww9nN8f5X0V44iGUkerqsKevcllIicQRB2WQvI7Th8/x9DY/EG4OJ8jIV4
 5lioupgsiRCKxwJ7goFA0Bw6Dy7KG70=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-Wn_K2gHVNkiYXKyF-AJIrg-1; Tue, 18 Feb 2020 09:08:06 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 445D11034B22;
 Tue, 18 Feb 2020 14:08:05 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-181.ams2.redhat.com
 [10.36.117.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3C4758B549;
 Tue, 18 Feb 2020 14:08:04 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 10/36] commit: Remove unused bytes_written
Date: Tue, 18 Feb 2020 15:06:56 +0100
Message-Id: <20200218140722.23876-11-kwolf@redhat.com>
In-Reply-To: <20200218140722.23876-1-kwolf@redhat.com>
References: <20200218140722.23876-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: Wn_K2gHVNkiYXKyF-AJIrg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

The bytes_written variable is only ever written to, it serves no
purpose. This has actually been the case since the commit job was first
introduced in commit 747ff602636.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20200214200812.28180-3-kwolf@redhat.com>
Reviewed-by: J=C3=A1n Tomko <jtomko@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/commit.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/block/commit.c b/block/commit.c
index 23c90b3b91..cce898a4f3 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -140,7 +140,6 @@ static int coroutine_fn commit_run(Job *job, Error **er=
rp)
     int ret =3D 0;
     int64_t n =3D 0; /* bytes */
     void *buf =3D NULL;
-    int bytes_written =3D 0;
     int64_t len, base_len;
=20
     ret =3D len =3D blk_getlength(s->top);
@@ -180,7 +179,6 @@ static int coroutine_fn commit_run(Job *job, Error **er=
rp)
         trace_commit_one_iteration(s, offset, n, ret);
         if (copy) {
             ret =3D commit_populate(s->top, s->base, offset, n, buf);
-            bytes_written +=3D n;
         }
         if (ret < 0) {
             BlockErrorAction action =3D
--=20
2.20.1


