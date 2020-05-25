Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9CBC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 13:19:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98FAD2078B
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 13:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WXVg1QOr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98FAD2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdD1C-0005G0-No
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 09:19:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jdD0K-0003k6-Mb
 for qemu-devel@nongnu.org; Mon, 25 May 2020 09:18:56 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26221
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jdD0J-0004C2-VF
 for qemu-devel@nongnu.org; Mon, 25 May 2020 09:18:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590412734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RN0DveABAQP1+ddsrat+De7sL81/he/iYChXXBaORPw=;
 b=WXVg1QOr7BS0rzKZ1E9Fc81w+ZtYJYNtM17DDU64YgoMGadB8fNO8217x/0zWN7ABE79RC
 ZabYttmH/0Y/0MdnTNHCx3OTBj7Y+1IhXOFfwBaVFwqRKtLPUYT7xIF5GLg2boY5d/ARCQ
 SAXke0OIDfL8mCBW2ez9ZeQhd1zWJWU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-NEui6ZLFN2ajAr1zo31aZg-1; Mon, 25 May 2020 09:18:51 -0400
X-MC-Unique: NEui6ZLFN2ajAr1zo31aZg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39778460;
 Mon, 25 May 2020 13:18:50 +0000 (UTC)
Received: from thuth.com (ovpn-113-78.ams2.redhat.com [10.36.113.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 477505C1BB;
 Mon, 25 May 2020 13:18:48 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/7] MAINTAINERS: Add Philippe,
 Alex and Wainer to the Gitlab-CI section
Date: Mon, 25 May 2020 15:18:17 +0200
Message-Id: <20200525131823.715-2-thuth@redhat.com>
In-Reply-To: <20200525131823.715-1-thuth@redhat.com>
References: <20200525131823.715-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 06:55:03
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

Initially, I was the only one who was using Gitlab while most developers
had their git trees still on other systems, but that has changed nowadays.
There is now much more interest in the Gitlab-CI today, so it would be
good to have more than only one maintainer / reviewer for the gitlab-ci.yml
file. Alex, Wainer and Philippe kindly offered their help here, so let's
add them to the corresponding section in the MAINTAINERS file now.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daude <philmd@redhat.com>
Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 87a412c229..bde5fd480f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2893,6 +2893,9 @@ W: https://cirrus-ci.com/github/qemu/qemu
 
 GitLab Continuous Integration
 M: Thomas Huth <thuth@redhat.com>
+M: Philippe Mathieu-Daudé <philmd@redhat.com>
+M: Alex Bennée <alex.bennee@linaro.org>
+R: Wainer dos Santos Moschetta <wainersm@redhat.com>
 S: Maintained
 F: .gitlab-ci.yml
 
-- 
2.18.1


