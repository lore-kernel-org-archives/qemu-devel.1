Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60433C46460
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 17:29:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F395120675
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 17:29:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tF+uAkrO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F395120675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58496 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOmrE-00072c-8M
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 13:29:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hOmUC-0003sQ-NN
	for qemu-devel@nongnu.org; Thu, 09 May 2019 13:05:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hOmU4-0008Bq-FC
	for qemu-devel@nongnu.org; Thu, 09 May 2019 13:05:36 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:33606)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hOmU3-000895-Su
	for qemu-devel@nongnu.org; Thu, 09 May 2019 13:05:28 -0400
Received: by mail-wr1-x429.google.com with SMTP id e11so4099026wrs.0
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 10:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=bB2i4GUjhBmVIAfyyxgXDSeVjb7JmNz+SNv0HmJf3DM=;
	b=tF+uAkrO0Kg+ghEjwa/l6Jb+aznNtPCjby/LwS57I6QmeUbAguX16lEEMDoRjhwfIi
	kFC68xbk8LtvsBCJXq3g26QwSRn45sUgsPEYKtjBSfKhqhPDOqqd90vXji3rA7296QCi
	WKCtQEzWmkZNGDeNUX0jSt0Eijr2cSW5XSbYCdBFcTW5g5sMbR1nN82HMAm2kXNDquB2
	1Ky05pn/4n8ZiERkFLf1cJYhFVYhp/UI98UwtGzbLLR6vFq8EN6CdNNw+qJ9R77l5Qxw
	+eECuFJ24RIysGOPqsBJZQZ4XIMS9AkMx3UMCo7VtsuhAT4cXXfdcb/8wBp0fXuLi/LT
	ZlRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=bB2i4GUjhBmVIAfyyxgXDSeVjb7JmNz+SNv0HmJf3DM=;
	b=qjGsualxA6r9+Y9c3RSpFT3ULuG7t7xZ8mqWW05To9K55AjOqTKNBHfhyURGYof9XY
	jSFrEUQrdkPgcpXkF2QH0kX7mnHsiYqLJXczCiVwXC8yL2e0UMdN2rgCWtJkbM7vvxYF
	Q3SuviPnsqvGLByvG4nRftPs8j9YqVZGN6l92vJkK1Cc6ZUKU04ldTIqNs9l8Ls9xKtQ
	wYGgDI5r82DOxju3NqLDpv4nDR7QGMkChi/EgbL9lktIH6oE6HrjhVlG+VT3wmyL+Owi
	D+Nn1UsLvZwGQV7GSxWYyE1Q19q8o+rhtGxx7KymeFeRUMiE/ACtR/1NqScdu79NDlir
	2Vcw==
X-Gm-Message-State: APjAAAVLNuwHdhBot2lROFQfFFEEV4PdC8QG71Jrr1wx8fKiW86zLL6I
	eiUuoETEe/FGhRlrvBxpjf3uKQ==
X-Google-Smtp-Source: APXvYqziQl+ifb4D0wCg+2RJrmMHqeeUObY4sZ+zaI3XSj0IAlnnwWAPlY0RjcrVhHconvGXitCgCA==
X-Received: by 2002:adf:94a5:: with SMTP id 34mr3943507wrr.275.1557421524651; 
	Thu, 09 May 2019 10:05:24 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	u22sm1581840wmc.12.2019.05.09.10.05.21
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 09 May 2019 10:05:23 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 4CA7A1FF8C;
	Thu,  9 May 2019 17:59:14 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 17:59:08 +0100
Message-Id: <20190509165912.10512-21-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190509165912.10512-1-alex.bennee@linaro.org>
References: <20190509165912.10512-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::429
Subject: [Qemu-devel] [PATCH v1 20/23] tests/qemu-iotests: Remove the
 "_supported_os Linux" line from many tests
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
	"open list:Block layer core" <qemu-block@nongnu.org>,
	Max Reitz <mreitz@redhat.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>, qemu-arm@nongnu.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

