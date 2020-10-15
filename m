Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7635EC433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 19:48:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8A82206DD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 19:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/VKTabF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8A82206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT9Ec-0003Vf-HU
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 15:48:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57182)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kT9DB-0002DF-Nb; Thu, 15 Oct 2020 15:46:53 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40274)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kT9DA-00079h-6I; Thu, 15 Oct 2020 15:46:53 -0400
Received: by mail-wm1-x343.google.com with SMTP id k18so226077wmj.5;
 Thu, 15 Oct 2020 12:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UJwnR5BFRgHy/XAVLZ16OHrt0PFOaSx13ZcXPWkLQh0=;
 b=e/VKTabFQ0C40GckiWwmcVfdMYe/UF8SZN9Edbd+DUygSPXcXoqEKxUOTHI1Qzq0zd
 ZIKb54eQ4I80rKfId3JLKkfxObjylN535CqyNjCm41TRXMI3vDqpG6hprxyzk79pySR5
 QxNX96aGiLVzkOEcWmaSexNbUMuqM+juBssI189TRSf0wCHOR61wIsOGZvchwwLgADtA
 UR92sqADCyfHySNJdJyLXb0ivOmnFVHuuo8HTWonxdlb1v+cauMsB6wp/APAS5FWrPjM
 FFjpF6Xiv4QlTC9x2eTs9vR7nWIdAAvQAplaoMGmJtrXVuHPsBCa2XJ68bZRF8a9DeWs
 0YtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=UJwnR5BFRgHy/XAVLZ16OHrt0PFOaSx13ZcXPWkLQh0=;
 b=TXxykVu6u5aAjrCErzNY9GmzFkZYaS7gEsNEQjZpiR+fSn99Zs6gEd9Q8iPOJTXSAp
 pxGt5Ta9hCDjO+3wXCwR8KNwGeNSmC/Cc9OCrx2ooQCY+NGkG0kaBWeclljslgdrE7Pg
 Ui2eCAR16r2EmqmAbHpUmC4FUPgynjUN3vEKNzFpl+87o5qqsdTp0OtepaWhkvkepVcH
 7Lz6gvUNNAs5/06+6Fc1p7QTOQJVv1u6PkPsAEgBgqT1Qf4xDxm+tJtDtxQ5Y683+5ey
 Nq0Oth7Wg8krw7HpBKIannneShmbDuCsYu8kidqIWRf0WGDaYKi9gZ3mhgl3acW6/siQ
 QtpQ==
X-Gm-Message-State: AOAM533es4pZghp4mJCoAzUWK/bsRDoymHn6/NXbzeQ5bt0fQW9UQIKs
 TlA+akQHRVW1W4HhCrp/vxFKQJkfX2g=
X-Google-Smtp-Source: ABdhPJybWxvDuaMNgtKZXH6DCmj3AIQTuKLFgiZyKJX2Mgg5f3cKz7Tda061gb4236ZhTB81vN4hMw==
X-Received: by 2002:a1c:1f89:: with SMTP id f131mr302438wmf.10.1602791210048; 
 Thu, 15 Oct 2020 12:46:50 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id i8sm104279wmd.14.2020.10.15.12.46.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2020 12:46:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] hw/rtc/m48t59: Simplify m48t59_init()
Date: Thu, 15 Oct 2020 21:46:45 +0200
Message-Id: <20201015194647.477252-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
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
Cc: qemu-trivial@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 qemu-ppc@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since v1:=0D
- Do not remove mem_base in patch 1 (Laurent)=0D
- Pass MemoryRegion* (new patch)=0D
- Run check-qtest=0D
=0D
Philippe Mathieu-Daud=C3=A9 (2):=0D
  hw/rtc/m48t59: Simplify m48t59_init() removing 'io_base' argument=0D
  hw/rtc/m48t59: Simplify m48t59_init() passing MemoryRegion argument=0D
=0D
 include/hw/rtc/m48t59.h |  5 ++---=0D
 hw/ppc/ppc405_boards.c  |  2 +-=0D
 hw/rtc/m48t59.c         | 14 +++-----------=0D
 hw/sparc/sun4m.c        |  3 ++-=0D
 hw/sparc64/sun4u.c      |  7 ++-----=0D
 5 files changed, 10 insertions(+), 21 deletions(-)=0D
=0D
-- =0D
2.26.2=0D
=0D

