Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E11C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 11:53:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1525A20872
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 11:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fWQoZBbn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1525A20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXl1D-0007oU-6X
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 06:53:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34021)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iXl0V-0007IO-Ng
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 06:52:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iXl0T-0001NG-6S
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 06:52:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26191
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iXl0S-0001Ll-MZ
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 06:52:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574337135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Uoq++likwzydtuLsEg6yx4EK+IYlwTVEOmhEenbr/wE=;
 b=fWQoZBbnn5ApkXD+gis2HWZdLVaa5XguEZAlkmpnhquXpQ777tliszuWpiulNPipVf9o3O
 BzIrsS6cfWuMoZTjQ7b6RHeojAGtA+FIXyDE3Kdj1BmHbZU6cl53gTG8nIYHGevq2ppBuh
 w3z+FHfleuspjsHkS4yrkyN+UnRVE+o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-sjOlWy7FMlqc23EswXekAQ-1; Thu, 21 Nov 2019 06:52:12 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 863991005502
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 11:52:11 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-116-86.ams2.redhat.com
 [10.36.116.86])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CCBB960C2D;
 Thu, 21 Nov 2019 11:52:10 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Subject: [qemu-web PATCH] Add a blog post about the QEMU-related presentation
 of KVM Forum 2019
Date: Thu, 21 Nov 2019 12:52:07 +0100
Message-Id: <20191121115207.5832-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: sjOlWy7FMlqc23EswXekAQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There have been quite a lot of QEMU-related talks at KVM Forum this
year - let's provide a summary for the people who could not attend.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Note: For some talks it's hard to decide whether they really fit the
 QEMU blog or not. I've assembled the list below by quickly skimming
 through the schedule and the videos, and that's what I came up with ...
 If you think any of the other talks should be mentioned here, too,
 please let me know.

 _posts/2019-11-21-kvm-forum.md | 45 ++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 _posts/2019-11-21-kvm-forum.md

diff --git a/_posts/2019-11-21-kvm-forum.md b/_posts/2019-11-21-kvm-forum.m=
d
new file mode 100644
index 0000000..e5adf5d
--- /dev/null
+++ b/_posts/2019-11-21-kvm-forum.md
@@ -0,0 +1,45 @@
+---
+layout: post
+title:  "Presentations from KVM Forum 2019"
+date:   2019-11-21 12:30:00 +0100
+author: Thomas Huth
+categories: [presentations, conferences]
+---
+Last month, the
+[KVM Forum 2019](https://events.linuxfoundation.org/events/kvm-forum-2019/=
)
+took place in Lyon, France. The conference also featured quite a lot talks
+about QEMU, and now the videos of the presentation are available online.
+So for those who could not attend, here is the list of the QEMU-related
+presentations:
+
+* [QEMU Status Report](https://www.youtube.com/watch?v=3D6_1QQaXPjd4)
+  by Paolo Bonzini
+
+* [The Hype Around the RISC-V
+  Hypervisor](https://www.youtube.com/watch?v=3D2MUka4lKGFU) by Alistair F=
rancis
+  and Anup Patel
+
+* [Reworking the Inter-VM Shared Memory
+  Device](https://www.youtube.com/watch?v=3DTiZrngLUFMA) by Jan Kiszka
+
+* [What's Going On? Taking Advantage of TCG's Total System
+  Awareness](https://www.youtube.com/watch?v=3DwxIF0dvGDuM) by Alex Benn=
=C3=A9e
+
+* [Towards the Higher Level Debugging with
+  QEMU](https://www.youtube.com/watch?v=3DE2yJL82gJYM) by Pavel Dovgalyuk
+
+* [QEMU-Hexagon: Automatic Translation of the ISA Manual Pseudcode to Tiny=
 Code
+  Instructions of a VLIW Architecture](https://www.youtube.com/watch?v=3D3=
EpnTYBOXCI)
+  by Niccol=C3=B2 Izzo and Taylor Simpson
+
+* [Reports of my Bloat Have Been Greatly
+  Exaggerated](https://www.youtube.com/watch?v=3D5TY7m1AneRY) by Paolo Bon=
zini
+
+* [Multi-process QEMU - Status Update](https://www.youtube.com/watch?v=3Dl=
slVYCuk4CQ)
+  by John Johnson and Elena Ufimtseva
+
+* [Bring QEMU to Micro Service World](https://www.youtube.com/watch?v=3D5h=
IDwkpXUiw)
+  by Xiao Guangrong and Zhang Yulei
+
+More interesting virtualization-related talks can be found in the
+[KVM Forum Youtube Channel](https://www.youtube.com/channel/UCRCSQmAOh7yzg=
heq-emy1xA).
--=20
2.23.0