A lot of tests run fine on FreeBSD and macOS, too - the limitation
to Linux here was likely just copied-and-pasted from other tests.
Thus remove the "_supported_os Linux" line from tests that run
successful in our CI pipelines on FreeBSD and macOS.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190502084506.8009-6-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/qemu-iotests/001 | 1 -
 tests/qemu-iotests/002 | 1 -
 tests/qemu-iotests/003 | 1 -
 tests/qemu-iotests/004 | 1 -
 tests/qemu-iotests/007 | 1 -
 tests/qemu-iotests/008 | 1 -
 tests/qemu-iotests/009 | 1 -
 tests/qemu-iotests/010 | 1 -
 tests/qemu-iotests/011 | 1 -
 tests/qemu-iotests/012 | 1 -
 tests/qemu-iotests/015 | 1 -
 tests/qemu-iotests/017 | 1 -
 tests/qemu-iotests/020 | 1 -
 tests/qemu-iotests/021 | 1 -
 tests/qemu-iotests/022 | 1 -
 tests/qemu-iotests/025 | 1 -
 tests/qemu-iotests/026 | 1 -
 tests/qemu-iotests/027 | 1 -
 tests/qemu-iotests/029 | 1 -
 tests/qemu-iotests/031 | 1 -
 tests/qemu-iotests/032 | 1 -
 tests/qemu-iotests/033 | 1 -
 tests/qemu-iotests/035 | 1 -
 tests/qemu-iotests/036 | 1 -
 tests/qemu-iotests/037 | 1 -
 tests/qemu-iotests/042 | 1 -
 tests/qemu-iotests/043 | 1 -
 tests/qemu-iotests/046 | 1 -
 tests/qemu-iotests/047 | 1 -
 tests/qemu-iotests/049 | 1 -
 tests/qemu-iotests/050 | 1 -
 tests/qemu-iotests/051 | 1 -
 tests/qemu-iotests/052 | 1 -
 tests/qemu-iotests/053 | 1 -
 tests/qemu-iotests/054 | 1 -
 tests/qemu-iotests/062 | 1 -
 tests/qemu-iotests/063 | 1 -
 tests/qemu-iotests/066 | 1 -
 tests/qemu-iotests/067 | 1 -
 tests/qemu-iotests/068 | 1 -
 tests/qemu-iotests/069 | 1 -
 tests/qemu-iotests/071 | 1 -
 tests/qemu-iotests/072 | 1 -
 tests/qemu-iotests/073 | 1 -
 tests/qemu-iotests/079 | 1 -
 tests/qemu-iotests/082 | 1 -
 tests/qemu-iotests/085 | 1 -
 tests/qemu-iotests/089 | 1 -
 tests/qemu-iotests/090 | 1 -
 tests/qemu-iotests/094 | 1 -
 tests/qemu-iotests/095 | 1 -
 tests/qemu-iotests/098 | 1 -
 tests/qemu-iotests/102 | 1 -
 tests/qemu-iotests/103 | 1 -
 tests/qemu-iotests/104 | 1 -
 tests/qemu-iotests/105 | 1 -
 tests/qemu-iotests/107 | 1 -
 tests/qemu-iotests/110 | 1 -
 tests/qemu-iotests/111 | 1 -
 tests/qemu-iotests/112 | 1 -
 tests/qemu-iotests/114 | 1 -
 tests/qemu-iotests/115 | 1 -
 tests/qemu-iotests/117 | 1 -
 tests/qemu-iotests/120 | 1 -
 tests/qemu-iotests/125 | 1 -
 tests/qemu-iotests/126 | 1 -
 tests/qemu-iotests/127 | 1 -
 tests/qemu-iotests/133 | 1 -
 tests/qemu-iotests/134 | 1 -
 tests/qemu-iotests/142 | 1 -
 tests/qemu-iotests/143 | 1 -
 tests/qemu-iotests/144 | 1 -
 tests/qemu-iotests/145 | 1 -
 tests/qemu-iotests/153 | 1 -
 tests/qemu-iotests/156 | 1 -
 tests/qemu-iotests/157 | 1 -
 tests/qemu-iotests/158 | 1 -
 tests/qemu-iotests/159 | 1 -
 tests/qemu-iotests/162 | 1 -
 tests/qemu-iotests/170 | 1 -
 tests/qemu-iotests/173 | 1 -
 tests/qemu-iotests/182 | 1 -
 tests/qemu-iotests/183 | 1 -
 tests/qemu-iotests/186 | 1 -
 tests/qemu-iotests/187 | 1 -
 tests/qemu-iotests/190 | 1 -
 tests/qemu-iotests/191 | 1 -
 tests/qemu-iotests/192 | 1 -
 tests/qemu-iotests/195 | 1 -
 tests/qemu-iotests/197 | 1 -
 tests/qemu-iotests/200 | 1 -
 tests/qemu-iotests/214 | 1 -
 tests/qemu-iotests/215 | 1 -
 tests/qemu-iotests/217 | 1 -
 tests/qemu-iotests/227 | 1 -
 tests/qemu-iotests/231 | 1 -
 tests/qemu-iotests/233 | 1 -
 tests/qemu-iotests/240 | 1 -
 tests/qemu-iotests/247 | 1 -
 99 files changed, 99 deletions(-)

diff --git a/tests/qemu-iotests/001 b/tests/qemu-iotests/001
index 5d266e170a9..d87a535c339 100755
--- a/tests/qemu-iotests/001
+++ b/tests/qemu-iotests/001
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt generic
 _supported_proto generic
-_supported_os Linux
 
 
 size=128M
diff --git a/tests/qemu-iotests/002 b/tests/qemu-iotests/002
index 7fb85084a1f..fd413bce48e 100755
--- a/tests/qemu-iotests/002
+++ b/tests/qemu-iotests/002
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt generic
 _supported_proto generic
-_supported_os Linux
 
 
 size=128M
diff --git a/tests/qemu-iotests/003 b/tests/qemu-iotests/003
index f008c57cdcb..ccd3a39dfb3 100755
--- a/tests/qemu-iotests/003
+++ b/tests/qemu-iotests/003
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt generic
 _supported_proto generic
-_supported_os Linux
 
 size=128M
 offset=67M
diff --git a/tests/qemu-iotests/004 b/tests/qemu-iotests/004
index 64fab3e7147..d308dc4b498 100755
--- a/tests/qemu-iotests/004
+++ b/tests/qemu-iotests/004
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt raw qcow qcow2 qed vdi vmdk vhdx luks
 _supported_proto generic
-_supported_os Linux
 
 
 size=128M
diff --git a/tests/qemu-iotests/007 b/tests/qemu-iotests/007
index 3ab5490db39..6abd402423f 100755
--- a/tests/qemu-iotests/007
+++ b/tests/qemu-iotests/007
@@ -40,7 +40,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # currently only qcow2 allows for consistency checks using qemu-img
 _supported_fmt qcow2
 _supported_proto generic
-_supported_os Linux
 # refcount_bits must be at least 4 so we can create ten internal snapshots
 # (1 bit supports none, 2 bits support two, 4 bits support 14)
 _unsupported_imgopts 'refcount_bits=\(1\|2\)[^0-9]'
diff --git a/tests/qemu-iotests/008 b/tests/qemu-iotests/008
index 75067e36ad8..2b81b119bfe 100755
--- a/tests/qemu-iotests/008
+++ b/tests/qemu-iotests/008
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt generic
 _supported_proto generic
-_supported_os Linux
 
 
 size=128M
diff --git a/tests/qemu-iotests/009 b/tests/qemu-iotests/009
index bc4b461122c..51b200db1d5 100755
--- a/tests/qemu-iotests/009
+++ b/tests/qemu-iotests/009
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt generic
 _supported_proto generic
-_supported_os Linux
 
 
 size=6G
diff --git a/tests/qemu-iotests/010 b/tests/qemu-iotests/010
index 6920408d289..48c533f6326 100755
--- a/tests/qemu-iotests/010
+++ b/tests/qemu-iotests/010
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt generic
 _supported_proto generic
-_supported_os Linux
 
 
 size=6G
diff --git a/tests/qemu-iotests/011 b/tests/qemu-iotests/011
index b4c7e8f7996..8b1fce069ad 100755
--- a/tests/qemu-iotests/011
+++ b/tests/qemu-iotests/011
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt generic
 _supported_proto generic
-_supported_os Linux
 
 
 size=6G
diff --git a/tests/qemu-iotests/012 b/tests/qemu-iotests/012
index 2c3b42d9dd0..12957285b33 100755
--- a/tests/qemu-iotests/012
+++ b/tests/qemu-iotests/012
@@ -40,7 +40,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt generic
 _supported_proto file
