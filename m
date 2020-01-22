Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC23C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 08:11:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 362F72253D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 08:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CKbCTB+J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 362F72253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuB6d-0003x9-Aa
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 03:11:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43980)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iuB1h-0005wc-SB
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 03:06:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iuB1g-0006Lz-Or
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 03:06:13 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37787
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iuB1g-0006Ln-Jm
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 03:06:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579680372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4HnVvdO9PVG27yQKQDqqOF3A6bmqC4jZ3lSftCc+CzU=;
 b=CKbCTB+JrdDKpFrRGkDb3ZpzGI+krTfH6QpdsdlilAM5YbcRp6JOo9NdH48MdooLKc8Cik
 PNYuKbd7rHe4jcKnmMZR1myBFtWmGNHXfLrsgmJ9tHEjfqBGxZH9+zH0ei3UmwKN+ReRy1
 P0XuWEueneQZwNwkVs0tlFqnYdpaHaY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-daXC4Lh_MYmjhD6P3MZYkQ-1; Wed, 22 Jan 2020 03:06:08 -0500
Received: by mail-wr1-f72.google.com with SMTP id f17so2681167wrt.19
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 00:06:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=8uqNcJ577hXSJJzPx9aMtc0hri4nmxSoPvEVTfUrw5Y=;
 b=czTjld3/3YtWuH09Ru3jW14M9kMaS75DegQS4tsjgt8lkxHkEYXWDtxb3qADPH+ZHT
 Cu5+KkJNuwCXsJZgwMgAELXj51nJA54iWnoxlI0mm4sm53qPps3VrPj4eP/EHb9sl11J
 jBLgY/fHCgJElFeVC4WbKtpfO93u0x6W40hh7Yp0/R7C/aGWskUQpQVBA43jgNgtpkmj
 ULxj9jVogaBGsHop0DEBpi/OlLHxBM66lmcrSfRdLrz6ulS6ZoC/uotIE8PJu07yYm+o
 7Z69jkFi2L/WCzwqERpvdb6hdSKhdi2CIPkktYTI3NLhRfVcXIzg9s+YtlnIyZG5m3o/
 /njA==
X-Gm-Message-State: APjAAAXOjtu7Gpq0N1x3YjgcIj0eSAG8DnQawj0nTxg1yX4iTJopRmTB
 1N8jOmCnBZL4ZDVZtMEQ08yOJt+DKA9RRSh8qoFFjjCnjsS/XqNvHQUBEpDftwlHGx5zqVJfJF5
 nQtvml2/nxFQRNVY=
X-Received: by 2002:a05:600c:108a:: with SMTP id
 e10mr1536312wmd.38.1579680366612; 
 Wed, 22 Jan 2020 00:06:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqxn8l3dPD1tZzvB0xGrwe1h07gnoP7bGkFAN9glkPTj1Hn/9xRbA3wQo85OhgsGtCI7KOp0hw==
X-Received: by 2002:a05:600c:108a:: with SMTP id
 e10mr1536290wmd.38.1579680366390; 
 Wed, 22 Jan 2020 00:06:06 -0800 (PST)
Received: from redhat.com (bzq-79-176-0-156.red.bezeqint.net. [79.176.0.156])
 by smtp.gmail.com with ESMTPSA id
 x16sm2778527wmk.35.2020.01.22.00.06.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2020 00:06:05 -0800 (PST)
Date: Wed, 22 Jan 2020 03:06:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/5] rebuild-expected-aml.sh: remind about the process
Message-ID: <20200122080538.591734-6-mst@redhat.com>
References: <20200122080538.591734-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200122080538.591734-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: daXC4Lh_MYmjhD6P3MZYkQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Igor Mammedov <imammedo@redhat.com>
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


