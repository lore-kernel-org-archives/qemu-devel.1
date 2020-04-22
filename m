Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685F8C54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 13:38:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CFA12076E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 13:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WFFWDpUj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CFA12076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRFa4-0006jc-6r
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 09:38:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59174)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRFU8-0006Jo-Jg
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:32:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRFTx-00022F-4x
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:32:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40739
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jRFTw-0001zE-N5
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:32:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587562323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EddQPcYtdLgHdxZ2GiPc2DPPevSFRzd+HN7v8HerO6Q=;
 b=WFFWDpUjUg9Y/kxK1mo8jbcUPYfckW7hr5iUWgi6yH7vtZjqLUQ/hWX9cZwFsFag3oLyAU
 qGQWTJitngCimFFScDSXNjb1V7dBPqdyI5CMWH5sI/GFZHLnOBMxyYi2fw4WT6/ZA9wLGB
 x/73b5W/2XaeAJ/yFg+uZshq5k3tAU4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-gdLbxDQ8PbmTlYGGHgzZKQ-1; Wed, 22 Apr 2020 09:32:02 -0400
X-MC-Unique: gdLbxDQ8PbmTlYGGHgzZKQ-1
Received: by mail-wr1-f69.google.com with SMTP id j16so1027650wrw.20
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 06:32:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=W1lYGStJLCIwnYjiuY8mcwIaZ71ZmPjavSPH5JD14Mc=;
 b=bRXCCgPZqga7MdaySrnkl/eDyfEK40EXuuz8uDG58g25onzKxsDicjkjfBo+DcnJGN
 hmlkX90YcvddD8BdYboNnFWSu3fFO+kM3QVwdS/BwAW98gWP1eleCDea+spoxe7+wIle
 c37MysuJ7IQpv7EQ57omwgyH+alh3XmPkqERp/0B5voSYH358FzptxgvDyQ3EXYVfl4p
 8ap8GUmlTXj96IJ1aaIghPHFkpFH/7nV3tPbIQjBM7KFg7KQT+u1P+8J/UZ4jzHdoi8d
 LJObY24sooQNIxRHrHZ9/GGY5qMd9rXkjCQTEQVsRTuJjyENZhQpK10A5zvr4ujh6asu
 cdbw==
X-Gm-Message-State: AGi0PuYdNDzVTDR9KPUOItHeWLLmOSKeCesJVRbCrkxFwktICfOXJDL7
 uqStauuPJBC0US7lbC3k2L9P0bb4k15k+u0wwpWDWegrkExC260lhvw/yBWkIg4JwBU6s7B/VU5
 ggPolN7jI9pNlN/U=
X-Received: by 2002:adf:f0cb:: with SMTP id x11mr30143983wro.266.1587562320626; 
 Wed, 22 Apr 2020 06:32:00 -0700 (PDT)
X-Google-Smtp-Source: APiQypLQNZoYRve3BMh/BCsvwykR4XDFWol49DCJ0F1Tpd1HazAVoxGAfH3vkEkcxaX/yVgFs4TCUA==
X-Received: by 2002:adf:f0cb:: with SMTP id x11mr30143935wro.266.1587562319974; 
 Wed, 22 Apr 2020 06:31:59 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id u12sm8166030wmu.25.2020.04.22.06.31.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2020 06:31:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/9] block: Avoid dead assignment
Date: Wed, 22 Apr 2020 15:31:44 +0200
Message-Id: <20200422133152.16770-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200422133152.16770-1-philmd@redhat.com>
References: <20200422133152.16770-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 04:15:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>, qemu-trivial@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix warning reported by Clang static code analyzer:

  block.c:3167:5: warning: Value stored to 'ret' is never read
      ret =3D bdrv_fill_options(&options, filename, &flags, &local_err);
      ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fixes: 462f5bcf6
Reported-by: Clang Static Analyzer
Suggested-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block.c b/block.c
index 2e3905c99e..27e7e0e3ab 100644
--- a/block.c
+++ b/block.c
@@ -3171,7 +3171,7 @@ static BlockDriverState *bdrv_open_inherit(const char=
 *filename,
     }
=20
     ret =3D bdrv_fill_options(&options, filename, &flags, &local_err);
-    if (local_err) {
+    if (ret < 0) {
         goto fail;
     }
=20
--=20
2.21.1


