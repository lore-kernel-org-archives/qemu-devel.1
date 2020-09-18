Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BB0C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 14:46:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 248AE21973
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 14:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jlqDCbs7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 248AE21973
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJHes-0008Ra-5u
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 10:46:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kJHdo-0007eh-Bo; Fri, 18 Sep 2020 10:45:38 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e]:37524)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kJHdm-00048c-1x; Fri, 18 Sep 2020 10:45:36 -0400
Received: by mail-pj1-x102e.google.com with SMTP id kk9so3138469pjb.2;
 Fri, 18 Sep 2020 07:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KI9wi8wtXI4j9WWUYsI3+T64+fj4Vp22um09VqfofOU=;
 b=jlqDCbs7YH68PQj7GDzsfbzfrrMEwItV4Njj9aV0ZxIRfkZ0j4wGTgTffqu5GfKNea
 w8QIqGLxX5oMr4ExPg4vnss34aDmg72r+14YEc4AJVtlZcrbs7H1mh5oqtFFXsisElAP
 eMd6z5tQkwmVnb/T2IyN3iWD7SnOxnroXbHrH21poBWDDsxfW9MOctE8ZGy1upda2g06
 uWjdJ6DSLnwab4ax56ET69+rmWmwuAQfuVLKGOnSt7WYJ1BWflIAbpnXi0WA12Et5uV8
 zI3gKLZ+BnndJ31BE64fTcciLgk0vbl6z7uhNlAO18nBQzGFuuQASqzKupEoJ562VA75
 puyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KI9wi8wtXI4j9WWUYsI3+T64+fj4Vp22um09VqfofOU=;
 b=PI5AvYCDuFHCRJWuwaVC7B9tk0er0zWXKypzhMqA5xd0P1apzmbkLIibSts8SQ7zbH
 xO2Mo1K+Do77siQQBqvcOJz7JkZbG/BCRhK4O99QjoA121flrIV4/yZ8s8jqAXY+Z+w9
 12XeFS0fS67AtVFKJNHm5rLSubBsR538IYCn3ZZW9uh0lCcDmWws+g6BIEl75gk3qo4Z
 KWPWcG6a6V+BfZ88mWRe+uzlyrk8tOLzuZODYrMXGnvOJ1EkciUW95cWAq4WDUukVIig
 URMANJC00UKvV+7HsX7KckvPVyDB3uFcyQldrMbQcWQ5hu3yH0P/CUz2JXFCSDLOLQQq
 mYoA==
X-Gm-Message-State: AOAM532j6tnznuMFB0uZDYm9eCOegajQFe4dcI9Mss+ZMFH0ivk9jCub
 fIDyLDV9QKdD7DCUtUjfc3jlsiOMEX0UCg==
X-Google-Smtp-Source: ABdhPJwTbPOLOeghdZEKNWD260eCzY0Ps0gkVH7XQ6jQ+aNff+qDhJh5WIQ1gAepugQEJLJqcfgpRw==
X-Received: by 2002:a17:90a:c28e:: with SMTP id
 f14mr13152584pjt.83.1600440331498; 
 Fri, 18 Sep 2020 07:45:31 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id k7sm3178184pjs.9.2020.09.18.07.45.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 07:45:30 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] configure: fixes indent of $meson setup
Date: Fri, 18 Sep 2020 22:45:12 +0800
Message-Id: <20200918144512.978-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x102e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

convert these line from tab to space

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 configure | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/configure b/configure
index 3757e48b17..422b1ef2a3 100755
--- a/configure
+++ b/configure
@@ -7850,10 +7850,10 @@ NINJA=${ninja:-$PWD/ninjatool} $meson setup \
         -Dstrip=$(if test "$strip_opt" = yes; then echo true; else echo false; fi) \
         -Db_pie=$(if test "$pie" = yes; then echo true; else echo false; fi) \
         -Db_coverage=$(if test "$gcov" = yes; then echo true; else echo false; fi) \
-	-Dmalloc=$malloc -Dmalloc_trim=$malloc_trim \
-	-Dcocoa=$cocoa -Dmpath=$mpath -Dsdl=$sdl -Dsdl_image=$sdl_image \
-	-Dvnc=$vnc -Dvnc_sasl=$vnc_sasl -Dvnc_jpeg=$vnc_jpeg -Dvnc_png=$vnc_png \
-	-Dgettext=$gettext -Dxkbcommon=$xkbcommon -Du2f=$u2f\
+        -Dmalloc=$malloc -Dmalloc_trim=$malloc_trim \
+        -Dcocoa=$cocoa -Dmpath=$mpath -Dsdl=$sdl -Dsdl_image=$sdl_image \
+        -Dvnc=$vnc -Dvnc_sasl=$vnc_sasl -Dvnc_jpeg=$vnc_jpeg -Dvnc_png=$vnc_png \
+        -Dgettext=$gettext -Dxkbcommon=$xkbcommon -Du2f=$u2f \
         $cross_arg \
         "$PWD" "$source_path"
 
-- 
2.28.0.windows.1


