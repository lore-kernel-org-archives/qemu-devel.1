Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64424C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 14:02:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 275BF20936
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 14:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XU+QaOYK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 275BF20936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCkOS-0002WI-9x
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 10:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1kCkNN-0001Xx-5u; Mon, 31 Aug 2020 10:01:38 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37926)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1kCkNK-0005RU-Ha; Mon, 31 Aug 2020 10:01:36 -0400
Received: by mail-wr1-x441.google.com with SMTP id w13so6063353wrk.5;
 Mon, 31 Aug 2020 07:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7WoK5JiGHWMfthNji8W9QYpbqPAt2/gvWfZDQR/2dMk=;
 b=XU+QaOYKuNCBKV7H6opsn5eYM0qEmiNh+IFghcd5WuUsxQpf+LQ5+d7ZBLpZY06cnE
 w22SBGlpTIHnBqCWw/JbrhFK/RObtMc/UvnZoeHlgaRMz6qVdE4XN08RXxVP6Iq4M6p+
 WSvbBFIJfgNT+Y24LqprGhP68Na0y/jRv6w+lOAwDBdj6dzxxalXPnnZD8WYgE6gZSoy
 2Muu+4Z/CN4nbwOIz3g/IH6o7khGlHCuJLSlHYOdl0ZbJ/782M2J2s1rFiluCeHSX9m6
 uckmf1z9aak1AdiEm9oGBSC+jnRiFVbn/J2ZrIMyJbwBt97DfPJH7zYEcjD/WiI1pbaZ
 m4OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7WoK5JiGHWMfthNji8W9QYpbqPAt2/gvWfZDQR/2dMk=;
 b=k3N5ahiySQ80JgeOkRo12TszA1RxnbyNW/LP45XrS2fIsXHV6o1MZ7LFu0WNG1zPGV
 uFyKTkv81X0s+mFXR57NeiuDHFHxEkH6fcX1Magh7cbct/G7UMdXKCGbaFEEhcjL/pRN
 DqeFdwInuoSsQKLMYJkGt/ktrtHEAIekoDfSMdbM/iMvxIYvHW9/xtANW1g3IHcmhSu8
 oSSAyzTGbrpEB0hsAUrryi3BXU+Tebrr5GTBzrdJmFxx5h00gwrFdsY/oBxRkoydVGPs
 DEig06RtbxG8CySl1dvlgd2UBVCubQT+tEb8xTLIq+xU/UYEQNoqdozH61bdIzD/WEdG
 tOhg==
X-Gm-Message-State: AOAM533T7tM5KKbfiWN8ayO3LbXdtvINQZ7g/PjQLPlqn35D/28xOPNQ
 qe/KtGVz3gqlTcQov7OI279Panqkl4qqTbEH
X-Google-Smtp-Source: ABdhPJx29/s6XEwgC2LXQLQo8p773iRGCzZPm5BYw3la5k/g8CbuR4IOVvwYOLZ8ERK5iyLu9agU9g==
X-Received: by 2002:adf:c58c:: with SMTP id m12mr1754034wrg.88.1598882491578; 
 Mon, 31 Aug 2020 07:01:31 -0700 (PDT)
Received: from localhost.localdomain (109-186-204-55.bb.netvision.net.il.
 [109.186.204.55])
 by smtp.gmail.com with ESMTPSA id q192sm12413320wme.13.2020.08.31.07.01.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 07:01:30 -0700 (PDT)
From: Nir Soffer <nirsof@gmail.com>
X-Google-Original-From: Nir Soffer <nsoffer@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] Replace posix_fallocate() with falloate()
Date: Mon, 31 Aug 2020 17:01:25 +0300
Message-Id: <20200831140127.657134-1-nsoffer@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=nirsof@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Nir Soffer <nsoffer@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Change preallocation=3Dfalloc to use fallocate() instead of=0D
posix_fallocte(), improving performance when legacy filesystem that do=0D
not support fallocate, and avoiding issues seen with OFD locks.=0D
=0D
More work is needed to respect cache mode when using full preallocation=0D
and maybe optimize buffer size.=0D
=0D
Continuing the discussion at:=0D
https://lists.nongnu.org/archive/html/qemu-block/2020-08/msg00947.html=0D
=0D
Nir Soffer (2):=0D
  block: file-posix: Extract preallocate helpers=0D
  block: file-posix: Replace posix_fallocate with fallocate=0D
=0D
 block/file-posix.c                     | 202 ++++++++++++++-----------=0D
 docs/system/qemu-block-drivers.rst.inc |  11 +-=0D
 docs/tools/qemu-img.rst                |  11 +-=0D
 qapi/block-core.json                   |   4 +-=0D
 4 files changed, 127 insertions(+), 101 deletions(-)=0D
=0D
-- =0D
2.26.2=0D
=0D

