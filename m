Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3411CC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 10:55:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6C3824650
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 10:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oMZwvs0q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6C3824650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihtT4-0007AT-QM
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 05:55:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38990)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ihtNK-0006f7-Vw
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:49:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ihtNJ-00007B-PI
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:49:46 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:41089)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ihtNJ-0008SO-DV
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:49:45 -0500
Received: by mail-wr1-x433.google.com with SMTP id c9so5472611wrw.8
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 02:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ppf+32iUYT5wLQ7K4SiHbEd1II5Q2/neiLzdRWS+Cpo=;
 b=oMZwvs0qYvo5sD2b7x6Sum0AjDageW28Uht7zW+iAotGfwDakn83a8S3zxw3Lzbias
 WPgK4MRu354i8nUM7T3+0fuyD8lG9ILafGSd9gGZNi3Z0kRUWWoiup+V68AYjC/OvXEe
 Fb6HgwZMDiw6MNnXyWIvAcm14nvdMlx4KuOFlerja17IIP4zNjmCq9aiW7pOhQTohwqV
 kmCglnVL10fJR8E5L64LUnu0652EFE3+aXik1PFNvc+RihX4jE4G5qABbJG7eRz4IUfo
 LnU3RCGzXJl6/YraUuvGb1I8klXP8YLXqVstolOmrO8jqDmeEaz/t9XiMPTFy/sBqWme
 Awng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ppf+32iUYT5wLQ7K4SiHbEd1II5Q2/neiLzdRWS+Cpo=;
 b=b5qDtYBAYR74NJXSJgyQ49LPx3G4aXYUXb4kikW0i7A2+tQITiVePO7hT6Cqo3Md8C
 UFVzunDHEGEIATPnEDj3K5vr48m/LdXjYoWA3vaf+ff5ioLhB5HY/vN+EjObI6pJYhcV
 pd+MMZr3Q8d2SI1oA3mk3WMpdUQq2RW2TQ02E3b66PHEFndcYsDbHg4xvQvgPRcUnz4o
 ViSaddokBm/dFWmU0hzDrE8wRgL5X8tZvPMzXzufYcVXAi7IBoMVKo20IZgJHUBSPYij
 HIhbrWsMuG0bOG8ki0qZ+Mdcrqcu/V/1rYo5161a853VKKepo4vC+iplS6A/B12s511F
 GbMA==
X-Gm-Message-State: APjAAAXREkyQlvzM8Z+VIklkDAbkVvKJQt7OPH4+b/gSkay1/+KNOEzK
 +5tNWYuBArr3ubQVPKowuYa3Xg==
X-Google-Smtp-Source: APXvYqxGdgNd6DTBp1h3MTxTV3h9kd0iVtsIBs8b17qlTZgAiDpdlyjksus9mKa6iKB+kfJRNVL84w==
X-Received: by 2002:a5d:4fd0:: with SMTP id h16mr8292145wrw.255.1576752584321; 
 Thu, 19 Dec 2019 02:49:44 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a1sm5676904wmj.40.2019.12.19.02.49.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 02:49:41 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 03BEF1FF93;
 Thu, 19 Dec 2019 10:49:35 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 06/25] iotests: Skip test 079 if it is not possible to create
 large files
Date: Thu, 19 Dec 2019 10:49:15 +0000
Message-Id: <20191219104934.866-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191219104934.866-1-alex.bennee@linaro.org>
References: <20191219104934.866-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

Test 079 fails in the arm64, s390x and ppc64le LXD containers on Travis
(which we will hopefully enable in our CI soon). These containers
apparently do not allow large files to be created. Test 079 tries to
create a 4G sparse file, which is apparently already too big for these
containers, so check first whether we can really create such files before
executing the test.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20191204154618.23560-4-thuth@redhat.com>

diff --git a/tests/qemu-iotests/079 b/tests/qemu-iotests/079
index 81f0c21f530..78536d3bbfa 100755
--- a/tests/qemu-iotests/079
+++ b/tests/qemu-iotests/079
@@ -39,6 +39,9 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt qcow2
 _supported_proto file nfs
 
+# Some containers (e.g. non-x86 on Travis) do not allow large files
+_require_large_file 4G
+
 echo "=== Check option preallocation and cluster_size ==="
 echo
 cluster_sizes="16384 32768 65536 131072 262144 524288 1048576 2097152 4194304"
-- 
2.20.1


