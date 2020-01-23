Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986DFC33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 07:12:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6047924673
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 07:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PJheTzMj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6047924673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuWf0-0007U4-0N
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 02:12:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37212)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iuWdC-0005ko-6S
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:10:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iuWdA-0007qE-Vd
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:10:22 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60228
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iuWdA-0007pp-RF
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:10:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579763420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OhMnOXw2jltLb3g6o0bZN0GY8d9d1JsgKnb3ojyU5uY=;
 b=PJheTzMjDu6XC3bbXY/uVe27qzxkics+U0vYZ9b5tHq9G0UFPhhe0bi+vn0f9SZurEF1Us
 Pqcp20l1qxn5HjIhFMMe5bDzNpHko8AJjFP+rv1VLsYm0FLgLOuN5ID6/jC6uWfOu5Zdei
 cBzsgu4aQMlx+pI+9wcRw8Ea81cTI/s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-85EewQqVMdu_F2AuXz3bNQ-1; Thu, 23 Jan 2020 02:10:18 -0500
Received: by mail-wr1-f72.google.com with SMTP id d8so1290890wrq.12
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 23:10:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=SmP96JjZ61jUtUgNUruj35mPI4zb3UYO5pk5xajyjow=;
 b=ZVSm/bad8t+lpSxAhvBm9+WIkwj25HCULkFIwlAVrbA6ITBbBTMFmRU6ArQGSA0wSW
 StL69qFNyGlb4lAsPEhkKm5SD4Q2ZwoTKIvpAvWwIRxYbqNl+9+Te0BfKfvEYrzm4KLj
 VOsDTHZUUhwRs0nfICwxXeXwmsp8usVQh8KrxcQd0I/1X3jYyAmkR+89A5kduawrhhdP
 QUd0zo9p8lX/KNE84GQriAeDOaxuiE9tOo4wisXALEbuQmrui5RpKEOzl7JgHUlAA4Zn
 MudFPkBL9LgllYlSvaYsEbvB7QkMk+BMxtkrtWzjSeyVrQNZOpNRSBPbFiRP6rsu2E1w
 S3MA==
X-Gm-Message-State: APjAAAVPLw9GQsVZ1W7mAT48T3ec/MDyrlYqkdz3J6X/lg2qZGVvxgAk
 r363LqLXUExOVkwwrU+mBsrcF/WOE1sX9zkokRTCgJTeINT96qRXoFweu/SwpRtzGyQumkvpi5E
 Skl+/m91ViFKrf0U=
X-Received: by 2002:adf:dfd2:: with SMTP id q18mr16511108wrn.152.1579763417043; 
 Wed, 22 Jan 2020 23:10:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqxaNxGAPJdxygRPKu1udOieOGOZ+OV3WhAgziY1NytEKk1xV/eZco/+HAUYAndcC3hDhnlVJg==
X-Received: by 2002:adf:dfd2:: with SMTP id q18mr16511079wrn.152.1579763416733; 
 Wed, 22 Jan 2020 23:10:16 -0800 (PST)
Received: from redhat.com (bzq-79-176-0-156.red.bezeqint.net. [79.176.0.156])
 by smtp.gmail.com with ESMTPSA id
 i5sm1804616wrv.34.2020.01.22.23.10.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2020 23:10:16 -0800 (PST)
Date: Thu, 23 Jan 2020 02:10:14 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 03/18] acpi: cpuhp: spec: clarify 'CPU selector' register
 usage and endianness
Message-ID: <20200123070913.626488-4-mst@redhat.com>
References: <20200123070913.626488-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200123070913.626488-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: 85EewQqVMdu_F2AuXz3bNQ-1
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

* Move reserved registers to the top of the section, so reader would be
  aware of effects when reading registers description.
* State registers endianness explicitly at the beginning of the section
* Describe registers behavior in case of 'CPU selector' register contains
  value that doesn't point to a possible CPU.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Message-Id: <1575896942-331151-5-git-send-email-imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 docs/specs/acpi_cpu_hotplug.txt | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/docs/specs/acpi_cpu_hotplug.txt b/docs/specs/acpi_cpu_hotplug.=
txt
index ee219c8358..4e65286ff5 100644
--- a/docs/specs/acpi_cpu_hotplug.txt
+++ b/docs/specs/acpi_cpu_hotplug.txt
@@ -30,6 +30,18 @@ Register block base address:
 Register block size:
     ACPI_CPU_HOTPLUG_REG_LEN =3D 12
=20
+All accesses to registers described below, imply little-endian byte order.
+
+Reserved resisters behavior:
+   - write accesses are ignored
+   - read accesses return all bits set to 0.
+
+The last stored value in 'CPU selector' must refer to a possible CPU, othe=
rwise
+  - reads from any register return 0
+  - writes to any other register are ignored until valid value is stored i=
nto it
+On QEMU start, 'CPU selector' is initialized to a valid value, on reset it
+keeps the current value.
+
 read access:
     offset:
     [0x0-0x3] reserved
@@ -86,9 +98,3 @@ write access:
                  ACPI_DEVICE_OST QMP event from QEMU to external applicati=
ons
                  with current values of OST event and status registers.
             other values: reserved
-
-Selecting CPU device beyond possible range has no effect on platform:
-   - write accesses to CPU hot-plug registers not documented above are
-     ignored
-   - read accesses to CPU hot-plug registers not documented above return
-     all bits set to 0.
--=20
MST


