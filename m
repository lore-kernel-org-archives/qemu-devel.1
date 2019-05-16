Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B14C04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 22:37:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15E7320848
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 22:37:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15E7320848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37745 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hROzv-0006tn-7C
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 18:37:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hROyN-0005qQ-QH
	for qemu-devel@nongnu.org; Thu, 16 May 2019 18:35:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hROyM-00020B-RZ
	for qemu-devel@nongnu.org; Thu, 16 May 2019 18:35:35 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:45753)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hROyM-0001w3-Ia
	for qemu-devel@nongnu.org; Thu, 16 May 2019 18:35:34 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1MsYzF-1gYU2K23Fj-00u3oG; Fri, 17 May 2019 00:35:31 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Fri, 17 May 2019 00:35:13 +0200
Message-Id: <20190516223519.7520-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:PRLeMkW5Hbu9MwlN/6IEh2hrpI+8eMTU8Psp+b7DkRxqxwROrpm
	c41Jh9oMVZ6DmqMuHOaHG7SAm2HLI9tNIUX/FcXVPGYSbXAnKsajAUfRkcbHthIoIQ+c8XI
	9QEInZ2QegAeAV44TV7HSAJ1yg+EO5plKMAbUm/uLe2LTKbOpx8moPojyw4PtFVsZLYmvwA
	xpS2deA7XRBrvQoIS5cTA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KXdLQGmtStM=:w/XdaTnmexKrBWBp352dS7
	GvhqUO0zJILZOVEWm0BTtgIw/saK28iD7R7uBaxn0CUj5U++CFNseXDQFU5R0SpJmgQw5ArOy
	4pBAmftxZdzGKYCRnyzrHC35ggftm4GGLC5a9oOEYhyzCpbfInNTYvmmTMEO4cA6RHuHCb/Np
	sjMOk3x5u2c+Lwb4CHJgkoQGFJFBg29CLuy2jJ0rJ/jM23L9MiK/NQwtswNQCHmxBA9+EPBpc
	ZBykJEH6ZHDSvnzUyfQR0Z8FIM+ftPNLd1R55dNcwqbu2nym3yUMitBUGiamRJlsFbUICysdh
	Wy0zdNrb0fItETM6Dxuc2KstMhQ2vFvO/ay0YhzFcC8XQo9RXbh3G6kjJfyEUlq2Lyk/DcN+V
	grLmxJZ3B3GqiA7fRVmQLtWQmahgvSvp+LeDumOTgbpkhUsmae+9O/EbtkFCQUwYArZWmsLtE
	ldSiS3voFzgzPKqjCf1SOvbX311/P0SD4XAVxB8yr7DdmnSiXHIbpKIapZW7GADGr5pzMHV1W
	WIi5LsE7jxt6EYbkVTbxOIdJT9rDO5MGhF323w8qSlBt4JbvLVMOuco1WdkyzSqm39443bxvm
	VAasb2/vooAbamYtBwRJAt2QcZ6dv1zyQSxWp+5AyradI5iYE1fH8ktC9+ZI/lEhqbW63PrcQ
	uArqAhWg/NZKWAo5FsUCdNJV3lG2RyHTs+eSElDUZuhWYGqqQ94gaMW3wRC++B4ZFvZcusZr1
	aE5RhFm87MnGdEWZrW5+XuyiDQWsVDYF3DravCk8muy1UyTAVP06FrB6vKs=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
Subject: [Qemu-devel] [PULL 0/6] M68k staging patches
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
Cc: Thomas Huth <huth@tuxfamily.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit c1497fba36465d0259d4d04f2bf09ea59ed42680:

  Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-20190514b' into staging (2019-05-16 10:24:08 +0100)

are available in the Git repository at:

  git://github.com/vivier/qemu-m68k.git tags/m68k-staging-pull-request

for you to fetch changes up to 60d3d0cfeb1658d2827d6a4f0df27252bb36baba:

  target/m68k: Optimize rotate_x() using extract_i32() (2019-05-17 00:30:47 +0200)

----------------------------------------------------------------
code cleanup, switch to transaction_failed hook

----------------------------------------------------------------

Peter Maydell (3):
  target/m68k: In dump_address_map() check for memory access failures
  target/m68k: In get_physical_address() check for memory access
    failures
  target/m68k: Switch to transaction_failed hook

Philippe Mathieu-Daudé (3):
  target/m68k: Reduce the l1 TCGLabel scope
  target/m68k: Fix a tcg_temp leak
  target/m68k: Optimize rotate_x() using extract_i32()

 target/m68k/cpu.c       |  2 +-
 target/m68k/cpu.h       |  7 ++--
 target/m68k/helper.c    | 84 ++++++++++++++++++++++++++++++++---------
 target/m68k/op_helper.c | 20 ++++------
 target/m68k/translate.c |  9 ++---
 5 files changed, 84 insertions(+), 38 deletions(-)

-- 
2.20.1


