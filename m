Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F04C43457
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 13:27:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C24BF22D73
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 13:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvFZnI0f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C24BF22D73
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSKKp-0008FJ-K6
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 09:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSKJD-0007DF-5k
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 09:25:43 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:32800)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSKJA-0000or-UA
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 09:25:42 -0400
Received: by mail-wr1-x442.google.com with SMTP id b8so10825545wrn.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 06:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=klTjWj53RaxLFiadxO2oNYYiOJ1FwNraFNjSA5K8RJY=;
 b=dvFZnI0fxBmKx8ZBsdN9pZvXT7TMmpWy/Zf3tnwNeVm1BTYTYuR1ajLnRLAvGuVUCr
 Dwtc/TMMJwg7CaCHq528LRQ6NcHPeSG3I4hsqA/f1TF4W6GFc1ptE7ym2c8QUxtbL8eR
 pUUQKrNmrfx2kGXPmligJFP5dH5cXImoLaA/DqfDV+xdu8VhjPnGRPbW8Fk45r6EC++i
 DemJcqnOsvBB5q+HA67TniJ6vEW+tWvsPmNtVn/gHO7gSO1JRhAuZatH9nGYYvkTE61t
 LYa297rR9UhhHRGFOqFPVAx5NPexSMhPmILnn11A8o+7xHUQStFeBvjn7FLmablQ10pa
 rwxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=klTjWj53RaxLFiadxO2oNYYiOJ1FwNraFNjSA5K8RJY=;
 b=Ovpe2ncfgCxqeRHNCJtEg504nEoAvQ93ixlJTrJHwvvf0eY1MLwTYudwL0i+zNzGK+
 I70A+GCzSMBQ6Kgy9J1b/abGSW7EtOB/S05bs0YjC/Sgwc6xJ0iUfeWUfexApsCE/JHT
 8HMOZfkzvwtEiSi4tXvKb2RyWeB5vULlyo+lZk9tbMlOFwTxQ/qPQQw3VNeDjfZLcsHV
 K5/ZLrzNRahiOvvmyf6KjpgEYizUTQW3Dq0ANeKLEhLydFCw+Ii6YP22PyzL0dqkr5a6
 qFu9C0aWybUe0Y5OWeD0Gz6EpmHbk3MuuamxJJKxhIEOFFnd97/l4Rr0ejqwmbVnJwIJ
 JOSg==
X-Gm-Message-State: AOAM5332INzOgII14wg9rYuJCdsLX0V3c+L+cgXGKxHbyTAuaB4QiY1T
 FU3bIwoAfuhZnLhoCEaK3sL7Us3sARA=
X-Google-Smtp-Source: ABdhPJyP0OWgkU5E9EplkK+tdSZrNNstsG4QxeIxJKhqkk+QTs7jIWLbq2JKQeBWVL6yVRJL/y1rXg==
X-Received: by 2002:adf:f50d:: with SMTP id q13mr35157780wro.215.1602595537757; 
 Tue, 13 Oct 2020 06:25:37 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id x1sm20948151wrl.41.2020.10.13.06.25.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2020 06:25:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Victor Kamensky <kamensky@cisco.com>
Subject: [RFC PATCH 0/3] target/mips: Make the number of TLB entries a CPU
 property
Date: Tue, 13 Oct 2020 15:25:32 +0200
Message-Id: <20201013132535.3599453-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Khem Raj <raj.khem@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Richard Purdie <richard.purdie@linuxfoundation.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Yocto developers have expressed interest in running MIPS32=0D
CPU with custom number of TLB:=0D
https://lists.gnu.org/archive/html/qemu-devel/2020-10/msg03428.html=0D
=0D
Help them by making the number of TLB entries a CPU property,=0D
keeping our set of CPU definitions in sync with real hardware.=0D
=0D
Please test/review,=0D
=0D
Phil.=0D
=0D
Philippe Mathieu-Daud=C3=A9 (3):=0D
  target/mips: Make cpu_mips_realize_env() propagate Error=0D
  target/mips: Store number of TLB entries in CPUMIPSState=0D
  target/mips: Make the number of TLB entries a CPU property=0D
=0D
 target/mips/cpu.h                |  1 +=0D
 target/mips/internal.h           | 10 +++++++++-=0D
 target/mips/cpu.c                | 12 ++++++++++--=0D
 target/mips/translate.c          | 16 ++++++++++++++--=0D
 target/mips/translate_init.c.inc |  2 +-=0D
 5 files changed, 35 insertions(+), 6 deletions(-)=0D
=0D
-- =0D
2.26.2=0D
=0D

