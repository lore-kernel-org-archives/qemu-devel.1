Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C65C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 15:28:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E12AE218A0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 15:28:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E12AE218A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hihBc-0002vv-42
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 11:28:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39931)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hih8W-00008B-HW
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 11:25:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hih8U-0007U5-IZ
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 11:25:32 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:52003)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1hih8L-0007MJ-2k; Wed, 03 Jul 2019 11:25:22 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MsZeX-1iXu6g0mnj-00u1lA; Wed, 03 Jul 2019 17:25:17 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Wed,  3 Jul 2019 17:25:11 +0200
Message-Id: <20190703152513.29166-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:gND+3XxiSssqpgSROM9KhdPJJtssIGci3B5o7MLOWAawL6WRIC2
 vTzxATdxPZFSj8jcSJO8u6jsSD1t0SjHREqiFgLxM6EjB8IbzJgoAIRbSEoIPF7/FE8xReb
 6uNTJ6ypGOO7Qt9O4Kor6LCdLCKRnLrSqR1ywtjGQEJqXuPlE9I9coYlphZhReqnVV/NH3z
 zlCw9IEPxDrgnmCfQwGmg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5crU/5KEY9w=:TaftfNzQVpFbNdrn0nFxAC
 5PwmyasuWn1lKXvreTyC4/OMGqbigug49ab7OdMVe2iHSwPc3q8xNpQvvc3CwwAZVE7xYM5D1
 Jq+XYpCAfy7lNvu7TqdedUfdv7YwBsIjWf/4f6ag+ZbCc4x3Y3MaxME71SbS8g8w8I/LwwefF
 9yYZaV+6JEVsWljgwIxteLuw1gG4JXjkQWSDnta4yW3qr3IM6SpDjWR33ZHvpqOY+KD2fOqYi
 /OetzrDuTQnd8jldUmhiovbkiddxFoWc4bHBqIPeVpim4t5NI662nLrXpFGK2KNRki3RBAz1f
 Kt2mLaV7hmIVKcU6VnJWPTMKq6eDnf19JVXf3dEdPNmqYplx7P70ELmtQ97aGroAa8bsJpkVc
 trmx5dDJcQwIECzi3p6zegdJMc+oFZ4GnVxDf0dJUi8USBYGvJiAzp6lAt9XaLU/A8mILNkbi
 Clzpo2GqNKhebgwPohHCNkNQ8aiiSCvR40a937Gzx8lkcQPjwcVeYIp+EWApyOlzThiPmkoTH
 ZgRyNk+mjXuFmwf5KXX7vSLn2atDShITy7WwMqGCJqexJR6k/Cikc5EWgqLeCYE+SKQfieLqU
 aLP5z2buGBbUbSXwF96rgP61kjstEDQxP1ut/Y4BbQ+CJBBPjc1LCHaYXvRBAMIQjO+rc+V5q
 rjCYF8v3VzosFiychcR0rL6JlpADWSZY7dBvA/9wiTK1S1BL6H7NXByyV1jX8M5h6/NfCKTgV
 UbfigYVeyKy77kxtWuPJvqptR7uE+fUBunvKdUcOFwKPGNGQIgv0Hep/mls=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.10
Subject: [Qemu-devel] [PULL v2 0/2] Trivial branch patches
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
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>, Amit Shah <amit@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 7d0e02405fc02a181319b1ab8681d2f72246b7c6:

  Merge remote-tracking branch 'remotes/vivier2/tags/trivial-patches-pull-request' into staging (2019-07-01 17:40:32 +0100)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/trivial-branch-pull-request

for you to fetch changes up to 2cd925dac80d708d01f124b26de52fb447a333aa:

  docs/devel/testing: Fix typo in dockerfile path (2019-07-03 17:23:39 +0200)

----------------------------------------------------------------
Fix typo, change virtio-rng default to urandom

----------------------------------------------------------------

Kashyap Chamarthy (1):
  VirtIO-RNG: Update default entropy source to `/dev/urandom`

Liam Merwick (1):
  docs/devel/testing: Fix typo in dockerfile path

 backends/rng-random.c  | 2 +-
 docs/devel/testing.rst | 2 +-
 qemu-options.hx        | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.21.0


