Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59EE3C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:49:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED52622248
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AGM8mJ2B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED52622248
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQvaI-0006pY-4B
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 12:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38548)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQvJj-0000Xd-Gi
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:32:27 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:42248)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQvJU-0005Cd-BA
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:32:23 -0400
Received: by mail-wr1-x435.google.com with SMTP id e18so10926762wrw.9
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 09:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QqtXKjYW6ApcjtfgWOgvPA89m4RzA0xWqb09wuhc5Z8=;
 b=AGM8mJ2BXAkxdb2gK7ZUINgzj9A5jq8mD/dBVee9LMuQW5v5tDRMl3HuzOik4zk0r5
 dkBZD9Xez3dW7FKpnqg6r2Kpbi8H3f0Bjqv+FIMsDXxbMWlKhNc4mvK87W9DA4EhK9nw
 MYxwnysSAKWgP2B/w7CDiolsIWQ+LrPHZPoiufRb/8q1/fYD4IGb2+C40PH6F0YOzI0S
 ae/Kn7Tm2wQEWneUGNZzED0+YbkV6MRXa1m0PBqJigGt1SBbD9nmTnQKjrBj5C+N2y2W
 T/K++SFXK9WdFUss7z1OcVhb+75nN+3D+eMqq9w6rdJteihwSyPu6yzi1xHAvym03iv2
 OoEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QqtXKjYW6ApcjtfgWOgvPA89m4RzA0xWqb09wuhc5Z8=;
 b=KSnRI0HDppLs4iGYq+cn1N1wrmdyuu1EyOui4xFnfUKbkqfxwHW31T/SqSzbQV0gC2
 ccMjeonylcZ74SJTgaG3r2l37jvI2F2k+nwGioBzP3xdLIDcqpQlV7+KPIwKoeAkj1G9
 dEUGAFRhMmBmFS/YEs8BQ15K/YhxKj9jLRw8xP5CSleFT6u5DIWrqPefpMp5KruViIDT
 KeshIAGEKILolvr2+gPCyjHjw/ZlDSLtnchDnvtQNrJNX2quQUp6kYUepF0pEEAC/3xD
 InwN/5WqjsYtSzHLoLIBmFi6wQxMROip2j4ZtS4uCsQdoa/mRBZJXDFt7prAtDr26/TS
 /GfQ==
X-Gm-Message-State: AOAM530yPx2EVlVL0uRWb72uqx4VxgH8DAo724I18ofmVuoV+O5QeUiz
 w/Msubzw3Z+qj6kkyacIjncOZg==
X-Google-Smtp-Source: ABdhPJy7x7KsoCS1mvJjxAk43tfM3XtLcAYbH3YUp7NNGgbET1aF+bmIn7wYJpynzeUE0J/NKn251A==
X-Received: by 2002:adf:f508:: with SMTP id q8mr15065557wro.233.1602261130910; 
 Fri, 09 Oct 2020 09:32:10 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e3sm8659496wra.90.2020.10.09.09.31.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2020 09:32:06 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3E0BF1FF9C;
 Fri,  9 Oct 2020 17:31:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 13/22] contrib/gitdm: Add Qualcomm to the domain map
Date: Fri,  9 Oct 2020 17:31:38 +0100
Message-Id: <20201009163147.28512-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201009163147.28512-1-alex.bennee@linaro.org>
References: <20201009163147.28512-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Taylor Simpson <tsimpson@quicinc.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

There is a number of contributions from this domain,
add its own entry to the gitdm domain map.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Taylor Simpson <tsimpson@quicinc.com>
Message-Id: <20201006160653.2391972-8-f4bug@amsat.org>
Message-Id: <20201007160038.26953-14-alex.bennee@linaro.org>

diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
index 14c0582060..6c5c92260d 100644
--- a/contrib/gitdm/domain-map
+++ b/contrib/gitdm/domain-map
@@ -22,6 +22,7 @@ nokia.com       Nokia
 nuviainc.com    NUVIA
 oracle.com      Oracle
 proxmox.com     Proxmox
+quicinc.com     Qualcomm Innovation Center
 redhat.com      Red Hat
 rt-rk.com       RT-RK
 siemens.com     Siemens
-- 
2.20.1


