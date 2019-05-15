Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506C6C04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 14:13:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2370A2084E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 14:13:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2370A2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37754 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQued-0000xe-F7
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 10:13:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hQubz-0007sl-Hr
	for qemu-devel@nongnu.org; Wed, 15 May 2019 10:10:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hQubx-0007Fl-Mk
	for qemu-devel@nongnu.org; Wed, 15 May 2019 10:10:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:11047)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hQubs-00079N-8F
	for qemu-devel@nongnu.org; Wed, 15 May 2019 10:10:21 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DA3DE306C9D8;
	Wed, 15 May 2019 14:10:17 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-112-65.ams2.redhat.com
	[10.36.112.65])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5F5665D706;
	Wed, 15 May 2019 14:10:16 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 15 May 2019 15:10:11 +0100
Message-Id: <20190515141011.5315-3-berrange@redhat.com>
In-Reply-To: <20190515141011.5315-1-berrange@redhat.com>
References: <20190515141011.5315-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Wed, 15 May 2019 14:10:17 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 2/2] docs: recommend use of md-clear feature on
 all Intel CPUs
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Update x86 CPU model guidance to recommend that the md-clear feature is
manually enabled with all Intel CPU models, when supported by the host
microcode.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 docs/qemu-cpu-models.texi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/docs/qemu-cpu-models.texi b/docs/qemu-cpu-models.texi
index 23c11dc86f..ad040cfc98 100644
--- a/docs/qemu-cpu-models.texi
+++ b/docs/qemu-cpu-models.texi
@@ -200,6 +200,18 @@ Not included by default in any Intel CPU model.
 Should be explicitly turned on for all Intel CPU models.
=20
 Note that not all CPU hardware will support this feature.
+
+@item @code{md-clear}
+
+Required to confirm the MDS (CVE-2018-12126, CVE-2018-12127, CVE-2018-12=
130,
+CVE-2019-11091) fixes.
+
+Not included by default in any Intel CPU model.
+
+Must be explicitly turned on for all Intel CPU models.
+
+Requires the host CPU microcode to support this feature before it
+can be used for guest CPUs.
 @end table
=20
=20
--=20
2.21.0


