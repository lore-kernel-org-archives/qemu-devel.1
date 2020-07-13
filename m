Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873A9C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 08:33:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 510542067D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 08:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TzCIdzKt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 510542067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jutuG-0004jW-Hw
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 04:33:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1juttW-00045f-Lb
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 04:33:02 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23698
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1juttV-0007cP-26
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 04:33:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594629180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zJhYKEjamMU9hgJe176/XVilKymLzBN28188AxtjLwA=;
 b=TzCIdzKtoP8zdNfBCgVApP576/WExli0Vg0IpQldbqiiK4YhlAyyG64pqIZwpiyRSE11qv
 LayPkF8CGF766GFPzpcmYgHZWkZtMcO6AtoSzGN9+HdHH0zAcvW2cK0sCivdd8NC6oFdVs
 jvdIajbsZezVdNiNGAduuOBGo27d3+4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-VMfDx4pPOF6q8FXV1-yrEQ-1; Mon, 13 Jul 2020 04:32:58 -0400
X-MC-Unique: VMfDx4pPOF6q8FXV1-yrEQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9BE91902EA0;
 Mon, 13 Jul 2020 08:32:57 +0000 (UTC)
Received: from localhost (unknown [10.36.110.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C471F27DE91;
 Mon, 13 Jul 2020 08:32:53 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] slirp: update to v4.3.1
Date: Mon, 13 Jul 2020 12:32:50 +0400
Message-Id: <20200713083250.2955536-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 02:19:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: samuel.thibault@ens-lyon.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Switch from stable-4.2 branch back to master (which is actually
maintained, I think we tend to forget about stable...).

git shortlog 2faae0f7..a62d3673:

5eraph (2):
      disable_dns option
      limit vnameserver_addr to port 53

Akihiro Suda (1):
      libslirp.h: fix SlirpConfig v3 documentation

Jindrich Novy (4):
      Fix possible infinite loops and use-after-free
      Use secure string copy to avoid overflow
      Be sure to initialize sockaddr structure
      Check lseek() for failure

Marc-André Lureau (12):
      Merge branch 'master' into 'master'
      Merge branch 'fix-slirpconfig-3-doc' into 'master'
      Fix use-afte-free in ip_reass() (CVE-2020-1983)
      Update CHANGELOG
      Merge branch 'cve-2020-1983' into 'master'
      Release v4.3.0
      Merge branch 'release-v4.3.0' into 'master'
      changelog: post-release
      util: do not silently truncate
      Merge branch 'slirp-fmt-truncate' into 'master'
      Release v4.3.1
      Merge branch 'release-v4.3.1' into 'master'

Philippe Mathieu-Daudé (3):
      Fix win32 builds by using the SLIRP_PACKED definition
      Fix constness warnings
      Remove unnecessary break

Ralf Haferkamp (2):
      Drop bogus IPv6 messages
      Fix MTU check

Samuel Thibault (1):
      Merge branch 'ip6_payload_len' into 'master'

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 slirp | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/slirp b/slirp
index 2faae0f778f..a62d36734ff 160000
--- a/slirp
+++ b/slirp
@@ -1 +1 @@
-Subproject commit 2faae0f778f818fadc873308f983289df697eb93
+Subproject commit a62d36734ffe9828d0f70df1b3898a3b4fbda755
-- 
2.27.0.221.ga08a83db2b


