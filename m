Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219B8C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 02:06:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF6AB20823
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 02:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hostfission.com header.i=@hostfission.com header.b="EAGSwINr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF6AB20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=hostfission.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjZ5i-0001P4-6o
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 22:06:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57298)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <geoff@hostfission.com>)
 id 1jjZ3b-0005ok-SZ
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 22:04:35 -0400
Received: from mail1.hostfission.com ([139.99.139.48]:34044)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <geoff@hostfission.com>) id 1jjZ3a-0004tq-6I
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 22:04:35 -0400
Received: from moya.office.hostfission.com (office.hostfission.com
 [220.233.29.71])
 by mail1.hostfission.com (Postfix) with ESMTP id C24FF443E9;
 Fri, 12 Jun 2020 12:04:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hostfission.com;
 s=mail; t=1591927471;
 bh=gPfDx0oOx78hVDtbsa3uYMHvYIzSXfoDfgaF8sNcNrE=;
 h=From:Date:Subject:To:Cc:From;
 b=EAGSwINrJEQihYpFZHZNP7EKb5z71uEqKvOiUoTNBOBefbNyLaZII8UVZSZnySxDT
 kRwPPXHp81VNBGugfhf0eXF3e+4n5ca5Rx0qNZyxX7o0BF+3YIul+xcHKRugtZViKZ
 RiVOtstvioc+PVO8A1EkbIyluawg2uRqjcugbY9g=
Received: by moya.office.hostfission.com (Postfix, from userid 0)
 id AD38F3A0172; Fri, 12 Jun 2020 12:04:31 +1000 (AEST)
From: Geoffrey McRae <geoff@hostfission.com>
Date: Fri, 12 Jun 2020 01:14:19 +1000
Subject: [PATCH 3/6] audio/jack: remove invalid set of input support bool
To: <qemu-devel@nongnu.org>
Cc: <kraxel@redhat.com>
X-Mailer: mail (GNU Mailutils 3.5)
Message-Id: <20200612020431.AD38F3A0172@moya.office.hostfission.com>
Received-SPF: pass client-ip=139.99.139.48; envelope-from=geoff@hostfission.com;
 helo=mail1.hostfission.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 20:16:15
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Geoffrey McRae <geoff@hostfission.com>
---
 audio/jackaudio.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/audio/jackaudio.c b/audio/jackaudio.c
index fb8efd7af7..58c7344497 100644
--- a/audio/jackaudio.c
+++ b/audio/jackaudio.c
@@ -607,9 +607,6 @@ static int qjack_thread_creator(jack_native_thread_t *thread,
 static void *qjack_init(Audiodev *dev)
 {
     assert(dev->driver == AUDIODEV_DRIVER_JACK);
-
-    dev->u.jack.has_in = false;
-
     return dev;
 }
 
-- 
2.20.1


