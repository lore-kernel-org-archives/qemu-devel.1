Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE27C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:11:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72348221E5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUbMoEcS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72348221E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3axr-0003ph-VF
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 04:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33718)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k3awx-0002FP-9C; Thu, 06 Aug 2020 04:08:31 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:37403)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k3awv-0005fp-Na; Thu, 06 Aug 2020 04:08:31 -0400
Received: by mail-wr1-x42d.google.com with SMTP id y3so43079462wrl.4;
 Thu, 06 Aug 2020 01:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=RLlgeL2C/FYTW7vdWP0OhAQl6GDJRLGBT60ys2uJvCE=;
 b=XUbMoEcSMxGEUtED05wSHJW1i3kN7U25wPcJj2yPbhyQU/Pczn1RGZp31CAY67/gmC
 DCrLIkgepqbJ8QEpRLeSNQlVB5E4Q/kgWefqQqjl9uSpdYp8oEeoKZMZh/SdG5j5nMSg
 EuBnmEDahY2CpdSdKSlVVeUhzbt82zPQwzZZ9iQyvxeDv6I1DJ+URVONHc6uScq1qjPV
 DJWtc09ySKKXAJm02s1OVPQJyJGi2M1wCIbB3tdrQ4o2tzHEBugSqbrulakCKho5i6Ul
 tN0VCeLSOu9EggP5b6yDWOUhS9OjSSESa6EU4099PXeMtugwsX3/0iZmzlAyGIgeE8MO
 WbSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=RLlgeL2C/FYTW7vdWP0OhAQl6GDJRLGBT60ys2uJvCE=;
 b=TpoI3GI1r2oC/+KFiLI4gWmwAnUP74/pofGJkJiqOpKHvbFoUrA2KxTK3Wo5gz+nbs
 W+CEFfjinJktMKL75g08rCLnfL0l90gIAolA7Gp8gaqsSSVuy+TYhgId7+Pzzq+oqJXn
 YqVj8kLH9hx+N/Ggxof1itFht27S21M9zXhDy74dzX7SOxdb8RAMwVYlcMs/MXLRdHh1
 Lm2fwSTUuZEyzfGntLGG0Ljk9XDqYCnmyT+2smjWmxd+W+h8K3EJly2XPr6GZ0xpxgAK
 Ud12KpBncSGOl0pyDoBqyKZwlyLXpNgwnOBnYHIPRzSwoPAmPAb+BaXStsP24ByfMa15
 cpPQ==
X-Gm-Message-State: AOAM53163I4eVFqXZQpF37emX7U7H6BCC/h0OfZROJBXIlkFEonWkFCV
 Um62PagwQwzlSFyiGUystydxAmLu
X-Google-Smtp-Source: ABdhPJyNVSLQR+za7u7ezBcMNENYCasW24bMQzaXmgM7d5dxS9R1qe1h+gMkDE4P/yk+4i0Vbwokow==
X-Received: by 2002:a5d:5151:: with SMTP id u17mr6292276wrt.154.1596701307340; 
 Thu, 06 Aug 2020 01:08:27 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id w2sm6039587wre.5.2020.08.06.01.08.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 01:08:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 0/7] hw/block/fdc: Cleanups trying to make sense of
 the floppy controllers
Date: Thu,  6 Aug 2020 10:08:17 +0200
Message-Id: <20200806080824.21567-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Trivial patches while trying to make sense of the floppy
controllers code.

Philippe Mathieu-Daudé (7):
  hw/block/fdc: Let sector count be unsigned
  hw/block/fdc: Let sector offset be unsigned
  hw/block/fdc: Use warn_report() instead of debug FLOPPY_DPRINTF()
    calls
  hw/block/fdc: Convert debug FLOPPY_DPRINTF() to trace events
  hw/block/fdc: Drop pointless FLOPPY_DPRINTF() call
  hw/block/fdc: Use more descriptive TypeInfo names
  hw/block/fdc: Add ASCII art schema of QOM relations

 hw/block/fdc.c        | 87 +++++++++++++++++++++++++++----------------
 hw/block/trace-events |  3 ++
 2 files changed, 57 insertions(+), 33 deletions(-)

-- 
2.21.3


