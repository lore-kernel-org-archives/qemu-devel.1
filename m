Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746F2C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 23:06:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06E6D221EF
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 23:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gEMDWDbb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06E6D221EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKrN7-0000Vk-6T
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 19:06:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36668)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKrLY-00079o-Jm
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 19:05:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44569)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKrLV-0002qe-Re
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 19:05:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600815912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7XQHco03dbR9d1ERBZrWUOAY8VXih0F6UF1zJPqg++s=;
 b=gEMDWDbbDgfOqlWqHLM3SP6tQw4wgFD6S4HX/ZYGaJ7pOUWUsd9qlJExb3aNwDTdqQdjmO
 qOfiAyKIDVpG2rGRYmSv7LRjuAENBVrU/TNiQ49TCQcdnQcRxBmyfX1sGB3TXW/o1nPHXW
 aabvo0ZSr1C6UVKEH0J3tF0WRMT2hYE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-puKL6D-BO0Gk_rHRbxnRpg-1; Tue, 22 Sep 2020 19:05:08 -0400
X-MC-Unique: puKL6D-BO0Gk_rHRbxnRpg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B99C802B51;
 Tue, 22 Sep 2020 23:05:07 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C89B85DE50;
 Tue, 22 Sep 2020 23:05:06 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/1] MAINTAINERS: Add Python library stanza
Date: Tue, 22 Sep 2020 19:05:05 -0400
Message-Id: <20200922230505.4089701-2-jsnow@redhat.com>
In-Reply-To: <20200922230505.4089701-1-jsnow@redhat.com>
References: <20200922230505.4089701-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 15:47:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: peter.maydell@linaro.org, ehabkost@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 alex.bennee@linaro.org, crosa@redhat.com, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I'm proposing that I split the actual Python library off from the other
miscellaneous python scripts we have and declare it maintained. Add
myself as a maintainer of this folder, along with Cleber.

v2: change python/* to python/, thanks Alex.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Cleber Rosa <crosa@redhat.com>
Acked-by: Eduardo Habkost <ehabkost@redhat.com>
---
 MAINTAINERS | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3d17cad19a..c0222ee645 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2355,11 +2355,18 @@ S: Maintained
 F: include/sysemu/cryptodev*.h
 F: backends/cryptodev*.c
 
+Python library
+M: John Snow <jsnow@redhat.com>
+M: Cleber Rosa <crosa@redhat.com>
+R: Eduardo Habkost <ehabkost@redhat.com>
+S: Maintained
+F: python/
+T: git https://gitlab.com/jsnow/qemu.git python
+
 Python scripts
 M: Eduardo Habkost <ehabkost@redhat.com>
 M: Cleber Rosa <crosa@redhat.com>
 S: Odd fixes
-F: python/qemu/*py
 F: scripts/*.py
 F: tests/*.py
 
-- 
2.26.2


