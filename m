Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7ABC4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 00:37:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A6342086D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 00:37:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A6342086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgetE-00089m-EA
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 20:37:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36334)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hgelK-0000Y3-PY
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 20:29:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hgelJ-0006w7-RQ
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 20:29:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39716)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hgelJ-0006vL-J4
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 20:29:09 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E3AC631628FF
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 00:29:08 +0000 (UTC)
Received: from localhost (ovpn-116-7.gru2.redhat.com [10.97.116.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3448360BE0;
 Fri, 28 Jun 2019 00:29:05 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 27 Jun 2019 21:28:43 -0300
Message-Id: <20190628002844.24894-9-ehabkost@redhat.com>
In-Reply-To: <20190628002844.24894-1-ehabkost@redhat.com>
References: <20190628002844.24894-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Fri, 28 Jun 2019 00:29:08 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 8/9] docs: Deprecate CPU model runnability
 guarantees
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
Cc: libvir-list@redhat.com, Igor Mammedov <imammedo@redhat.com>,
 Jiri Denemark <jdenemar@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Document that CPU model runnability guarantees won't apply to
unversioned CPU models anymore.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v1 -> v2:
* (none)

Cc: libvir-list@redhat.com
---
 qemu-deprecated.texi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 9cba82d5ec..18f85f70e1 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -276,3 +276,22 @@ Note that if you are exposing the export via /dev/nbd0, it is easier
 to just export the entire image and then mount only /dev/nbd0p1 than
 it is to reinvoke @command{qemu-nbd -c /dev/nbd0} limited to just a
 subset of the image.
+
+@section Backwards compatibility
+
+@subsection Runnability guarantee of CPU models (since 4.1.0)
+
+Previous versions of QEMU never changed existing CPU models in
+ways that introduced additional host software or hardware
+requirements to the VM.  This allowed management software to
+safely change the machine type of an existing VM without
+introducing new requirements ("runnability guarantee").  This
+prevented CPU models from being updated to include CPU
+vulnerability mitigations, leaving guests vulnerable in the
+default configuration.
+
+The CPU model runnability guarantee won't apply anymore to
+existing CPU models.  Management software that needs runnability
+guarantees must resolve the CPU model aliases using te
+``alias-of'' field returned by the ``query-cpu-definitions'' QMP
+command.
-- 
2.18.0.rc1.1.g3f1ff2140


