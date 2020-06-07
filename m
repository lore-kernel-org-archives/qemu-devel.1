Return-Path: <SRS0=Pynu=7U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E55C433DF
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2020 08:58:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F416D206D5
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2020 08:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=qubes-os.org header.i=frederic.pierret@qubes-os.org header.b="iP9Hm/F3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F416D206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=qubes-os.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhr8L-0005Mg-7z
	for qemu-devel@archiver.kernel.org; Sun, 07 Jun 2020 04:58:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frederic.pierret@qubes-os.org>)
 id 1jhr7n-0004xc-0z
 for qemu-devel@nongnu.org; Sun, 07 Jun 2020 04:57:51 -0400
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21357)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <frederic.pierret@qubes-os.org>)
 id 1jhr7l-0007ly-AQ
 for qemu-devel@nongnu.org; Sun, 07 Jun 2020 04:57:50 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1591520264; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=hFhak2Fm6dOOZgp5Yut2iN1nUPOp6KV/lebiZ/MxcYByAjBnWHuq5hEbLssQMuOi5b+ms4mjwGXAzq6Awn9NlThbwrl7lzPKN6HjT2Gai6jbuc5EZfOgxxmIotO8dN5exqtYcrnYNYIGCF1Gc1bmGKtgcfdL9V43dUwBGTzR6QY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1591520264;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To;
 bh=5K0n9KAIGrnMivdFLw/siNJnwku7ZT6lY9+wjhqTUqw=; 
 b=Qq6D4ZWkppTyTKz8+KWSAPHx3FYjb5RO4njftD7eTI3reW6Pnc/+illlCwXdIAVOQQuOesmIQ9FXS69lPjyhstIzXYCxCbwUm7TEUrl+rvRNKn5gZ1oAcbLA9CqwSwZp6CHzEEXvxENjHaql8XHP/bxIylr1wPj+bhOx7knbX90=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=qubes-os.org;
 spf=pass  smtp.mailfrom=frederic.pierret@qubes-os.org;
 dmarc=pass header.from=<frederic.pierret@qubes-os.org>
 header.from=<frederic.pierret@qubes-os.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1591520264; 
 s=s; d=qubes-os.org; i=frederic.pierret@qubes-os.org;
 h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
 bh=5K0n9KAIGrnMivdFLw/siNJnwku7ZT6lY9+wjhqTUqw=;
 b=iP9Hm/F3zYwLnPNOraUXoaaNXR+vGAF+6hx3xCeg7th+LWuVXFYY+qCt6Bv/c+e1
 rFdAE4XddIqRU+8JdQukpL6MCUUBtuEAQzAHgfkJBxbxPwu58wXpEEPoBKqCfQXZwmb
 L7a5web3wLRnz6ZiwLzozO1kZvKhvvNSLy2zzLnw=
Received: from localhost.localdomain (92.188.110.153 [92.188.110.153]) by
 mx.zohomail.com with SMTPS id 1591520262762433.57643671614005;
 Sun, 7 Jun 2020 01:57:42 -0700 (PDT)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Pierret=20=28fepitre=29?=
 <frederic.pierret@qubes-os.org>
To: qemu-devel@nongnu.org
Message-ID: <20200607085639.7640-1-frederic.pierret@qubes-os.org>
Subject: [PATCH] Makefile: set PYTHON to python2 instead of python
Date: Sun,  7 Jun 2020 10:56:40 +0200
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
Received-SPF: pass client-ip=136.143.188.53;
 envelope-from=frederic.pierret@qubes-os.org; helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/07 04:57:46
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Pierret=20=28fepitre=29?=
 <frederic.pierret@qubes-os.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Newer distro like CentOS 8 does not include any reference
to 'python' binary but only 'python2'.
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index c20be15..995dc86 100644
--- a/Makefile
+++ b/Makefile
@@ -22,7 +22,7 @@ LD=3D$(CROSS_PREFIX)ld
 OBJCOPY=3D$(CROSS_PREFIX)objcopy
 OBJDUMP=3D$(CROSS_PREFIX)objdump
 STRIP=3D$(CROSS_PREFIX)strip
-PYTHON=3Dpython
+PYTHON=3Dpython2
 CPP=3Dcpp
 IASL:=3Diasl
 LD32BIT_FLAG:=3D-melf_i386
--=20
2.25.4



