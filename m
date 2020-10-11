Return-Path: <SRS0=+Fwv=DS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86306C433E7
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 21:07:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA88F2073A
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 21:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOt/7E1w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA88F2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRiYy-0000cC-U6
	for qemu-devel@archiver.kernel.org; Sun, 11 Oct 2020 17:07:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34174)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRiX4-0007eh-84; Sun, 11 Oct 2020 17:05:30 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39434)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRiWz-0008SA-5W; Sun, 11 Oct 2020 17:05:26 -0400
Received: by mail-wm1-x342.google.com with SMTP id d3so15560627wma.4;
 Sun, 11 Oct 2020 14:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=RVEzdFzHG52dMol05fP/JH3htxgV/2K75VVlQolC92Q=;
 b=nOt/7E1w5qckBWFAbySA3+Ea7uSlqnSe92H+xbt4af0H0jD5QOF6W48WhFa8a+iFqB
 TWv7jqJ0+ziefyPjBka1Ot+H/RIfVYAhecFsIXZZwmj/ztJSyAQQUM77GHMxuuB44H9q
 NK2TJ3ltKzVFSAeSLYLkEC+YZYHiJXzEW7HA/Z8Xoo8zoSeNIsITA+v1RtAYchm8s/qc
 fLo5RDDsX+Z8h9kLuvWgrHnaCQwfGGGx/km6YaTzipTSmm9uS6l822Oe4Gybxt5BMk3I
 YNkffa+qogQDkt96K41FbVNh8CluYSeW0G181TwexFIygZSe0mbluTWeFDpu6k4x3NCW
 +gpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=RVEzdFzHG52dMol05fP/JH3htxgV/2K75VVlQolC92Q=;
 b=tBuzkzh1yzHM6HphrmV0QjHhi0HxpYirygO+B1Qs3DXWzLmZBBptddgHZG0eo5a6qE
 HGOFtwHBBjZ+vybvxsnR2BXQztElYuvhfahCcCYQuiNIuk+eQ5mqcKw/j3NAZxgQIZpk
 1g0z9VXxM/xmvwO3tmxVonJUQacWJYeXB70hrIuOtG1NeEkrJrmBbI3lMzv1YPT1JFUZ
 V2QlKAM3oesUdTFIBNglVVR2A/oc45uAOA8GnROMlGwdhMbVgY9sMCU5Yy7GKkpYrjlZ
 U50nbvHrSMEu/CpkCyj4wkmnqRUOF4jov4V4C1noinbZgS/eiOJZB8VkqSpuIGiT0OSW
 1WuA==
X-Gm-Message-State: AOAM5315pdLQYRn0JiF7oZjPzis3iS6sYh5Ls2f9Cb/375vPdUwppWRz
 VN0IfWjFtKWLr4lrqG6AFzJHbTow0fI=
X-Google-Smtp-Source: ABdhPJzWYQEr/OMaVc3tepE4+WU58sBwce3RsVkO+V4yBy1LFp3sJUXhk5TDGOggZhyWeGCxllj8NQ==
X-Received: by 2002:a1c:9cd3:: with SMTP id f202mr8078235wme.148.1602450320998; 
 Sun, 11 Oct 2020 14:05:20 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id x15sm24781991wrr.36.2020.10.11.14.05.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2020 14:05:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 0/3] hw/ssi: Rename SSI 'slave' as 'peripheral'
Date: Sun, 11 Oct 2020 23:05:10 +0200
Message-Id: <20201011210513.3253905-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Andrew Jeffery <andrew@aj.id.au>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Max Reitz <mreitz@redhat.com>, qemu-trivial@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In order to use inclusive terminology, rename SSI 'slave' as=0D
'peripheral', following the resolution Paolo pointed in [*]:=0D
https://www.oshwa.org/a-resolution-to-redefine-spi-signal-names/=0D
=0D
Candidate to be merged via the ARM or Trivial trees.=0D
=0D
[*] https://www.mail-archive.com/qemu-devel@nongnu.org/msg739108.html=0D
=0D
Philippe Mathieu-Daud=C3=A9 (3):=0D
  hw/ssi/aspeed_smc: Rename max_slaves as max_devices=0D
  hw/ssi/ssi: Update coding style to make checkpatch.pl happy=0D
  hw/ssi: Rename SSI 'slave' as 'peripheral'=0D
=0D
 include/hw/misc/max111x.h   |  2 +-=0D
 include/hw/ssi/aspeed_smc.h |  2 +-=0D
 include/hw/ssi/ssi.h        | 56 +++++++++++++++++++------------------=0D
 hw/arm/spitz.c              | 32 ++++++++++-----------=0D
 hw/arm/stellaris.c          |  4 +--=0D
 hw/arm/tosa.c               | 12 ++++----=0D
 hw/arm/z2.c                 | 14 +++++-----=0D
 hw/block/m25p80.c           | 14 +++++-----=0D
 hw/display/ads7846.c        | 12 ++++----=0D
 hw/display/ssd0323.c        | 12 ++++----=0D
 hw/misc/max111x.c           | 18 ++++++------=0D
 hw/sd/ssi-sd.c              | 12 ++++----=0D
 hw/ssi/aspeed_smc.c         | 53 ++++++++++++++++++-----------------=0D
 hw/ssi/pl022.c              |  2 +-=0D
 hw/ssi/ssi.c                | 48 +++++++++++++++----------------=0D
 hw/ssi/xilinx_spips.c       |  7 +++--=0D
 16 files changed, 152 insertions(+), 148 deletions(-)=0D
=0D
-- =0D
2.26.2=0D
=0D