-_supported_os Linux
 
 # Remove once all tests are fixed to use TEST_IMG_FILE
 # correctly and common.rc sets it unconditionally
diff --git a/tests/qemu-iotests/015 b/tests/qemu-iotests/015
index 5a4063e4f53..eec5387f3d7 100755
--- a/tests/qemu-iotests/015
+++ b/tests/qemu-iotests/015
@@ -40,7 +40,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # actually any format that supports snapshots
 _supported_fmt qcow2
 _supported_proto generic
-_supported_os Linux
 # Internal snapshots are (currently) impossible with refcount_bits=1
 _unsupported_imgopts 'refcount_bits=1[^0-9]'
 
diff --git a/tests/qemu-iotests/017 b/tests/qemu-iotests/017
index 83744f29a3f..79875de4543 100755
--- a/tests/qemu-iotests/017
+++ b/tests/qemu-iotests/017
@@ -41,7 +41,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt qcow qcow2 vmdk qed
 _supported_proto generic
 _unsupported_proto vxhs
-_supported_os Linux
 _unsupported_imgopts "subformat=monolithicFlat" "subformat=twoGbMaxExtentFlat"
 
 TEST_OFFSETS="0 4294967296"
diff --git a/tests/qemu-iotests/020 b/tests/qemu-iotests/020
index 71fa753b4ed..6b0ebb37d2f 100755
--- a/tests/qemu-iotests/020
+++ b/tests/qemu-iotests/020
@@ -42,7 +42,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # Any format supporting backing files
 _supported_fmt qcow qcow2 vmdk qed
 _supported_proto file
-_supported_os Linux
 _unsupported_imgopts "subformat=monolithicFlat" \
                      "subformat=twoGbMaxExtentFlat" \
                      "subformat=twoGbMaxExtentSparse"
diff --git a/tests/qemu-iotests/021 b/tests/qemu-iotests/021
index f6555f3b74d..f888269fd4c 100755
--- a/tests/qemu-iotests/021
+++ b/tests/qemu-iotests/021
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt generic
 _supported_proto generic
-_supported_os Linux
 
 
 size=128M
diff --git a/tests/qemu-iotests/022 b/tests/qemu-iotests/022
index b68cd64b33c..99eb08f57f6 100755
--- a/tests/qemu-iotests/022
+++ b/tests/qemu-iotests/022
@@ -42,7 +42,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # Any format that supports snapshots
 _supported_fmt qcow2
 _supported_proto generic
-_supported_os Linux
 
 TEST_OFFSETS="10485760 4294967296"
 CLUSTER_SIZE="4096"
diff --git a/tests/qemu-iotests/025 b/tests/qemu-iotests/025
index d9a4ebc5e75..e05d833452d 100755
--- a/tests/qemu-iotests/025
+++ b/tests/qemu-iotests/025
@@ -39,7 +39,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt raw qcow2 qed luks
 _supported_proto file sheepdog rbd nfs
-_supported_os Linux
 
 echo "=== Creating image"
 echo
diff --git a/tests/qemu-iotests/026 b/tests/qemu-iotests/026
index ca89ad70486..e30243608b9 100755
--- a/tests/qemu-iotests/026
+++ b/tests/qemu-iotests/026
@@ -41,7 +41,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # Currently only qcow2 supports rebasing
 _supported_fmt qcow2
 _supported_proto file
-_supported_os Linux
 _default_cache_mode "writethrough"
 _supported_cache_modes "writethrough" "none"
 # The refcount table tests expect a certain minimum width for refcount entries
diff --git a/tests/qemu-iotests/027 b/tests/qemu-iotests/027
index b7df9701f73..4cb638022a1 100755
--- a/tests/qemu-iotests/027
+++ b/tests/qemu-iotests/027
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt vmdk qcow qcow2 qed
 _supported_proto generic
-_supported_os Linux
 
 
 size=128M
diff --git a/tests/qemu-iotests/029 b/tests/qemu-iotests/029
index 5f42f76cc6e..94c27131320 100755
--- a/tests/qemu-iotests/029
+++ b/tests/qemu-iotests/029
@@ -42,7 +42,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt qcow2
 _supported_proto generic
 _unsupported_proto vxhs
-_supported_os Linux
 # Internal snapshots are (currently) impossible with refcount_bits=1
 _unsupported_imgopts 'refcount_bits=1[^0-9]'
 
diff --git a/tests/qemu-iotests/031 b/tests/qemu-iotests/031
index ef92d8eee37..a3c25ec2378 100755
--- a/tests/qemu-iotests/031
+++ b/tests/qemu-iotests/031
@@ -40,7 +40,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # This tests qcow2-specific low-level functionality
 _supported_fmt qcow2
 _supported_proto file
-_supported_os Linux
 
 CLUSTER_SIZE=65536
 
diff --git a/tests/qemu-iotests/032 b/tests/qemu-iotests/032
index a1757bb15e2..23c216c5495 100755
--- a/tests/qemu-iotests/032
+++ b/tests/qemu-iotests/032
@@ -42,7 +42,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # This works for any image format (though unlikely to segfault for raw)
 _supported_fmt generic
 _supported_proto generic
-_supported_os Linux
 
 echo
 echo === Prepare image ===
diff --git a/tests/qemu-iotests/033 b/tests/qemu-iotests/033
index cfdf1ec2bab..362a48c0a07 100755
--- a/tests/qemu-iotests/033
+++ b/tests/qemu-iotests/033
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt generic
 _supported_proto generic
-_supported_os Linux
 
 
 size=128M
diff --git a/tests/qemu-iotests/035 b/tests/qemu-iotests/035
index 46aa8359365..ad6fa3115a7 100755
--- a/tests/qemu-iotests/035
+++ b/tests/qemu-iotests/035
@@ -39,7 +39,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow2
 _supported_proto generic
-_supported_os Linux
 
 
 size=6G
diff --git a/tests/qemu-iotests/036 b/tests/qemu-iotests/036
index 1b563941299..f06ff67408f 100755
--- a/tests/qemu-iotests/036
+++ b/tests/qemu-iotests/036
@@ -43,7 +43,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # This tests qcow2-specific low-level functionality
 _supported_fmt qcow2
 _supported_proto file
