Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA8FC33CB6
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 07:14:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9995324655
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 07:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T0lRqNJF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9995324655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuWhX-0002Sx-Rs
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 02:14:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37293)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iuWdJ-0005x2-Uv
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:10:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iuWdI-0007yM-Qw
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:10:29 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60655
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iuWdI-0007yC-Mi
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:10:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579763428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=47oh9akmDrhkEtMoFDskPeBdfNDdFnGRT7tngWCeWTo=;
 b=T0lRqNJFfimaPxgH9V8oZ2CUC5rQyjZjhmrB3h3CnPHLpAVUo+h7gVu4fsLvIQ6TvnBE9y
 WBHDLzOaDpjIJTXlK9eYLQ4OzploQ70nBc987zzZI+QoWVwNLU9WDLb55KGM6n6sh+0nAP
 Jns7u2YiHPEVpml0YtbHGPlElZ/4oKE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-N7XQR-gGO6WGPnt737Kbxw-1; Thu, 23 Jan 2020 02:10:26 -0500
Received: by mail-wr1-f71.google.com with SMTP id o6so1301080wrp.8
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 23:10:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=qLwCkCIBdxpEX8Qu8xH9v4eZQ8D42cjdHR7wkseYBRA=;
 b=INWCBP3Hl3lfqijXupWROtfhQOm2gENxi6YcRmZti8nkt9IM7dF+bcG92HiNiQsxpS
 BzwmbDazKPBvhpbfBBSvueSqnUlfBgyibnoHsKpPdgMGN2fbQVnkOE3VvbGANGoV7rpm
 tVNZCWjknrzHhbaXyb4I+ldYeyUpL7y4cgclHA0QBZGXh4X5St4mm4PKdD8CWNlcihpG
 gzyDXQR17aN/AnlO7JWUQ01TsygTgrZJFAsTKWbpSYXxvW3/kUetM9pJhKFeEhl+1i32
 Qn1PCTpgQNtJDW3HpqiS0rDMvkqqEVzYgM1/qwsLOgtloSXsNRpUVJfuY+EgZkzgyHLA
 2how==
X-Gm-Message-State: APjAAAUgBRmXZ75UKraS0TkwtgpsG4O9U2OIZsDe9euBxpKHf7XSHC8Q
 VidwXV2QRSTd8N4fA4ZiMsZZHqmNOKgs4QR74fpZKJPHdP/vX7wq6EbOJAWDBFBofTz5lKBU0Zd
 WckrzCaWoeB+UfOI=
X-Received: by 2002:a05:6000:cf:: with SMTP id
 q15mr15682828wrx.393.1579763423787; 
 Wed, 22 Jan 2020 23:10:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqwUFgwz+bupy4SfyPWHac6CAFk+cusWPS5rZQCDKLpZtQv56AvMiqif/MU9ynwZHQ7RlRIRcQ==
X-Received: by 2002:a05:6000:cf:: with SMTP id
 q15mr15682806wrx.393.1579763423589; 
 Wed, 22 Jan 2020 23:10:23 -0800 (PST)
Received: from redhat.com (bzq-79-176-0-156.red.bezeqint.net. [79.176.0.156])
 by smtp.gmail.com with ESMTPSA id
 l19sm1476052wmj.12.2020.01.22.23.10.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2020 23:10:22 -0800 (PST)
Date: Thu, 23 Jan 2020 02:10:20 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 05/18] acpi: cpuhp: spec: clarify store into 'Command data'
 when 'Command field' == 0
Message-ID: <20200123070913.626488-6-mst@redhat.com>
References: <20200123070913.626488-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200123070913.626488-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: N7XQR-gGO6WGPnt737Kbxw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Mammedov <imammedo@redhat.com>

Write section of 'Command data' register should describe what happens
when it's written into. Correct description in case the last stored
'Command field' value is equal to 0, to reflect that currently it's not
supported.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Message-Id: <1575896942-331151-7-git-send-email-imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 docs/specs/acpi_cpu_hotplug.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/docs/specs/acpi_cpu_hotplug.txt b/docs/specs/acpi_cpu_hotplug.=
txt
index d5108720bf..8fb9ad22e6 100644
--- a/docs/specs/acpi_cpu_hotplug.txt
+++ b/docs/specs/acpi_cpu_hotplug.txt
@@ -90,8 +90,7 @@ write access:
             other values: reserved
     [0x6-0x7] reserved
     [0x8] Command data: (DWORD access)
-          current 'Command field' value:
-              0: OSPM reads value of CPU selector
+          if last stored 'Command field' value:
               1: stores value into OST event register
               2: stores value into OST status register, triggers
                  ACPI_DEVICE_OST QMP event from QEMU to external applicati=
ons
--=20
MST


