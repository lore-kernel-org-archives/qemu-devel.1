Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9D9C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 13:03:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42AB8206D7
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 13:03:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42AB8206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihYyw-0004Bk-JV
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 08:03:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51923)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1ihYx1-0001qQ-0m
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 08:01:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1ihYwz-0007bj-N9
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 08:01:14 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:43969)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1ihYwz-0007RE-CV; Wed, 18 Dec 2019 08:01:13 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MVe1U-1iIIsB22tQ-00RXmI; Wed, 18 Dec 2019 14:01:07 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 0/7] Trivial branch patches
Date: Wed, 18 Dec 2019 14:00:58 +0100
Message-Id: <20191218130105.125981-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:B8ZplYw8Glwj/6TNTnw3i/jgYCZxpqTday4Nxs0wogksvukWWMY
 55PWF6TQMB+b+NphNvRtrnYVLpVevgFGnhdjS0YoYTuqIekxUyBTBxUnEqxSaor8O/9uVn1
 pKkZsqj3jDorgb2iRTs0p3jpOfp4ApdvLsV6FRTO47CKKe8u74Mm6wPb+KBGmhE/92gZ3Qv
 M4NYAzhzpxBLu31WZ5hhA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OA/PsERFB7c=:tMyEkbshoBsP+4fcxRK/gm
 P/VdNt7Pi0emnb4sbmHUcjTn8sITNTTk8fuIe166ZRVvUZ0bMmr0n9oF4/fTm05Qp5+Xk8SNH
 dNKhcGN3D61VUnWl2Nwdm4kLSKGf/7LZS+zp09Fw6vpeaedGF4wUzsSRUxfh6SDdWxkwFUCDW
 PW6Lqv8Y6LjxuSOjd4rATzKOYD4pmQsEJ6z6QlwJP8v/J+xIpm3P6XaQAILqiZU97LTOw832Q
 5qt59DbSHk4ox/N9mKHMFEdFjDXbXEFUBfAk/JTTM+A78mOOZZazFAgBKy/Q7pLWQUaH8dx/+
 SHItFqABWeoVkmmEiDk0MjgQSdj4ZTMdSX9Kcgtm6fI0RNU1o4mGkgoV4zjHkzsILcU93I27R
 dcdvypagLNFzjj89x3ZNWDWisu5cE1rTOBvocoC8J8O51HAazfKbPdXBWfO/Mt1WhzYPiRdkG
 DAQDVDlwRMxepiXTWM/SWit29SsEPMeLc0si/4wtQBYfnW8AU8HQOr77UmYwa5e6Cv0vXniA7
 wqE3lnjaDaT2NxvdgMI2rPj0PgEvT5h6f7NKlxU/4fr76PtrTTXeYQOBubm3HvalKvpP/agLH
 5lkXupnzY6e8Xr/3jXnsOvgdEcbWuGUwonVq4SVXBFr9HzTppSCQwJKBQDyB2RFmfvn3GK48t
 Da65+0TvT6K2ALdtPs0Bt6aTqwzWMVVesjMZPhiZbNpNdaBDKowsrrP9Dc1dzPUf0kxJXB/8K
 4piPMd1ChPR3V08zwnfac/O42QRaNGcKIXxmTmESy/9HX9rAyGeFMXitdNW4bPn8F414BdON1
 32QtBvI4mQ4vTKUa5ng84Z9A0cyHaSM6ZlS12+DUaFSvrXgEdZ6CPIh1dCWWQVfHAWpWzpHyD
 gbdeA+2uJO1Ym5vUmENkdctNcVxqIQS+lvzzF8BE4=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.131
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
 Laurent Vivier <laurent@vivier.eu>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit aceeaa69d28e6f08a24395d0aa6915b687d0a681:

  Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2019-12-17' into staging (2019-12-17 15:55:20 +0000)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/trivial-branch-pull-request

for you to fetch changes up to 80bc935eaaf93e5b9a4efe97abd7c51d645f2612:

  qemu-doc: Remove the unused "Guest Agent" node (2019-12-18 13:31:01 +0100)

----------------------------------------------------------------
Trivial fixes (20191218)

----------------------------------------------------------------

Han Han (1):
  Revert "qemu-options.hx: Update for reboot-timeout parameter"

Markus Armbruster (2):
  util/cutils: Turn FIXME comment into QEMU_BUILD_BUG_ON()
  test-keyval: Tighten test of trailing crap after size

Philippe Mathieu-Daudé (1):
  MAINTAINERS: Add hw/sd/ssi-sd.c in the SD section

Thomas Huth (2):
  target/sparc: Remove old TODO file
  qemu-doc: Remove the unused "Guest Agent" node

Yury Kotov (1):
  monitor: Remove unused define

 MAINTAINERS         |  1 +
 monitor/misc.c      |  3 --
 qemu-doc.texi       |  1 -
 qemu-options.hx     |  4 +--
 target/sparc/TODO   | 88 ---------------------------------------------
 tests/test-keyval.c |  2 +-
 util/cutils.c       |  8 +++--
 7 files changed, 9 insertions(+), 98 deletions(-)
 delete mode 100644 target/sparc/TODO

-- 
2.24.1


