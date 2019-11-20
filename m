Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73C7C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 10:01:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8202A22429
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 10:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zy11f+mp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8202A22429
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXMnH-0004tx-JW
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 05:01:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49569)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iXMm7-0003sf-Kc
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 04:59:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iXMm6-0004qb-L7
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 04:59:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56578
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iXMm6-0004qO-HX
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 04:59:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574243990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BZskGUfyn7jaYYd2DvEDC0RMUYMrzQsxfievlb9z0CI=;
 b=Zy11f+mpwhOMAd9e3CN5girSX5C/OkkTqwdYmbd0KQvkQZsnUEN7AsxtNNedHRg1fuBeXH
 imfS+Auuf6px9ma9N+bEpPYafcIyHdLODMkZ2a4SCAKDgTUBL4ZM5es7UjMLL80PhszYh9
 PGgfz9qJCAIwcJAziIlbhNsoYmlXz9o=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-gtZULBH2MjGt6fOweS5Duw-1; Wed, 20 Nov 2019 04:59:48 -0500
Received: by mail-qt1-f199.google.com with SMTP id r12so16664567qtp.21
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 01:59:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=udlnRDFsi+KkBvtwSXFal5HYXw9hrZuZTWTmkZClDRA=;
 b=d0mtSZjPOrkLqGHOIKT+cKQqDEqR40Ww+yweniuoUoq6T54ZPU/VitKZQhp29jpeVd
 heW9K2tHlu7uxaK8zTIPNUNlhQL7+Ks6A5MvpYlJwrG6z+Wm2BW6MvsdMmqB9SPbQaNK
 W24UVsDo2LJcAsw2+xyaQmOQrSbRv4Eoa70A4dWjKiQr8g6X8jyrbUqloRazQeIbUxqd
 vsgOfQmj7lbQ3DwzZOSiMc3JiY6U0r1U1XZNvZ6MDbdPlwPIoOJAVP+yB250yBOJP2Hg
 DsP7VUcLU+fo4hkD7jDCwyrk774bnP7Tra7Al06TcMckyVqMX3zrMzuNv2Ik/L6tBKe+
 qWcw==
X-Gm-Message-State: APjAAAUsFWwBORD5EZ/F20KmN3VdLHAdHSiQu9SdadBgrzQIX4NouEXV
 iaZoFqznqM/t/A9hgAkCzmTwZZdIgY3jueNu31vmMovJ19I8pm8Huc7kJ+WWC7q+O9FZTIeV0IX
 4GAtFWQSsM53CRiI=
X-Received: by 2002:a37:a00f:: with SMTP id j15mr1551955qke.103.1574243988040; 
 Wed, 20 Nov 2019 01:59:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqz9cBCiWJEKY2AIJhD/SsJc4F1TmMBwH6bEFAQanVevdLCGq68OEa2EW4k9dNp9pEqK2VrPyg==
X-Received: by 2002:a37:a00f:: with SMTP id j15mr1551949qke.103.1574243987806; 
 Wed, 20 Nov 2019 01:59:47 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
 by smtp.gmail.com with ESMTPSA id z3sm13956555qtu.83.2019.11.20.01.59.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2019 01:59:47 -0800 (PST)
Date: Wed, 20 Nov 2019 04:59:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/3] tests: acpi: always retain dumped ACPI tables in case of
 error
Message-ID: <20191120095904.11384-4-mst@redhat.com>
References: <20191120095904.11384-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191120095904.11384-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-MC-Unique: gtZULBH2MjGt6fOweS5Duw-1
X-Mimecast-Spam-Score: 0
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Mammedov <imammedo@redhat.com>

If IASL wasn't able to parse expected file, test will just
print warning
  "Warning! iasl couldn't parse the expected aml\n"
and remove temporary table dumped from guest.

Typically expected tables are always valid, with an exception
when patchset introduces new tables.
Make sure dumped tables are retained even if expected files
are not valid, so one could have a chance to manualy check new
tables.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <1574240560-12538-1-git-send-email-imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/bios-tables-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 0b33fb265f..79f5da092f 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -437,11 +437,11 @@ static void test_acpi_asl(test_data *data)
         g_assert(!err || exp_err);
=20
         if (g_strcmp0(asl->str, exp_asl->str)) {
+            sdt->tmp_files_retain =3D true;
             if (exp_err) {
                 fprintf(stderr,
                         "Warning! iasl couldn't parse the expected aml\n")=
;
             } else {
-                sdt->tmp_files_retain =3D true;
                 exp_sdt->tmp_files_retain =3D true;
                 fprintf(stderr,
                         "acpi-test: Warning! %.4s mismatch. "
--=20
MST


