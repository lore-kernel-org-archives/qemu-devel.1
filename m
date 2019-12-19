Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A173C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 18:53:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC1F824687
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 18:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlmMNCLN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC1F824687
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ii0vM-0000FK-O7
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 13:53:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39031)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ii0ta-0006zc-Fq
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 13:51:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ii0tY-0007HZ-0H
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 13:51:34 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:39782)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ii0tX-00077M-MV; Thu, 19 Dec 2019 13:51:31 -0500
Received: by mail-wm1-x332.google.com with SMTP id 20so6637350wmj.4;
 Thu, 19 Dec 2019 10:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=kawbqCEjPPYKCsVnRVsa55n98nVaL/1o+fmH2TsyLNE=;
 b=hlmMNCLNwX+RKju0XCfr9FBOQbehZMq5UQz4OtXjSkx2kDsWMOmkiJVcAocgiUOMCq
 dk429h3d4vhPgkXjx+0WXlbk0ZwbwtqpfTaGGhU2wGDQyzUcX0Db5zmGi9nlpIKP8n3Z
 xO0qpuuMEp0etQ5PzaxG8tWIcGc6UhfqfO97S5MPVIjSG4Qpdp9enG08SgnGx62SFJWH
 uvzr3jee9R8X3QgiZaldjIdQivqTRrnekv/dryvXYfLjD5Mg0Fn2dyzKrGu5tit5unHX
 o1TqASqFhTZvwXviwl5GKkr03feprp2aHRUlDiy/KTkHVpvxKrnC2qIizd9qvxfYoS2v
 9NyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=kawbqCEjPPYKCsVnRVsa55n98nVaL/1o+fmH2TsyLNE=;
 b=YivAMyzbDWZvJ2ZTv6FOMqXVr0ndZqJwoW14LVWBjLoOLRi1ouv2emYAzS0deycGsc
 jWsm+uixisoBGsmQnLOdq5H/vVcOzXXmg7yNOa88g5s7beLr+R5w1xmeha/66u8ut97x
 fOCN8+UIWW08Km7HymLMM1tOGvgdvCqp1JzOFedgGQsx4B9wEdjH4j8Pc2UmKQZmsblu
 PgmXWIl857pm4eaKGwnuYJfMr5xs2rDpqRPITWA3FbSyBgbLt2wCJShpIoMgpEBpowmx
 2J5yAXYW3PtA5SHCeH4ubhK8mPY9v5WQCM6yth4qYbdmrwq5LbmY3PImlX1ytEEHYMSx
 bpRA==
X-Gm-Message-State: APjAAAWT23b2QUZUyioLJs4ICOAGtQ7pCR/4EdEC+hSH4puGitcnSIYI
 VsFtdwFglSUeyULfsP/OAGmvQc8h
X-Google-Smtp-Source: APXvYqz4Ia2RBAjPZFSasg71WzEA+swTRfYLvHFWg23ljEMzGUeSrng+dCuiQyyrZTCYkU3rdmzt7Q==
X-Received: by 2002:a1c:486:: with SMTP id 128mr12132694wme.163.1576781489342; 
 Thu, 19 Dec 2019 10:51:29 -0800 (PST)
Received: from x1w.redhat.com (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id b67sm7435494wmc.38.2019.12.19.10.51.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 10:51:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Niek Linnenbank <nieklinnenbank@gmail.com>
Subject: [RFC PATCH 00/13] hw/timer/allwinner: Make it reusable
Date: Thu, 19 Dec 2019 19:51:14 +0100
Message-Id: <20191219185127.24388-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::332
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
Cc: Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

Niek added the H3 SoC in [1] and noticed in [2] the timer
controller is very similar (less timers, watchdog register
placed at different address).

On 12/18/19 9:14 PM, Niek Linnenbank wrote:
> Actually, I copied the timer support code from the existing cubieboard.c
> that has
> the Allwinner A10, so potentially the same problem is there.
>
> While looking more closer at this part, I now also discovered that the
> timer module from the Allwinner H3 is
> mostly a stripped down version of the timer module in the Allwinner A10:
>
>    Allwinner A10, 10.2 Timer Register List, page 85:
> https://linux-sunxi.org/images/1/1e/Allwinner_A10_User_manual_V1.5.pdf
>
> The A10 version has six timers, where the H3 has only two. That should
> be fine I would say, the guest would simply
> use those available on H3 and ignore the rest. There is however one
> conflicting difference: the WDOG0 registers in the Allwinner H3 start
> at a different offset and are also different. The current A10 timer does
> not currently implement the watchdog part.
[...]
> So in my opinion its a bit of a trade off here: we can keep it like this
> and re-use the A10 timer for now, and perhaps
> attempt to generalize that module for proper use in both SoCs. Or we can
> introduce a new H3 specific timer module.
> What do you think?

As an answer to his question, this series is to help him to
reuse the A10 timer controller instead of adding a new model
to the codebase.

[1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg665532.html
[2] https://www.mail-archive.com/qemu-devel@nongnu.org/msg666304.html

Philippe Mathieu-Daudé (13):
  hw/timer/allwinner: Use the AW_A10_PIT_TIMER_NR definition
  hw/timer/allwinner: Add AW_PIT_TIMER_MAX definition
  hw/timer/allwinner: Remove unused definitions
  hw/timer/allwinner: Move definitions from header to source
  hw/timer/allwinner: Rename the ptimer field
  hw/timer/allwinner: Rename 'timer_context' as 'timer'
  hw/timer/allwinner: Move timer specific fields into AwA10TimerContext
  hw/timer/allwinner: Add a timer_count field
  hw/timer/allwinner: Rename AwA10TimerContext as AllwinnerTmrState
  hw/timer/allwinner: Rename AwA10PITState as AllwinnerTmrCtrlState
  hw/timer/allwinner: Introduce TYPE_AW_COMMON_PIT abstract device
  hw/timer/allwinner: Rename AW_A10_PIT() as AW_TIMER_CTRL()
  hw/timer/allwinner: Rename functions not specific to the A10 SoC

 include/hw/arm/allwinner-a10.h       |   2 +-
 include/hw/timer/allwinner-a10-pit.h |  54 ++----
 hw/timer/allwinner-a10-pit.c         | 271 +++++++++++++++++----------
 3 files changed, 192 insertions(+), 135 deletions(-)

-- 
2.21.0


