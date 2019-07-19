Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2872BC76188
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 13:39:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC76E2173B
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 13:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MxLXoUR/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC76E2173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoT6E-0007C1-9f
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 09:39:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38269)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hoT4n-0000Yq-2N
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:37:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hoT4m-0008NG-3v
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:37:32 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:35145)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
 id 1hoT4l-0008N0-Ur; Fri, 19 Jul 2019 09:37:32 -0400
Received: by mail-pg1-x543.google.com with SMTP id s1so8181674pgr.2;
 Fri, 19 Jul 2019 06:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5PwunZdX3lYy6VRIRqTKHiVhaugi0Tx2+fSQwVilljI=;
 b=MxLXoUR/o/2O1ZOFubEXpebb2iTccPddcbT9q7Z+TaZblktoGUafweLIbcI90VYgIX
 0i6V6aeOTMZl9zmW99/Z/bNZYVevUSU2QhQ3zaxyYRhllWIZ/CoOQ21Wy4v5Vp8URZYB
 XUsukgXgcrYZcua+C1z1nGL0smZ6P2iexzFu6/TiW/di5mbsoioX45ZL1pJf+vOIySkP
 Zj6SdZr/0IK6M23WJna7CePyfLj7DDiC9ZS1mRRWP4imhy4SSXOUP5DaRyvxkWQiDAVR
 UpSEiK5kqC7+a504X0fPQA4OIG85LtfU8VgUd9lINrfHaJrAlFZLGOyGMv3D+NGbJwfs
 2R5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5PwunZdX3lYy6VRIRqTKHiVhaugi0Tx2+fSQwVilljI=;
 b=VbN6aOeEeUu9KDRLVdU7J60/ezN1A8BYJgmMFMyEprzjUmBhNb43yQQbtBIc3POefx
 o3TXZ5VvOCfH10ZVJ8emHwdbKcN+GwdwtNzDJS9mvX4vOO1LapZUZFsALl27NUctiXVz
 +nkRVOwDeMhwQOlPtDreHAWT3pZ5BNDay2S0lqtrIGRhTWrnva8xFC4vEZ5L4vkGT09I
 cU0229WoOwg+h2g3YhHiAcnRN88ZPtiEAt2HqylKN+zeVJgfFsW6e/ClwyLEtY9+rECI
 PRxEXJ6BIrGfAzappHJqp/wM0CHzdZjyFP0UJQtDoEGdhya7eGFOiLhqYqzmzzDLm02J
 J7qA==
X-Gm-Message-State: APjAAAU3RYo/T064rPfFWjm0cyXbU102xVHwHl2oKfEB7hIooDBo7A28
 aW62MX3qTpxSwSvn4OkMOgxHW3xsqDU=
X-Google-Smtp-Source: APXvYqwa369re8m8ISWJL906oMmy5H5+CRovGcnHFt1OOeLZehDbM1okot/WH4i8+0vooYfZH0k2eA==
X-Received: by 2002:a17:90a:ab01:: with SMTP id
 m1mr55682783pjq.69.1563543450786; 
 Fri, 19 Jul 2019 06:37:30 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:433:31a4:f2fb:dab8:3a89:c056])
 by smtp.gmail.com with ESMTPSA id 11sm31895369pfw.33.2019.07.19.06.37.23
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 19 Jul 2019 06:37:30 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 19 Jul 2019 19:05:29 +0530
Message-Id: <20190719133530.28688-14-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190719133530.28688-1-mehta.aaru20@gmail.com>
References: <20190719133530.28688-1-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH v6 13/14] qemu-nbd: adds option for aio engines
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Sergio Lopez <slp@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 saket.sinha89@gmail.com, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefan@redhat.com>, Julia Suvorova <jusual@mail.ru>,
 Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
---
 qemu-nbd.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/qemu-nbd.c b/qemu-nbd.c
index a8cb39e510..e5a71b3501 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -135,7 +135,7 @@ static void usage(const char *name)
 "                            '[ID_OR_NAME]'\n"
 "  -n, --nocache             disable host cache\n"
 "      --cache=MODE          set cache mode (none, writeback, ...)\n"
-"      --aio=MODE            set AIO mode (native or threads)\n"
+"      --aio=MODE            set AIO mode (native, io_uring or threads)\n"
 "      --discard=MODE        set discard mode (ignore, unmap)\n"
 "      --detect-zeroes=MODE  set detect-zeroes mode (off, on, unmap)\n"
 "      --image-opts          treat FILE as a full set of image options\n"
@@ -718,13 +718,9 @@ int main(int argc, char **argv)
                 exit(EXIT_FAILURE);
             }
             seen_aio = true;
-            if (!strcmp(optarg, "native")) {
-                flags |= BDRV_O_NATIVE_AIO;
-            } else if (!strcmp(optarg, "threads")) {
-                /* this is the default */
-            } else {
-               error_report("invalid aio mode `%s'", optarg);
-               exit(EXIT_FAILURE);
+            if (bdrv_parse_aio(optarg, &flags) < 0) {
+                error_report("Invalid aio mode `%s'", optarg);
+                exit(EXIT_FAILURE);
             }
             break;
         case QEMU_NBD_OPT_DISCARD:
-- 
2.21.0


