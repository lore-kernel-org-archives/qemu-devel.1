Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097ACC2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:40:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD90F2074D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZJQxy2q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD90F2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOOcL-0006Ni-QQ
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 12:40:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53498)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <devtoe82@gmail.com>) id 1jOOUz-0001Ne-Nz
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:33:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <devtoe82@gmail.com>) id 1jOOUy-00021b-Qk
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:33:21 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336]:42016)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <devtoe82@gmail.com>) id 1jOMfU-0000tD-Jr
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 10:36:04 -0400
Received: by mail-ot1-x336.google.com with SMTP id l21so7398094otd.9
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 07:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=0UKzmnzb24l9+mhQPAfis3S8cu/WolgMuV5WqdYEOGA=;
 b=UZJQxy2q0zNO8EC6IjCll1cEoGKfoA5X0Va1ynOw5034I7cxqkb7F+BJ62ArX+OvrE
 bVbJbpD9rbyYg9ydXPw2TwGTmRJjv0tiFeiBCMkCD5FyQ3/S/Q46xfcnQTXetorlHUJ6
 g2CS4GY6pZP2nwl+BouOOqdyLlTFCcVREaMi5Ai2OJLdpjPiZiptyC1C+cjw2WwDyLCC
 tDhROTB0jWWtPLcmquBWX6S5KytWeBJV+sjBIBJHWu3QR1A3ZaTbMRMwku8DievCRJLh
 sOeh0s/5fReKz3S1r2GvcgLj7gBEdPrKcnK9Cr5B8EHWEZC91xlRWqZHBPfpTYg4Xp6V
 SsVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=0UKzmnzb24l9+mhQPAfis3S8cu/WolgMuV5WqdYEOGA=;
 b=b8aznwt156khY/nFG4IlnMhFvvgAh/opvT1DDIGrSObXalozpfK7sIxfswfnSnGZXv
 3LtZo14f+N+2d0JeTh1AEyc1SnjBtCOwwPI8xVQn6o/uGnrZ5y+euo4sxhKzcYk+UTPN
 eOYY081zQhhlFldgiFQrKKaMNXq/HNtCgfrAE31tWi261g25eAxmdcNeCAUAvEBUkcpx
 lKzJym1TLb374xE4Bu2rJjPsAYZEPLhWhJtJ+lR23c+NIyvfUByR5n9ZcWypMhPz9BJY
 X6hrw6S3VDGsZ5vR6AnqwLLKwL31DpDvms1BcnNm61JObe+9/EXlfD6P/N/AXtXBVXbW
 nB6A==
X-Gm-Message-State: AGi0Pubc19TGXnYgvFyrIO29Gawr91U1Gu+A7Iov4ub7sjyHryQ0tEY9
 k4uhELUQ4quZ1FU0sK9L8T3/A5vRPrtLnuKHu/LoCn3P
X-Google-Smtp-Source: APiQypInEQimLjb3vS4XBC8tYEgRAVkdunJbMnutNPncbDSPP+0YRoKgx7/6TklzqvykrxjsHtEzH4HzYU3uQXWsS7g=
X-Received: by 2002:a9d:3a04:: with SMTP id j4mr12111540otc.217.1586874962943; 
 Tue, 14 Apr 2020 07:36:02 -0700 (PDT)
MIME-Version: 1.0
From: Toe Dev <devtoe82@gmail.com>
Date: Tue, 14 Apr 2020 17:35:50 +0300
Message-ID: <CAN+O=T+bk=hXjPF67R=YHKebcuMP2dGzT_qXPWMUp=RvWOPxOw@mail.gmail.com>
Subject: cscope redundant chars
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::336
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

add cscope phony(ctags have one) and remove redundancy

diff --git a/Makefile b/Makefile
index 84ef881600..9cf62532f9 100644
--- a/Makefile
+++ b/Makefile
@@ -1005,16 +1005,18 @@ ctags:
        rm -f tags
        find "$(SRC_PATH)" -name '*.[hc]' -exec ctags --append {} +

+.PHONY: cscope
+
+cscope:
+       rm -f cscope.*
+       find $(SRC_PATH) -name "*.[chsS]" -print | sed 's,^\./,,' >
"$(SRC_PATH)/cscope.files"
+       cscope -b -q -k cscope.files
+
 .PHONY: TAGS
 TAGS:
        rm -f TAGS
        find "$(SRC_PATH)" -name '*.[hc]' -exec etags --append {} +

-cscope:
-       rm -f "$(SRC_PATH)"/cscope.*
-       find "$(SRC_PATH)/" -name "*.[chsS]" -print | sed 's,^\./,,' >
"$(SRC_PATH)/cscope.files"
-       cscope -b -i"$(SRC_PATH)/cscope.files"
-

