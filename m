Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3A2C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 15:03:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07C6C20781
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 15:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LwOK4TQb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07C6C20781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJIQC-0000sB-1v
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 11:03:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56408)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jJIKL-0008FV-3b
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:57:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jJIKJ-00058e-32
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:57:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41910
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jJIKI-00058F-UN
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:57:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585666634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eJ9Xth7wqdOj25TgGKfdDH1GcrDV7YNI8nWtz5DyfF8=;
 b=LwOK4TQbIfgQCdPIDJV3OqYQ7Xjf7UbaiEPzaRd6bgpDeTka9qPsbDFwB0Tkz8CATi9KRN
 JqlD8yahUKLGJsCGU3/Q8jF5j5d0xFb1Bw0u9+ixyCCW6CEH45Whggz8xpyGCblvf69O4e
 cbtod52Ut7deHgWjxfIAH891EiKcnLY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-ysb1C8sBN-qoLyYroSfG4g-1; Tue, 31 Mar 2020 10:57:12 -0400
X-MC-Unique: ysb1C8sBN-qoLyYroSfG4g-1
Received: by mail-wr1-f71.google.com with SMTP id i18so13011461wrx.17
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 07:57:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=624vl1Deh+cu1AvcgEkyNrweiLps7QJqCr3A1oEA78g=;
 b=NRWx3vR/bXHChbxA13ysOFH2DeGBGDOzvo2qbzgXXt0QsmOkETjeSuHXbZNCY91Jk+
 GCp9gx1PlUuP1oG/QwAtQdHLL96SYQCDhgxIdBiqVJlKDLqf9xdXL7cKOaHoY915DMPR
 liPU0kijXBm7ECoxHl5NEDONPThrMyzbQnABqET2LGQEQi8oXbzMyvM+gCZJSDcfrdDz
 nfuEmfifG48pZ1/VxQFiZ0UAuaRvkAIJj/y2zU5jvs6cHMro0a1jkaSpXEr8Z+zzKIAV
 rVoyYgAiRn5bt/gVGV0FDFsDGDMsX8m4YcO/m/USV6OqQ7U1+45220Yxc7la1xB7/YYy
 hQlw==
X-Gm-Message-State: ANhLgQ2/LcI8qbzSBK9xAFnj9bk2wuBompqtGBG08fH7ChDYKe2dt9aY
 o4jnbfiPngKNajKpacGRyzBfWmq79Bp8+ej+NANwDz+XJpdMp/AL02e6apD92Cyfvlkzz2eOZzx
 5W2IpHlOY/oEVa3s=
X-Received: by 2002:a1c:3b89:: with SMTP id i131mr3825620wma.35.1585666630831; 
 Tue, 31 Mar 2020 07:57:10 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vs49Nbmi8uiQ2el0IQ00U4nMKaxNjpfZaMMpD+jEUVav7mn8Xq1T/LfkjKJWIZNLPQ1900z2Q==
X-Received: by 2002:a1c:3b89:: with SMTP id i131mr3825604wma.35.1585666630595; 
 Tue, 31 Mar 2020 07:57:10 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
 by smtp.gmail.com with ESMTPSA id o14sm4130920wmh.22.2020.03.31.07.57.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2020 07:57:10 -0700 (PDT)
Date: Tue, 31 Mar 2020 10:57:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/10] acpi: pcihp: fix left shift undefined behavior in
 acpi_pcihp_eject_slot()
Message-ID: <20200331145631.135630-5-mst@redhat.com>
References: <20200331145631.135630-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200331145631.135630-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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

From: Igor Mammedov <imammedo@redhat.com>

Coverity spots subj in following guest triggered code path
  pci_write(, data =3D 0) -> acpi_pcihp_eject_slot(,slots =3D 0)
     uinst32_t slot =3D ctz32(slots)
     ...
     ... =3D ~(1U << slot)
where 'slot' value is 32 in case 'slots' bitmap is empty.
'slots' is a bitmap and empty one shouldn't  do anything
so return early doing nothing if resulted slot value is
not valid (i.e. not in 0-31 range)

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20200326135624.32464-1-imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/acpi/pcihp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index 4dcef372bf..0dc963e983 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -154,7 +154,7 @@ static void acpi_pcihp_eject_slot(AcpiPciHpState *s, un=
signed bsel, unsigned slo
=20
     trace_acpi_pci_eject_slot(bsel, slot);
=20
-    if (!bus) {
+    if (!bus || slot > 31) {
         return;
     }
=20
--=20
MST


