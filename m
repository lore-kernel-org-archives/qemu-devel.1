Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467DCC2BA19
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 07:36:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 153F4208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 07:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YnjnrTWj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 153F4208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRWOw-0006lz-8E
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 03:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46780)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRWNG-0004yf-Tj
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 03:34:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRWN9-0006cW-Cq
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 03:34:18 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51473)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jRWN8-0006ZS-Qj
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 03:34:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587627249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ct7jMKth8vWbm+2CUvy6qe7DTi6gbSwkWjtezFIRh9c=;
 b=YnjnrTWj3iBDW993nN0fi585Yj8N4pAxeojbz3V/gBak7IasEjluNjtWUEGG5s65scLHL8
 HF2acvx6AT+l3ThyexkUoMwOjPEBc6Ed2n1MYoKw0mgfOunTMp1R7JdK425XjOgeAUJKyn
 Em4Cgk5wpadhl9AQRQjIyEmQvahkMuA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-yWgtRDPEOkmyOFvsMqtT1A-1; Thu, 23 Apr 2020 03:34:04 -0400
X-MC-Unique: yWgtRDPEOkmyOFvsMqtT1A-1
Received: by mail-wr1-f70.google.com with SMTP id d17so2405878wrr.17
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 00:34:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=oLonGkIJTHbG03JF1+Ssy7OAaXsd0W1f3V8ZSYCW5BI=;
 b=ancDYvdGi2EvSxITqRp8UAB+2DmBNKgQW0YG/KS662R8BzgRS7723eoY999uM4BVk4
 jlFfSXb605qLkgh2tGK7/1+QlAXZfMt5jFgc54MT5lmYZ+aQi3Cx6+81Nq/o9d4p6CQ7
 4XroM/jRvNjh24O8bi8t8JV1Xh36Q3wf7uXFrkut5RC6Z4PwbV/NNAahIL3EYAW/ZKag
 W+YkJqQwJJJztyij7RMzcW8PREes6IyoE4rzhCnLpskcTIkf+7ovZcqIPHFG4oc6Hdjd
 MQTm/I9bMi2gzXj2jvF+D6Hblc3MFlVV95AJjGEnpTEvhTuSHAVR46Xb+IsmxEb3sYmj
 7UcQ==
X-Gm-Message-State: AGi0PubgbK8k01Oaqfg2hCHMw3CUBzXdXmAhYAww+O/SgHcb1S99abwu
 sIEuWSSD4uhTfiTh9OodcpKiHkJgHvJ3pa3ONScu7k3oUfAohMVCyb3ziTagGbDIZ/niZCbYw9U
 FmRDkSiiBEaz440M=
X-Received: by 2002:adf:bbca:: with SMTP id z10mr3483609wrg.288.1587627243517; 
 Thu, 23 Apr 2020 00:34:03 -0700 (PDT)
X-Google-Smtp-Source: APiQypJXwtXv2tdl4JoAyKUwkzS0wPwGL5YmaqH3RUQIR8hiPfgeBECoBznyNjj4lSUc9HpxFWswIw==
X-Received: by 2002:adf:bbca:: with SMTP id z10mr3483586wrg.288.1587627243281; 
 Thu, 23 Apr 2020 00:34:03 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id o18sm2366000wrp.23.2020.04.23.00.34.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2020 00:34:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/5] target/arm: Restrict TCG cpus to TCG accel
Date: Thu, 23 Apr 2020 09:33:53 +0200
Message-Id: <20200423073358.27155-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 03:23:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These are the uncontroversial patches from "Support disabling
TCG on ARM (part 2)"
https://www.mail-archive.com/qemu-devel@nongnu.org/msg689168.html

The other patches are blocked by the "accel: Allow targets to
use Kconfig" series:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg689024.html

All patches reviewed.

Since v1:
- Dropped 'Make set_feature() available for other files' patch
  which fails to build with KVM only, see:
https://lists.gnu.org/archive/html/qemu-devel/2020-04/msg03843.html

Many thanks to Richard Henderson for his patience!

Regards,

Phil.

Philippe Mathieu-Daud=C3=A9 (4):
  target/arm: Restric the Address Translate write operation to TCG accel
  target/arm/cpu: Use ARRAY_SIZE() to iterate over ARMCPUInfo[]
  target/arm/cpu: Update coding style to make checkpatch.pl happy
  target/arm: Restrict TCG cpus to TCG accel

Thomas Huth (1):
  target/arm: Make cpu_register() available for other files

 target/arm/cpu-qom.h     |   9 +-
 target/arm/cpu.c         | 647 +-------------------------------------
 target/arm/cpu64.c       |  16 +-
 target/arm/cpu_tcg.c     | 664 +++++++++++++++++++++++++++++++++++++++
 target/arm/helper.c      |  17 +
 target/arm/Makefile.objs |   1 +
 6 files changed, 698 insertions(+), 656 deletions(-)
 create mode 100644 target/arm/cpu_tcg.c

--=20
2.21.1


