Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F3DC3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 15:40:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F07E4206C1
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 15:40:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F07E4206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyHs1-0001Ox-Pd
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 11:40:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38951)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1hyHoa-0005SS-Aw
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 11:37:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hyHoV-0000Wy-W3
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 11:37:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56756)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hyHoO-0000UE-4r; Thu, 15 Aug 2019 11:37:12 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 76472302C07A;
 Thu, 15 Aug 2019 15:37:11 +0000 (UTC)
Received: from localhost (ovpn-204-81.brq.redhat.com [10.40.204.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 72DC81797F;
 Thu, 15 Aug 2019 15:37:08 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Thu, 15 Aug 2019 17:36:38 +0200
Message-Id: <20190815153638.4600-8-mreitz@redhat.com>
In-Reply-To: <20190815153638.4600-1-mreitz@redhat.com>
References: <20190815153638.4600-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Thu, 15 Aug 2019 15:37:11 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 7/7] iotests: Disable 126 for flat vmdk
 subformats
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

iotest 126 requires backing file support, which flat vmdks cannot offer.
Skip this test for such subformats.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/126 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/qemu-iotests/126 b/tests/qemu-iotests/126
index 9b0dcf9255..b7fce1e59d 100755
--- a/tests/qemu-iotests/126
+++ b/tests/qemu-iotests/126
@@ -33,6 +33,8 @@ status=3D1	# failure is the default!
=20
 # Needs backing file support
 _supported_fmt qcow qcow2 qed vmdk
+_unsupported_imgopts "subformat=3DmonolithicFlat" \
+                     "subformat=3DtwoGbMaxExtentFlat"
 # This is the default protocol (and we want to test the difference betwe=
en
 # colons which separate a protocol prefix from the rest and colons which=
 are
 # just part of the filename, so we cannot test protocols which require a=
 prefix)
--=20
2.21.0


