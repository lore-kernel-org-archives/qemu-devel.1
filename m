Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF9FC3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 20:18:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 540AB206C1
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 20:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vfM8Wqxn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 540AB206C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzo7F-0000P7-3d
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 16:18:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45425)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tcminyard@gmail.com>) id 1hzo5g-0007bB-SP
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 16:17:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tcminyard@gmail.com>) id 1hzo5f-0003Dt-Qe
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 16:17:20 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:35630)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1hzo5f-0003CE-Kv
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 16:17:19 -0400
Received: by mail-ot1-x32e.google.com with SMTP id g17so2895643otl.2
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 13:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id;
 bh=hqXIr8HVI/CPn07kv36YhqCW795qD1dgMCPSMPwGDBc=;
 b=vfM8WqxnWVntHpgtd4hDRXxp5+8SZEh6D3tHOtrRp0oOHai5TlXmDtmvMlnkzxWf3S
 IGUh1bYOnBJFoZCVfRPrt5et4PRu5jOD+UdmXXbKlxdszligIoM+ergW/u6+0JZVgWEf
 lsF9k70ZYgU3pI5Ef2C2aF2dEOGAL34hnZ5HO0lFmX1BSHGVbkKdnoLAeT8MIXFD6fwQ
 EMEEpytRiLmKfNT1bvpNW5GRk19DcYcDtuOmw0R85jnCQvoOTR7Zz2hT64PXroOdoGM6
 riBBS7yUWGZ26flmk6qZyOVQwBfLfbZpRk+BAxPqDo2sRigAu3rV7pGd6//BHKqI23ww
 IyFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id;
 bh=hqXIr8HVI/CPn07kv36YhqCW795qD1dgMCPSMPwGDBc=;
 b=igGGgbdkePb9coTsCR7hAQgcCOsSeTTLW6Z3YrXOUGTwaREstUoZLBBiNb1ZiZ5EBY
 TPU/4GkgKh6kHb1kBs0CmuHcOOTihn8fMhrUpah6tTRCfLcJ0cXdRJGZg4Qwfwv0UQ0l
 dAlzpedV7LWBIBV3SZW3iE9fmz9qYr841tK3Jep1cjl05pMioOVGAaOL2QCaOETFeE0d
 qPfvBzdNN5CUF80nkMECugfOc84mBd81msvP91meKhHPKJ3y4AeSo7WTXZb5ul8Ueaq3
 qPOBCPWwmT/4TnBg4lyD+RVkXzvIbD+o2qd/hG3IpfIJWONxwJQT8Q1YOfzRpEzMOGGF
 5rZA==
X-Gm-Message-State: APjAAAUhscWJgxeDNoaQ81RdqLk0jTVsdLAbgH8nzT/dYDIrjOllf/95
 g7shhoeAkw6hzCYMtT/skSkdnmI=
X-Google-Smtp-Source: APXvYqwWufCLpYXVMz4ViOlBIOdkS0bSQqAbPMoWCyx0eC7J+KEB0uoZuOsp0jZbQmyrc1tzli+0Zg==
X-Received: by 2002:a05:6830:17d6:: with SMTP id
 p22mr2449628ota.67.1566245837425; 
 Mon, 19 Aug 2019 13:17:17 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
 by smtp.gmail.com with ESMTPSA id v5sm5805853otk.64.2019.08.19.13.17.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 13:17:16 -0700 (PDT)
Received: from t430.minyard.net (t430m.minyard.net [192.168.27.3])
 by serve.minyard.net (Postfix) with ESMTPA id 3AE7A1800D1
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 20:17:16 +0000 (UTC)
Received: by t430.minyard.net (Postfix, from userid 1000)
 id 72B9630232A; Mon, 19 Aug 2019 15:17:15 -0500 (CDT)
From: minyard@acm.org
To: QEMU Developers <qemu-devel@nongnu.org>
Date: Mon, 19 Aug 2019 15:16:50 -0500
Message-Id: <20190819201705.31633-1-minyard@acm.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32e
Subject: [Qemu-devel] [PATCH 00/15] IPMI updates for 4.3
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

These changes contain the following:

  * Fixes for the IPMI watchdog pretimeout handling..
  * Allow the IPMI UUID to be passed in, don't use the standard QEMU one.
  * Add PCI support for IPMI interfaces.  Not a lot of systems use this,
    but I use it often for testing, and maybe someone will need it.
  * Add an SMBus IPMI interface (SSIF).  This is becoming more used on ARM
    systems, and I use this for testing.  It requires some ACPI updates
    for getting the SSIF into the ACPI tables.