-_supported_os Linux
 
 # Only qcow2v3 and later supports feature bits
 IMGOPTS="compat=1.1"
diff --git a/tests/qemu-iotests/037 b/tests/qemu-iotests/037
index 0781bebefe6..819a2a52d2f 100755
--- a/tests/qemu-iotests/037
+++ b/tests/qemu-iotests/037
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow qcow2 vmdk qed
 _supported_proto file
-_supported_os Linux
 _unsupported_imgopts "subformat=monolithicFlat" \
                      "subformat=twoGbMaxExtentFlat" \
                      "subformat=twoGbMaxExtentSparse"
diff --git a/tests/qemu-iotests/042 b/tests/qemu-iotests/042
index a9a7fc30412..0e85b356b76 100755
--- a/tests/qemu-iotests/042
+++ b/tests/qemu-iotests/042
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow2 qed
 _supported_proto file
-_supported_os Linux
 
 echo
 echo "== Creating zero size image =="
diff --git a/tests/qemu-iotests/043 b/tests/qemu-iotests/043
index 9894b154ecb..67cc7e74c2d 100755
--- a/tests/qemu-iotests/043
+++ b/tests/qemu-iotests/043
@@ -40,7 +40,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # Any format supporting backing files
 _supported_fmt qcow2 qed
 _supported_proto file
-_supported_os Linux
 
 
 size=128M
diff --git a/tests/qemu-iotests/046 b/tests/qemu-iotests/046
index 95160bea4c2..543355c64f4 100755
--- a/tests/qemu-iotests/046
+++ b/tests/qemu-iotests/046
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow2
 _supported_proto file
-_supported_os Linux
 
 CLUSTER_SIZE=64k
 size=128M
diff --git a/tests/qemu-iotests/047 b/tests/qemu-iotests/047
index ce81fc6fa78..4528465fb02 100755
--- a/tests/qemu-iotests/047
+++ b/tests/qemu-iotests/047
@@ -39,7 +39,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow2
 _supported_proto generic
-_supported_os Linux
 
 size=128M
 
diff --git a/tests/qemu-iotests/049 b/tests/qemu-iotests/049
index bc09cd67179..c100d30ed07 100755
--- a/tests/qemu-iotests/049
+++ b/tests/qemu-iotests/049
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow2
 _supported_proto file
