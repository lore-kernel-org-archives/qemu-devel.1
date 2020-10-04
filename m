Return-Path: <SRS0=Kewn=DL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6A6C4363C
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 18:14:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38DD7206DD
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 18:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qYXeituD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38DD7206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kP8WJ-0006JP-Aa
	for qemu-devel@archiver.kernel.org; Sun, 04 Oct 2020 14:14:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45928)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kP8Nb-0002Jb-Ox
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 14:05:03 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54392)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kP8NZ-0008JS-VQ
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 14:05:03 -0400
Received: by mail-wm1-x344.google.com with SMTP id p15so1864137wmi.4
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2020 11:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oyavbmWIj/eOXW/LqQ5QFSBgtWxFz2/Zs/ME04i4zHA=;
 b=qYXeituD24Yk86iVZB6O7MD+rXIjZYKJNs1SIK8qBTuJEiz/mPJoEqZB5XcNbBfo6f
 IUsGxAbxr+ntIAPbr6JX2TG/5s8fxIowLwL6GLTv6nPyyNBZmth9n1ao70JBL6yGHJ92
 GUpksU7SOHXg4j8wkFMUDOPi5q00/0hjwfAwy7ql0IpNZXhlJYo8ZBDwGteeqmv1ufjj
 T+qnBgISDFE9SecxPayDpUl69iMiskN3s9pLtIsCXp6+MqXMeesOJke3fmoVsYz4Knc4
 s2IRFlKYi2WcyGbwauCYV+f4OGHinvhmbl1ZbQR3z+cTxS5MaQ4cYxb9QzAISO8qlfKc
 QoRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=oyavbmWIj/eOXW/LqQ5QFSBgtWxFz2/Zs/ME04i4zHA=;
 b=cu3mxxFwPANNQOjovtDXD65TDUqhp/KNxZ3K7h2wFLR4FGd8B7xAg1JEmyePMzZtDe
 2/6KztQXBcbpK24nITyTk3jwe1Lv0Takxt9AzoRQwgDSA1uuXVA+FKAWffEIC/PHD18i
 48XqMW7KPBL/HBYSnRdu4BP6FxylIt35+dtPX3yprFPb48X+cLNQArRpyxZ0lf1ie97G
 qQ6PS1GOY1JbtQfbpxmA+dm9U8Nuk/lRDi5ogzdbxvP+ehXEg4UczoYcxAq3cMYzKtzA
 HogneP8bljCmdTECs1QBIrolPkq+q3INVGbuhxCXsCLDUNxaRP11E7o4vIZL9GvCGXOM
 JakQ==
X-Gm-Message-State: AOAM5316BgUNK/zndELCKAaCpV/VsUZ22LSIJ749rM2OzBN4GiWlQ+sh
 s+avlkN0SM4F5CptvVZtz6IPUJt8+Sk=
X-Google-Smtp-Source: ABdhPJw/2X+je9jgS9QIZDgd/NAax5b8v1lt9B3pzlpRCRWL8FWfWcJIYPjmf1Z9SVdFMpIQPHviZw==
X-Received: by 2002:a1c:bbc6:: with SMTP id l189mr13632177wmf.52.1601834700358; 
 Sun, 04 Oct 2020 11:05:00 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id j10sm9593202wrn.2.2020.10.04.11.04.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2020 11:04:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 10/21] contrib/gitdm: Add Nuvia to the domain map
Date: Sun,  4 Oct 2020 20:04:32 +0200
Message-Id: <20201004180443.2035359-11-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201004180443.2035359-1-f4bug@amsat.org>
References: <20201004180443.2035359-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
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
Cc: Graeme Gregory <graeme@nuviainc.com>, Leif Lindholm <leif@nuviainc.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is a number of contributions from this domain,
add its own entry to the gitdm domain map.

Cc: Graeme Gregory <graeme@nuviainc.com>
Cc: Leif Lindholm <leif@nuviainc.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
One Reviewed-by/Ack-by from someone from this domain
should be sufficient to get this patch merged.
---
 contrib/gitdm/domain-map | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
index 39251fd97c..d7dca5efd4 100644
--- a/contrib/gitdm/domain-map
+++ b/contrib/gitdm/domain-map
@@ -25,6 +25,7 @@ codesourcery.com Mentor Graphics
 microsoft.com   Microsoft
 nokia.com       Nokia
 nutanix.com     Nutanix
+nuviainc.com    NUVIA
 oracle.com      Oracle
 proxmox.com     Proxmox
 redhat.com      Red Hat
-- 
2.26.2


