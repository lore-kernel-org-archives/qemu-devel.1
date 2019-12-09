Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF636C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 13:13:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9F3B20663
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 13:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jTDke9nD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9F3B20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieIqa-0002g1-C7
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 08:13:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45010)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1ieImm-0006Ta-I7
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 08:09:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1ieIml-0006QK-GR
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 08:09:12 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37988
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ieIml-0006Q5-Cx
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 08:09:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575896951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IXWUNvqNN5ClGR1wviwpy2v2AS3yXXwj2mo3UIvxF8s=;
 b=jTDke9nDyzThgnVMiw2CRWiS4v/2Iy1oD8CE0rvojpQB7IAG4pu0o8/T3gdaO2D00xuhfy
 GBO1U7Hy5/QUrZCALA73ZmYH6NyaTT2HCbyuyrjfyykc5PYe0HAgsroUQLzo4PYrtwQ2Pz
 eO7Q3IefxxYRC72AtX1JQzIZMRJ0fGQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-nc6LehCjPkSomqRE26Zpgw-1; Mon, 09 Dec 2019 08:09:09 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94AF618AAFA5
 for <qemu-devel@nongnu.org>; Mon,  9 Dec 2019 13:09:08 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6AD245DA60;
 Mon,  9 Dec 2019 13:09:07 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.0 v2 5/9] acpi: cpuhp: spec: fix 'Command data'
 description
Date: Mon,  9 Dec 2019 14:08:58 +0100
Message-Id: <1575896942-331151-6-git-send-email-imammedo@redhat.com>
In-Reply-To: <1575896942-331151-1-git-send-email-imammedo@redhat.com>
References: <1575896942-331151-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: nc6LehCjPkSomqRE26Zpgw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
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
Cc: pbonzini@redhat.com, philmd@redhat.com, lersek@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Correct returned value description in case 'Command field' =3D=3D 0x0,
it's not PXM but CPU selector value with pending event

In addition describe 0 blanket value in case of not supported
'Command field' value.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
---
v2:
 * rephrase a docs little bit (Laszlo)
---
 docs/specs/acpi_cpu_hotplug.txt | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/docs/specs/acpi_cpu_hotplug.txt b/docs/specs/acpi_cpu_hotplug.=
txt
index 4e65286..d510872 100644
--- a/docs/specs/acpi_cpu_hotplug.txt
+++ b/docs/specs/acpi_cpu_hotplug.txt
@@ -56,9 +56,8 @@ read access:
            3-7: reserved and should be ignored by OSPM
     [0x5-0x7] reserved
     [0x8] Command data: (DWORD access)
-          in case of error or unsupported command reads is 0xFFFFFFFF
-          current 'Command field' value:
-              0: returns PXM value corresponding to device
+          contains 0 unless value last stored in 'Command field' is one of=
:
+              0: contains 'CPU selector' value of a CPU with pending event=
[s]
=20
 write access:
     offset:
@@ -81,9 +80,9 @@ write access:
           value:
             0: selects a CPU device with inserting/removing events and
                following reads from 'Command data' register return
-               selected CPU (CPU selector value). If no CPU with events
-               found, the current CPU selector doesn't change and
-               corresponding insert/remove event flags are not set.
+               selected CPU ('CPU selector' value).
+               If no CPU with events found, the current 'CPU selector' doe=
sn't
+               change and corresponding insert/remove event flags are not =
modified.
             1: following writes to 'Command data' register set OST event
                register in QEMU
             2: following writes to 'Command data' register set OST status
--=20
2.7.4


