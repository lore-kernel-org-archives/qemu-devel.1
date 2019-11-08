Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F929C5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 12:44:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A42D21D7E
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 12:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMTGJZcV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A42D21D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT3cy-00038c-SI
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 07:44:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45964)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1iT3b7-0001TU-TY
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 07:42:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <edgar.iglesias@gmail.com>) id 1iT3b6-0000I6-PT
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 07:42:41 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55966)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
 id 1iT3b6-0000H1-Jg
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 07:42:40 -0500
Received: by mail-wm1-x342.google.com with SMTP id b11so6031055wmb.5
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2019 04:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/5O7PjcjAoeRLO1L/DKR9iB88xGHJxmmESpBt8TEgNY=;
 b=HMTGJZcVSrwOWJ09+KEcCWLEX09GolY8kyQD9kdUGrTCcEJaN679jLFI92TIW0I9nx
 H3hnSwgO96WmGDxyS2m4EGjLA4qfUYoOQwNfurpGjc1pHV8JuvTEK6BLJ4SXfRb2Xo43
 t/Rx9uucP6Gjudq5YotJaFrkcmLx/D29W7sz3V2qbtEnKTcaH1bGkp6jtdDDc34Jlt/b
 yEgnljBpJaEEoWgwv766vK+CGHjRWKJcplNl4TP0y4GWXoWSpC9JWZA0MgsFqhCYAuCF
 Ew+4jpKfYn/YSnrxUoHtTmRhealrwqM9aUWR/+2+sqyqJ29UuKrmYyKojP7k97Yp4nEw
 5bHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/5O7PjcjAoeRLO1L/DKR9iB88xGHJxmmESpBt8TEgNY=;
 b=DMw0y3A+Gd5vWVe08xiw4ujlrSLTNqVvpPsKKBI5mMwUtaEpzAfECzhSpyFuLhTA9v
 y2zmvMsiIcZyamKGKU1Zs+k9S8UR3bJi0d6gofjxvGjB7GSlJ+sp7C11OSR5GqXj8xdx
 pejAq7F/MzCO6Kt3TUA10v5zoAd9nzQ0fo0ISmU8uqcqAxzF5uvfbS0z+UT+UKVAsihD
 ZYiBhv49Wy2OXIRH/M8UkXxYzeXYqi7fWsHFBC9HDnfGTr6xZsZtqDjXFxCGvlU+KkTy
 8FsMAym5hXbqX6D+H62gvfq7MG013vUUASaETE9U36VKuU8mCPs3mQCfqVA2q/iWBskk
 trNw==
X-Gm-Message-State: APjAAAW/BmjZj33itXTuhH1iF7g5BULXffTT8L+8ucDPejgUB4hZSbYD
 LMZ0zmfGvfidWUyjdwGaY5YLWA5/oqk=
X-Google-Smtp-Source: APXvYqyhxghajvi9FrabLdsoSxHScmVzb6hh7CZfkeR/mwSyF8YNnnI30gYYo9hPyRDVQipVOdQvDw==
X-Received: by 2002:a7b:cb83:: with SMTP id m3mr7434830wmi.134.1573216958229; 
 Fri, 08 Nov 2019 04:42:38 -0800 (PST)
Received: from localhost (ec2-34-244-242-0.eu-west-1.compute.amazonaws.com.
 [34.244.242.0])
 by smtp.gmail.com with ESMTPSA id d4sm5030967wrw.83.2019.11.08.04.42.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2019 04:42:37 -0800 (PST)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/3] target/microblaze: Plug tcg temp leaks
Date: Fri,  8 Nov 2019 13:42:16 +0100
Message-Id: <20191108124219.31348-1-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me,
 richard.henderson@linaro.org, frederic.konrad@adacore.com, philmd@redhat.com,
 luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

On some workloads we've seen TCG run out of temps due to leakage
in the MicroBlaze translator. This series fixes the leaks.

Cheers,
Edgar

ChangeLog:

v1 -> v2:
* Use tcg_gen_xori_tl when endian reversing load/store addresses


Edgar E. Iglesias (3):
  target/microblaze: Plug temp leaks for loads/stores
  target/microblaze: Plug temp leaks with delay slot setup
  target/microblaze: Plug temp leak around eval_cond_jmp()

 target/microblaze/translate.c | 77 +++++++++++++++++------------------
 1 file changed, 38 insertions(+), 39 deletions(-)

-- 
2.20.1


