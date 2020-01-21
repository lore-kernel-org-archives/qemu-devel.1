Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFB8C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 12:22:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7AD82073A
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 12:22:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7AD82073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itsYZ-0003UW-Ro
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 07:22:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50510)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1itsXV-0002H4-00
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:21:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1itsXP-0008JS-3J
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:21:46 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:36481)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1itsXO-0008Hu-Qx
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:21:43 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MKc0o-1jCUmm1YFg-00Kv5T; Tue, 21 Jan 2020 13:21:40 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 0/1] M68k for 5.0 patches
Date: Tue, 21 Jan 2020 13:21:37 +0100
Message-Id: <20200121122138.1708193-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:n65t07nb7eoErKvXWqekFgzmXK+6aHXhKQPIvMeRGmB8wB5x4xp
 jdrC4Nc9upX0V08GjyM+FPNdCcxfqUAvFAI7mSBRqMj5Q6rqSKCZT5gSDgVwyb5iIUbb+0D
 72osJhvAb2Dcepfg5C7w8lq7rBo+VH6MutW4sZk24yVCuvZ0VKVcDovbJ0KaJimXofy1ZjM
 Kz04iPzNTTMtpq7WyQzeQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tpJ/ZW37WDw=:oAzBpVPes2aknQegKhyWZc
 ON8tjWyGpG5IREBy9LZMmSeCx9QrSihS0Po+mVsHnvpGYCcg+heOx9q69OzMqQFjljNHxLG0o
 27Pr9WTu6a+3w0+ZF+YoRtY1fNlZR1flmeINDwoXdr41EaRnGBJQbPlWAAEydySeja/V0phbY
 B1XYYg0tSRD7yFEg30Q9Tp83JT4X0pkfmuj9bdaM61bfLYW02FyDeL6NUJXQbCdcDRuUoxlV5
 SfLbtccf8qXGgFdIhFBd6wLkgmdwAK7sdCnEP5Rg1n4HkGalEHiANaFsumhLOolDiWmWJbeyT
 UAPfhQOvWqtUOeRTVYDwAyerOUNibTWDJscrMLfBNY+MMoAARrqofb4Ov9hj8SYLbqk2R/9ue
 waZFRxhG57rBXa/WtSw9dFT+edslJA/laU/QWcSgMpSaYIci+GcAwNGgeNLop6iaI1AVZOInV
 zRrv2y79UCI3ZqZ+cBmqFjDfdvS6LEdCZXkINtCrMEaQvD6kEdTndE8qOOyR6cBhqYxPwtV3X
 hzE3m4HCkmznYTstMg12ocBY7+oYpCg4oiO2YnqmQBqqxkUkx4isL61XrroR2ReOlp0399d7Q
 qvIPjv8Y00bAaR8atFuhDffL49RRe1MEpyBGJkpQHiFLYrpZBoGAQS9OYO1F9wW8hGrwvufk7
 lbRzVjQVHHXoksC0LtsRGez2WU21DnNNV3EvA6JTmg/mlfIkbMC95ZRbrffPq1GCFdlYXJ0Zi
 WspVKSE33YE85XV3DaxGfmlaglUFghUvfpGDCcxusUVYUjPbQ2+V9fccMKVkVavtyu2JZxvD9
 YF+VCHYQfFNxveCXLjE25ZrtUdMRLQcNouVXjy1PuwgTxblCFeq959lrXf9WIUDMcx7F+gMAg
 gNEwJIvATBuC0L7xBrNA==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.13
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
Cc: Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit d83bbedab5a2758fbb7866c06472feb3f3bf079b:

  Makefile: add missing mkdir MANUAL_BUILDDIR (2020-01-21 11:56:17 +0000)

are available in the Git repository at:

  git://github.com/vivier/qemu-m68k.git tags/m68k-for-5.0-pull-request

for you to fetch changes up to 322f244aaa80a5208090d41481c1c09c6face66b:

  m68k: Fix regression causing Single-Step via GDB/RSP to not single step (2020-01-21 13:05:45 +0100)

----------------------------------------------------------------
Fix m68k single-stepping with remote gdb

----------------------------------------------------------------

Laurent Vivier (1):
  m68k: Fix regression causing Single-Step via GDB/RSP to not single
    step

 target/m68k/translate.c | 42 ++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 15 deletions(-)

-- 
2.24.1


