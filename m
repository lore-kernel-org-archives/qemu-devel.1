Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B2EC4BA0B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 09:04:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DD6120732
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 09:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cxnA+FMj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DD6120732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6sc1-0000Vr-C6
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 04:04:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56245)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j6sZO-0005Lj-5m
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:01:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j6sZK-0000jt-Kl
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:01:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46899
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j6sZK-0000ia-G9
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:01:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582707686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4HnVvdO9PVG27yQKQDqqOF3A6bmqC4jZ3lSftCc+CzU=;
 b=cxnA+FMjcyKhHLNNFvt4nDDT+aJ9Yuc2ZUVzQqgzLOg4gJh5GKQxR6l5exIUjzqBX+8XYV
 vxV2ss7TFTEKbFbrcd8bepHc/qcGr+w1sBJ0FjyagRgY9ee7Rhy7m7BtUOPh1PBgTWxtDh
 46aK6ulW3udvWOznMZWJanHYC7GoEyY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427--Yp3CaHNMWuaiO97JRopEQ-1; Wed, 26 Feb 2020 04:01:24 -0500
X-MC-Unique: -Yp3CaHNMWuaiO97JRopEQ-1
Received: by mail-qt1-f197.google.com with SMTP id m8so3505861qta.20
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 01:01:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=8uqNcJ577hXSJJzPx9aMtc0hri4nmxSoPvEVTfUrw5Y=;
 b=qchD8aZytWF1u5/oZdDrJnPfwFar7Y38/oWDFWwgNcEtHXW1HVzFGEdnmlTcBodHF6
 mWHWY5kRMDYCwd5dxZQFjrvu4eVapkMYhL/ALFyP9yfW47fhpGZbXhNmtDkpskCOWYLl
 8B7vYoLxdbRAD+sTGNArGpmcLGVTVlruyV38OJpJKueTLWnEMBO8dOsQ6iTJ/iD3h80b
 tdTfKTMWWS22k7jZRnK51mBCpSNmodr0NPfYPmTS1p1SApwhudGbui7kx7fKZT+iEthh
 aHMWwbuEe5mWYmsqHPoazUbQpC7+pslh1jAMxX8rv3bgN+sEdQLegGPd17aUntZKolzh
 FzKg==
X-Gm-Message-State: APjAAAWRR0Gqzn9nLCeDit+fYiWFwMLYHD+nrOXTV1qVrE0m/Qeu7WWP
 /10QsmjhG+xDECeoWO5726M2PX0e3vIqJMY0/eJY4TFqdaxzFbfDhWhBupyvDXQeBW3afuK8GhQ
 ywIWP9pgaRy0gfGA=
X-Received: by 2002:a37:a404:: with SMTP id n4mr3829997qke.404.1582707683568; 
 Wed, 26 Feb 2020 01:01:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqycppQrnUjAHFPb9ecDb0lel9gc5NWLwOm2DIX46spQhH1Y08u5zLLkdiBbFgXEsXW7tDWSGw==
X-Received: by 2002:a37:a404:: with SMTP id n4mr3829979qke.404.1582707683344; 
 Wed, 26 Feb 2020 01:01:23 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id
 g6sm798579qki.100.2020.02.26.01.01.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 01:01:22 -0800 (PST)
Date: Wed, 26 Feb 2020 04:01:19 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 04/30] rebuild-expected-aml.sh: remind about the process
Message-ID: <20200226090010.708934-5-mst@redhat.com>
References: <20200226090010.708934-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200226090010.708934-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

Remind users of rebuild-expected-aml.sh about the process
to follow. Suppress the warning if allowed file list exists -
that's a big hint user is already aware of the process.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/data/acpi/rebuild-expected-aml.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/data/acpi/rebuild-expected-aml.sh b/tests/data/acpi/rebu=
ild-expected-aml.sh
index d44e511533..9cbaab1a4d 100755
--- a/tests/data/acpi/rebuild-expected-aml.sh
+++ b/tests/data/acpi/rebuild-expected-aml.sh
@@ -31,6 +31,13 @@ done
=20
 eval `grep SRC_PATH=3D config-host.mak`
=20
+old_allowed_dif=3D`grep -v -e 'List of comma-separated changed AML files t=
o ignore' ${SRC_PATH}/tests/qtest/bios-tables-test-allowed-diff.h`
+
 echo '/* List of comma-separated changed AML files to ignore */' > ${SRC_P=
ATH}/tests/qtest/bios-tables-test-allowed-diff.h
=20
 echo "The files were rebuilt and can be added to git."
+
+if [ -z "$old_allowed_dif" ]; then
+    echo "Note! Please do not commit expected files with source changes"
+    echo "Note! Please follow the process documented in ${SRC_PATH}/tests/=
qtest/bios-tables-test.c"
+fi
--=20
MST


