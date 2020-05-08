Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95531C47255
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 18:05:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63C272184D
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 18:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZtCxYG3V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63C272184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX7NP-00026T-GY
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 14:05:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55262)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jX7Ln-0000Cl-0I
 for qemu-devel@nongnu.org; Fri, 08 May 2020 14:03:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31355
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jX7Lk-0007JL-Hb
 for qemu-devel@nongnu.org; Fri, 08 May 2020 14:03:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588961030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PQLMYYEI8PL6c8h28Vx0MCV7nQXRtHfkaEXos5JlrgI=;
 b=ZtCxYG3VzvT8MJVh41S/eFpQ7empSJM8YaR2VjDN/XnbnUkn2BIKy6FzVPhrHz2tSU3xF4
 2x5MNM8g5hiMM/LeMe+gxLzmGLufczsPQ64ldcSl73uoI4U4s+1RNP3z9vLGuM0Md/wzZg
 BlUT1Usr69FrzokORmhdntNd81SifP4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-u4jzXmS1NVCIJCZ5celltQ-1; Fri, 08 May 2020 14:03:47 -0400
X-MC-Unique: u4jzXmS1NVCIJCZ5celltQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87E6D835B40;
 Fri,  8 May 2020 18:03:46 +0000 (UTC)
Received: from blue.redhat.com (ovpn-114-73.phx2.redhat.com [10.3.114.73])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AB3DC6109E;
 Fri,  8 May 2020 18:03:43 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/9] qemu-img: Fix stale comments on doc location
Date: Fri,  8 May 2020 13:03:33 -0500
Message-Id: <20200508180340.675712-3-eblake@redhat.com>
In-Reply-To: <20200508180340.675712-1-eblake@redhat.com>
References: <20200508180340.675712-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 02:25:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Missed in commit e13c59fa.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qemu-img.c       | 2 +-
 qemu-img-cmds.hx | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 6a4327aaba56..b6e8af9202a5 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -108,7 +108,7 @@ static void QEMU_NORETURN unrecognized_option(const char *option)
     error_exit("unrecognized option '%s'", option);
 }

-/* Please keep in synch with qemu-img.texi */
+/* Please keep in synch with docs/tools/qemu-img.rst */
 static void QEMU_NORETURN help(void)
 {
     const char *help_msg =
diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
index c9c54de1df40..e0886437b1f2 100644
--- a/qemu-img-cmds.hx
+++ b/qemu-img-cmds.hx
@@ -7,7 +7,7 @@ HXCOMM command structures and help message.
 HXCOMM HXCOMM can be used for comments, discarded from both rST and C

 HXCOMM When amending the rST sections, please remember to copy the usage
-HXCOMM over to the per-command sections in qemu-img.texi.
+HXCOMM over to the per-command sections in docs/tools/qemu-img.rst.

 DEF("amend", img_amend,
     "amend [--object objectdef] [--image-opts] [-p] [-q] [-f fmt] [-t cache] -o options filename")
-- 
2.26.2


