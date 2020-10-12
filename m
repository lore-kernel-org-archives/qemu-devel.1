Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D011C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 13:22:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 946CD20714
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 13:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Klg4jDOF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 946CD20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRxmE-0006Q7-GM
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 09:22:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRxkV-0004jA-Ug; Mon, 12 Oct 2020 09:20:24 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:50927)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRxkT-0005Fg-M4; Mon, 12 Oct 2020 09:20:23 -0400
Received: by mail-wm1-x32b.google.com with SMTP id 13so17168482wmf.0;
 Mon, 12 Oct 2020 06:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=05RfNurGaAHkRWlZ1YYxqFf0MRZv8h15YxydMsNWKx0=;
 b=Klg4jDOF3uxhIMfMszwhjX7wIHESa2ulFQff3ybFJU3mJTr5mYM7RjMDR1UBVHRmnp
 NihX4egubF86I+6z15EypOXG8z5cOs5INzwh7askzE8ep2cA4rDMuZAiStwkM0EFW2D7
 lOAy1KgFvuDSHHOOrGYKof9c8fLpxa3bgjPYAroQggz0HUf2Fk+QGv7M5V07fxW9nhgk
 VEg2FBGhIzav4KJgIuHcTlfTFnX1VSt6gwu6VJBa8PUVvOx+3RmyGgG78cGOP3HP1Dg4
 arcwkhNjxqqa8XGj2kou4rjosW+Mh7yvmcS41redFtig/y6kAxzZqXERrhHJFkrvIJ0R
 P7jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=05RfNurGaAHkRWlZ1YYxqFf0MRZv8h15YxydMsNWKx0=;
 b=N/BZGHjkIdlKTd4dGBrC/lK9jBid/BylZMy3gVxRG8s9dYg18Ozpv575LbPbxH2teA
 OJ7pr0EZ9Qur9eX83yAsutNSmxo+OilJ/VfQKCQ918D8+AZTyt6UDwdKof3Rb7zH5/tp
 jHOPOV3V1VDFxoIrJvLhLio+5HQcLzQlBog3xWBhtKuhobr9O4gXmSH9HxXPiUD8fPJT
 +typjIpbJxt6sLb6suIYfW17FdpYkKapUbCapnvvn1gKHBSGBtZmvvPeUIASAYsbZBAs
 w9fOU/i74qsCK/ngHU00ZY/IZX2XOYOn4BsqW+XwCKM0AA+yEOqFfxHmuAaUFDvvDImV
 k1ig==
X-Gm-Message-State: AOAM530hPiE0MBDL8gklviyA76dDGxXVcHpE+lrAWcmUPePTh76NWXZw
 rwYzIbrgJyKNaylB9zJXaqLGrO2hUF8=
X-Google-Smtp-Source: ABdhPJyPjK5SPgZGW0RVJvWov+OEKINCn+dqa4NeDtPCL87xbnFf1uu/v2aQisHcaefNfgmEBiO61w==
X-Received: by 2002:a1c:1983:: with SMTP id 125mr10768239wmz.29.1602508819174; 
 Mon, 12 Oct 2020 06:20:19 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id t6sm28092754wre.30.2020.10.12.06.20.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 06:20:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/5] hw: Replace some magic by definitions
Date: Mon, 12 Oct 2020 15:20:11 +0200
Message-Id: <20201012132017.3423954-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32b.google.com
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A bunch of trivial cleanups, replacing magic=0D
values by definitions to make the code easier=0D
to review.=0D
=0D
Since v1:=0D
- Addressed Peter review comment on versatile PCI controller=0D
- Added Thomas R-b tag=0D
=0D
Expected to be merged via qemu-trivial@.=0D
=0D
Regards,=0D
=0D
Phil.=0D
=0D
Philippe Mathieu-Daud=C3=A9 (5):=0D
  hw: Replace magic value by PCI_NUM_PINS definition=0D
  hw/pci-host/pam: Use ARRAY_SIZE() instead of magic value=0D
  hw/pci-host/versatile: Add the MEMORY_WINDOW_COUNT definition=0D
  hw/pci-host/versatile: Add the PCI_BAR_COUNT definition=0D
  tests/qtest: Replace magic value by NANOSECONDS_PER_SECOND definition=0D
=0D
 hw/arm/virt.c           |  4 ++--=0D
 hw/mips/gt64xxx_pci.c   |  2 +-=0D
 hw/pci-host/pam.c       |  2 +-=0D
 hw/pci-host/versatile.c | 46 ++++++++++++++++++++++-------------------=0D
 tests/qtest/rtc-test.c  |  2 +-=0D
 5 files changed, 30 insertions(+), 26 deletions(-)=0D
=0D
-- =0D
2.26.2=0D
=0D

