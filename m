Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52ACFC00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 09:12:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CFC620705
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 09:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="QzeH39UE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CFC620705
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40843 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip7Nw-0003pv-U3
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 04:12:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55417)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1ip7Mc-0002aK-Or
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 04:10:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1ip7Mb-0004O2-QS
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 04:10:54 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:38262)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1ip7Mb-0004Mv-HB
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 04:10:53 -0500
Received: by mail-wm1-x32a.google.com with SMTP id u2so1636679wmc.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 01:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=nJ2lUzqVn8Akvmgs/bn/mnZ2yDSz3w4xjaD06n6bevY=;
 b=QzeH39UEPqkz9kCq1x9/Rhn8bGtbhSIl2L5IS9VczTgRlMi/q/6S9Axc3hD43/+hsu
 mNfgK8d0NHEnWPYL9z61Jbb/EuxTaLBqxKrxsYjoOKw8YiuU0ComHv/5hhsOUpLGxgJc
 we1+cbn2xxVBBpyPg/pUcZCyCPB8zGfSP4OqQZHTZ8XGszCcnDnqvpESyIiOVThGpr9t
 lmiiK59niLV17n3CcOoGmsS5vl+GvsnxSplSxZ726xJV7/rq+K5IXVgZKtxc6YzOWuaW
 CN8uuZraXPV3gtF1OgNy58hSX/hXtcXIZ8x6TSOP3baBkDhthTbuT7MLtYrkwiZHrh2U
 hnPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=nJ2lUzqVn8Akvmgs/bn/mnZ2yDSz3w4xjaD06n6bevY=;
 b=ey/nXCdhLfYk0NtWXOzmSZJbIdlu65kZRySkMP4fwnZzP1TiAvuDDCV7NkPHbYu/Kf
 tymne7ZdfARxKkehnKrGRk1FX5+QMtlrUwC1uu6P71P5Ydv1PsG903PkAKa4e4InItCw
 hD2wb0tFOEYb4/Jsvm1KDe1rhx/iMwZk/D29obtp5qk2lRpTWuyf6J7+K0eKJEFnyEGn
 Fs66c3fEKqbWWg6IXxKmtGP52D33E7vWUtFNAkTNI0xkCyRbJDzGYN6y3Zhuxj2RG4/c
 MqaOFWhNmiqNdh6SSbdXScvbJytwVEPCcqhMiv7eP4+sIAgd0Smyw+ApdMvvDG3knKMl
 t5nw==
X-Gm-Message-State: APjAAAUTQ7CnIr+cjVLjvz/m6j7pGNuIkuqTADwxl5tsqueq4e6JNory
 tcA1PJ5+hcO8Pe8/7NvGVC/xHA==
X-Google-Smtp-Source: APXvYqzNYEEtoeruYCW9R4FslZZUcivfIgMM1JSW7lk2HnQcPogVFtxleFhVJInz36B4wzlvlYuBPQ==
X-Received: by 2002:a7b:c190:: with SMTP id y16mr2599010wmi.107.1578474652533; 
 Wed, 08 Jan 2020 01:10:52 -0800 (PST)
Received: from f2.redhat.com (bzq-79-177-42-131.red.bezeqint.net.
 [79.177.42.131])
 by smtp.gmail.com with ESMTPSA id q3sm2892676wmc.47.2020.01.08.01.10.51
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 08 Jan 2020 01:10:51 -0800 (PST)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, kraxel@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH v3 0/2] Remove 'remote wakeup' flag from USB config descriptor
Date: Wed,  8 Jan 2020 11:10:42 +0200
Message-Id: <20200108091044.18055-1-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32a
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
Cc: yan@daynix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series of patches addresses possible functional problem of USB
devices with 'remote wakeup' capability, redirected to Windows VM
(local redirection using libusb or spice redirection using usbredir).

Yuri Benditovich (2):
  usb-host: remove 'remote wakeup' flag from configuration descriptor
  usb-redir: remove 'remote wakeup' flag from configuration descriptor

 hw/core/machine.c    |  2 ++
 hw/usb/host-libusb.c | 20 ++++++++++++++++++++
 hw/usb/redirect.c    | 20 ++++++++++++++++++++
 hw/usb/trace-events  |  1 +
 4 files changed, 43 insertions(+)

-- 
2.17.1


