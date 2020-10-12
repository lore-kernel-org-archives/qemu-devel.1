Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FAA4C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 17:11:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E822120838
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 17:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBIAFk+U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E822120838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS1M6-000463-JI
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 13:11:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50910)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kS1Kd-0002yE-QV
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 13:09:55 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:37770)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kS1Kc-0002eJ-3E
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 13:09:55 -0400
Received: by mail-wr1-x42b.google.com with SMTP id h7so20050398wre.4
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 10:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HB3l91wZFg4VGCC0wOXM+jKyZXt8fcLfUUkjmiYVEEQ=;
 b=jBIAFk+UI2nRNiuXx5tzZvZ1ETQm+jc/f/ooua06WGdWThmYzf/kT4iUtrWEHMfPZr
 T0kGqnjiRSzYLgbl+hdynjIe8k6P/HVCZZEUhZLhO9qNW+nyYMm3CX0XXlJ8wP5mjtZj
 p33HbG9EwBrM6lRRxgcwADOyf7baRd6Q5ZQTq19QdfDcn1ivgYgdBprUxyL4VhXEc7kI
 3mXR/FAAzTNATu/ZP3TAAhTxFj94v25vcXjPwUklfkRW4ZNBvhjbSXmzvTscJqxvlbzX
 13TZOT7OeqZSE4Zgj59dGiaxyxOqsbhwDoCVURfPG/AFz+x900Gq62RctiKkSSFTimIc
 qtcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=HB3l91wZFg4VGCC0wOXM+jKyZXt8fcLfUUkjmiYVEEQ=;
 b=Hlmc7RteMGDB12my8SObJZuAOSKrGAsUBVcdhtqNrjNzCY64YPMX1b0O/3V1/ZbEpc
 fC8MM9ip7XsQRtsyv6H0JoNhzuK1HFE8Ki0MyzxlVKWalOJoq9gzaa/vU2gtVBAD2k1T
 zPBUlayqB8bb1zRfPRyEEftfj9nLYYLIJyzGVUaT4pPZzMoIuvYRsW3CA1ZOIGvMad+5
 O0m/xBL/9F4NrH8CV1aGszTncadpzYnrFgOgdoY75JMu8QQyojAYqAuF8dQcguXdDKX5
 S79zwRS3TQvaW6CfpFh6ZbIu6RDlcRYzMbELlT7VvUKhV9p7WJKm/WniY3kbhIuF/9uy
 eueA==
X-Gm-Message-State: AOAM531ifj4sRpmk6v9NmO7HEYIzMLdFAJhLMA5yUGfnBo9LPtAHtyHV
 V34Mdw8hmuS4x38EkpqJ69jbjRMDgl0=
X-Google-Smtp-Source: ABdhPJwfSyhEVhGho1g4YnM6e26ed2d5uOT63uIiUHwMC4mi4WAjScTBwuXuEGxGN+sW9SOJTPrAkg==
X-Received: by 2002:a5d:688c:: with SMTP id h12mr8300329wru.92.1602522592225; 
 Mon, 12 Oct 2020 10:09:52 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id o14sm24611929wmc.36.2020.10.12.10.09.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 10:09:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/6] hw/pci-host/sabre: Report UNIMP/GUEST_ERROR accesses
Date: Mon, 12 Oct 2020 19:09:44 +0200
Message-Id: <20201012170950.3491912-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Notes while trying to understand Mark's patch from yesterday:=0D
"sabre: increase number of PCI bus IRQs from 32 to 64"=0D
https://www.mail-archive.com/qemu-devel@nongnu.org/msg749458.html=0D
=0D
Philippe Mathieu-Daud=C3=A9 (6):=0D
  hw/pci-host/sabre: Update documentation link=0D
  hw/pci-host/sabre: Remove superfluous address range check=0D
  hw/pci-host/sabre: Simplify code initializing variable once=0D
  hw/pci-host/sabre: Report unimplemented accesses via UNIMP log_mask=0D
  hw/pci-host/sabre: Report IOMMU address range as unimplemented=0D
  hw/pci-host/sabre: Log reserved address accesses as GUEST_ERROR=0D
=0D
 hw/pci-host/sabre.c | 40 ++++++++++++++++++++++------------------=0D
 1 file changed, 22 insertions(+), 18 deletions(-)=0D
=0D
-- =0D
2.26.2=0D
=0D