-_supported_os Linux
 
 filter_test_dir()
 {
diff --git a/tests/qemu-iotests/050 b/tests/qemu-iotests/050
index dd7b2c72eb2..211fc00797d 100755
--- a/tests/qemu-iotests/050
+++ b/tests/qemu-iotests/050
@@ -40,7 +40,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow2 qed
 _supported_proto file
-_supported_os Linux
 
 if test "$IMGFMT" = qcow2 && test $IMGOPTS = ""; then
   IMGOPTS=compat=1.1
diff --git a/tests/qemu-iotests/051 b/tests/qemu-iotests/051
index 02ac960da43..a3deb1fcadb 100755
--- a/tests/qemu-iotests/051
+++ b/tests/qemu-iotests/051
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow2
 _supported_proto file
-_supported_os Linux
 # A compat=0.10 image is created in this test which does not support anything
 # other than refcount_bits=16
 _unsupported_imgopts 'refcount_bits=\([^1]\|.\([^6]\|$\)\)'
diff --git a/tests/qemu-iotests/052 b/tests/qemu-iotests/052
index b3a2dc11432..6e2ecbfe214 100755
--- a/tests/qemu-iotests/052
+++ b/tests/qemu-iotests/052
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt generic
 _supported_proto file
-_supported_os Linux
 
 # Don't do O_DIRECT on tmpfs
 _supported_cache_modes "writeback" "writethrough" "unsafe"
diff --git a/tests/qemu-iotests/053 b/tests/qemu-iotests/053
index 50c62f0f563..e82bb698814 100755
--- a/tests/qemu-iotests/053
+++ b/tests/qemu-iotests/053
@@ -39,7 +39,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow2 qcow
 _supported_proto file
-_supported_os Linux
 
 echo
 echo "== Creating single sector image =="
diff --git a/tests/qemu-iotests/054 b/tests/qemu-iotests/054
index 0d5e14f8474..a8905b60d0e 100755
--- a/tests/qemu-iotests/054
+++ b/tests/qemu-iotests/054
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow2
 _supported_proto file
-_supported_os Linux
 
 echo
 echo "creating too large image (1 EB)"
diff --git a/tests/qemu-iotests/062 b/tests/qemu-iotests/062
index ed7400fed2d..d5f818fcce1 100755
--- a/tests/qemu-iotests/062
+++ b/tests/qemu-iotests/062
@@ -40,7 +40,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # This tests qocw2-specific low-level functionality
 _supported_fmt qcow2
 _supported_proto generic
-_supported_os Linux
 
 IMGOPTS="compat=1.1"
 IMG_SIZE=64M
diff --git a/tests/qemu-iotests/063 b/tests/qemu-iotests/063
index 2d5c0ce9fb4..fe4892e4679 100755
--- a/tests/qemu-iotests/063
+++ b/tests/qemu-iotests/063
@@ -41,7 +41,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow qcow2 vmdk qed raw
 _supported_proto file
-_supported_os Linux
 _unsupported_imgopts "subformat=monolithicFlat" \
                      "subformat=twoGbMaxExtentFlat" \
                      "subformat=twoGbMaxExtentSparse"
diff --git a/tests/qemu-iotests/066 b/tests/qemu-iotests/066
index f480986e352..28f8c98412c 100755
--- a/tests/qemu-iotests/066
+++ b/tests/qemu-iotests/066
@@ -39,7 +39,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # This tests qocw2-specific low-level functionality
 _supported_fmt qcow2
 _supported_proto generic
-_supported_os Linux
 
 # Intentionally create an unaligned image
 IMGOPTS="compat=1.1"
diff --git a/tests/qemu-iotests/067 b/tests/qemu-iotests/067
index fda16a6b0d7..926c79b37c4 100755
--- a/tests/qemu-iotests/067
+++ b/tests/qemu-iotests/067
@@ -32,7 +32,6 @@ status=1	# failure is the default!
 
 _supported_fmt qcow2
 _supported_proto file
-_supported_os Linux
 # Because anything other than 16 would change the output of query-block
 _unsupported_imgopts 'refcount_bits=\([^1]\|.\([^6]\|$\)\)'
 
diff --git a/tests/qemu-iotests/068 b/tests/qemu-iotests/068
index 881a022107d..22f5ca3ba66 100755
--- a/tests/qemu-iotests/068
+++ b/tests/qemu-iotests/068
@@ -39,7 +39,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # This tests qocw2-specific low-level functionality
 _supported_fmt qcow2
 _supported_proto generic
-_supported_os Linux
 
 IMGOPTS="compat=1.1"
 IMG_SIZE=128K
diff --git a/tests/qemu-iotests/069 b/tests/qemu-iotests/069
index 6a8e4aa22ed..3974714852d 100755
--- a/tests/qemu-iotests/069
+++ b/tests/qemu-iotests/069
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qed qcow qcow2 vmdk
 _supported_proto file
-_supported_os Linux
 _unsupported_imgopts "subformat=monolithicFlat" "subformat=twoGbMaxExtentFlat"
 
 IMG_SIZE=128K
diff --git a/tests/qemu-iotests/071 b/tests/qemu-iotests/071
index 7f3e5abd570..1cca9233d09 100755
--- a/tests/qemu-iotests/071
+++ b/tests/qemu-iotests/071
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow2
 _supported_proto file
-_supported_os Linux
 
 do_run_qemu()
 {
diff --git a/tests/qemu-iotests/072 b/tests/qemu-iotests/072
index 6f9f247fa57..661b36da2da 100755
--- a/tests/qemu-iotests/072
+++ b/tests/qemu-iotests/072
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt vpc vmdk vhdx vdi qed qcow2 qcow
 _supported_proto file
-_supported_os Linux
 
 IMG_SIZE=64M
 
diff --git a/tests/qemu-iotests/073 b/tests/qemu-iotests/073
index 990f90acbd7..e684b1b780f 100755
--- a/tests/qemu-iotests/073
+++ b/tests/qemu-iotests/073
@@ -39,7 +39,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt qcow2
 _supported_proto generic
 _unsupported_proto vxhs
-_supported_os Linux
 
 CLUSTER_SIZE=64k
 size=128M
diff --git a/tests/qemu-iotests/079 b/tests/qemu-iotests/079
index 1b6594ebefe..81f0c21f530 100755
--- a/tests/qemu-iotests/079
+++ b/tests/qemu-iotests/079
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow2
 _supported_proto file nfs
-_supported_os Linux
 
 echo "=== Check option preallocation and cluster_size ==="
 echo
diff --git a/tests/qemu-iotests/082 b/tests/qemu-iotests/082
index 278511dba49..bbbdf555dcb 100755
--- a/tests/qemu-iotests/082
+++ b/tests/qemu-iotests/082
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow2
 _supported_proto file nfs
-_supported_os Linux
 
 run_qemu_img()
 {
diff --git a/tests/qemu-iotests/085 b/tests/qemu-iotests/085
index 68cb6659878..d40fdab5421 100755
--- a/tests/qemu-iotests/085
+++ b/tests/qemu-iotests/085
@@ -56,7 +56,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow2
 _supported_proto file
-_supported_os Linux
 
 
 # ${1}: unique identifier for the snapshot filename
diff --git a/tests/qemu-iotests/089 b/tests/qemu-iotests/089
index 66099549084..ad029f1f099 100755
--- a/tests/qemu-iotests/089
+++ b/tests/qemu-iotests/089
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow2
 _supported_proto file
-_supported_os Linux
 # Because anything other than 16 would change the output of qemu_io -c info
 _unsupported_imgopts 'refcount_bits=\([^1]\|.\([^6]\|$\)\)'
 
diff --git a/tests/qemu-iotests/090 b/tests/qemu-iotests/090
index 193bae7d773..9f8cfbb80f3 100755
--- a/tests/qemu-iotests/090
+++ b/tests/qemu-iotests/090
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow2
 _supported_proto file nfs
-_supported_os Linux
 
 IMG_SIZE=128K
 
diff --git a/tests/qemu-iotests/094 b/tests/qemu-iotests/094
index 0bcca772611..9343e09492f 100755
--- a/tests/qemu-iotests/094
+++ b/tests/qemu-iotests/094
@@ -42,7 +42,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt generic
 _supported_proto nbd
-_supported_os Linux
 _unsupported_imgopts "subformat=monolithicFlat" "subformat=twoGbMaxExtentFlat"
 
 _make_test_img 64M
diff --git a/tests/qemu-iotests/095 b/tests/qemu-iotests/095
index 18505b7181a..58fe174b5ed 100755
--- a/tests/qemu-iotests/095
+++ b/tests/qemu-iotests/095
@@ -44,7 +44,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow2
 _supported_proto file
-_supported_os Linux
 
 size_smaller=5M
 size_larger=100M
diff --git a/tests/qemu-iotests/098 b/tests/qemu-iotests/098
index 461144c831f..1c1d1c468f8 100755
--- a/tests/qemu-iotests/098
+++ b/tests/qemu-iotests/098
@@ -40,7 +40,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow2
 _supported_proto file
-_supported_os Linux
 
 IMGOPTS="compat=1.1"
 
diff --git a/tests/qemu-iotests/102 b/tests/qemu-iotests/102
index cedd2b25dcf..749ff66b8ad 100755
--- a/tests/qemu-iotests/102
+++ b/tests/qemu-iotests/102
@@ -40,7 +40,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow2
 _supported_proto file
-_supported_os Linux
 
 IMG_SIZE=64K
 
diff --git a/tests/qemu-iotests/103 b/tests/qemu-iotests/103
index 6773e94d9fa..554b9de0547 100755
--- a/tests/qemu-iotests/103
+++ b/tests/qemu-iotests/103
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow2
 _supported_proto file nfs
-_supported_os Linux
 # Internal snapshots are (currently) impossible with refcount_bits=1
 _unsupported_imgopts 'refcount_bits=1[^0-9]'
 
diff --git a/tests/qemu-iotests/104 b/tests/qemu-iotests/104
index 390167bad40..c70f28a9a1c 100755
--- a/tests/qemu-iotests/104
+++ b/tests/qemu-iotests/104
@@ -34,7 +34,6 @@ trap "exit \$status" 0 1 2 3 15
 
 _supported_fmt raw qcow qcow2 qed vdi vmdk vhdx
 _supported_proto generic
-_supported_os Linux
 
 echo "=== Check qemu-img info output ==="
 echo
diff --git a/tests/qemu-iotests/105 b/tests/qemu-iotests/105
index 3b5a5968440..3346e8cb254 100755
--- a/tests/qemu-iotests/105
+++ b/tests/qemu-iotests/105
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow2 vmdk vhdx qed
 _supported_proto generic
-_supported_os Linux
 _unsupported_imgopts "subformat=twoGbMaxExtentFlat" \
                      "subformat=twoGbMaxExtentSparse"
 
diff --git a/tests/qemu-iotests/107 b/tests/qemu-iotests/107
index fcd5a24dfe6..268ba276889 100755
--- a/tests/qemu-iotests/107
+++ b/tests/qemu-iotests/107
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow2
 _supported_proto file nfs
-_supported_os Linux
 
 
 IMG_SIZE=64K
diff --git a/tests/qemu-iotests/110 b/tests/qemu-iotests/110
index fad672c1aea..4318341ac59 100755
--- a/tests/qemu-iotests/110
+++ b/tests/qemu-iotests/110
@@ -40,7 +40,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # Any format supporting backing files
 _supported_fmt qed qcow qcow2 vmdk
 _supported_proto file
-_supported_os Linux
 _unsupported_imgopts "subformat=monolithicFlat" "subformat=twoGbMaxExtentFlat"
 
 TEST_IMG_REL=$(basename "$TEST_IMG")
diff --git a/tests/qemu-iotests/111 b/tests/qemu-iotests/111
index 57395be64cb..490a5bbcb53 100755
--- a/tests/qemu-iotests/111
+++ b/tests/qemu-iotests/111
@@ -39,7 +39,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qed qcow qcow2 vmdk
 _supported_proto file
-_supported_os Linux
 _unsupported_imgopts "subformat=monolithicFlat" "subformat=twoGbMaxExtentFlat"
 
 $QEMU_IMG create -f $IMGFMT -b "$TEST_IMG.inexistent" "$TEST_IMG" 2>&1 \
diff --git a/tests/qemu-iotests/112 b/tests/qemu-iotests/112
index 6d81c75a9c9..706c10b6006 100755
--- a/tests/qemu-iotests/112
+++ b/tests/qemu-iotests/112
@@ -39,7 +39,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # This tests qcow2-specific low-level functionality
 _supported_fmt qcow2
 _supported_proto file
-_supported_os Linux
 # This test will set refcount_bits on its own which would conflict with the
 # manual setting; compat will be overridden as well
 _unsupported_imgopts refcount_bits 'compat=0.10'
diff --git a/tests/qemu-iotests/114 b/tests/qemu-iotests/114
index f36b88f3f3c..f90a744fc09 100755
--- a/tests/qemu-iotests/114
+++ b/tests/qemu-iotests/114
@@ -39,7 +39,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt qcow2
 _supported_proto generic
 _unsupported_proto vxhs
-_supported_os Linux
 
 
 TEST_IMG="$TEST_IMG.base" _make_test_img 64M
diff --git a/tests/qemu-iotests/115 b/tests/qemu-iotests/115
index 7ed347010f5..9ed3cb6a83d 100755
--- a/tests/qemu-iotests/115
+++ b/tests/qemu-iotests/115
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow2
 _supported_proto file
-_supported_os Linux
 # This test relies on refcounts being 64 bits wide (which does not work with
 # compat=0.10)
 _unsupported_imgopts 'refcount_bits=\([^6]\|.\([^4]\|$\)\)' 'compat=0.10'
diff --git a/tests/qemu-iotests/117 b/tests/qemu-iotests/117
index 0af0f31c5aa..f37b34f8b1e 100755
--- a/tests/qemu-iotests/117
+++ b/tests/qemu-iotests/117
@@ -40,7 +40,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow2
 _supported_proto file
-_supported_os Linux
 
 _make_test_img 64k
 
diff --git a/tests/qemu-iotests/120 b/tests/qemu-iotests/120
index ca95b9276ea..e9b4fbb0095 100755
--- a/tests/qemu-iotests/120
+++ b/tests/qemu-iotests/120
@@ -39,7 +39,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt generic
 _supported_proto file
-_supported_os Linux
 _unsupported_fmt luks
 
 _make_test_img 64M
diff --git a/tests/qemu-iotests/125 b/tests/qemu-iotests/125
index 212dcd8f0d5..dc4b8f5fb99 100755
--- a/tests/qemu-iotests/125
+++ b/tests/qemu-iotests/125
@@ -44,7 +44,6 @@ get_image_size_on_host()
 
 _supported_fmt qcow2
 _supported_proto file
-_supported_os Linux
 
 if [ -z "$TEST_IMG_FILE" ]; then
     TEST_IMG_FILE=$TEST_IMG
diff --git a/tests/qemu-iotests/126 b/tests/qemu-iotests/126
index 96dc048d592..580fae5d62c 100755
--- a/tests/qemu-iotests/126
+++ b/tests/qemu-iotests/126
@@ -37,7 +37,6 @@ _supported_fmt qcow qcow2 qed vmdk
 # colons which separate a protocol prefix from the rest and colons which are
 # just part of the filename, so we cannot test protocols which require a prefix)
 _supported_proto file
-_supported_os Linux
 
 echo
 echo '=== Testing plain files ==='
diff --git a/tests/qemu-iotests/127 b/tests/qemu-iotests/127
index 3e941f74d4f..b64926ab316 100755
--- a/tests/qemu-iotests/127
+++ b/tests/qemu-iotests/127
@@ -42,7 +42,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow2
 _supported_proto file
-_supported_os Linux
 
 IMG_SIZE=64K
 
diff --git a/tests/qemu-iotests/133 b/tests/qemu-iotests/133
index 1f6056d1449..6f7cacc0910 100755
--- a/tests/qemu-iotests/133
+++ b/tests/qemu-iotests/133
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow2
 _supported_proto file
-_supported_os Linux
 
 TEST_IMG="$TEST_IMG.base" _make_test_img 64M
 _make_test_img -b "$TEST_IMG.base"
diff --git a/tests/qemu-iotests/134 b/tests/qemu-iotests/134
index e9e3e84c2ab..141a2eaa7eb 100755
--- a/tests/qemu-iotests/134
+++ b/tests/qemu-iotests/134
@@ -39,7 +39,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt qcow qcow2
 _supported_proto generic
 _unsupported_proto vxhs
-_supported_os Linux
 
 
 size=128M
diff --git a/tests/qemu-iotests/142 b/tests/qemu-iotests/142
index d9b98cf60a5..6b62271876e 100755
--- a/tests/qemu-iotests/142
+++ b/tests/qemu-iotests/142
@@ -39,7 +39,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow2
 _supported_proto file
-_supported_os Linux
 
 # We test all cache modes anyway, but O_DIRECT needs to be supported
 _default_cache_mode none
diff --git a/tests/qemu-iotests/143 b/tests/qemu-iotests/143
index c223867cb3c..92249ac8dad 100755
--- a/tests/qemu-iotests/143
+++ b/tests/qemu-iotests/143
@@ -40,7 +40,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt generic
 _supported_proto generic
-_supported_os Linux
 
 keep_stderr=y \
 _launch_qemu 2> >(_filter_nbd)
diff --git a/tests/qemu-iotests/144 b/tests/qemu-iotests/144
index 15157f33d77..011ed4f2bc1 100755
--- a/tests/qemu-iotests/144
+++ b/tests/qemu-iotests/144
@@ -46,7 +46,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow2
 _supported_proto file
-_supported_os Linux
 
 size=512M
 
diff --git a/tests/qemu-iotests/145 b/tests/qemu-iotests/145
index 28878dc8a1b..94275496514 100755
--- a/tests/qemu-iotests/145
+++ b/tests/qemu-iotests/145
@@ -39,7 +39,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt generic
 _supported_proto generic
-_supported_os Linux
 
 _make_test_img 1M
 
diff --git a/tests/qemu-iotests/153 b/tests/qemu-iotests/153
index 08ad8a67301..c969a1a16ff 100755
--- a/tests/qemu-iotests/153
+++ b/tests/qemu-iotests/153
@@ -62,7 +62,6 @@ _check_ofd || _notrun "OFD lock not available"
 
 _supported_fmt qcow2
 _supported_proto file
-_supported_os Linux
 
 _run_cmd()
 {
diff --git a/tests/qemu-iotests/156 b/tests/qemu-iotests/156
index 8d134029c6e..2ffa3ca942a 100755
--- a/tests/qemu-iotests/156
+++ b/tests/qemu-iotests/156
@@ -49,7 +49,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt qcow2 qed
 _supported_proto generic
 _unsupported_proto vxhs
-_supported_os Linux
 
 # Create source disk
 TEST_IMG="$TEST_IMG.backing" _make_test_img 1M
diff --git a/tests/qemu-iotests/157 b/tests/qemu-iotests/157
index 69b25cab303..7cbac380999 100755
--- a/tests/qemu-iotests/157
+++ b/tests/qemu-iotests/157
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt generic
 _supported_proto file
-_supported_os Linux
 
 do_run_qemu()
 {
diff --git a/tests/qemu-iotests/158 b/tests/qemu-iotests/158
index 8c0928a7f95..ba4db6116ac 100755
--- a/tests/qemu-iotests/158
+++ b/tests/qemu-iotests/158
@@ -39,7 +39,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt qcow qcow2
 _supported_proto generic
 _unsupported_proto vxhs
-_supported_os Linux
 
 
 size=128M
diff --git a/tests/qemu-iotests/159 b/tests/qemu-iotests/159
index 29066eebde8..2557140ac26 100755
--- a/tests/qemu-iotests/159
+++ b/tests/qemu-iotests/159
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt generic
 _supported_proto file
-_supported_os Linux
 _unsupported_fmt luks
 
 TEST_SIZES="5 512 1024 1999 1K 64K 1M"
diff --git a/tests/qemu-iotests/162 b/tests/qemu-iotests/162
index 2e9947fd9ab..4e5ed74fd58 100755
--- a/tests/qemu-iotests/162
+++ b/tests/qemu-iotests/162
@@ -39,7 +39,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt generic
-_supported_os Linux
 
 test_ssh=$($QEMU_IMG --help | grep '^Supported formats:.* ssh\( \|$\)')
 [ "$test_ssh" = "" ] && _notrun "ssh support required"
diff --git a/tests/qemu-iotests/170 b/tests/qemu-iotests/170
index 7deb7563c97..05dd6ed6c36 100755
--- a/tests/qemu-iotests/170
+++ b/tests/qemu-iotests/170
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt generic
 _supported_proto file
-_supported_os Linux
 _unsupported_fmt luks
 
 echo
diff --git a/tests/qemu-iotests/173 b/tests/qemu-iotests/173
index 47036a5564f..9e2fa2e73cb 100755
--- a/tests/qemu-iotests/173
+++ b/tests/qemu-iotests/173
@@ -41,7 +41,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow2
 _supported_proto nfs
-_supported_os Linux
 
 size=100M
 
diff --git a/tests/qemu-iotests/182 b/tests/qemu-iotests/182
index 38959bf276a..3a90ebfbfd6 100755
--- a/tests/qemu-iotests/182
+++ b/tests/qemu-iotests/182
@@ -42,7 +42,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow2
 _supported_proto file
-_supported_os Linux
 
 size=32M
 
diff --git a/tests/qemu-iotests/183 b/tests/qemu-iotests/183
index 93b7bd798ae..fbe5a99bebd 100755
--- a/tests/qemu-iotests/183
+++ b/tests/qemu-iotests/183
@@ -44,7 +44,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow2 raw qed quorum
 _supported_proto file
-_supported_os Linux
 
 size=64M
 _make_test_img $size
diff --git a/tests/qemu-iotests/186 b/tests/qemu-iotests/186
index 5dd2177b893..7e7d45babc2 100755
--- a/tests/qemu-iotests/186
+++ b/tests/qemu-iotests/186
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow2
 _supported_proto file
-_supported_os Linux
 
 if [ "$QEMU_DEFAULT_MACHINE" != "pc" ]; then
     _notrun "Requires a PC machine"
diff --git a/tests/qemu-iotests/187 b/tests/qemu-iotests/187
index a45addde09a..2fcef9e2bd2 100755
--- a/tests/qemu-iotests/187
+++ b/tests/qemu-iotests/187
@@ -40,7 +40,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow2
 _supported_proto file
-_supported_os Linux
 
 size=64M
 _make_test_img $size
diff --git a/tests/qemu-iotests/190 b/tests/qemu-iotests/190
index e1c1d407f08..eb766ad09f4 100755
--- a/tests/qemu-iotests/190
+++ b/tests/qemu-iotests/190
@@ -41,7 +41,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # See 178 for more extensive tests across more formats
 _supported_fmt qcow2
 _supported_proto file
-_supported_os Linux
 
 echo "== Huge file =="
 echo
diff --git a/tests/qemu-iotests/191 b/tests/qemu-iotests/191
index 1ea908ce3d6..528022e8d81 100755
--- a/tests/qemu-iotests/191
+++ b/tests/qemu-iotests/191
@@ -43,7 +43,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow2
 _supported_proto file
-_supported_os Linux
 
 size=64M
 
diff --git a/tests/qemu-iotests/192 b/tests/qemu-iotests/192
index 158086f9d2c..84d1ed7cfa7 100755
--- a/tests/qemu-iotests/192
+++ b/tests/qemu-iotests/192
@@ -40,7 +40,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt generic
 _supported_proto file
-_supported_os Linux
 
 if [ "$QEMU_DEFAULT_MACHINE" != "pc" ]; then
     _notrun "Requires a PC machine"
diff --git a/tests/qemu-iotests/195 b/tests/qemu-iotests/195
index bd1b71ae5ee..ef7b9a94e29 100755
--- a/tests/qemu-iotests/195
+++ b/tests/qemu-iotests/195
@@ -39,7 +39,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow2
 _supported_proto file
-_supported_os Linux
 
 do_run_qemu()
 {
diff --git a/tests/qemu-iotests/197 b/tests/qemu-iotests/197
index 2c664793f41..383d7d7f616 100755
--- a/tests/qemu-iotests/197
+++ b/tests/qemu-iotests/197
@@ -51,7 +51,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # Test is supported for any backing file; but we force qcow2 for our wrapper.
 _supported_fmt generic
 _supported_proto generic
-_supported_os Linux
 # LUKS support may be possible, but it complicates things.
 _unsupported_fmt luks
 
diff --git a/tests/qemu-iotests/200 b/tests/qemu-iotests/200
index 1c0f8cafc2f..72d431f2517 100755
--- a/tests/qemu-iotests/200
+++ b/tests/qemu-iotests/200
@@ -42,7 +42,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow2 qed
 _supported_proto file
-_supported_os Linux
 
 BACKING_IMG="${TEST_DIR}/backing.img"
 TEST_IMG="${TEST_DIR}/test.img"
diff --git a/tests/qemu-iotests/214 b/tests/qemu-iotests/214
index c1a452ff9a1..21ec8a2ad83 100755
--- a/tests/qemu-iotests/214
+++ b/tests/qemu-iotests/214
@@ -36,7 +36,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow2
 _supported_proto file
-_supported_os Linux
 
 # Repairing the corrupted image requires qemu-img check to store a
 # refcount up to 3, which requires at least two refcount bits.
diff --git a/tests/qemu-iotests/215 b/tests/qemu-iotests/215
index 7b063d7cfa7..958c14f5a07 100755
--- a/tests/qemu-iotests/215
+++ b/tests/qemu-iotests/215
@@ -48,7 +48,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # Test is supported for any backing file; but we force qcow2 for our wrapper.
 _supported_fmt generic
 _supported_proto generic
-_supported_os Linux
 # LUKS support may be possible, but it complicates things.
 _unsupported_fmt luks
 
diff --git a/tests/qemu-iotests/217 b/tests/qemu-iotests/217
index f5482bb6694..58a78a6098a 100755
--- a/tests/qemu-iotests/217
+++ b/tests/qemu-iotests/217
@@ -37,7 +37,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # This test is specific to qcow2
 _supported_fmt qcow2
 _supported_proto file
-_supported_os Linux
 
 # This test needs clusters with at least a refcount of 2 so that
 # OFLAG_COPIED is not set.  refcount_bits=1 is therefore unsupported.
diff --git a/tests/qemu-iotests/227 b/tests/qemu-iotests/227
index 10cf144eb05..bdd727a721b 100755
--- a/tests/qemu-iotests/227
+++ b/tests/qemu-iotests/227
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt generic
 _supported_proto file
-_supported_os Linux
 
 do_run_qemu()
 {
diff --git a/tests/qemu-iotests/231 b/tests/qemu-iotests/231
index 5b2cbab9ace..c0b053ac30a 100755
--- a/tests/qemu-iotests/231
+++ b/tests/qemu-iotests/231
@@ -40,7 +40,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt generic
 _supported_proto rbd
-_supported_os Linux
 
 BOGUS_CONF=${TEST_DIR}/ceph-$$.conf
 touch "${BOGUS_CONF}"
diff --git a/tests/qemu-iotests/233 b/tests/qemu-iotests/233
index 41b4d465606..057cad20446 100755
--- a/tests/qemu-iotests/233
+++ b/tests/qemu-iotests/233
@@ -47,7 +47,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt raw qcow2
 _supported_proto file
 # If porting to non-Linux, consider using socat instead of ss in common.nbd
-_supported_os Linux
 _require_command QEMU_NBD
 
 nbd_server_set_tcp_port
diff --git a/tests/qemu-iotests/240 b/tests/qemu-iotests/240
index d3e663ed65c..b4cf95096db 100755
--- a/tests/qemu-iotests/240
+++ b/tests/qemu-iotests/240
@@ -33,7 +33,6 @@ status=1	# failure is the default!
 
 _supported_fmt generic
 _supported_proto generic
-_supported_os Linux
 
 do_run_qemu()
 {
diff --git a/tests/qemu-iotests/247 b/tests/qemu-iotests/247
index fc50eb5dc1a..546a794d3d4 100755
--- a/tests/qemu-iotests/247
+++ b/tests/qemu-iotests/247
@@ -40,7 +40,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # Requires backing files and .bdrv_change_backing_file support
 _supported_fmt qcow2 qed
 _supported_proto file
-_supported_os Linux
 
 size=128M
 
-- 
2.20.1


