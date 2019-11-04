Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D9ACA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 17:31:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1C0F20869
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 17:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntr+oDjk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1C0F20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRgCd-0003Jl-Q0
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 12:31:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33398)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <flukshun@gmail.com>) id 1iRgBR-0002WV-Db
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 12:30:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <flukshun@gmail.com>) id 1iRgBQ-0006Ip-G4
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 12:30:29 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:39384)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1iRgBQ-0006IO-BW
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 12:30:28 -0500
Received: by mail-oi1-x241.google.com with SMTP id v138so14823968oif.6
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2019 09:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id;
 bh=IBXDAzDv4jMVN4HVkExpkj4YJ/RZ0eeoVpdxAwobc54=;
 b=ntr+oDjkL/n5VSgdQhJi5ZMVZe6vd+JZxYP7ZLmUKerFTk/e7EL9HpDFWFKK0J2ZZc
 bt7K2vOmYr79Lejrf9zKTUgPUd03Q1ziOg5QxEGZgaGnN9Iqx9eXyTid38pwe+2RTVIY
 GV/RVvl0zWB0atoIjCeI29s9Y0HR+rE+SRoxJW4kltUZZkQR4+Vru0eqoFB5gxTqTgAh
 r7cOUslGaEGOI0cbJWGx2XYNc3GTZGtsHgJVBkiLzGSE/T0iH2Dp8b4u3NZgqbtEVIbz
 HF+QrMu3bfakOisfBT7lBoxWFIVrKDyq+FwsKZ+gLvXCTUvslFDCvbmejKpolZFXcFBz
 TkSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
 bh=IBXDAzDv4jMVN4HVkExpkj4YJ/RZ0eeoVpdxAwobc54=;
 b=rux/2MNQfnLuIDN1nfhLCSJYpJODYpog8Z8h1mNI6e0HhNneJkXQXj46c5STtjlCKF
 H0Rfxkbq8VRmQnxY+RtCfE6kThoBU/RwLkpty1wDfGiVoiFA+NMYVTaYujAxV6ZvNki7
 5aY6/zjqKpPzBtcvB4Fb3ovwlThyVQ0VWC1QH5YjYqHJno1piwNYrscDi1TvSH6DC5b5
 Q4fArfNjSWHK8VQkaQtV0Lsz4rlDI9qfF84bX9krhpmeGJ+XUZrRSygjaSadCA0qgbdp
 H1PE4kDHyFGPx1sE/LhDbEuHvF8F/AD6SiF2k22pIo1WgCVCrOXwjNNDgfrglC5QZUKU
 VlpQ==
X-Gm-Message-State: APjAAAXQlJHC51Zf5srPUjD9SZRWdJrd1t9WInVRDoMlW9PPqQp/RzCp
 K9I3z34h8hpNULJqoHbd0nvWliHM2T4=
X-Google-Smtp-Source: APXvYqxqvbRgFkTipStp5azc6/OPOyXXNQW90nSWNwRec1i8V0/VNcQom+JSBsyqnFGcnO78TtljrA==
X-Received: by 2002:aca:de84:: with SMTP id v126mr192521oig.46.1572888625991; 
 Mon, 04 Nov 2019 09:30:25 -0800 (PST)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id 202sm4912669oii.39.2019.11.04.09.30.24
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 04 Nov 2019 09:30:24 -0800 (PST)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/2] qemu-ga patch queue for 4.2-rc0
Date: Mon,  4 Nov 2019 11:30:15 -0600
Message-Id: <20191104173017.14324-1-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 36609b4fa36f0ac934874371874416f7533a5408:

  Merge remote-tracking branch 'remotes/palmer/tags/palmer-for-master-4.2-sf1' into staging (2019-11-02 17:59:03 +0000)

are available in the Git repository at:

  git://github.com/mdroth/qemu.git tags/qga-pull-2019-11-04-tag

for you to fetch changes up to 28d8dd355be98da6239bd5569721980c833df6a1:

  qga: Add "guest-get-memory-block-info" to blacklist (2019-11-04 08:50:54 -0600)

----------------------------------------------------------------
qemu-ga patch queue for hard-freeze

* fix handling of Chinese network device names in
  guest-network-get-interfaces
* add missing blacklist entries for guest-get-memory-block-info for
  w32/non-linux builds

----------------------------------------------------------------
Basil Salman (1):
      qga: Add "guest-get-memory-block-info" to blacklist

Bishara AbuHattoum (1):
      qga-win: network-get-interfaces command name field bug fix

 qga/commands-posix.c |  3 ++-
 qga/commands-win32.c | 12 ++++++------
 2 files changed, 8 insertions(+), 7 deletions(-)



