Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05467C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 00:23:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C26972085A
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 00:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="KvYwtfPw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C26972085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60232 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMLzF-0003oN-Tf
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 20:23:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <driver1998@foxmail.com>) id 1hMLyT-0003Tl-EO
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:22:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <driver1998@foxmail.com>) id 1hMLyS-0001WG-BO
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:22:49 -0400
Received: from smtpbgeu2.qq.com ([18.194.254.142]:50598)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <driver1998@foxmail.com>)
	id 1hMLyR-0001T0-Cr
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:22:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1556842958;
	bh=kEag8MSFTjWpjZW6lXg2p7kdbQn3vJMkbZKJa8bqjcY=;
	h=From:To:Subject:Date:Message-Id;
	b=KvYwtfPwbB1E4xQTPoBvJPfYTMo+3TsbUZmWwrbDoLnuPbye8UZEZlYBWmleXc8Pt
	vZAWFymFQXm4p6p3uNEYRWGH09WUDgP+iLLjcEBkGliocIG6Nrc2KesjceYJWVI5sG
	aMuHgiUJFjrF1GyhKSXoNDy95HjbYNyIzfUmk49s=
X-QQ-mid: esmtp4t1556842957t39jbvj43
Received: from localhost (unknown [183.63.119.3])
	by esmtp4.qq.com (ESMTP) with 
	id ; Fri, 03 May 2019 08:22:36 +0800 (CST)
X-QQ-SSF: B100000000000030F7F00F00000000O
X-QQ-FEAT: LukZvA942xDTCZzSbnhKTAybvETAuLYk1URApw0UdO9bdm95498f5YaMmHxnT
	N7sqhNMszD5gp9ewHZdWTipZtJrlVCLB5hgBxhLDP0koQrXBfhN9vGYpgEhUGqIbTBAztqv
	l08FwStsg/wyp5YSOOdzJs3uyEpzWrSrGVeffoQg5vzzBUYpMJO6ImVX2tmS9rDM46Dlyl+
	3knKzTCvpOCPbfgJ5bjjMMysBKGslglGP1vaKLLZ+UlztUqfML4/LqSuA5HCtzB9KKL4r9J
	4Olf0Eyg6c/7wgU2DJspRt/RaWFoumZlTTWA==
X-QQ-GoodBg: 0
From: Cao Jiaxi <driver1998@foxmail.com>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 08:22:06 +0800
Message-Id: <20190503002206.9751-1-driver1998@foxmail.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: esmtp:foxmail.com:bgforeign:bgforeign2
X-QQ-Bgrelay: 1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 18.194.254.142
Subject: [Qemu-devel] [PATCH v3 0/4] Initial Windows on ARM (AArch64 64-Bit)
 host support
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Cao Jiaxi <driver1998@foxmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190503002206.Y1ktg3QDPQamXV4IWnpbU5sQF6ENGmy3dgtR8F2smEc@z>

Initial Windows on ARM (AArch64 64-Bit) host support

This series of patches is for initial support of Windows 10 on ARM as a QEMU host.
Currently only TCG intepreter is working correctly, it crashes when TCG JIT is enabled.

For now we assume it is built using the clang aarch64-w64-mingw32 toolchain,
you can get a prebuilt toolchain at https://github.com/mstorsjo/llvm-mingw.

Cao Jiaxi (4):
  QEMU_PACKED: Remove gcc_struct attribute in Windows non x86 targets
  qga: Fix mingw compilation warnings on enum conversion
  util/cacheinfo: Use uint64_t on LLP64 model to satisfy Windows ARM64
  osdep: Fix mingw compilation regarding stdio formats

 contrib/libvhost-user/libvhost-user.h |  2 +-
 include/qemu/compiler.h               |  2 +-
 include/qemu/osdep.h                  | 10 +++++-----
 qga/commands-win32.c                  |  2 +-
 scripts/cocci-macro-file.h            |  7 ++++++-
 slirp/src/util.h                      |  2 +-
 util/cacheinfo.c                      |  2 +-
 7 files changed, 16 insertions(+), 11 deletions(-)

-- 
2.17.1




