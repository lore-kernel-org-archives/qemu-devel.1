Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADAAC0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 19:47:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E07DA20659
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 19:47:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E07DA20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsY5v-0007qp-6G
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 15:47:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59551)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hsY4a-0005yF-0c
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 15:46:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hsY4Y-0004k1-Vi
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 15:46:11 -0400
Received: from mail-vs1-f41.google.com ([209.85.217.41]:43496)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hsY4Y-0004jb-Rf
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 15:46:10 -0400
Received: by mail-vs1-f41.google.com with SMTP id j26so44454954vsn.10
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2019 12:46:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=1XYbN2Iz7QqIaG00F6sJt/JwcSoQhTqB38WUQOJa2l4=;
 b=Gxjfxy9egBxX5+Z8GyogJx+WQEoHgC26EEphvqb03ohiWNDpI1p7D5YUOCIHEM/bfA
 ca9Bx23qA/bhUMeuFvtY9T6Mimi57DvAhmNQG98o2UIE1CmJ5zt4oewWaq6MwquwdqDP
 2EN4/GGBes31Cn71IKR3kFXVpkG0bBcNCnyB3zqeZ9ppjxNGVvPVXfXG3WjV2YRVhxmY
 cvjr59z841BL5hMYN+hNhWPfelIDefbWKWUvGt68lMs/mP51CG2Qj6Yc8PZElRUwTU45
 ESt9K/mPrBhj+hxbCCyM5Fwv0g1oNfBZdiYE2FsyrNOpVSXAnqQHe4CFnooaFaDjQXQ7
 o7yA==
X-Gm-Message-State: APjAAAVWzu2o/8ZdyUiPZ4Vb2dw0MgKwynvA6NpXfozAbHox9VhbRgA5
 XQTztwUF0N1C69AKA9VFJdyEtqS8aOUmFw==
X-Google-Smtp-Source: APXvYqwC2TOPrIuaSyAsVlEfBP1kNkATas1ClKo3uvEzpBb6bc7Ba2nJR883QPE+c4uARHaDa4aZVQ==
X-Received: by 2002:a05:6102:8c:: with SMTP id
 t12mr21916199vsp.143.1564515969804; 
 Tue, 30 Jul 2019 12:46:09 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
 by smtp.gmail.com with ESMTPSA id
 v5sm76519990vsi.24.2019.07.30.12.46.06
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 30 Jul 2019 12:46:08 -0700 (PDT)
Date: Tue, 30 Jul 2019 15:46:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190730093719.12958-3-dgilbert@redhat.com>
References: <20190730194519.3689-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190730194519.3689-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.217.41
Subject: [Qemu-devel] [PULL 2/2] pcie_root_port: Disable ACS on older
 machines
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
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190730194604.BS3p9zbSgP4Z8HtTrv9zdaIlwPyeRRhYVXFG0N53Dwo@z>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

ACS got added in 4.0 unconditionally,  that broke older<->4.0 migration
where there was a PCIe root port.
Fix this by turning it off for 3.1 and older machines; note this
fixes compatibility for older QEMUs but breaks compatibility with 4.0
for older machine types.

    machine type    source qemu   dest qemu
       3.1             3.1           4.0        broken
       3.1             3.1           4.1rc2     broken
       3.1             3.1           4.1+this   OK ++
       3.1             4.0           4.1rc2     OK
       3.1             4.0           4.1+this   broken --
       4.0             4.0           4.1rc2     OK
       4.0             4.0           4.1+this   OK

So we gain and lose; the consensus seems to be treat this as a
fix for older machine types.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20190730093719.12958-3-dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/core/machine.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index c4a2ab2282..28a475ad97 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -52,6 +52,7 @@ GlobalProperty hw_compat_3_1[] = {
     { "virtio-blk-device", "discard", "false" },
     { "virtio-blk-device", "write-zeroes", "false" },
     { "virtio-balloon-device", "qemu-4-0-config-size", "false" },
+    { "pcie-root-port-base", "disable-acs", "true" }, /* Added in 4.1 */
 };
 const size_t hw_compat_3_1_len = G_N_ELEMENTS(hw_compat_3_1);
 
-- 
MST


