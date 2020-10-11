Return-Path: <SRS0=+Fwv=DS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05939C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 19:34:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B5F02083B
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 19:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAAZ+cRm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B5F02083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRh6b-0003j5-L6
	for qemu-devel@archiver.kernel.org; Sun, 11 Oct 2020 15:34:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRh5C-00021W-5R; Sun, 11 Oct 2020 15:32:38 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:44961)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRh5A-0006qD-FI; Sun, 11 Oct 2020 15:32:37 -0400
Received: by mail-wr1-x42b.google.com with SMTP id t9so16556573wrq.11;
 Sun, 11 Oct 2020 12:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=zSWcoIxwl/osf0emIgj/fyThgXyLQD65MYh1YFk/hhU=;
 b=dAAZ+cRm4BXGeAzbsBBR3QyU3PhteUoeZYimadFW0JWJFKCYWVp6auF5hxTBjmbLJL
 mgpSf2M9LqOArmeTcBirSG2Xr4oulNd5Aph3zkrwijG3Ll3ih0Poma6qQyFOiDCcJiNg
 4ESQeF7ML3C2a5c2M25NOLQBetWQUX7xaHe4TjvFz0qMgNsYE2SUmSwJZufODAFDH6JJ
 0kwPk5a2jlTHrWE0XtfkEiNiNQ/CCvnHZ31m0WK792cwzXs+KVRkqVuUTI9F7n+dIFgA
 gkXeOIEK67S7eg6FfDv/z2/Z39iiUthvVaTRdGGxGlZUke8bmHEEvbcXSEK8mxeOxmam
 kkMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=zSWcoIxwl/osf0emIgj/fyThgXyLQD65MYh1YFk/hhU=;
 b=G9AklXFlNqsGqfzruxp9tRwRA578VZzBDltmIj1d7sa2FhBBfHv499+qfS3YQqo0ZE
 y5/PDuethvXa5Q6bYZBTVNYShymdsTeoD00gwAXxgUbe5O+2LXYj870+A1/gmeyaGX47
 RrcX7xdLXR48ikJM4fFdCN2moGzhLhqEZApBrl0TY7tSJZwybjTlvYNd/D7Fh4ICDXV/
 izKZtKy/eZ1bVQqxmLiaiRDvE5gXKm5od96H13TJaSozZokhxsiSVWz/UT3drXYffCLV
 kR7iMkho4464yT6eOcdLCZZFIrqv9QHkX+ukwxz7dciOXhczy36kNumaoGeubvP3KcCO
 Tjbw==
X-Gm-Message-State: AOAM533stNa2Wk1/wf/LPruPiN5YktTlbjdFyPjS+A6xxAVydfnDzeGM
 SmbQT2ajdnP3bCKjDxwTAoWjt8OM+lY=
X-Google-Smtp-Source: ABdhPJyxQm8YkbsYd6OFFKlpAiaMMmf17lpgzSVB4kBqktMQk3nBPuXbAe+M4QLij1TTIfXNst2gRA==
X-Received: by 2002:a5d:63cb:: with SMTP id c11mr20721288wrw.243.1602444753431; 
 Sun, 11 Oct 2020 12:32:33 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id j5sm16467132wrx.88.2020.10.11.12.32.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2020 12:32:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/10] hw/isa: Introduce definitions for default IRQ values
Date: Sun, 11 Oct 2020 21:32:19 +0200
Message-Id: <20201011193229.3210774-1-f4bug@amsat.org>
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-block@nongnu.org,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Corey Minyard <minyard@acm.org>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Max Reitz <mreitz@redhat.com>, qemu-ppc@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace various magic values by definitions to make=0D
the code easier to read.=0D
=0D
This probably makes sense to merge this series via=0D
the 'PC chipset' tree, rather than qemu-trivial@.=0D
=0D
Regards,=0D
=0D
Phil.=0D
=0D
Philippe Mathieu-Daud=C3=A9 (10):=0D
  hw/isa: Introduce IsaIrqNumber enum=0D
  hw/isa: Add the ISA_IRQ_KBD_DEFAULT definition=0D
  hw/isa: Add the ISA_IRQ_SER_DEFAULT definition=0D
  hw/isa: Add the ISA_IRQ_TPM_DEFAULT definition=0D
  hw/isa: Add the ISA_IRQ_FDC_DEFAULT definition=0D
  hw/isa: Add the ISA_IRQ_PAR_DEFAULT definition=0D
  hw/isa: Add the ISA_IRQ_RTC_DEFAULT definition=0D
  hw/isa: Add the ISA_IRQ_NET_DEFAULT definition=0D
  hw/isa: Add the ISA_IRQ_MOU_DEFAULT definition=0D
  hw/isa: Add the ISA_IRQ_IDE_DEFAULT definition=0D
=0D
 include/hw/isa/isa.h         | 13 ++++++++++++-=0D
 include/hw/rtc/mc146818rtc.h |  1 -=0D
 hw/block/fdc.c               |  4 ++--=0D
 hw/char/parallel.c           |  2 +-=0D
 hw/i386/acpi-build.c         |  2 +-=0D
 hw/ide/isa.c                 |  2 +-=0D
 hw/input/pckbd.c             |  2 +-=0D
 hw/ipmi/isa_ipmi_bt.c        |  2 +-=0D
 hw/ipmi/isa_ipmi_kcs.c       |  2 +-=0D
 hw/isa/piix4.c               |  2 +-=0D
 hw/net/ne2000-isa.c          |  2 +-=0D
 hw/rtc/m48t59-isa.c          |  2 +-=0D
 hw/rtc/mc146818rtc.c         |  4 ++--=0D
 hw/sparc64/sun4u.c           | 10 +++++-----=0D
 hw/timer/hpet.c              |  8 ++++----=0D
 hw/tpm/tpm_tis_isa.c         |  2 +-=0D
 tests/qtest/rtc-test.c       |  8 ++++----=0D
 17 files changed, 39 insertions(+), 29 deletions(-)=0D
=0D
-- =0D
2.26.2=0D
=0D

