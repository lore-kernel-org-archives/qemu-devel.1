Return-Path: <SRS0=Kewn=DL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CEEC4363C
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 18:10:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0E43206B6
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 18:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikfv9EUy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0E43206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kP8SY-0008D8-2E
	for qemu-devel@archiver.kernel.org; Sun, 04 Oct 2020 14:10:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kP8Nd-0002NS-AV
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 14:05:05 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42947)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kP8Na-0008Jc-Ui
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 14:05:04 -0400
Received: by mail-wr1-x441.google.com with SMTP id e18so1181613wrw.9
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2020 11:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vh4+AuQar0YnwnSPAY0Sx99++Yu4SLhLBMcb3f0gv+Y=;
 b=ikfv9EUyqff2zVoYE96pF4eliOU6+RkSMGTnAUYKFL4G2uTdzgHo+Zu0C+ZSaO/zDc
 pSRUfKmURsTbvqqpoVi3OivuWeBpmcsUnI8zzI69I12z4Yi/VuNXNeR4ZPa6odohijCJ
 Ic9GBESjJ2Kta5Y0kmgIaMQrmnOJBgNpMqqOTmlK/RMc5REEoXK0nyMXeuatWDZaS/gI
 nAbCdMH4p9gWNdiRl5hvg8hfknXhQOzgNuP5sckFPce00WgGn6MXHSKh4Yq7L3rSQL86
 iGEG9lna94KKxkFilFurp964d/HBjMFFJeJCAlNuLbmf0emKuMfDoMn7RDu4+IZ+lCa/
 SLQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=vh4+AuQar0YnwnSPAY0Sx99++Yu4SLhLBMcb3f0gv+Y=;
 b=i/bODzTkmgkNa9URkigPpBkfauo830FxtV/0Eul7B6jp+edNymfQJl7wDiUxu14QA6
 bMQzL4SBhR3dHoZpqj+HI2GXDU/i+Vt9fqOxmL4EJukj+urxA/EwgfYKmjx/QXGUllJn
 rI4MrvKpmvUQfVsixTAbLvxdhYtj0TFgss3wz6P6Auai1cihfFBDRGF/QCX/qlPj2Hxv
 PymXauq2Etr0SKiY1suwgDUiLbAWGsNk41C913UhPpjkEeWiwYndCAPR168PP0LVLn0y
 soULABlRrI2Pnuj91R5JEI3vsD2bCTuk4QMyGkPVWvdL0X3aF8qcY4FlwRkM5S6+G8wu
 vFUQ==
X-Gm-Message-State: AOAM5336kBenyGP0czo+dmEzVQGG/L97Gbgp/IBAUHRdM+lq+PQbMHQP
 ulP6L30QS8m2ILDKQg68e1NEEnVP/ow=
X-Google-Smtp-Source: ABdhPJzf2VE82thp8lGJuysJDBSHmKSDF71PE8IyxUKcx/ij0FVAWv+LYqy69Sc5v9qy72CuuHrkZA==
X-Received: by 2002:a05:6000:1282:: with SMTP id
 f2mr14324045wrx.251.1601834701351; 
 Sun, 04 Oct 2020 11:05:01 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id j10sm9593202wrn.2.2020.10.04.11.05.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2020 11:05:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 11/21] contrib/gitdm: Add Yuval Shaia to Oracle group
Date: Sun,  4 Oct 2020 20:04:33 +0200
Message-Id: <20201004180443.2035359-12-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201004180443.2035359-1-f4bug@amsat.org>
References: <20201004180443.2035359-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Yuval Shaia <yuval.shaia@oracle.com>, Yuval Shaia <yuval.shaia.ml@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc: Yuval Shaia <yuval.shaia@oracle.com>
Cc: Yuval Shaia <yuval.shaia.ml@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Yuval, if you agree with your entry, please reply with a
Reviewed-by/Acked-by tag and I'll repost it in 2 weeks as
a formal patch (not RFC). If you disagree or doesn't
care, please either reply with Nack-by or ignore this patch.
---
 contrib/gitdm/group-map-oracle | 1 +
 gitdm.config                   | 1 +
 2 files changed, 2 insertions(+)
 create mode 100644 contrib/gitdm/group-map-oracle

diff --git a/contrib/gitdm/group-map-oracle b/contrib/gitdm/group-map-oracle
new file mode 100644
index 0000000000..c07d5a3d06
--- /dev/null
+++ b/contrib/gitdm/group-map-oracle
@@ -0,0 +1 @@
+yuval.shaia.ml@gmail.com
diff --git a/gitdm.config b/gitdm.config
index 4f821ab8ba..1c56131769 100644
--- a/gitdm.config
+++ b/gitdm.config
@@ -38,6 +38,7 @@ GroupMap contrib/gitdm/group-map-codeweavers CodeWeavers
 GroupMap contrib/gitdm/group-map-ibm IBM
 GroupMap contrib/gitdm/group-map-janustech Janus Technologies
 GroupMap contrib/gitdm/group-map-nutanix Nutanix
+GroupMap contrib/gitdm/group-map-oracle Oracle
 
 # Also group together our prolific individual contributors
 # and those working under academic auspices
-- 
2.26.2


