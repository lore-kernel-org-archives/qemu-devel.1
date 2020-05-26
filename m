Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5A8C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 13:34:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 862CE207CB
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 13:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxdi596e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 862CE207CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdZiY-00086m-Kn
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 09:34:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56890)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdZhM-00065f-1y
 for qemu-devel@nongnu.org; Tue, 26 May 2020 09:32:52 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533]:43255)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdZhL-0005nm-BW
 for qemu-devel@nongnu.org; Tue, 26 May 2020 09:32:51 -0400
Received: by mail-ed1-x533.google.com with SMTP id g9so17643307edw.10
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 06:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DEy04fG1/PRWyY9C3rZNsdt5oECHcpQnIt7jscHEVGw=;
 b=hxdi596eixO12Q0P6sQkYSuQi7pumz3V2evVhhHREHhsjPSIQuDFrZQojmraOdB/X5
 haHy5A+1n+2afFvMR1aG0apQXuexR0tejdXOyFZR0CgrLAUL4NwEIYOEhEhpi/hJ/xnL
 Z2GUCOyQBvBW85kdtbNXGMhfpZ9n0tmDO9iDGJlsOV63tVBTUQj32E888wx8xz6e0ezr
 BVBoEPFBlbv695eL3n9xZAyRe6+Z47cXGWDEWKQ7boSXgqDjfG7iT04tz18vYFYpgtMx
 oBTKngwTTIKv+3Oi/U6KK5VMCGmrBN49nYO82VuQ5CKcAVp5IVFlEB4dsKEXIVvTHpXQ
 4Ahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=DEy04fG1/PRWyY9C3rZNsdt5oECHcpQnIt7jscHEVGw=;
 b=eqiOnP1j/eIUKj3ek3DlZTY+qh2taNff0w0YJ1NSTn1I2h6QLWZa48JzFKd5uDfrPJ
 10KfH1MdMHKPEkx7hxljRnYhPy0AxbvclCZrAGyBwuSn45UAHZZIkuUut+YytZNcN8jG
 /QdgbA9z9Yfw+qzFwHvna93Og1goAnfU3aUq5B6r+pipimIqAY82NHpDb17HwsifvqBs
 0Mvg+TLVwlzNKumywR2Cb3w29l8Exry/vgVjULK0a1LNXi+OIgxCaiXZNBNpqPJ0gX2+
 kGE5Lu+y0SJa48wVCM+9hpY+RCJTbaUeRBwaWaXsNq2LVJ8NDvN1VQulPvRvBqxonB3D
 k9eg==
X-Gm-Message-State: AOAM533ExRrDDENxqIqx+sn7+rGOLIR+rTgoXfTz9X0Bwqdjs+F1gz4w
 8oX6jR3FHNG60y7N39XwuCueh24HTCI=
X-Google-Smtp-Source: ABdhPJx5H2jyS9cHPUVQNlU9w9s10taYy18h3AMHE6EWj6VRwTvdYPvRrS8frdxZuJgm9UCWy9LsxA==
X-Received: by 2002:aa7:c3cb:: with SMTP id l11mr19044511edr.364.1590499969499; 
 Tue, 26 May 2020 06:32:49 -0700 (PDT)
Received: from x1w.redhat.com (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id n25sm1623084edo.56.2020.05.26.06.32.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2020 06:32:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/14] mips-hw-next patches for 2020-05-26
Date: Tue, 26 May 2020 15:32:33 +0200
Message-Id: <20200526133247.13066-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x533.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, libvir-list@redhat.com,
 Thomas Huth <thuth@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Huacai Chen <chenhc@lemote.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 8f72c75cfc9b3c84a9b5e7a58ee5e471cb2f19c8:

  Merge remote-tracking branch 'remotes/kraxel/tags/audio-20200526-pull-reque=
st' into staging (2020-05-26 10:59:01 +0100)

are available in the Git repository at:

  https://gitlab.com/philmd/qemu.git tags/mips-hw-next-20200526

for you to fetch changes up to 97d8974620053db5754af808583de70380f73a10:

  MAINTAINERS: Change Aleksandar Rikalo's email address (2020-05-26 13:21:12 =
+0200)

----------------------------------------------------------------
MIPS hardware updates

- MAINTAINERS updated to welcome Huacai Chen and Jiaxun Yang,
  and update Aleksandar Rikalo's email address,
- Trivial improvements in the Bonito64 North Bridge and the
  Fuloong 2e machine,
- MIPS Machines names unified without 'mips_' prefix.

CI: https://travis-ci.org/github/philmd/qemu/builds/691247975

----------------------------------------------------------------

Aleksandar Markovic (3):
  hw/mips: Rename malta/mipssim/r4k/jazz files
  hw/mips/malta: Add some logging for bad register offset cases
  MAINTAINERS: Change Aleksandar Rikalo's email address

Huacai Chen (1):
  MAINTAINERS: Add Huacai Chen as fuloong2e co-maintainer

Philippe Mathieu-Daud=C3=A9 (10):
  hw/pci-host: Use CONFIG_PCI_BONITO to select the Bonito North Bridge
  hw/pci-host/bonito: Fix DPRINTF() format strings
  hw/pci-host/bonito: Map peripheral using physical address
  hw/pci-host/bonito: Map all the Bonito64 I/O range
  hw/pci-host/bonito: Map the different PCI ranges more detailed
  hw/pci-host/bonito: Better describe the I/O CS regions
  hw/pci-host/bonito: Set the Config register reset value with
    FIELD_DP32
  hw/mips/fuloong2e: Move code and update a comment
  hw/mips/fuloong2e: Fix typo in Fuloong machine name
  hw/mips/mips_int: De-duplicate KVM interrupt delivery

 docs/system/deprecated.rst               |  5 ++
 docs/system/target-mips.rst              |  2 +-
 default-configs/mips64el-softmmu.mak     |  2 +-
 hw/isa/vt82c686.c                        |  2 +-
 hw/mips/{mips_fulong2e.c =3D> fuloong2e.c} | 48 ++++++-------
 hw/mips/{mips_jazz.c =3D> jazz.c}          |  0
 hw/mips/{mips_malta.c =3D> malta.c}        | 14 ++--
 hw/mips/mips_int.c                       | 11 +--
 hw/mips/{mips_mipssim.c =3D> mipssim.c}    |  0
 hw/mips/{mips_r4k.c =3D> r4k.c}            |  0
 hw/pci-host/bonito.c                     | 87 +++++++++++++++++++-----
 tests/qtest/endianness-test.c            |  2 +-
 .mailmap                                 |  3 +-
 MAINTAINERS                              | 26 +++----
 hw/mips/Kconfig                          |  3 +-
 hw/mips/Makefile.objs                    | 10 +--
 hw/pci-host/Kconfig                      |  5 ++
 hw/pci-host/Makefile.objs                |  2 +-
 18 files changed, 142 insertions(+), 80 deletions(-)
 rename hw/mips/{mips_fulong2e.c =3D> fuloong2e.c} (91%)
 rename hw/mips/{mips_jazz.c =3D> jazz.c} (100%)
 rename hw/mips/{mips_malta.c =3D> malta.c} (99%)
 rename hw/mips/{mips_mipssim.c =3D> mipssim.c} (100%)
 rename hw/mips/{mips_r4k.c =3D> r4k.c} (100%)

--=20
2.21.3


