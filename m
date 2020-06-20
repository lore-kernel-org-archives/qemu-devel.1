Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E845C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 13:33:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 463F623B8B
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 13:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7Xnq8GO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 463F623B8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmdcp-0001bn-Cp
	for qemu-devel@archiver.kernel.org; Sat, 20 Jun 2020 09:33:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jmdbi-0000I0-K6
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 09:32:30 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:41336)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jmdbh-0003H3-0i
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 09:32:30 -0400
Received: by mail-ej1-x644.google.com with SMTP id dp18so13278563ejc.8
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2020 06:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=GpHIQnBIRExBKcXtlBLaXgYH3gkpz0GaMrOkHHv+dn0=;
 b=g7Xnq8GOSCkTyrNhZTHvEAsbcr+JZe3Oi1YU3THZkVxelsac4nkoZFAAwFyvdSUz0X
 gOM7BLzJgI/qtC/F9FYtOOQk2V6gtasQfpaLIlJg+txXJd0mMQIS/XWpC4RoF/QN5iRG
 6kUCcLWqnuP2difQN2SMwofpcdj7tmYw3jOvpxFJkGj91c1/sml94rF+/34rTjGan6QU
 Fc3aEnxOe7Xg/+7b4HXoFnq1qWL7Sa62snHH28F3vhLXrC8vpzIipVz52ZFLfmfEqdSj
 seVYqR/JhJdg8AZHXgNcMOlDp/Ra1oGrLXAuub0lKGy2k2jmr4oWszLIq3c3YbtZWNok
 No8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=GpHIQnBIRExBKcXtlBLaXgYH3gkpz0GaMrOkHHv+dn0=;
 b=gtBbL2SwE8W6Lhix/84rTZ5YH6Iq4Ux3I/qCqvn7RglQdNzF8kuP0dE5xyiPaQO+mg
 r0Uq/poNVaOCy9LwsX08tAwfEDsR1vrH3xO0wufHiuD01MxVPVZek+glLqT+74SKEasw
 epuAF6mpKlBMO94UlFftdTrzN2hMT/BUj2aTj2yLuQsGfS/C9b9/cqHDCfVxwCdQtWbc
 FRh6qlGMf73akVP3t0bj1ePtGihcXiiFXjwMcJ0hF2JNxtSduDSmrso1D/vWB3Wm/xND
 0xuy/6PqHvsAc4F/j/UBVHH+ptMOQSWXObMIZo6IYjWHXA7SJGxHtGiekR5b7sN++hA7
 Q2QQ==
X-Gm-Message-State: AOAM5323qo8Tejde3/B/V4NkDCPgtKA8wQAG4/D9aL2JROW5bMOJqfuT
 U9PGJHKJc5f5F6MtHzwIsVNbuXql
X-Google-Smtp-Source: ABdhPJzNT7oN4rJhjzHE0yI9IPQsOI7S9b1qqch6/vU/GA+b1eVlzCITZEXZrLUFMqrhUOfUglx6qQ==
X-Received: by 2002:a17:906:66d0:: with SMTP id
 k16mr8212254ejp.293.1592659947345; 
 Sat, 20 Jun 2020 06:32:27 -0700 (PDT)
Received: from localhost.localdomain (net252-38-245-109.mbb.telenor.rs.
 [109.245.38.252])
 by smtp.gmail.com with ESMTPSA id bd19sm7453202edb.2.2020.06.20.06.32.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2020 06:32:26 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] checkpatch: Do appropriate kernel->qemu renaming
Date: Sat, 20 Jun 2020 15:32:05 +0200
Message-Id: <20200620133207.26849-1-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-ej1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: pbonzini@redhat.com, Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 stefanha@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There are several places where 'kernel' is mentioned instead of
'qemu' in checkpatch.pl.

This small series corrects this.

Aleksandar Markovic (2):
  checkpatch: Rename top_of_kernel_tree() to top_of_qemu_tree()
  checkpatch: Change occurences of 'kernel' to 'qemu' in user messages

 scripts/checkpatch.pl | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

-- 
2.20.1


