Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90FEEC35E04
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:15:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 604AB21744
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y3Ou/hU/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 604AB21744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6bvk-0002mn-Cu
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 10:15:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55178)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j6btE-0006Qg-MM
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:12:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j6btD-0000vD-NC
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:12:52 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48158
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j6btD-0000v4-JW
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:12:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582643571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4HnVvdO9PVG27yQKQDqqOF3A6bmqC4jZ3lSftCc+CzU=;
 b=Y3Ou/hU/QaR3Wq8bMNLuNjRMs/eDUS+5zGOPI3jHSEUInrvJsXw4c7B/2TWAHYQ+ShR7Rl
 TrK8YlTjJDQpZ387LAn1g+Lv0xzLeLt6pRM1/UcfnSnFWCra1zMDq+q3H60LTIGtYmA5us
 l6McjNcK5DJeGWfD4nSsBDla/ogyKHE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-2-NXI7iTPEO7_NEa2e-_kA-1; Tue, 25 Feb 2020 10:12:49 -0500
X-MC-Unique: 2-NXI7iTPEO7_NEa2e-_kA-1
Received: by mail-qv1-f70.google.com with SMTP id k2so13183170qvu.22
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 07:12:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=8uqNcJ577hXSJJzPx9aMtc0hri4nmxSoPvEVTfUrw5Y=;
 b=t0rvuKOXbuYFbMU01nV+xltmQswOzuo12WqYLzr/ToyMBAs28eMiVy+t16JuxKSJJ8
 F/0nimJTnEoldBN/FNxmDjkJ6aycMWKYWMOwU6SIQBaDKmgzh/XtK25y7seCK84d2hgV
 CFz/j32C6WbT62zIu+9AFaq0uAP2C7D32ByyKj4PuNyhLcsK5yC3EtHV8WqedhIxN5Ia
 ino1WcEMFcbIe3p8g5zQfjPoMypjbFe0EKcNm6GYH+YpcnHLFJL+xMPGotNGEkrBynd7
 CDZD53JR+rtj3sE2jKZTBsPu5qHQ8fGVsX2e+hteZDj+f1B7IYtUXdC9HPnQtnfP2ZRk
 iIIQ==
X-Gm-Message-State: APjAAAWWhJ6rf5IbmJoMz1wvhRRTvZPmzeReVpLx3hsC8x4ACpx8/MNI
 /D1GqOSS0AjxIExNtgVlRO/6hs1G56kHi9tMV8jwVY7NSesTUPCf6zMtFbjjCOGvmn3hOtbOu9z
 2fVQ7/qky8CkWK5s=
X-Received: by 2002:aed:2510:: with SMTP id v16mr54191533qtc.306.1582643568390; 
 Tue, 25 Feb 2020 07:12:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqwC/s628sfMqAm6nLwJBI8XnafBN05K2JPZArt2t7iXhNHjuMfMHf7iZpaYWWluWNCjc8jQbA==
X-Received: by 2002:aed:2510:: with SMTP id v16mr54191508qtc.306.1582643568154; 
 Tue, 25 Feb 2020 07:12:48 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id
 f59sm7596361qtb.75.2020.02.25.07.12.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 07:12:47 -0800 (PST)
Date: Tue, 25 Feb 2020 10:12:44 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/32] rebuild-expected-aml.sh: remind about the process
Message-ID: <20200225151210.647797-5-mst@redhat.com>
References: <20200225151210.647797-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200225151210.647797-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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


