Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D499C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 08:53:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37DB820734
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 08:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNUSY8n/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37DB820734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg2fs-0003X5-Fg
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 04:53:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37676)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jg2f8-0002rP-SR
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 04:52:46 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c]:34602)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jg2f8-0005oF-6H
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 04:52:46 -0400
Received: by mail-ed1-x52c.google.com with SMTP id w7so5755878edt.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 01:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Jne8ZIrCq5Hz36DpkBP1vaJ9T3qWA9tudkPN9cfyEiY=;
 b=LNUSY8n/X7d2ChaPVnWY+m2vEO2N+I5Pyo9+S6FyzDcGOV9nfXqCBwLFbx5r4ZMdzB
 lih29uTxPi+UtUd/Z7q+AqRt1FEYmmgAGSQyRDD5wRMj+HyALKcIvxYBwe/FEFhnVlgg
 J8wpqT/+7114v/jhL8vwsy8N9x4H/rFtJZoISSBJ7OXxYpKzZYIdSWR1D19KDcBxqcwX
 sXAGSbiD0ZfCR9jvtTsR+vdHXNcaltbw2BsI4rvlEhIwEdcPRv88cBXeSQwt4fDUWNlg
 bXr2RYzSuYXnxDCwDVnOZyLeX6koQr8taXcOFpbHgFq4MiMZJ6h3pz95wcI5mP81GoHA
 rKbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Jne8ZIrCq5Hz36DpkBP1vaJ9T3qWA9tudkPN9cfyEiY=;
 b=XUqgPRAi8UzK1aSE0Sd7fnfo7rMFrgaA4WGBaTS25IG8eKBogTpifD0w7sKn4bwbM/
 nYyaT5nic9MYEnAsLI//xmwNkYPFzXHJ/Kgb797soNGIh75fYSxuYw1QzHxyh/uLGOyQ
 7iPXBGooVssa8KnAfnGJ9z0ENAi0UJWJP3EBHYZK7J5qKFq5cKgSZtYB9ggrTqmNzZ86
 bYA4olOZiY7/INI9ggj09w3g3CxO4LtjdNiNAEvDfUcMJNIYve0GkTYRwD25f8YF0FAc
 1aESj92pg18tRzkGWm+yoPa2gNlrbOmDTeFkYLYIWImbMtiQ6OBfNj1IVy+a4xAbkoMi
 tnwA==
X-Gm-Message-State: AOAM532MBajFLYL55vTI3UdqMNe43RRS2f4Uf5GLiPObenvfNS5/lOou
 ToDJPmG8mA1Z3X/z1wR03+5Z31GLCTQ=
X-Google-Smtp-Source: ABdhPJwyv9HswkHQ679Z9cd+EZu3oTDpRHA3pD9w8dQ+sLTZcyAAFTvnmWbRWoc7oRbIJtjkcYT4nA==
X-Received: by 2002:a05:6402:1d29:: with SMTP id
 dh9mr7734685edb.269.1591087964334; 
 Tue, 02 Jun 2020 01:52:44 -0700 (PDT)
Received: from localhost.localdomain (net202-35-245-109.mbb.telenor.rs.
 [109.245.35.202])
 by smtp.gmail.com with ESMTPSA id qp15sm1363601ejb.69.2020.06.02.01.52.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 01:52:43 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] mailmap: change email addresses of two contributors
Date: Tue,  2 Jun 2020 10:52:13 +0200
Message-Id: <20200602085215.12585-1-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-ed1-x52c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: aleksandar.qemu.devel@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Two contributors want to switch to using their new email addresses.

Aleksandar Markovic (2):
  mailmap: Change email address of Filip Bozuta
  mailmap: Change email address of Stefan Brankovic

 .mailmap | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.20.1


