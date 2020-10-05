Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F335EC46466
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 15:10:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 628022078A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 15:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ObzC85D2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 628022078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPS7j-0003CH-Al
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 11:09:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44358)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPS6h-0001sA-Gd
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 11:08:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36971)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPS6e-00029L-Kq
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 11:08:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601910531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=RsHxzOJVf/n4DmVsqEbZ5oe9eeK3RtAZyihHr68HtoU=;
 b=ObzC85D2u5CjWGrpJYNGxZawpBtfDvMShBGG76x9qXHiUixxk3nw64qA08lApzx72HEYv8
 lAMON+NUB+HBHVc6Td5vLEgYYUWNTg6ICUpi0fjqQsyfmFDj/abdf5Lo0JCOIml3CeeT9Q
 CzKUkj+w6S64gHxs0U6uD7nCi5uCPXQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-RX8-VFRzNmWS65dmziF_5Q-1; Mon, 05 Oct 2020 11:08:48 -0400
X-MC-Unique: RX8-VFRzNmWS65dmziF_5Q-1
Received: by mail-wr1-f72.google.com with SMTP id r16so4107957wrm.18
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 08:08:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=RsHxzOJVf/n4DmVsqEbZ5oe9eeK3RtAZyihHr68HtoU=;
 b=Mf2RFWPJ3pvI4FSnizMnl3EQiJYkRqGHQpufB1a4jaAs1CtoUFB9WHkk81Vgd8QDwx
 /DHYyeMmxL7ooFTZIokO6Wp9/zoLdLdWq00X/q0gFHhP6ZvjtTfaaUxr5w6QcdwbpTHY
 QEodgp8GMCj4l7wZaygXO6/YgegvWaH7Or4u9pUZh8EqlbjSAwLNDzAzE47jMgZz5AOf
 RYu+CoTFzwaZ+9IRA8/P9glR0wirS7vBd77+Z+HUc2r0QhSyTsTfqPPY6ddstyb0e4N0
 mfh7fz2WTgoXRTFRWAO5t+C97yRcuF3tG+GJJAqD6pEFZ0N2qkJqD8PF7+g+D17dFqTq
 pFVw==
X-Gm-Message-State: AOAM531rZRoDh7aFVmci+msR1boc29gmPv5DyxlF+qeO5XCRjSkj2mcp
 GBO+ccREYNalOK2TLEoLg1C+q8BhF6Mw6ndwr+qV5lzIFekEW6c9cXU9bjfdbN5DX9cI/Cl8Pfn
 aZ0X0eq1AYdN0eU0=
X-Received: by 2002:a1c:2394:: with SMTP id j142mr56777wmj.3.1601910527538;
 Mon, 05 Oct 2020 08:08:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGOM+CXDsPjuW3rvvS93O9LzwbNdP9LoCeVfMglurInxiUrwC1la1PBU4XP/wlik/A/FxgHA==
X-Received: by 2002:a1c:2394:: with SMTP id j142mr56738wmj.3.1601910527244;
 Mon, 05 Oct 2020 08:08:47 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id u2sm384586wre.7.2020.10.05.08.08.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 08:08:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 0/4] hw: Have some targets select FDT on a per-machine
 basis
Date: Mon,  5 Oct 2020 17:08:41 +0200
Message-Id: <20201005150845.2124381-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 02:11:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PoC to have CONFIG_FDT per-machine set by Kconfig, looking at
Paolo's "dtc: Convert Makefile bits to meson bits":
https://lists.gnu.org/archive/html/qemu-devel/2020-10/msg00983.html

These files shouldn't be needed:
. default-configs/targets/mips64el-softmmu.mak
. default-configs/targets/ppc-softmmu.mak
. default-configs/targets/ppc64-softmmu.mak
. default-configs/targets/rx-softmmu.mak

The QEMU FTD API is used by these boot.c files, so for these it is
easier to have a per-target config:
. hw/arm/boot.c
. hw/microblaze/boot.c
. hw/nios2/boot.c
. hw/riscv/boot.c

Philippe Mathieu-Daudé (4):
  Kconfig.host: Declare FDT symbol
  hw/ppc: Rename FDT_PPC as FDT
  hw/mips/Kconfig: Let boston machine select FDT
  hw/rx/Kconfig: Let gdbsim machine select FDT

 Kconfig.host       |  4 ++++
 hw/mips/Kconfig    |  1 +
 hw/ppc/Kconfig     | 15 ++++++---------
 hw/ppc/meson.build |  2 +-
 hw/rx/Kconfig      |  1 +
 5 files changed, 13 insertions(+), 10 deletions(-)

-- 
2.26.2


