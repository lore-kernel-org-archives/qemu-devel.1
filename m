Return-Path: <SRS0=Kewn=DL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE421C47095
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 17:28:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B275206B6
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 17:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ew73Nkev"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B275206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kP7nm-0003bD-7b
	for qemu-devel@archiver.kernel.org; Sun, 04 Oct 2020 13:28:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40520)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kP7md-0002ds-PU
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 13:26:51 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34619)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kP7mc-0004Fz-FD
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 13:26:51 -0400
Received: by mail-wr1-x443.google.com with SMTP id t10so7047956wrv.1
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2020 10:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NPGQVpWhE+9vavo66WHyZDNXTtzu5s2rCVG2cEimRiQ=;
 b=Ew73NkeveXojqnd2oiSLyCuLavRz2FxTX+WrfPo+8jTX8VCZqxYuFECRpcJ6SMHhrK
 uSmYr3IjByooc2+L3RQB374itSmaKpUNme19ry4CiNrusIdlIw6wEmKOP1x/H9h2/O6E
 WIrTfLV8xoBT3ajXJzlzyntTMjCOlWgC1t3npbSDfiFaSXlMbRgZFa+5oa2c7WTMSC30
 uUVRCHqGTJPnzaQiQfIHGE21NFimvr98nUlUHgl/pM17uvUi1fHdAcT7KsADk0rfryhF
 JiALuFfC6c6Nf4uS5/MsHplK1NVU6+4HvK9LwPYSHVr71S76C9JzE7FzPo0hL2KBbozS
 ATPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=NPGQVpWhE+9vavo66WHyZDNXTtzu5s2rCVG2cEimRiQ=;
 b=rgidzCTwJkFXNVL0xzq8cNDYol62FGzYak6HB4/9Tt4/HMd6D65AWrbueX/usuqLPt
 PodZkmzHr7sceV4OSVCt+y2kedOWkhk/nCky7W5S3EhKBFLG3lCHBodAWj9l5E6darYu
 3N/kiSybIcixGzs4e744y48/Pdy3LIiTGdHk88J4qfLj5WsAsIgDPCm7MRcA88HW+Xom
 bizbXudjSxESO5pFuTJKtZ9HjSdRU50Zoex+2OKWPWt20Ses3ikwKdsNkWAZekj7MxRB
 9PtdGJ8EbzDPyf6XcBCVB5hrpK0lFJZ/4DRQNI8jw+TOiBcK/uaA9C6KGLCQVGNBhsqG
 V/2g==
X-Gm-Message-State: AOAM530n2qANRH8LOyhvsSJ6LttGy9dYWmnMGE2smkl5hbsEGfwOdMYL
 SJZ+V8rghIt7umnvr24a16x5etVNHVg=
X-Google-Smtp-Source: ABdhPJxZ0gxDOhfYzQ5nEVw8Qy+//GFUJfw95pkQGvAJAB3qDUfMJVTL1p4/1A1fdZYXpV06kUovIQ==
X-Received: by 2002:adf:ecc1:: with SMTP id s1mr1482625wro.120.1601832408332; 
 Sun, 04 Oct 2020 10:26:48 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id n2sm2709423wrt.82.2020.10.04.10.26.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2020 10:26:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] .mailmap: Correct Marek Dolata name
Date: Sun,  4 Oct 2020 19:26:43 +0200
Message-Id: <20201004172644.2027440-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201004172644.2027440-1-f4bug@amsat.org>
References: <20201004172644.2027440-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
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
Cc: Andrew Melnychenko <andrew@daynix.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Anup Patel <anup.patel@wdc.com>,
 Pan Nengyuan <pannengyuan@huawei.com>, David Carlier <devnexen@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Erik Smit <erik.lucas.smit@gmail.com>, Marek Dolata <mkdolata@us.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 5a07192a04 has email instead of name, triggering
warnings when using git-dm. Use the same name Marek Dolata
uses in other commits.

Cc: Marek Dolata <mkdolata@us.ibm.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index b914c9e290..2b9f3b4aa5 100644
--- a/.mailmap
+++ b/.mailmap
@@ -119,6 +119,7 @@ Luc Michel <luc.michel@git.antfield.fr>
 Luc Michel <luc.michel@greensocs.com>
 Marc Marí <marc.mari.barcelo@gmail.com>
 Marc Marí <markmb@redhat.com>
+Marek Dolata <mkdolata@us.ibm.com>
 Michael Avdienko <whitearchey@gmail.com>
 Michael S. Tsirkin <mst@redhat.com>
 Munkyu Im <munkyu.im@samsung.com>
-- 
2.26.2


