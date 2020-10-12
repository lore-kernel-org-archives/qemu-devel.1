Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5E4C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 23:45:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 155532078E
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 23:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ia8ZV2i/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 155532078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS7VS-0001N4-3t
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 19:45:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kS7UE-0008LG-G1; Mon, 12 Oct 2020 19:44:14 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633]:42061)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kS7UC-0007ho-Ot; Mon, 12 Oct 2020 19:44:14 -0400
Received: by mail-pl1-x633.google.com with SMTP id c6so9614105plr.9;
 Mon, 12 Oct 2020 16:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=y3umcJaYXKr0x2iVux7+4Z8Jw1GhDZ0QgyiRRBlED8Q=;
 b=Ia8ZV2i/5M+sVSz1sc2+nC1GKB77e1QVODPrMDxe+oqS4dIErVSZYRNUPo/TSeOjjO
 U1hmXE0azq0E3PXg7AIHTODVBNFbeMERtsL6rCh6X/dvz0b9vwgf0YPv9UHknxJ2R4it
 dvcuqRdNdbDGFDbvX9mcK97097nI+7awO2KAC2aJ/zLZ6n5GUy3oeRnY2EF/EBTNIUcv
 lTePvc+y9TQFhALIu3OvsVXlrYuR4Vyf8JasGzSaX8+O40lnqKLC58AdB4haemg1iXv0
 DzyvEJFwI35kka/R7VDb7QtX85vkBjQuuapsT9Y3oXw1I/AI07Ax71GlSZz57T+ETlrK
 V94Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=y3umcJaYXKr0x2iVux7+4Z8Jw1GhDZ0QgyiRRBlED8Q=;
 b=uRYTHO77/IWQGWo1du+yGiwb0WUGWfFoQlJzXsNPk6K2EL1WpWWmeq1rM/1PHSrvik
 c6PPRnBZOo9srOJKVRyFFLX/bQb8IvqL6DDLrM2WD1+YyHUiycUxgU3HYsZ0PBq3M+U2
 kP24yrSfEhAqCtpZRijdWWzaSRCFG43pjGk6rH/zIGvPzaHq9HKXTcYqhyQ1bXBsjBei
 goe30L83nufXLa31fWuQTagk4eZ2UP02E+65JOGfGWgIg/Y7ICCoOdlAHNGzHe3UioEy
 6PeaEtfU0RPee6FP6fJ/EoJrr8X7j/1g+LMJO6mgIm+1vTo0HHNqcEgU9ZyvMfIrkqVF
 /yNw==
X-Gm-Message-State: AOAM5303pCUUbQ7N80jq6+ciR9iprxhWFOX4682BfzHGcFZ8gRzJ47fd
 FkT0AFGzcsFmAOzvnJWpgNz1AQF/VUjPAw==
X-Google-Smtp-Source: ABdhPJz1PFc/VPND1lVZTsmVceuvrpOs3KVqBg4E2/O8xPQe96qZmA/hnfgOsU7ZEIYEB8cSY2W30A==
X-Received: by 2002:a17:902:24d:b029:d2:564c:654b with SMTP id
 71-20020a170902024db02900d2564c654bmr24336077plc.8.1602546250719; 
 Mon, 12 Oct 2020 16:44:10 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id j3sm9714890pjv.20.2020.10.12.16.44.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 16:44:09 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v9 1/5] configure: fixes indent of $meson setup
Date: Tue, 13 Oct 2020 07:43:44 +0800
Message-Id: <20201012234348.1427-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20201012234348.1427-1-luoyonggang@gmail.com>
References: <20201012234348.1427-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=luoyonggang@gmail.com; helo=mail-pl1-x633.google.com
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
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

convert these line from tab to space

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 configure | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/configure b/configure
index b553288c5e..1b63488521 100755
--- a/configure
+++ b/configure
@@ -7211,13 +7211,13 @@ NINJA=${ninja:-$PWD/ninjatool} $meson setup \
         -Db_pie=$(if test "$pie" = yes; then echo true; else echo false; fi) \
         -Db_staticpic=$(if test "$pie" = yes; then echo true; else echo false; fi) \
         -Db_coverage=$(if test "$gcov" = yes; then echo true; else echo false; fi) \
-	-Dmalloc=$malloc -Dmalloc_trim=$malloc_trim -Dsparse=$sparse \
-	-Dkvm=$kvm -Dhax=$hax -Dwhpx=$whpx -Dhvf=$hvf \
-	-Dxen=$xen -Dxen_pci_passthrough=$xen_pci_passthrough -Dtcg=$tcg \
-	-Dcocoa=$cocoa -Dmpath=$mpath -Dsdl=$sdl -Dsdl_image=$sdl_image \
-	-Dvnc=$vnc -Dvnc_sasl=$vnc_sasl -Dvnc_jpeg=$vnc_jpeg -Dvnc_png=$vnc_png \
-	-Dgettext=$gettext -Dxkbcommon=$xkbcommon -Du2f=$u2f \
-	-Dcapstone=$capstone -Dslirp=$slirp -Dfdt=$fdt \
+        -Dmalloc=$malloc -Dmalloc_trim=$malloc_trim -Dsparse=$sparse \
+        -Dkvm=$kvm -Dhax=$hax -Dwhpx=$whpx -Dhvf=$hvf \
+        -Dxen=$xen -Dxen_pci_passthrough=$xen_pci_passthrough -Dtcg=$tcg \
+        -Dcocoa=$cocoa -Dmpath=$mpath -Dsdl=$sdl -Dsdl_image=$sdl_image \
+        -Dvnc=$vnc -Dvnc_sasl=$vnc_sasl -Dvnc_jpeg=$vnc_jpeg -Dvnc_png=$vnc_png \
+        -Dgettext=$gettext -Dxkbcommon=$xkbcommon -Du2f=$u2f \
+        -Dcapstone=$capstone -Dslirp=$slirp -Dfdt=$fdt \
         $cross_arg \
         "$PWD" "$source_path"
 
-- 
2.28.0.windows.1


