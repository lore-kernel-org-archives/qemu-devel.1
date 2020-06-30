Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590E8C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 14:53:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28CA520675
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 14:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LD8LBQln"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28CA520675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqHdv-0002hq-A1
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 10:53:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqHco-0000Ne-S4
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 10:52:42 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:40472)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqHcn-0002TH-5p
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 10:52:42 -0400
Received: by mail-ej1-x644.google.com with SMTP id o18so16511141eje.7
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 07:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=RztwnshbK6MJrHrWxkOXoXPKJip4CYHZKzl9mScPgZE=;
 b=LD8LBQlnMd4QV1yy5WXGYRatkG2MvU7A6wIcVzlLxTWTwfC/ET/dsBu96+lJ7GupRH
 kuiFcDTkHmdwKDx3SX7kbhB07dRlMYVcIJqkNyDB+IlvIh+etND+tujA2iaPZxrTSXCE
 dsCYYKXdRYPifw2h70BJ5OJnC7Bx+QDj0zYTRC3WDwhdnbgUxCFBZr93R91lGhd9y77f
 okUUD+yz5a1OglZYvWgAC9USYw2t4L+rhxMIHf3trwv2AF9GkWnPnyqwHuHnbFkyDKjU
 5L+n0xhgzsgAONhboADqI1g01r5ene4x7v9gmqJ126idwYk3YSN/HKZMhn5QR/yO3wFf
 9yKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=RztwnshbK6MJrHrWxkOXoXPKJip4CYHZKzl9mScPgZE=;
 b=EGDiy79JSPI+av0PnvNVJORnhGHMd6OYldPCCeVKlF6edyzhTtBCOmsHj7/lPknJTq
 9fxkxu+htOppe9CKLKj+MJ91wZWrQ3hqnY0NgJ/aAjjcusTL2T6C1dmrtiMIwvBiHd7r
 /nJl28+bTPMZMarFJqHsMKrpmUWD+ZblWHzaaOkM0WW50zI741OeHjUmt+Gt9SwNwKYV
 4KKJO1PCvUaBAl4eCEEiBUSkX5szco4l5ObT6o43/+vvYhGsmy3m0DaFh7FRtJ6BPKoi
 rNm3xPjqyxanzvvLsR5m4LbvNQe/rKoZfc94dP2BF63xqPIMU3+uJ4+47Olo/YHtlAGu
 Ltsg==
X-Gm-Message-State: AOAM530cru+qfqMINjeO5bN5bdxLbXA5j6HUGRRm6jD59+urz1iq8wEZ
 6a4aQYni9KV+KxNaxJmFplU=
X-Google-Smtp-Source: ABdhPJzPNawBdbRHtdcWScv0gP1YapryDrEpVOCWp2Oo3Tc+Gn8J/q6dkNFDhgYBBCoQRzknFSfarg==
X-Received: by 2002:a17:906:355b:: with SMTP id
 s27mr19606014eja.368.1593528758345; 
 Tue, 30 Jun 2020 07:52:38 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id p9sm2144569ejd.50.2020.06.30.07.52.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 07:52:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Aurelien Jarno <aurelien@aurel32.net>, Yunqiang Su <ysu@wavecomp.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 0/6] hw/mips/malta: Add the 'malta-strict' machine,
 matching Malta hardware
Date: Tue, 30 Jun 2020 16:52:30 +0200
Message-Id: <20200630145236.27529-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x644.google.com
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
Cc: Igor Mammedov <imammedo@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This series add a new 'malta-strict' machine, that aims to properly
model the real hardware (which is not what the current 'malta'
machine models).

As a bonus for Debian builders, a 'malta-unleashed' machine RFC
patch is included. This might start another endless discussion
upstream, but this is not the point of, so I still include it
for people to test. The rest of the series is candidate for merging
in mainstream QEMU.

Philippe Mathieu-Daudé (6):
  hw/mips/malta: Trivial code movement
  hw/mips/malta: Register the machine as a TypeInfo
  hw/mips/malta: Introduce MaltaMachineClass::max_ramsize
  hw/mips/malta: Introduce the 'malta-strict' machine
  hw/mips/malta: Verify malta-strict machine uses correct DIMM sizes
  hw/mips/malta: Introduce the 'malta-unleashed' 64-bit machine

 hw/mips/malta.c | 125 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 111 insertions(+), 14 deletions(-)

-- 
2.21.3


