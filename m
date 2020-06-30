Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB7CC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 19:58:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78A1820768
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 19:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sw1oCa8S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78A1820768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqMOo-000178-NV
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 15:58:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqMNl-00089E-MA; Tue, 30 Jun 2020 15:57:29 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37191)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqMNk-00044T-Bz; Tue, 30 Jun 2020 15:57:29 -0400
Received: by mail-wr1-x443.google.com with SMTP id a6so21339355wrm.4;
 Tue, 30 Jun 2020 12:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=znF0WQWyIqwGCAno4Um3q4Y6c7tQfMSvObuszrCzcOU=;
 b=sw1oCa8SAfWJs9iSCnQUnUQZKHwn876FsUAU4nArXdfW0HkiH6dox8D8o3JWX37o+i
 fkVCeT07dEaXy+meKOojYfKuUds5e9ujbwiwbN1kEWQxEJfWCBuYNKVJ+cmGjDI5uZbW
 zkD2LC/+SYukrxbnm2NZN+tkVsZ3lSOB65SnUVHcHMzDiGh46fxWyMXBKTaAIxB3nDUH
 +0HHh6KhJU7CAgz0veDkgYsuhcbmp1crlx4O0c5vu5eUgm35m7xmvN3+JeOyR2icaoOe
 +8F8qwAvRtU4riz7KrEo0d2j+aJuqwXAVjT7AaNm8RWOFs8QzM9w8Du+WsYTrq/4QFb8
 bDtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=znF0WQWyIqwGCAno4Um3q4Y6c7tQfMSvObuszrCzcOU=;
 b=DzfYXOiMJ3XkeXOBd/h2qE4hla+V7lmF1TPl8k1AfeP+LvnEtI31dCefj855BbQ2ih
 gPzigMXBEgeiobk7itrwt4+uLyFxqAJUJw7wSIwCSO7G+sdoLapvFvoAyBNSBmYPk0GS
 RtMoMKbH8eYeN8w78KoKf3oQ0na/hzc40X9M2ulfssOq6HYa1tXcJfgdoFNe52yueAwO
 Ia0D7D4NDtSqqLyqZLGmCZEQbC8ROEcSQqsvPaLjPQDsqzzNK4WtE8D1hvY1MSoWIBpJ
 TlDEuQohVNbKjsGnktUtlwOlJXkOna83LasI0y4sU/p8nQ9tszRWohUavKNr9LNGlh9q
 TIQA==
X-Gm-Message-State: AOAM531NlW3XXhT+zBHlZEFCwXtk14lYp2ht+Bazfz9k1PDKte5Finr2
 QT3OHrFtTFIYBG6iQVlfbxvkdBHiMuM=
X-Google-Smtp-Source: ABdhPJzb3MpPAdJyF/SEYmSS/22YsA7VmQtQy6nPUF0HNtsU+BgZd1+PqK1h9S9haLMKL/v3pKo/kg==
X-Received: by 2002:adf:edc6:: with SMTP id v6mr23308804wro.413.1593547045495; 
 Tue, 30 Jun 2020 12:57:25 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id k11sm5172979wrd.23.2020.06.30.12.57.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 12:57:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org, Yunqiang Su <ysu@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v3 0/5] hw/mips/malta: Add the 'malta-strict' machine,
 matching Malta hardware
Date: Tue, 30 Jun 2020 21:57:18 +0200
Message-Id: <20200630195723.1359-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, qemu-trivial@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This series add a new 'malta-strict' machine, that aims to properly
model the real hardware (which is not what the current 'malta'
machine models).

Since v2:
- Initialize missing malta_machine_types::class_size
- Remove RFC patch that confuses Aleksandar
- Added examples of 'malta-strict' use

$ git backport-diff -u v2
Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/5:[----] [--] 'hw/mips/malta: Trivial code movement'
002/5:[----] [--] 'hw/mips/malta: Register the machine as a TypeInfo'
003/5:[0001] [FC] 'hw/mips/malta: Introduce MaltaMachineClass::max_ramsize'
004/5:[----] [--] 'hw/mips/malta: Introduce the 'malta-strict' machine'
005/5:[----] [--] 'hw/mips/malta: Verify malta-strict machine uses correct DIMM sizes'

Philippe Mathieu-Daudé (5):
  hw/mips/malta: Trivial code movement
  hw/mips/malta: Register the machine as a TypeInfo
  hw/mips/malta: Introduce MaltaMachineClass::max_ramsize
  hw/mips/malta: Introduce the 'malta-strict' machine
  hw/mips/malta: Verify malta-strict machine uses correct DIMM sizes

 hw/mips/malta.c | 105 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 91 insertions(+), 14 deletions(-)

-- 
2.21.3


