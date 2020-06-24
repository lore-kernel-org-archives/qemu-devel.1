Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBF9C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 23:14:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E773A206F7
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 23:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="breEcmMo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E773A206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joEay-0004mF-4r
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 19:14:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42464)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1joEUH-000154-Vy
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 19:07:26 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37558
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1joEUG-0001jn-7q
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 19:07:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593040043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hGOMsAz9jdPgrKOCTlRHBfJs9awMvv/tzRGS1Q+Bj0g=;
 b=breEcmMozFn9a8FATfx+0BLDBRjsEhJDzIBT4OEbIs/uC4OVKt8cl0XIoI0GGqfIXdr4aL
 CyoVJn/W2QEdS03YwNw1BkkRPLoea0Z6QouVvAXWfkFAzwLeXjcvhGSNzQTqdN+DWDZu6/
 R53o7kDScKJ+PzvFJUkgoqpyd+lM/70=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-57-tQQugGMjPtqcGeW6nmlCOg-1; Wed, 24 Jun 2020 19:07:21 -0400
X-MC-Unique: tQQugGMjPtqcGeW6nmlCOg-1
Received: by mail-wm1-f71.google.com with SMTP id g124so4625921wmg.6
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 16:07:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=hGOMsAz9jdPgrKOCTlRHBfJs9awMvv/tzRGS1Q+Bj0g=;
 b=e0B7nyiUrzfFjG6xsTW3PXH0YhsHsrYBe74I1EKFCECcebKooGQ9432hZWEUsLznxm
 nT9AJO1QEcZtV+T6kMlwZm+OBShitpjeBkQiq9BMjM9WoeYqMk+I6WYzV73HGv7AjpnB
 DvssZcQN1233dT/a5oXeEgZMofquVdTSH0cl5TQs6zz1cHUncU9PapLsDOFFxHEzFJ3M
 U9vSBGrQCPgnc3efZxg4owHJqj5nrE1AZIDoWLZb2rBLxNrmCEv93bF94/sErCSJb6PS
 wVl5gg4tK2esVeOn5usDNWM5R2jOTMZlNo3Mr/++ik+e2RdKLqJrKwjIeCp9J/3EBEGQ
 yaCQ==
X-Gm-Message-State: AOAM532TUs4SUo2XnZb8N+W5Prl//8wh4jXadMkxyxEqJf+PBfXBhlz2
 kBlZNZEH9FK3MYqxygo5nWlw5ZNvcpZuUjD10XjD9YI86YQg2nGPfRBfiag4pl89DMccxPgUtHR
 neWCVBOw8xKtetso=
X-Received: by 2002:a1c:3286:: with SMTP id y128mr104740wmy.29.1593040040306; 
 Wed, 24 Jun 2020 16:07:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxvTsWAdEV23Qi4p4iyVTBg+1P1PR552XP5IZOvvNde2i4Mf0xk9dTqVIxw67NbJOKXU5h9aw==
X-Received: by 2002:a1c:3286:: with SMTP id y128mr104728wmy.29.1593040040120; 
 Wed, 24 Jun 2020 16:07:20 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 b201sm10008014wmb.36.2020.06.24.16.07.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2020 16:07:19 -0700 (PDT)
Date: Wed, 24 Jun 2020 19:07:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 19/19] tests: disassemble-asm.sh: generate AML in readable
 format
Message-ID: <20200624230609.703104-20-mst@redhat.com>
References: <20200624230609.703104-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200624230609.703104-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 01:59:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On systems where the IASL tool exists, we can convert
extected ACPI tables to ASL format, which is useful
for debugging and documentation purposes.
This script does this for all ACPI tables under tests/data/acpi/.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/data/acpi/disassemle-aml.sh | 52 +++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100755 tests/data/acpi/disassemle-aml.sh

diff --git a/tests/data/acpi/disassemle-aml.sh b/tests/data/acpi/disassemle-aml.sh
new file mode 100755
index 0000000000..1d8a4d0301
--- /dev/null
+++ b/tests/data/acpi/disassemle-aml.sh
@@ -0,0 +1,52 @@
+#!/usr/bin/bash
+
+outdir=
+while getopts "o:" arg; do
+  case ${arg} in
+    o )
+        outdir=$OPTARG
+        ;;
+    \? )
+        echo "Usage: ./tests/data/acpi/disassemle-aml.sh [-o <output-directory>]"
+        exit 1
+        ;;
+
+  esac
+done
+
+for machine in tests/data/acpi/*
+do
+    if [[ ! -d "$machine" ]];
+    then
+        continue
+    fi
+
+    if [[ "${outdir}" ]];
+    then
+        mkdir -p "${outdir}"/${machine} || exit $?
+    fi
+    for aml in $machine/*
+    do
+        if [[ "$aml" == $machine/*.dsl ]];
+        then
+            continue
+        fi
+        if [[ "$aml" == $machine/SSDT*.* ]];
+        then
+            dsdt=${aml/SSDT*./DSDT.}
+            extra="-e ${dsdt}"
+        elif [[ "$aml" == $machine/SSDT* ]];
+        then
+            dsdt=${aml/SSDT*/DSDT};
+            extra="-e ${dsdt}"
+        else
+            extra=""
+        fi
+        asl=${aml}.dsl
+        if [[ "${outdir}" ]];
+        then
+            asl="${outdir}"/${machine}/${asl}
+        fi
+        iasl -d -p ${asl} ${extra} ${aml}
+    done
+done
-- 
MST


