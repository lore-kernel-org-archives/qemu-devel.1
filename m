Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0335FC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 17:14:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC50F22314
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 17:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAr3UpbH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC50F22314
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itacj-0004T6-LK
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 12:14:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36350)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tcminyard@gmail.com>) id 1itaWV-0005qr-Ew
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 12:07:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tcminyard@gmail.com>) id 1itaWU-0001h2-GV
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 12:07:35 -0500
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c]:41605)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1itaWU-0001gI-BA
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 12:07:34 -0500
Received: by mail-oi1-x22c.google.com with SMTP id i1so29068999oie.8
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 09:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id;
 bh=33xaIkQ1O/osMK/i7HxJLrauilgFEHwYgOxz2A8g9TQ=;
 b=YAr3UpbHSNM3l+nU2Xc7gwK0HSwyb9775R5y7tRtOPKD/pNlfyl3xASBEPwEcmcBwR
 DMFwMgGafTFlHYIXFwsaMMaLJDHJFNVR5KXdRAKIagL8xLR7j7mBcQyGNO0r7Wcj2eFs
 znKCioBwVEBJtalaSALOyAstNjylkc4sc/jbC/qj29QXsObg5EPhfCItJELcueM9fd+0
 TkUEYOtIMCypJDh0AEWmEPnRYXkGueL3QDzg5jUlHnNT/wG4Dun5UyYjXWcaH8GNQiG+
 7kPVTYno89VPlPAzPFwu+mX7Te3BbXi4kOk5VmfNF0eifurJ+6+HK4wFTV3606R+nAsY
 r46g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id;
 bh=33xaIkQ1O/osMK/i7HxJLrauilgFEHwYgOxz2A8g9TQ=;
 b=maqkaDVL8EQ+PXEBWdaM0ZxjTLNXV8F51dfBYfmSPg+RQgFLrJQl+g4KRPoWWprGtU
 X9cG9OKBNK3X0//MVExc9pDyCu9ktDJHVn4IStL7nAGh8lGZ2r0GuXsUqW0Cw7fkODC6
 SZ5GGG3txiajHHyebcL1pd2xgy+DeojfKX0IqjdKQhGjFT8Dfno041sN4Q88aH2nQYdQ
 4sn7a1BkVr5B0Ft9SMTev8HC6WOFAwyNur+gZy7PS1JvptHKPkHyeMAkDiEwD2wtTFgH
 WbxYl5eGJy9fnGlgyNVoLlkgFZ9hYQTwu2B3SwxZFPfA/heLxOhJnw9rySD2DkhCeOo/
 B6bQ==
X-Gm-Message-State: APjAAAXPNsyWxz8M33EtLDzJ5G/DPE+ZyXjLtly8IDf/4cyWfxq/BbpC
 Mz+MiMPGNHEzOWIrAK1pzowwA4M=
X-Google-Smtp-Source: APXvYqzPaxo9/qduKALdkNz0sXkSlh5Wg+NlaRHdfY9Kq55Z5PnbNJw+dTA1Y96wZ5FZyxN7yzT1zA==
X-Received: by 2002:aca:1a10:: with SMTP id a16mr210553oia.9.1579540052181;
 Mon, 20 Jan 2020 09:07:32 -0800 (PST)
Received: from serve.minyard.net ([47.184.136.59])
 by smtp.gmail.com with ESMTPSA id z17sm11070052oib.3.2020.01.20.09.07.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 09:07:31 -0800 (PST)
Received: from t560.minyard.net (unknown
 [IPv6:2001:470:b8f6:1b:9c9c:d583:ce3d:f87a])
 by serve.minyard.net (Postfix) with ESMTPA id 44003180050
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 17:07:31 +0000 (UTC)
From: minyard@acm.org
To: QEMU Developers <qemu-devel@nongnu.org>
Subject: [PATCH 0/5] IPMI patch queue
Date: Mon, 20 Jan 2020 11:07:20 -0600
Message-Id: <20200120170725.24935-1-minyard@acm.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22c
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

Sending this out for review, nothing big, but these would be good for
the next release.

-corey



