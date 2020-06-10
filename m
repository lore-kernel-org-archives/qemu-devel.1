Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E51C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:41:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC29320734
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fZ2IALgI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC29320734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jisY5-0001S3-1o
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 00:41:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisKh-0007oY-2b
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:27:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37025
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisKg-0008Fl-5z
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:27:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591763241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i525bms7gqVVwpF2fPgVg2EaF8HaC1eOaVMCjQtCrsc=;
 b=fZ2IALgI4/McSBcQ7gmhDRMb0HMvbbQ5BUWueOxmOmW7nmo7P80PLhAzvqiw17CgCbrX90
 rq0bc9SvtxCgnThmST1jR6iww/9aSgsSfsZ9/lPDzEVLKTY5LZx3IW76E9TdC/AXd6FdGX
 AqW/UhwomlsndhZxIVWd7TaJ3+YTeWk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-z86WRS74PJaafVpAaugqLA-1; Wed, 10 Jun 2020 00:27:19 -0400
X-MC-Unique: z86WRS74PJaafVpAaugqLA-1
Received: by mail-wr1-f71.google.com with SMTP id p10so498631wrn.19
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 21:27:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=i525bms7gqVVwpF2fPgVg2EaF8HaC1eOaVMCjQtCrsc=;
 b=WiTz/hLoi8WIBLQ7nbh38eGptV/S3yRKDOuRoxiv4BhoToOgQNwZj3uzcUQH/pdAld
 2ad6WS7PJbxAxn9/N5VnMF3T4Knuj3RJbeucZYct5cZeHbcqjsaTjebcWqdETaKPbK/f
 sIZaOxlda+epceVPXVJDDpx1HP7yoc+ZzJ4qhCdbP7R6f7utTQJpvGcZmKSEgEoqR/rH
 4G0p+zhhayKURtFZ9s/uF1+PsgJpFtZKEDAwIdYzq31NcrkhQlZnfy1n6S7H8ZD6WRsf
 lBXyFtI0qkz8QrN18+vB1ImzhSuv1zD+hm5rw5Fqse1ahlodAWY2nkRepGOmrE469hYP
 5g9g==
X-Gm-Message-State: AOAM530k/x9eoOpez1WoY+GjQdNMYB0P+vImdTi+TqzRXGVsSAAXEzvd
 MDM0GTdcpmL53daMNeQ01qaIVeIZFhXjv6pBleF2LdckRaqNP0OK4Q3CDEW3FbCtPNwRCMDNO8H
 8vnIYeIZEvLDWGfk=
X-Received: by 2002:a1c:2506:: with SMTP id l6mr1210994wml.34.1591763237915;
 Tue, 09 Jun 2020 21:27:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGpqwGc+dHVAdWUvv/HA23YeeOIIyXxzCtPkv5+FCY3dytSsuWl+lUGxLMV8xc3XwbZ0PruQ==
X-Received: by 2002:a1c:2506:: with SMTP id l6mr1210988wml.34.1591763237714;
 Tue, 09 Jun 2020 21:27:17 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
 by smtp.gmail.com with ESMTPSA id h27sm7109827wrb.18.2020.06.09.21.27.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 21:27:17 -0700 (PDT)
Date: Wed, 10 Jun 2020 00:27:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 19/56] tests: tpm-emu: Remove assert on TPM2_ST_NO_SESSIONS
Message-ID: <20200610042613.1459309-20-mst@redhat.com>
References: <20200610042613.1459309-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200610042613.1459309-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:51:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eric Auger <eric.auger@redhat.com>

bios-tables-test executes SeaBIOS. Indeed FW is needed to
fetch tables from QEMU and put them into the guest RAM. Also
the FW patches cross table pointers. At some point, SeaBIOS
ends up calling the TPM2_CC_HierarchyControl command with
TPM2_ST_SESSIONS tag, most probably steming from
tpm_set_failure/tpm20_hierarchycontrol SeaBIOS call path.
This causes an assert() in the qtest tpm emulation code.

As the goal here is not to boot SeaBIOS completely but just
let it grab the ACPI tables and consolidate them, let's just
remove the assert().

Signed-off-by: Eric Auger <eric.auger@redhat.com>

Message-Id: <20200609125409.24179-4-eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/tpm-emu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/qtest/tpm-emu.c b/tests/qtest/tpm-emu.c
index c43ac4aef8..298d0eec74 100644
--- a/tests/qtest/tpm-emu.c
+++ b/tests/qtest/tpm-emu.c
@@ -49,7 +49,6 @@ static void *tpm_emu_tpm_thread(void *data)
         s->tpm_msg->tag = be16_to_cpu(s->tpm_msg->tag);
         s->tpm_msg->len = be32_to_cpu(s->tpm_msg->len);
         g_assert_cmpint(s->tpm_msg->len, >=, minhlen);
-        g_assert_cmpint(s->tpm_msg->tag, ==, TPM2_ST_NO_SESSIONS);
 
         s->tpm_msg = g_realloc(s->tpm_msg, s->tpm_msg->len);
         qio_channel_read(ioc, (char *)&s->tpm_msg->code,
-- 
MST


