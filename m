Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1466BC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 10:12:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D34262075A
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 10:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K702EMKd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D34262075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeFWJ-0001Nn-VV
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 06:12:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42584)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jeFVI-0007vp-De
 for qemu-devel@nongnu.org; Thu, 28 May 2020 06:11:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56106
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jeFVH-0003Rg-Ji
 for qemu-devel@nongnu.org; Thu, 28 May 2020 06:11:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590660670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gPm5/FMQqnaW8HNt8jo86Olr1SMefReSPK7R+kU8ln0=;
 b=K702EMKdGWiojkRwzfjQ13eWFNxzdc5TIcdFD6TwzzpPvfQ9sv/nebVXUd+ZZ5P15AXGAD
 Q+xtGRpUycH/EBCXhh8JSo/CKRa3U/CKnTH0chNgOite3P7q6v2Soixdn3USLPpRQWDdEh
 UtuQY32KwTZW6Sf7I75qd0o+i0RSRPo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-60_PRLl5OKiXM9z2WekZmA-1; Thu, 28 May 2020 06:11:07 -0400
X-MC-Unique: 60_PRLl5OKiXM9z2WekZmA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2EDD835B40;
 Thu, 28 May 2020 10:11:06 +0000 (UTC)
Received: from thuth.com (ovpn-112-213.ams2.redhat.com [10.36.112.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9D5AA5D9EF;
 Thu, 28 May 2020 10:11:01 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 5/7] gitlab-ci: Move edk2 and opensbi YAML files to
 .gitlab-ci.d folder
Date: Thu, 28 May 2020 12:10:37 +0200
Message-Id: <20200528101039.24600-6-thuth@redhat.com>
In-Reply-To: <20200528101039.24600-1-thuth@redhat.com>
References: <20200528101039.24600-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 01:51:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We have a dedicated folder for the gitlab-ci - so there is no need
to clutter the top directory with these .yml files.

Message-Id: <20200525131823.715-5-thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .gitlab-ci-edk2.yml => .gitlab-ci.d/edk2.yml       | 0
 .gitlab-ci-opensbi.yml => .gitlab-ci.d/opensbi.yml | 0
 .gitlab-ci.yml                                     | 4 ++--
 MAINTAINERS                                        | 2 +-
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename .gitlab-ci-edk2.yml => .gitlab-ci.d/edk2.yml (100%)
 rename .gitlab-ci-opensbi.yml => .gitlab-ci.d/opensbi.yml (100%)

diff --git a/.gitlab-ci-edk2.yml b/.gitlab-ci.d/edk2.yml
similarity index 100%
rename from .gitlab-ci-edk2.yml
rename to .gitlab-ci.d/edk2.yml
diff --git a/.gitlab-ci-opensbi.yml b/.gitlab-ci.d/opensbi.yml
similarity index 100%
rename from .gitlab-ci-opensbi.yml
rename to .gitlab-ci.d/opensbi.yml
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index bc6aee6aba..5208d93ff8 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -1,6 +1,6 @@
 include:
-  - local: '/.gitlab-ci-edk2.yml'
-  - local: '/.gitlab-ci-opensbi.yml'
+  - local: '/.gitlab-ci.d/edk2.yml'
+  - local: '/.gitlab-ci.d/opensbi.yml'
 
 .update_apt_template: &before_script_apt
  before_script:
diff --git a/MAINTAINERS b/MAINTAINERS
index 71a0438843..0944d9c731 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2542,7 +2542,7 @@ F: roms/edk2
 F: roms/edk2-*
 F: tests/data/uefi-boot-images/
 F: tests/uefi-test-tools/
-F: .gitlab-ci-edk2.yml
+F: .gitlab-ci.d/edk2.yml
 F: .gitlab-ci.d/edk2/
 
 Usermode Emulation
-- 
2.18.1


