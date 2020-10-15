Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA21C433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 22:49:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7134020678
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 22:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pOQ1ZhvV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7134020678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTC3Y-0003wj-3s
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 18:49:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTC2J-0002vU-RE
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 18:47:51 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36255)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTC2I-0003Fj-0l
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 18:47:51 -0400
Received: by mail-wr1-x441.google.com with SMTP id x7so449799wrl.3
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 15:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/WG2ZH1/GMeKxvlBOp+x+9HJsBVVTi9kugoga7KL4q8=;
 b=pOQ1ZhvVz8rLobzhd0RJpfBqNHI+aKRrgdKwk7jF2njYazvVWGlejwdjkaA0zcKQO7
 QsQMWWlOjCZl63qjLePRjpE1RnVfH576h11j0Fr7cEYHECFZyH2Kwlj7Y3+bp5aGWcB1
 ZFfIoRlGsRxdKxzUwXdtr6H7CaS7tmecm62HVjFIecutpLDof2mDYrNuMUzsKI/03QOi
 5cHTsZJwaPGZ1IM9b1OUlyXH3BblnxAljvA3o2YHpc4SRlku6uO4yB7XuCYL+B+UAf8q
 1yE2s6RWIET+ikaYKB0mHpKBpKS3NbCjHWKud0lxg1PFeQnAQtSLPcKpPT2EWQGgnOrC
 6f9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=/WG2ZH1/GMeKxvlBOp+x+9HJsBVVTi9kugoga7KL4q8=;
 b=TIR4wajLuPnUqZwA7ryfkrrqIOuUr+HZhK/S1NQd7QwEQbw18ZLOb49rsHb9nTUs6n
 ZVPOPvsRK32Zh76z4NzHg0xf7aXnI9UHHNqqA33S6cusBnr9maGcS1a3RfapM1Cz+gIZ
 ABf+CYD2orOIQ0wBiKD0rZLQ2zU85uNgnDnZniX2aUBBDg0ZT/9agrxbkqufomVdKGOy
 QiVNlRR8bpHgybyRO/IQKHlPQYHop0qYh3Tc2qQilcqh/0N9PCNIrAHuUW0JXQ8G4rX4
 B86UoPMwDk9jMK5ba9ukty1HQaz1lVCkNB2yqwQbdsH48qLAmarNwJBsHWXwIYYJKzXJ
 7GRw==
X-Gm-Message-State: AOAM5312ShUVEflarXoKgVy13BmN3JEjRB6c7y0GZAbRXhXum5XxF5qm
 33kZcwp9/j6/ZdIh6vZ9T+gf3B9tn3E=
X-Google-Smtp-Source: ABdhPJzHLwZZhH0aEpVX690GNEokY4Bl59M7Qido8rISG6Vx6cWdyqO4nKqAbXfGrb/ftDHregCLJA==
X-Received: by 2002:adf:9461:: with SMTP id 88mr477435wrq.307.1602802068335;
 Thu, 15 Oct 2020 15:47:48 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id d20sm1028273wra.38.2020.10.15.15.47.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2020 15:47:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Victor Kamensky <kamensky@cisco.com>
Subject: [RFC PATCH v2 0/4] target/mips: Make the number of TLB entries a CPU
 property
Date: Fri, 16 Oct 2020 00:47:42 +0200
Message-Id: <20201015224746.540027-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
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
CPU with preset number of TLB:=0D
https://lists.gnu.org/archive/html/qemu-devel/2020-10/msg03428.html=0D
=0D
Help them by allowing to set the TLB entries from a preset array=0D
of valid hardware values.=0D
=0D
Please test/review,=0D
=0D
Phil.=0D
=0D
Philippe Mathieu-Daud=C3=A9 (4):=0D
  target/mips: Make cpu_mips_realize_env() propagate Error=0D
  target/mips: Store number of TLB entries in CPUMIPSState=0D
  target/mips: Make the number of TLB entries a CPU property=0D
  target/mips: Allow using the 34Kf with 16/32/64 preset TLB entries=0D
=0D
 target/mips/cpu.h                |  1 +=0D
 target/mips/internal.h           | 11 ++++++++-=0D
 target/mips/cpu.c                | 12 ++++++++--=0D
 target/mips/translate.c          | 39 ++++++++++++++++++++++++++++++--=0D
 target/mips/translate_init.c.inc |  3 ++-=0D
 5 files changed, 60 insertions(+), 6 deletions(-)=0D
=0D
-- =0D
2.26.2=0D
=0D

