Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00121C11D0F
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 16:23:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C39622465D
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 16:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hTWOrdRE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C39622465D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4obv-0002jC-0V
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 11:23:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56538)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j4oas-0001A6-2i
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:22:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j4oaq-00013c-LR
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:22:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41237
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j4oaq-000125-Gg
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:22:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582215747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=90XxUVJClHVX9ZIEzjbVDV0xE3nAzZrkmioDqBw5JMg=;
 b=hTWOrdREjp9hr+Xsa2K/xaroNBHaq1gFxASSPyTMwTaacGBemewC1MWb3ALZP3eWqlV5JZ
 ppfmNSVpiwee76IyNPApZPw4pBjtXkLFrjqdCjfT//RgLuSYeuPTZ2TuOlomOz+NF3Tfmf
 NO4HzYJ5Frs1LbLhNVxeJD8H3SV6A/g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224--lql1mL2MGG7MLX7ZDDmeA-1; Thu, 20 Feb 2020 11:22:19 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F40A4800D5A;
 Thu, 20 Feb 2020 16:22:17 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-180.phx2.redhat.com [10.3.116.180])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9F0CD1001281;
 Thu, 20 Feb 2020 16:22:17 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] maint: Include top-level *.rst files early in git diff
Date: Thu, 20 Feb 2020 10:22:13 -0600
Message-Id: <20200220162214.3474280-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: -lql1mL2MGG7MLX7ZDDmeA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
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
Cc: qemu-trivial@nongnu.org, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are converting more doc files to *.rst rather than *.texi.  Most
doc files are already listed early in diffs due to our catchall
docs/*, but a few top-level files get missed by that glob.

Signed-off-by: Eric Blake <eblake@redhat.com>
---

Both *.texi and *.rst entries make sense while we are still converting
things, but we'll need a followup to drop *.texi when the conversion
is complete...

 scripts/git.orderfile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/git.orderfile b/scripts/git.orderfile
index 1f747b583a9e..abd8a67a2b4e 100644
--- a/scripts/git.orderfile
+++ b/scripts/git.orderfile
@@ -11,6 +11,7 @@

 # Documentation
 docs/*
+*.rst
 *.texi

 # build system
--=20
2.24.1


