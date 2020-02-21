Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA8AC35656
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:40:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8F80208C4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nk29l1AR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8F80208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j58XB-0007Ib-Up
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 08:40:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32903)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1j58JR-0002ml-F0
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:25:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1j58JO-0007Dp-P0
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:25:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36356
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1j58JO-0007CQ-Gw
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:25:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582291545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ou82nfRlLTKFiiP9tvRubo3I4987Bvtv3Cz7XMNiIrg=;
 b=Nk29l1ARcTi18y2/oM6ztUOfVdA40fHOjhoGWU9oesUBwttzrrotsong8VVeHv2zSUUYHu
 Ge1dr6zgE4CRyyHBJVFkx6aI2/wkILJmdlPpVvG8m6yxcsQNSG0kPwVJBe1VM3epL+rlhk
 FKFcgvBWYxbof5ZdKAewfnIB6i3XLw0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-Hx0QJl4DP0KZBPwJI8IjRg-1; Fri, 21 Feb 2020 08:25:42 -0500
X-MC-Unique: Hx0QJl4DP0KZBPwJI8IjRg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2C4CDB23;
 Fri, 21 Feb 2020 13:25:41 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.1])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A9C3A8B745;
 Fri, 21 Feb 2020 13:25:40 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, philmd@redhat.com, yangx.jy@cn.fujitsu.com,
 mrezanin@redhat.com
Subject: [PULL 1/6] virtiofsd: Help message fix for 'seconds'
Date: Fri, 21 Feb 2020 13:25:31 +0000
Message-Id: <20200221132536.38364-2-dgilbert@redhat.com>
In-Reply-To: <20200221132536.38364-1-dgilbert@redhat.com>
References: <20200221132536.38364-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

second should be seconds.

Reported-by: Christophe de Dinechin <dinechin@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
index 0801cf752c..819c2bc13c 100644
--- a/tools/virtiofsd/helper.c
+++ b/tools/virtiofsd/helper.c
@@ -165,7 +165,7 @@ void fuse_cmdline_help(void)
            "                               enable/disable readirplus\n"
            "                               default: readdirplus except wit=
h "
            "cache=3Dnone\n"
-           "    -o timeout=3D<number>        I/O timeout (second)\n"
+           "    -o timeout=3D<number>        I/O timeout (seconds)\n"
            "                               default: depends on cache=3D op=
tion.\n"
            "    -o writeback|no_writeback  enable/disable writeback cache\=
n"
            "                               default: no_writeback\n"
--=20
2.24.1


