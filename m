Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE7FCA9EA1
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 10:00:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61101222BD
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 10:00:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61101222BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLP3M-0006nI-I7
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 06:00:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50793)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hhan@redhat.com>) id 1iLP2Q-0006He-BY
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 05:59:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hhan@redhat.com>) id 1iLP2N-0001Jw-Dl
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 05:59:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:29836)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <hhan@redhat.com>) id 1iLP2N-0001JT-8S
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 05:59:11 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AC0943001FEB
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 09:59:08 +0000 (UTC)
Received: from hansolo.pek2.redhat.com (wlc-trust-29.pek2.redhat.com
 [10.72.3.29])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1F7CA5D9CA;
 Fri, 18 Oct 2019 09:59:06 +0000 (UTC)
From: Han Han <hhan@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] qemu-img.texi: Describe data_file and data_file_raw
Date: Fri, 18 Oct 2019 17:59:24 +0800
Message-Id: <20191018095924.4409-1-hhan@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Fri, 18 Oct 2019 09:59:08 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Han Han <hhan@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

https://bugzilla.redhat.com/show_bug.cgi?id=3D1763105

Signed-off-by: Han Han <hhan@redhat.com>
---
 qemu-img.texi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/qemu-img.texi b/qemu-img.texi
index b5156d6316..44596c2d93 100644
--- a/qemu-img.texi
+++ b/qemu-img.texi
@@ -763,6 +763,16 @@ file which is COW and has data blocks already, it co=
uldn't be changed to NOCOW
 by setting @code{nocow=3Don}. One can issue @code{lsattr filename} to ch=
eck if
 the NOCOW flag is set or not (Capital 'C' is NOCOW flag).
=20
+@item data_file
+File name of data file that is stored in the image and used as a default=
 for
+opening the image. If the option is used, qcow2 file only stores the met=
adata
+of the image.
+
+@item data_file_raw
+This option requires @option{data_file}. If this option is set to @code{=
on},
+qemu will always keep the external data file consistent as a standalone
+read-only raw image. Default value is @code{off}.
+
 @end table
=20
 @item Other
--=20
2.20.1


