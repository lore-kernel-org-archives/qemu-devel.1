Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2704BC4332B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 22:24:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D00892076C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 22:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ahcdq7xW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D00892076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEh6o-0002sE-T1
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 18:24:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35389)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jEh5N-0002NA-7f
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 18:22:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jEh5L-0007ot-Up
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 18:22:48 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:60562)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jEh5L-0007jJ-Q3
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 18:22:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584570165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=IleK/yNW4pkfiWy8U9Z+21DMP5F9ievVLSZTVwIzUvI=;
 b=ahcdq7xW0zN3+hDB1rMxh25/4WzZDfvQQSvO/54DZOu81kFhh904OsVFrdnu+s9SL0KvCM
 W0ghi9Fw1ZKUawmXlA9W46rQbOO+OC3yWiXPVjgPV0ZOM+f3jQplZJVOOHrgfP8M4Tg6u6
 skJ/zGqRggFiyc5eKr/+h5EECcunhwI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-_-UgZG-_Ms--s7YwhYaGdA-1; Wed, 18 Mar 2020 18:22:44 -0400
X-MC-Unique: _-UgZG-_Ms--s7YwhYaGdA-1
Received: by mail-wm1-f71.google.com with SMTP id s20so149148wmj.2
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 15:22:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wTFvmkrYGR3nvc+p1HX4PhBtjC+SXzPdHGKE+XXOjQA=;
 b=CIqjwCdLCqocJfZwos3qgJlrhFGyXSq7VQEejvFD/8CAQs7Ynov2dGQ2wy+Cc1QlSJ
 +g82l4p+WIMBcnGRlq0pqyq0iC8BciM8Qla9hHt9WZHmOs2NzLshk+6dseQ8/SlFKX66
 06IC3IthMdyWmfG/aH8UVI1q4uruTbonO2y+rMKQrWJ3LqltAsHW8TuLklV3RdelYbMA
 nrUm1fX9UTw8AyIVCkQq98U8Qw6myermaP4Bb8S3h7LRzNCg/zo9qEz9c1L4LBeC0sia
 MaSilXzIpSndnuRVPDjXMDb/ORDbfE/LKA5DiucVxZNYnKdtX4AW0ZM9XH7tMILyLAjX
 1Rvg==
X-Gm-Message-State: ANhLgQ3HUyuJS0PcbvXpLSK2skkjYivNI6K/txpxCDeyfzsN2XQVhCpc
 px7WZl5sAPVgQQPJ0SAfl1fLcdTlPOPAm17kjUS2CZ27sx2iTJ7/yxd7BjPE8hJlBUXdwoZPHFf
 Mz917r6qfPIwXcJ0=
X-Received: by 2002:a5d:4681:: with SMTP id u1mr128508wrq.62.1584570162700;
 Wed, 18 Mar 2020 15:22:42 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vv+p8ox9R1NYWQrrTyjFFCa5YCTA3ufyA1Wci2u2mCZ1i3c+cqYCnNWzjVxEVXGGrNAyH2+ow==
X-Received: by 2002:a5d:4681:: with SMTP id u1mr128493wrq.62.1584570162459;
 Wed, 18 Mar 2020 15:22:42 -0700 (PDT)
Received: from localhost.localdomain (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id z6sm268305wrp.95.2020.03.18.15.22.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2020 15:22:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0] block: Assert BlockDriver::format_name is not NULL
Date: Wed, 18 Mar 2020 23:22:35 +0100
Message-Id: <20200318222235.23856-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Mansour Ahmadi <ManSoSec@gmail.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

bdrv_do_find_format() calls strcmp() using BlockDriver::format_name
as argument, which must not be NULL. Assert this field is not null
when we register a block driver in bdrv_register().

Reported-by: Mansour Ahmadi <ManSoSec@gmail.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 block.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block.c b/block.c
index a2542c977b..6b984dc883 100644
--- a/block.c
+++ b/block.c
@@ -363,6 +363,7 @@ char *bdrv_get_full_backing_filename(BlockDriverState *=
bs, Error **errp)
=20
 void bdrv_register(BlockDriver *bdrv)
 {
+    assert(bdrv->format_name);
     QLIST_INSERT_HEAD(&bdrv_drivers, bdrv, list);
 }
=20
--=20
2.21.1


