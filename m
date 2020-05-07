Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC34C38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 17:04:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84454207DD
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 17:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LzBK97jN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84454207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWjws-0006Um-Ls
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 13:04:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jWjuy-0004j9-ET
 for qemu-devel@nongnu.org; Thu, 07 May 2020 13:02:40 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59505
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jWjut-0001a9-0G
 for qemu-devel@nongnu.org; Thu, 07 May 2020 13:02:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588870953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0FeS7J+dpo8/xTc7woyCEyx39nSoYsRltfEaVs0z5v8=;
 b=LzBK97jNLeIm10tV3QH3BqTT2byDXa9ZNgJMZXAs9UCMjn+ZvXW0fFUTXK/LAe2tgZ+2kh
 w4uxAvZ/CYK339PSNZu41F9CliMj2XKaC4TMwfSBo+8Bheh+ZW528u5kanqS99r/LDGnDc
 HCrAO567WUsoHVG08f4XHd+rz/uF+n0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-QFl6ERcpMMqe1f9ATrMF5w-1; Thu, 07 May 2020 13:02:26 -0400
X-MC-Unique: QFl6ERcpMMqe1f9ATrMF5w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 338231009445;
 Thu,  7 May 2020 17:02:25 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-114-224.ams2.redhat.com
 [10.36.114.224])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2AF46100EBA4;
 Thu,  7 May 2020 17:02:22 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, david@redhat.com, zhukeqian1@huawei.com,
 maozhongyi@cmss.chinamobile.com, marcandre.lureau@redhat.com,
 pannengyuan@huawei.com, f4bug@amsat.org, wei.w.wang@intel.com,
 yi.y.sun@intel.com, quintela@redhat.com
Subject: [PULL 01/12] migration: fix bad indentation in error_report()
Date: Thu,  7 May 2020 18:02:00 +0100
Message-Id: <20200507170211.238283-2-dgilbert@redhat.com>
In-Reply-To: <20200507170211.238283-1-dgilbert@redhat.com>
References: <20200507170211.238283-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 00:55:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_HK_NAME_DR=0.01, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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

From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>

bad indentation conflicts with CODING_STYLE doc.

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Message-Id: <09f7529c665cac0c6a5e032ac6fdb6ca701f7e37.1585329482.git.maozho=
ngyi@cmss.chinamobile.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/migration.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 177cce9e95..8f27174ff6 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2494,7 +2494,7 @@ retry:
         if (header_type >=3D MIG_RP_MSG_MAX ||
             header_type =3D=3D MIG_RP_MSG_INVALID) {
             error_report("RP: Received invalid message 0x%04x length 0x%04=
x",
-                    header_type, header_len);
+                         header_type, header_len);
             mark_source_rp_bad(ms);
             goto out;
         }
@@ -2503,9 +2503,9 @@ retry:
             header_len !=3D rp_cmd_args[header_type].len) ||
             header_len > sizeof(buf)) {
             error_report("RP: Received '%s' message (0x%04x) with"
-                    "incorrect length %d expecting %zu",
-                    rp_cmd_args[header_type].name, header_type, header_len=
,
-                    (size_t)rp_cmd_args[header_type].len);
+                         "incorrect length %d expecting %zu",
+                         rp_cmd_args[header_type].name, header_type, heade=
r_len,
+                         (size_t)rp_cmd_args[header_type].len);
             mark_source_rp_bad(ms);
             goto out;
         }
@@ -2560,7 +2560,7 @@ retry:
             }
             if (header_len !=3D expected_len) {
                 error_report("RP: Req_Page_id with length %d expecting %zd=
",
-                        header_len, expected_len);
+                             header_len, expected_len);
                 mark_source_rp_bad(ms);
                 goto out;
             }
--=20
2.26.2


