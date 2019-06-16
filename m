Return-Path: <SRS0=kfsH=UP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C41AC31E50
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 21:50:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E29E20679
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 21:50:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E29E20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43108 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcd2R-0001xn-HC
	for qemu-devel@archiver.kernel.org; Sun, 16 Jun 2019 17:50:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41065)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hccpN-0006tV-Q9
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 17:36:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hccpK-00075y-1D
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 17:36:40 -0400
Received: from mail-qt1-f177.google.com ([209.85.160.177]:42720)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hccpE-0006nP-0a
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 17:36:32 -0400
Received: by mail-qt1-f177.google.com with SMTP id s15so8548502qtk.9
 for <qemu-devel@nongnu.org>; Sun, 16 Jun 2019 14:36:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=8L/MR43tMh3LvP0+3dx2flcbEwLi3e0Tqk/xAOfUOGM=;
 b=OxlJaD2doCbqdts5KXcGvsocy9EnmL40URrRIRusZDHVzQiKryyMnWBJQeJbniPdSv
 1DBseUIEBo+4jN60WiZ1eyGKhavOfJqwjOhFhHTxJKdFoqAlmkwmOxCeFPT+QWYYGjZy
 S+NVsLzjlVW84ymWs1KNz2gcGv3cuckg2BSkrLO5Ri8LVLqNHXTsBMIe0U2zYoc0UFcR
 fchnp0W7njtZGuB7Tzb4Au8iPXnmrYaFdDp82zjLOqjrVWvSbnfBzvqcfCPP/3+UL9eV
 oWNRNQUhwqpo4EXJ2JC0b29K31yjhbAhcT6h4JTRvehoC38/xNhY3plgrgbVV6lPbQF2
 nNwQ==
X-Gm-Message-State: APjAAAVVIvJT0QYaA7Eut3BdemaUQGHpRb/BD2+kkklBARKM9Eds6sWR
 YEWht+mh1jhQ9+Tg8PUWri/2IW6boUo=
X-Google-Smtp-Source: APXvYqynN5rzfJcxbZ+QkuiZ/F3btoj8MQUFG+I6ebn1WxeruvX25BiZM4EVxCio1Ufuh501In9YZA==
X-Received: by 2002:ac8:2379:: with SMTP id b54mr31103324qtb.168.1560720985554; 
 Sun, 16 Jun 2019 14:36:25 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
 [100.0.197.103])
 by smtp.gmail.com with ESMTPSA id t29sm6625163qtt.42.2019.06.16.14.36.24
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sun, 16 Jun 2019 14:36:24 -0700 (PDT)
Date: Sun, 16 Jun 2019 17:36:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190616213540.20430-12-mst@redhat.com>
References: <20190616213540.20430-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190616213540.20430-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.160.177
Subject: [Qemu-devel] [PULL 11/11] tests/rebuild-expected-aml.sh: blow out
 difflist
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As expected files have been updated, make sure we
do not forget to remove them from the allowed
diff list.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/data/acpi/rebuild-expected-aml.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/data/acpi/rebuild-expected-aml.sh b/tests/data/acpi/rebuild-expected-aml.sh
index d2853218dd..f89d4624bc 100755
--- a/tests/data/acpi/rebuild-expected-aml.sh
+++ b/tests/data/acpi/rebuild-expected-aml.sh
@@ -29,5 +29,8 @@ for qemu in $qemu_bins; do
     TEST_ACPI_REBUILD_AML=y QTEST_QEMU_BINARY=$qemu tests/bios-tables-test
 done
 
+eval `grep SRC_PATH= config-host.mak`
+
+echo '/* List of comma-separated changed AML files to ignore */' > ${SRC_PATH}/tests/bios-tables-test-allowed-diff.h
 
 echo "The files were rebuilt and can be added to git."
-- 
MST


