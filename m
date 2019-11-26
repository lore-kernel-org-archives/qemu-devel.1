Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A916C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 09:01:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 472722073F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 09:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPPjLFZs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 472722073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZWin-0003FB-3N
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 04:01:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49945)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iZWh9-0001xR-UC
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 03:59:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iZWh9-00034a-0B
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 03:59:39 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:34711)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iZWh8-00034J-Ky
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 03:59:38 -0500
Received: by mail-wm1-x335.google.com with SMTP id j18so1857473wmk.1
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 00:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DijFizQKywtJd6297+vkWzPeDBWLa5nq/Big6xgvCww=;
 b=GPPjLFZsaf1H6XCEHn4cVKo/3+DtXoqBsFCV1fEUcus6dr3llQcjBwzCMyrrcsvMgM
 7zQKSV4A2v2dT67awKTUv0uS8k+Gfs3yceO9NyQYJWDNkz28+kRyUjxH8yyxa8U6jm9Y
 fUevUGL48TbKlkQHvNP0KZRL93QXEOzRxyLk6RhLASu/T/UDqijmTfcq6O0aEHPoyt+6
 xherCN0WgwRBdYxa7xpMJ8slGnQFc4cwKpvj6BvkBVfUqAvUhKBVO59X+ju+1wBgjqtM
 iEygPBDgzK5YC0J9O5rj8yW8q1ETwk0alrnkbWOlWGSV95EXRwQ9+ZPHX+icKVpnIdi3
 aBGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=DijFizQKywtJd6297+vkWzPeDBWLa5nq/Big6xgvCww=;
 b=Mhue3VKZVXu21sIdPnj1xlq4E7Q7lMa67OjeWgTJCIdw5SQuJWJHEteDka1LIBRFFs
 TK522sYXKPVnuFK0MzRX/hvyLNzCOi8gzvUFPH/tWQS88QstKcuEYnyO6C207QPOtEhe
 J1IkH/jXLMs34EzzTHZ20YxhIEmD/W/wxS1X3IpZ+wM3+Tfwr25lezedyK1fl1dwENkw
 7tJkP2tDNDetjaTeSH9ROqc1oZ0TpVLTvaJMGck/5GTNPGkvLR5/fiaMv0RTYWBdMT0G
 Ix1y2MYSbleL+68hhTb9R1qt+RtpXMADCS0G72ta/oJprzGnJyvEAeT9alKK+pspQiVP
 0GZA==
X-Gm-Message-State: APjAAAXec91gvK17egY0xAc9kZifGpMLRPdDYmcPHYUT4pQr7uT/RsZm
 pfGfyUZdAGv8e3vCkoXtzltaae+H
X-Google-Smtp-Source: APXvYqysZox0BttBa3E7aGMkyxGU4y2IKDYAm0n0hhh9U+8KjlJVTtbHw+1dHnPK4AiNvWLms6yy9A==
X-Received: by 2002:a1c:6885:: with SMTP id d127mr3028946wmc.64.1574758777164; 
 Tue, 26 Nov 2019 00:59:37 -0800 (PST)
Received: from donizetti.lan ([2001:b07:6468:f312:5454:a592:5a0a:75c])
 by smtp.gmail.com with ESMTPSA id a206sm2349172wmf.15.2019.11.26.00.59.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2019 00:59:36 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/5] i386 patches for QEMU 4.2-rc
Date: Tue, 26 Nov 2019 09:59:31 +0100
Message-Id: <20191126085936.1689-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 65e05c82bdc6d348155e301c9d87dba7a08a5701:

  Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2019-11-25 15:47:44 +0000)

are available in the Git repository at:

  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to e37aa8b0e410e83b4e150e38e83e385169ba09a7:

  hvf: more accurately match SDM when setting CR0 and PDPTE registers (2019-11-26 09:58:37 +0100)

----------------------------------------------------------------
* VMX feature fix (myself)
* HVF fixes (Cameron)

----------------------------------------------------------------
Cameron Esfahani (4):
      hvf: non-RAM, non-ROMD memory ranges are now correctly mapped in
      hvf: remove TSC synchronization code because it isn't fully complete
      hvf: correctly handle REX prefix in relation to legacy prefixes
      hvf: more accurately match SDM when setting CR0 and PDPTE registers

Paolo Bonzini (1):
      target/i386: add two missing VMX features for Skylake and CascadeLake Server

 target/i386/cpu.c            |  6 +++--
 target/i386/hvf/hvf.c        | 61 +++++++++++++++++++++++++++++------------
 target/i386/hvf/vmx.h        | 18 +++++++------
 target/i386/hvf/x86_decode.c | 64 +++++++++++++++++++++++++-------------------
 target/i386/hvf/x86_decode.h | 20 +++++++-------
 target/i386/hvf/x86_emu.c    |  3 ---
 target/i386/hvf/x86hvf.c     |  4 ---
 7 files changed, 104 insertions(+), 72 deletions(-)
-- 
2.21.0


