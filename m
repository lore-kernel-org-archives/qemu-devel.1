Return-Path: <SRS0=GetT=XK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B26DC4CEC7
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 21:41:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BBB920692
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 21:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HN3fOc79"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BBB920692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9cGv-0005H8-97
	for qemu-devel@archiver.kernel.org; Sun, 15 Sep 2019 17:41:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53256)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i9cF0-0003ui-If
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 17:39:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i9cEz-00027f-7w
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 17:39:30 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42069)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i9cEy-00027G-W2
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 17:39:29 -0400
Received: by mail-wr1-x441.google.com with SMTP id q14so36839314wrm.9
 for <qemu-devel@nongnu.org>; Sun, 15 Sep 2019 14:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=E1zda2hSlOvLM2ahO/QAzusOrTa1pHUM7urJSazM5GQ=;
 b=HN3fOc79X/1lJL3gRSdUfrLHDEpmS/QtVPsBMvFos/kK1q3QDoEsciMZvNtCNg191f
 8k5lpi2+zKgdmx/SD9I82g3+VBV8FGBibMbX7lzN8hqUZvcXa59E3/PT90tFAy2vME61
 flVzX24kZdc/v0quudhaWrI/afxLw/ANicY6BYf5a+fla+5Qz6/7sXV/97TgrHbuG9yG
 mzdAukR5A7tENVnXSMdakBAcx4L47sfA0nKEEUmgu/YGmyrfAe/mSyjPUE77obPScPNE
 KZkVq5vOjfQJcoGK0j8oXDtuHCKF7BSAnbf1j+nHO3rgqUjxY6murDPhUaDxraTJWbzK
 ggrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=E1zda2hSlOvLM2ahO/QAzusOrTa1pHUM7urJSazM5GQ=;
 b=W93RG0TVQcB/jAjkmFRxdk7yo52LrrPJQmBnctOqRIrKo3B1ym1J9waQpammemcboc
 fAYTxFv1xrUAQpLd7BGYD20czn8JyimGM+HcPioU24wRp9mFvBAZez8hyrXO/daP8g9a
 NGFTmfbPJ5PmuWw9klGg8hQ4Ia2gKwxICEsm2asvI7jO5k9vCUy4CbGi6NowkpN+8c0l
 cdV8x1u2c7okGBULDke88M2HWdwDSMOcbQzroXWt/UHsFKQgFir2rgEad0zxdTBJDwvP
 /POVgO82+YxEgdHdOg92FmLd/6R8IEIXCh50BS7eSvka9YcewYySABHfHwsrMT4PnRIw
 mgGg==
X-Gm-Message-State: APjAAAUX07m7Mv5P7bSJnrh/xIzMzFPq82oCHCy8ail5FT384TQPjtOz
 F1Gm2S8d0UVdv02UYrRlcr3j2MCl
X-Google-Smtp-Source: APXvYqxmfnNOZp4Sn/t3u+7XfGoprjK1rX/veyHUrt2sQOP9N4D7YLw//V4EEWHcMG/AOXcf+9Q11A==
X-Received: by 2002:a5d:66c5:: with SMTP id k5mr19898019wrw.304.1568583566764; 
 Sun, 15 Sep 2019 14:39:26 -0700 (PDT)
Received: from localhost.localdomain (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id z1sm68738999wre.40.2019.09.15.14.39.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Sep 2019 14:39:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Date: Sun, 15 Sep 2019 23:39:15 +0200
Message-Id: <20190915213924.22223-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH v7 0/9] linux-user: strace improvements
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Laurent,

Few patches I'v been writting while trying to figure out this issue:
http://lists.nongnu.org/archive/html/qemu-arm/2018-01/msg00514.html

As usual with linux-user files, this series will trigger some checkpatch
benign warnings.

Regards,

Phil.

Since v6:
- Use ABI types in sockaddr

Since v5:
- dropped 'Verify recvfrom(addr)' since failing LTP testsuite (see [1])
- also define print_sockfd() for bind() (patches #6 and #7)

Since v4:
- rebased on master (no change)

Since v3:
- addressed Laurent comments
- added print_sockfd()
- removed the print_sockaddr_ptr() patch, also the two
  getsockname()/recvfrom() patches for after 3.0.

Since v2:
- display invalid pointer in print_timeval() and print_timezone()
- do not display gettimeofday() arguments

Since v1:
- addressed Laurent comments
- added 'last' argument to print_sockaddr()
- reordered series, so patches already correct can get applied directly
- dropped "linux-user/syscall: simplify recvfrom()" for now

v1: http://lists.nongnu.org/archive/html/qemu-devel/2018-01/msg05855.html
v2: http://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg08216.html
v3: http://lists.nongnu.org/archive/html/qemu-devel/2018-07/msg00411.html
v5: https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg02067.html
v6: https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg01346.html
[1] https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg02807.html

Philippe Mathieu-Daudé (9):
  linux-user/strace: Display invalid pointer in print_timeval()
  linux-user/strace: Add print_timezone()
  linux-user/strace: Improve settimeofday()
  linux-user/syscall: Introduce target_sockaddr_nl
  linux-user/strace: Dump AF_NETLINK sockaddr content
  linux-user/strace: Add print_sockfd()
  linux-user/strace: Improve bind() output
  linux-user/strace: Let print_sockaddr() have a 'last' argument
  linux-user/syscall: Align target_sockaddr fields using ABI types

 linux-user/strace.c       | 120 +++++++++++++++++++++++++++++++++-----
 linux-user/strace.list    |   4 +-
 linux-user/syscall.c      |   6 +-
 linux-user/syscall_defs.h |  41 +++++++------
 4 files changed, 137 insertions(+), 34 deletions(-)

-- 
2.20.1


