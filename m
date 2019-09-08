Return-Path: <SRS0=PtAT=XD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6F4C433EF
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2019 06:19:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86D31214DB
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2019 06:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIOIp1mR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86D31214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6qY3-0007Md-MS
	for qemu-devel@archiver.kernel.org; Sun, 08 Sep 2019 02:19:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41773)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i6qUH-0002mS-0n
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 02:15:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i6qUF-0002Oq-Ma
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 02:15:48 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45293)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i6qUF-0002OR-AZ
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 02:15:47 -0400
Received: by mail-wr1-x443.google.com with SMTP id l16so10356406wrv.12
 for <qemu-devel@nongnu.org>; Sat, 07 Sep 2019 23:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=eWXWkg3EvXYUxOonSyJWRsvHKIjYDZYYfDquolDEb3M=;
 b=bIOIp1mRGXtAS6aft80fWANxuw0g+f/u5sn+f4gzEcHOjip0kL6joImgFEE/CTVSGI
 jU+sSry1TtKD0C6lD+IQ3EBAO/oyj/i1UFFS3FUvTGqDMzXhhDYDZlhkEDZ8ucnCGXs9
 Jj9Aui65L1zQ0+k5zzjgzF7Dzicc1Tn6t1d4WSw/MGASU2pIkqy7z3V60Aa4k/AkIFL3
 xnY16/49gU/1I+zUEIXYPE7+sqRRnDUuJjec/lqvMX2XAQFh6BiLAG67MISwEOe2m00F
 tkeqRaKqHmjMifrC2KyjwrQ/+B84fI9KC4vQId2mrAGLgvimbyVcMbgvd+fkg+nfSZoi
 8D4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=eWXWkg3EvXYUxOonSyJWRsvHKIjYDZYYfDquolDEb3M=;
 b=AvHk4YjwAfvpsLQfyA5XiOoNcX2NqvgXYDtA/Z8TihJzsfl6JBnmmy3mETDSAVfVTq
 wQi25k2NAjzFYSUiVXO82qgcj8kO2B7/CKcHCKw2CdJ+K0uiXwNywDvgv9VL798aYuNb
 oFPuUlKjc8305Xz3ayxInS7sLQYC4Sasu2r6TRqxaVpX1phdxfYfxc27IrHWfLjCX5+I
 +WR7p5ZhzbxsReuUbZzirG7OZ7Sosw9czkHd3NUusJ7oAnjCsC2AouzbBRPRnfg1PYMH
 zwhQEtspWUIit7X6x/oT417i24jmXabMOOQX/jhqjZljLqH+iGvPRybxZONBpiatxaJD
 5z1Q==
X-Gm-Message-State: APjAAAXOhQBUC/eFhobI3jIHZTIqPOmXIwSrCh9GdXIZ8+ZOWR7fSj44
 gUMTPvrCrVSW+7Z429kpA7qha4xK
X-Google-Smtp-Source: APXvYqwux68RLUnfx5yvA93OG2joTsAXvPIKncRfQlxe0Lf4YaF1dImoD5ISgekSUVRjb57O3GoLlg==
X-Received: by 2002:a5d:4c41:: with SMTP id n1mr1669772wrt.4.1567923345696;
 Sat, 07 Sep 2019 23:15:45 -0700 (PDT)
Received: from localhost.localdomain
 (251.red-88-10-102.dynamicip.rima-tde.net. [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id g201sm15616552wmg.34.2019.09.07.23.15.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Sep 2019 23:15:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Date: Sun,  8 Sep 2019 08:15:35 +0200
Message-Id: <20190908061543.25136-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH v6 0/8] linux-user: strace improvements
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
Cc: =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
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
[1] https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg02807.html

Philippe Mathieu-Daudé (8):
  linux-user/strace: Display invalid pointer in print_timeval()
  linux-user/strace: Add print_timezone()
  linux-user/strace: Improve settimeofday()
  linux-user/syscall: Introduce target_sockaddr_nl
  linux-user/strace: Dump AF_NETLINK sockaddr content
  linux-user/strace: Add print_sockfd()
  linux-user/strace: Improve bind() output
  linux-user/strace: Let print_sockaddr() have a 'last' argument

 linux-user/strace.c       | 121 ++++++++++++++++++++++++++++++++++----
 linux-user/strace.list    |   4 +-
 linux-user/syscall.c      |   6 +-
 linux-user/syscall_defs.h |   7 +++
 4 files changed, 121 insertions(+), 17 deletions(-)

-- 
2.20.1


