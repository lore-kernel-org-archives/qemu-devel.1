Return-Path: <SRS0=Kewn=DL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B19BC4363C
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 18:13:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B426F206B6
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 18:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPCluonC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B426F206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kP8Vt-0005jJ-SF
	for qemu-devel@archiver.kernel.org; Sun, 04 Oct 2020 14:13:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kP8Nb-0002K2-Sw
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 14:05:03 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:43965)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kP8NZ-0008JN-VJ
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 14:05:03 -0400
Received: by mail-wr1-x42f.google.com with SMTP id g12so1662687wrp.10
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2020 11:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=D/Kyoh7t+Y9PYvCwdYS4pSQU39+GJU7zpdwNIUsxLz0=;
 b=FPCluonCEM9wtw0JQsG8LKtJnylKNgk6VCrI/gdNpbjMfP58Erddx1H5B3hrzZUjx0
 nb25HQBRjz4XV5yIBMMBGph4/9BlI6ywMIrokXPxmzuPYq66ShaD3Fq4bVl/JZBweEkz
 pCGGUnLsiXIQ/Qf6053PAyGf7TO8a10sg0s61eWEru8as/heM64wHQsI82hqr5Z5SD3A
 S3RyK5CSX2pa8KXgCgWTD2QB20bUH/FlpWGgI2wXgbDJbh9AFy4VV+zZ2tLRBwg4Yyce
 o33OVwRzEMWUEdqpebaFaDuMkF3sUVtwnpw/vHcjzp2i0fy6MCP0uBTcS0rWDMYMWNGs
 2cbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=D/Kyoh7t+Y9PYvCwdYS4pSQU39+GJU7zpdwNIUsxLz0=;
 b=Xbp2qJ2Ro68/pssJjGnuW2Xd5xKkXjq87aTagSCrCBdD1GDeFhVUss7Z5tajgFXi0T
 3hWZt24v2whZKfn9si4j/UtWAuThXUnya73A7cKp5oQCWkXtT3YS1Cv7f/WCUt8/e0GZ
 yXBRokFbIojAPpRTHaiQzfnVm0OueIF3exrrH+vrpBPF96BAnf47spKuEGu9fqUtI4Qy
 /T0+u/R3fDcecDvpG8EqX0+mDUbpSCB7GH30+Oj7rBMBkCYcIrTb87w9wgJ6MPhb+y3s
 UnsMSQLXO8mpWICFGGOdk3MsnRPTHl8bxea72wUX6RN8+RY1WEx9ZAGwjXthGdcF+2N8
 NCeA==
X-Gm-Message-State: AOAM530fSFM7GD/TI9NLpWsQwGJ/AeXpKGn7tD0XiLhC0iqQGCCbus35
 q9nhwOP+4DiWrVb3ttKDfh1pYTObZ+P6BQ==
X-Google-Smtp-Source: ABdhPJxyieWapNMM67vFpiIeMRqEgbjJ1SBIpPYuWidpfAymLZ93YQIf2BeaM61OER6seA4heIOUow==
X-Received: by 2002:adf:ab46:: with SMTP id r6mr7805444wrc.360.1601834699339; 
 Sun, 04 Oct 2020 11:04:59 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id j10sm9593202wrn.2.2020.10.04.11.04.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2020 11:04:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 09/21] contrib/gitdm: Add Nutanix to the domain map
Date: Sun,  4 Oct 2020 20:04:31 +0200
Message-Id: <20201004180443.2035359-10-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201004180443.2035359-1-f4bug@amsat.org>
References: <20201004180443.2035359-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42f.google.com
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
Cc: Mike Cui <cui@nutanix.com>, Peter Turschmid <peter.turschm@nutanix.com>,
 Ani Sinha <ani.sinha@nutanix.com>, Swapnil Ingle <swapnil.ingle@nutanix.com>,
 Prerna Saxena <prerna.saxena@nutanix.com>,
 Malcolm Crossley <malcolm@nutanix.com>,
 David Vrabel <david.vrabel@nutanix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>, Ani Sinha <ani@anisinha.ca>,
 Felipe Franciosi <felipe@nutanix.com>,
 Jonathan Davies <jonathan.davies@nutanix.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is a number of contributors from this domain,
add its own entry to the gitdm domain map.

Cc: Ani Sinha <ani.sinha@nutanix.com>
Cc: David Vrabel <david.vrabel@nutanix.com>
Cc: Felipe Franciosi <felipe@nutanix.com>
Cc: Jonathan Davies <jonathan.davies@nutanix.com>
Cc: Malcolm Crossley <malcolm@nutanix.com>
Cc: Mike Cui <cui@nutanix.com>
Cc: Peter Turschmid <peter.turschm@nutanix.com>
Cc: Prerna Saxena <prerna.saxena@nutanix.com>
Cc: Raphael Norwitz <raphael.norwitz@nutanix.com>
Cc: Swapnil Ingle <swapnil.ingle@nutanix.com>
Cc: Ani Sinha <ani@anisinha.ca>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
One Reviewed-by/Ack-by from someone from this domain
should be sufficient to get this patch merged.

Ani, can you confirm the ani@anisinha.ca email?
Should it go into 'individual contributors' instead?
---
 contrib/gitdm/domain-map        | 1 +
 contrib/gitdm/group-map-nutanix | 2 ++
 gitdm.config                    | 1 +
 3 files changed, 4 insertions(+)
 create mode 100644 contrib/gitdm/group-map-nutanix

diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
index 4850eab4c4..39251fd97c 100644
--- a/contrib/gitdm/domain-map
+++ b/contrib/gitdm/domain-map
@@ -24,6 +24,7 @@ linaro.org      Linaro
 codesourcery.com Mentor Graphics
 microsoft.com   Microsoft
 nokia.com       Nokia
+nutanix.com     Nutanix
 oracle.com      Oracle
 proxmox.com     Proxmox
 redhat.com      Red Hat
diff --git a/contrib/gitdm/group-map-nutanix b/contrib/gitdm/group-map-nutanix
new file mode 100644
index 0000000000..a3f11425b3
--- /dev/null
+++ b/contrib/gitdm/group-map-nutanix
@@ -0,0 +1,2 @@
+raphael.s.norwitz@gmail.com
+ani@anisinha.ca
diff --git a/gitdm.config b/gitdm.config
index c01c219078..4f821ab8ba 100644
--- a/gitdm.config
+++ b/gitdm.config
@@ -37,6 +37,7 @@ GroupMap contrib/gitdm/group-map-cadence Cadence Design Systems
 GroupMap contrib/gitdm/group-map-codeweavers CodeWeavers
 GroupMap contrib/gitdm/group-map-ibm IBM
 GroupMap contrib/gitdm/group-map-janustech Janus Technologies
+GroupMap contrib/gitdm/group-map-nutanix Nutanix
 
 # Also group together our prolific individual contributors
 # and those working under academic auspices
-- 
2.26.2


