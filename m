Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD4BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 20:39:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F46420825
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 20:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="DBET5vrv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F46420825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBOgG-00015I-4q
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 16:39:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kBOcL-0007ka-UO
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 16:35:30 -0400
Received: from mout.gmx.net ([212.227.15.18]:38181)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kBOcI-0001Uv-6U
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 16:35:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1598560519;
 bh=Mrn/A0X5/xQInu0wwnBaa95PjhxvZPXwa0fxFdbgxMc=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=DBET5vrv5qTJTPMl1FDZcpE0qqPnGVxyGfF1tor3U8ExCKbOey2hv0SQYYQdaZKug
 rGRQFlBx77YQgpq2oYC1dlvNoqLA4IGquBlRarw4/zGv/GrLjbfVn59bRSC+/3a9vU
 jrHZEsR57WIXDK8UUb8K4nAINGvzeWcU03jLXnec=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.181.35]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MD9X9-1kKVIk1Omf-0095sn; Thu, 27
 Aug 2020 22:35:19 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/5] hppa power button support and firmware fixes
Date: Thu, 27 Aug 2020 22:35:12 +0200
Message-Id: <20200827203517.29404-1-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4GocHkrseHgqS1Ibfp9eclmCEGCsBSnNuAao2vCkB1VAE6gix0p
 siLYBzbex84ATYi4aeHRP68iCORD+ru4ZTBt1+l6NXVZu5PzvJqBbSa75vPWbMUtfD9InjS
 mJIeWP+yHb350yUXw9XldvRtz6Vl81pJMGcPcp+7N3DdsWdT3ce909PmaN4uVISDxTXjE7a
 vczgcjbw4QC5y+lB9W8eg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yeaEWf8kU44=:Y3WN2CcRoqS6R8tTeb92RG
 onSY4GACULWDvtYIxGRz16qOpCZied/59RpVsYZRl5eaWIZedmRfbKKvIo2+/jGpD58Ls+sfN
 Hu9GtBxRj4uK3Jwhg8wnJ7fCGVy0hQn8GFdlBW6rc7toqczlh5gsZQ1KU6ZTA5hzbURXQv9e+
 T6Ci1ydKH5//HqHHYCbX5I0BTjGyUShH+S8CdsyBisW/S5yfybYa1dpZwsKCahxC0eFYZq5IE
 q9zn5BzmBld9ZK8SMjt4mhYNd5HAvMQihukXUzOACt4vD25VgLS8wjuvWDcTr35a9T6Lwrbtl
 w8qghMerqXEOwGb7JI2DaTcjr/xF+1e03HLAWJtq7IKnD6HzxEYcRJ8Ad1RqjUOD5UwLUwtFS
 9tVKVZru1cvCXECvrOWNPRJbsh2O3ygGXmzoOp6ccYSMNYeqiDnr2TG2o44vEbJbsYgldCaQa
 1c1gi8dlAJtxeKYK7MWOYp9OkHxyHWGD4sHDD1z+RTGqCn+BY5fGBVgqUfQ19+KMfgdogx/Sd
 WBAPNJYodP2n9sbIZcSawEBsLoCI9rerMniEgAw5QcH3vyKrMrD6MUJ+i72+z7/cgGqhLnFPA
 7HijaU7+fJA1TpBluD27/4fR4P/2kSP/asx4K5DjpLSS9ZFn/nrLW9ZwhNE6cMxLQ/QEiJuHV
 TEkUL3isUvbLhMdq9uoFSjKne8u8PnmSVbgIMyESw7s6HkagtEMrjndYMeZLy9OeknxeWJO5Y
 /6AOrYFCjxoAmKblglq9Ht61XvXFQkuFtxcEFI6mzNNmMp/bWkT7tT4aCCiMFjmlJKB8hC/U+
 3ZJWHFPuN8WzqsZhIzt/Ec11mFdjvOFPQt46NX8JZNqyNJlNLQOVmmUqFiW/cmcYpgLjQ00Of
 7zfCffQyCW/ksnkzI7i02EDnPVD/Kpz4xo/KNk9s8MUpdCle3X3qls2yBis09ksgYncmKezV1
 3+prRlQ4nO5rHsZ6J06e2g/juwy8V/1rvbErUr2A3cKry9Pa9wI1OjOF5KlGk5dsXUYH//tQb
 7BSqpCixwMfu/HLUC5JM9+xwc85qzd3jcMRjFgwlQgHSWx/W7vFjUv5OY8/iF0IjDOhTX2w98
 b+8zNECiREUw0mes5Ype3dOF10cDyLgGDJQHpP5XCDumaMYuYn9loiPrU/wqAYCQL1bpGq6Xz
 P4Ixz6f77oyfUDlwq7VCZTC0WzX3bL6K1gTNOWAl5bdNUHnxP3/mbQQlhR/NqOhu+NFvUoLI6
 mlLWlciHW+A4Z+903
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 16:35:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch adds emulation for a power button on hppa,
makes the number of TLB/BTLB entries configurable from qemu
and includes a new hppa firmware with some bugs fixed.

Helge Deller (5):
  seabios-hppa: Update SeaBIOS to hppa-qemu-5.2-2 tag
  hw/hppa: Make number of TLB and BTLB entries configurable
  hw/hppa: Store boot device in fw_cfg section
  hw/hppa: Inform SeaBIOS about fw_cfg port address
  hw/hppa: Add power button emulation

 hw/hppa/hppa_hardware.h   |   3 +-
 hw/hppa/machine.c         |  56 +++++++++++++++++++++++++++++++++++++-
 pc-bios/hppa-firmware.img | Bin 783192 -> 783456 bytes
 roms/seabios-hppa         |   2 +-
 target/hppa/cpu.h         |   5 +++-
 5 files changed, 61 insertions(+), 5 deletions(-)

=2D-
2.21.3


