Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B46C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 11:14:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41BFA22263
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 11:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Krm7muIH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41BFA22263
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX0S2-0004nr-7G
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 07:14:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54142)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kX0Ha-0008A7-Qc; Mon, 26 Oct 2020 07:03:22 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:43438)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kX0HY-0002bS-4F; Mon, 26 Oct 2020 07:03:22 -0400
Received: by mail-wr1-x42f.google.com with SMTP id g12so11889342wrp.10;
 Mon, 26 Oct 2020 04:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UU3dU+alkYkiXNEONdXIYMswJhk5jrJ/vInw/K/xvqU=;
 b=Krm7muIHqUdM4j3rb3huMw+LslnKEjHOEk2qd2W/m6Pu8craTvgS63u4PAJeGc0HQR
 41mdalmUowJKY4Tcp8B0oyWNp1C6DnVk8WCXdwbZxTOqInJ+YVZepD/oAlqsLNXZQFaJ
 2xwJOIfaSJZH52niQ1e5VJ0aj6GQVqYkacZmpKCZJQj7d8anlTmvf8G4ffl9yyRSibNk
 Vzzu83LMPrfd8hUVJ+Fv9PuA6M+0c7kYs7EVWB7eFbv7q4hZB3ge/gkDCwrx0PtRRqkp
 h3hyiBZnYWQNjZ7kgFsd7sNn5vU743JBIZa2qtb1onPTVOk6esybsnEtFkwR0rBaGEmT
 BkJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=UU3dU+alkYkiXNEONdXIYMswJhk5jrJ/vInw/K/xvqU=;
 b=B9LaRZ5zQZAe4a8jat5x2YV8BgESOMLynkFzKZQtF9BoND+0RXvTr6bcrJYbT4zAdD
 Z+0cLzmZYIUKpZpkKgobriy6gmA9cK4JZ0m8mCY3NRbZXoYWwlXjX4f7DLt6jnGcfkcK
 YqAWwdnYKgoHL2AVD6HrBHvecuxOyicHmv+bsistMSAnCy3HA8b9uZSWL5DfmdCHB8l2
 xQf7dYbJiwZgPI22CP+FBpKUhzHbR2C+TAD9qCi6P+M6ZpcZKUZm8NfaSkiyfwHlnBDS
 GDY1IympxQlVZ5iEcu9f4fO/IgVD0peo4SpzvafPmse9WRmEDTDpfABd2NgmLdzNSq8L
 5k6A==
X-Gm-Message-State: AOAM533aF4JSswa43rg/Z48+bXC4vvt5TiFXKU62vEDaO6Y8AInGZzpK
 2oO7WABXDiVYgvqD9A/DCZh75Ve1K9Q=
X-Google-Smtp-Source: ABdhPJzsSk1kdObPf8EeFxeB8TkUX0kzXlaMH1aSabcdZ999GYgMyvNW8sUuMCMTGVgOKoDEGkvzNg==
X-Received: by 2002:adf:c045:: with SMTP id c5mr17075969wrf.405.1603710197845; 
 Mon, 26 Oct 2020 04:03:17 -0700 (PDT)
Received: from localhost.localdomain (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id s11sm21703184wrm.56.2020.10.26.04.03.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2020 04:03:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/5] SD/MMC patches for 2020-10-26
Date: Mon, 26 Oct 2020 12:03:10 +0100
Message-Id: <20201026110315.4026183-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42f.google.com
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 4c5b97bfd0dd54dc27717ae8d1cd10e14eef1430=
:=0D
=0D
  Merge remote-tracking branch 'remotes/kraxel/tags/modules-20201022-pull-r=
eq=3D=0D
uest' into staging (2020-10-22 12:33:21 +0100)=0D
=0D
are available in the Git repository at:=0D
=0D
  https://gitlab.com/philmd/qemu.git tags/sd-next-20201026=0D
=0D
for you to fetch changes up to 89c6700fe7eed9195f10055751edbc6d5e7ab940:=0D
=0D
  hw/sd/sdcard: Zero out function selection fields before being populated (=
20=3D=0D
20-10-26 09:23:47 +0100)=0D
=0D
----------------------------------------------------------------=0D
SD/MMC patches=0D
=0D
- Fix a bug in CMD6/SWITCH_FUNCTION (Bin Meng)=0D
- Minor housekeeping patches=0D
=0D
CI jobs result:=0D
. https://cirrus-ci.com/build/5461987880599552=0D
. https://gitlab.com/philmd/qemu/-/pipelines/207532287=0D
. https://travis-ci.org/github/philmd/qemu/builds/738901111=0D
. https://app.shippable.com/github/philmd/qemu/runs/888/summary/console=0D
----------------------------------------------------------------=0D
=0D
Bin Meng (1):=0D
  hw/sd/sdcard: Zero out function selection fields before being=0D
    populated=0D
=0D
Philippe Mathieu-Daud=3DC3=3DA9 (4):=0D
  hw/sd/sdcard: Update the SDState documentation=0D
  hw/sd/sdcard: Simplify cmd_valid_while_locked()=0D
  hw/sd/sdcard: Constify sd_crc*()'s message argument=0D
  hw/sd/sdcard: Make iolen unsigned=0D
=0D
 hw/sd/sd.c         | 27 +++++++++++++++------------=0D
 hw/sd/trace-events |  2 +-=0D
 2 files changed, 16 insertions(+), 13 deletions(-)=0D
=0D
--=3D20=0D
2.26.2=0D
=0D

