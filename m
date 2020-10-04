Return-Path: <SRS0=Kewn=DL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2AEC4363C
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 17:28:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F841206B6
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 17:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="teA9g1kb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F841206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kP7nl-0003ZJ-Bp
	for qemu-devel@archiver.kernel.org; Sun, 04 Oct 2020 13:28:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kP7mc-0002dS-Kx
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 13:26:50 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39319)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kP7ma-0004Fr-Ls
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 13:26:50 -0400
Received: by mail-wm1-x343.google.com with SMTP id t17so6497973wmi.4
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2020 10:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0rN7wdmbD8KzNLwzlfv+wIlccbkVnWOQiCegW/AYLvM=;
 b=teA9g1kbD831xV2nhssjssjMOiDMXeIkX3IPgWhzFIHrLgwWDHgDI4EzEOCkuyats2
 8jfV4EW0403i+4quyYQTyT4X7oGOkGVaWgoWqFc5Lp+IKlrlKRueGrXONrUgjKdkLkdX
 hgrq/khFm1Cid/7KdUWncgwzeXJRschi1VqGaIHsKn/8p74//DWOUrvS/EPwxhj/Q1Eb
 5vGUOF1luMAEBqcQ33/XJp8Iszlv+hRf9A8Ote5suntHZeXl5RwLKMn2FBDox9PP3dg1
 hC0HZURXsMEECDhpHQiZYOiaUfdD637Xac7vaLKnvAZzkBH9Nk7R0ukqnoPr/gxHBUDG
 zQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=0rN7wdmbD8KzNLwzlfv+wIlccbkVnWOQiCegW/AYLvM=;
 b=IovR5hx8jld16zR5AKpnkNJXtjcVQVgO3cN8J7FUo8Klg3LX7IgcplokUw5LFAQLjm
 zwC0nnCklo9v3mtRjtEsFOdGVQS/ldJl5ktQix3g6cfZiE6Tc1N91OIiItO5H5ivFUH1
 RHim5SBBvtriz/kKBJADXz1NZ4lpWvWa3osieqByPdwCwbQmnYQz9L1/K0spterlWQbI
 p2G4h3Lpc7xZ+XjVpEP1aAiJ9cPH/51dq8aVWfjj6oPlK9QprNLuOuWyTMeRUCU9pViJ
 /TjaiLN113oXZmYPvPiw3pl4P2gC4fgeRKkxpgqW36PZUmmyLdR5tDkoKTeptVd/ly2H
 fZ+A==
X-Gm-Message-State: AOAM531kNEIFh/CLplnAZrUYCZTazX2aTDV37gcrxj5gnPaIxVOUvTO3
 ihvoy1j6YQLLjuFE6eL5tdbc4WDKFOM=
X-Google-Smtp-Source: ABdhPJzIB0NwufyQdd0TFbNVSojPN3xjhcjnRgHYqEMwvekkG7pFNMxaE7HrPR0MtYWfh9ZoLYU1Rw==
X-Received: by 2002:a1c:9c4b:: with SMTP id f72mr12742901wme.188.1601832406979; 
 Sun, 04 Oct 2020 10:26:46 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id n2sm2709423wrt.82.2020.10.04.10.26.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2020 10:26:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] .mailmap: Fixes since v5.1
Date: Sun,  4 Oct 2020 19:26:42 +0200
Message-Id: <20201004172644.2027440-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
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

Fix incorrect entries committed during 5.1-5.2.

To the developers Cc'ed:

If you agree with your entry, please reply with a Reviewed-by /
Acked-by tag. If you disagree or doesn't care, please either
reply with Nack-by or ignore this patch.
I'll repost in 2 weeks as formal patch (not RFC) with only the
entries acked by their author.

Regards,

Phil.

Philippe Mathieu-Daudé (2):
  .mailmap: Correct Marek Dolata name
  .mailmap: Fix more contributor entries

 .mailmap | 8 ++++++++
 1 file changed, 8 insertions(+)

-- 
2.26.2


