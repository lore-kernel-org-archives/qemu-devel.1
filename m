Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0790C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 16:42:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 617A72076A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 16:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gBNGAwzF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 617A72076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXS2z-0002RZ-A2
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 12:42:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kXRzK-0006us-4t
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 12:38:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47888)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kXRzH-0002Ym-5R
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 12:38:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603816698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VnG/4QQfytZ7hL6P3lJ2TvFZAR/U24GCrYSnTXJwSr8=;
 b=gBNGAwzFrni8RSsCM4PlNa4EmyVmYK4hRLdPXc02NgncOjYh1tYhNqnBb9S/KUpT6PwOGu
 rhuVKkeBBCtaiIv672DEr0QeMdWOFAkXWkn/DiAp2g3UGqLPK2YD4M23GfHrcWD9dtvm4o
 qbAVuKEWTWBC3DTTOo80BCAojL/znxo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-_w7K46SBN4OggEJNzfmBuA-1; Tue, 27 Oct 2020 12:38:15 -0400
X-MC-Unique: _w7K46SBN4OggEJNzfmBuA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51E5F101F753;
 Tue, 27 Oct 2020 16:38:14 +0000 (UTC)
Received: from merkur.redhat.com (ovpn-114-16.ams2.redhat.com [10.36.114.16])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0E17210013C0;
 Tue, 27 Oct 2020 16:38:10 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 2/3] iotests: Disable unsubscriptable-object in pylint
Date: Tue, 27 Oct 2020 17:38:05 +0100
Message-Id: <20201027163806.290960-3-kwolf@redhat.com>
In-Reply-To: <20201027163806.290960-1-kwolf@redhat.com>
References: <20201027163806.290960-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When run with Python 3.9, pylint incorrectly warns about things like
Optional[foo] because it doesn't recognise Optional as unsubscriptable.
This is a known pylint bug:

    https://github.com/PyCQA/pylint/issues/3882

Just disable this check to get rid of the warnings.

Disabling this shouldn't make us miss any real bug because mypy also
has a similar check ("... is not indexable").

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/pylintrc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/qemu-iotests/pylintrc b/tests/qemu-iotests/pylintrc
index 5481afe528..cd3702e23c 100644
--- a/tests/qemu-iotests/pylintrc
+++ b/tests/qemu-iotests/pylintrc
@@ -17,6 +17,8 @@ disable=invalid-name,
         too-many-lines,
         too-many-locals,
         too-many-public-methods,
+        # pylint warns about Optional[] etc. as unsubscriptable in 3.9
+        unsubscriptable-object,
         # These are temporary, and should be removed:
         missing-docstring,
 
-- 
2.28.0


