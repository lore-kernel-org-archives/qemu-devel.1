Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0C9C5517A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 16:32:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AE5821655
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 16:32:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AE5821655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXRtc-0008Hv-Vo
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 12:32:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50450)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kXRrc-0006jp-MP; Tue, 27 Oct 2020 12:30:24 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:38277)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kXRra-0001TJ-HC; Tue, 27 Oct 2020 12:30:24 -0400
Received: from localhost.localdomain ([82.252.139.38]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MQdMG-1kmFSB1hFG-00Ni8H; Tue, 27 Oct 2020 17:30:17 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 0/8] Trivial branch for 5.2 patches
Date: Tue, 27 Oct 2020 17:30:06 +0100
Message-Id: <20201027163014.247336-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1XQhp5ibv2NQ8j76mM9vIEb9P3mElSbznEj4aRuf2qPbEDTU+oM
 oOtEDe9EPv1KkCyy6+pEwZBJe1VBA1W5ZxTJylEehePFktfWhbdKPFIcf7al0wuBmzG7f2w
 Inx4arPwp3DDv9IuiL9ZjMzD1vL37gAK9pTw1Ul1QtRSvpHk9GR5dzFg23LF+d27YV6LtlS
 /sDf600osqxPEtIUdvUjg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EfQNSVaynJQ=:ocXRD+v0xjHGz8df9dFWIU
 gdAc8dC0/dJkJ/PRsliGP/KMiRGo8QYwyS1iXZuDgA89r3xTPNy+jgezsRX2lI4FsTE4nTHLv
 OEkNr1KBHKlX4pfTYzNPBgrkvQwcAStK+rabNri+er7+hlrnWhy4K7H5bUYypf4SAirXlYBLt
 bpPuRvDgLEFDam2OCcYwkuSbXqCeGxoYVxsIuFajthFS3QcltOCEXeKTzrjiSr+APvgVmCqmz
 g8FQOu1tY6jfzrh2Ic0TnyjvcIAIIOH4rDWOwrqYER72AKD5NhUlRuTPwFyyt8abXhfT8ckyw
 86kNloHwTip7WJi1X7H11ODrj+G9hYL6gVP803zW323E3JtplN9dSvcSL5Md0VxDAkr3+UDks
 x4PTTONRFh3RIEjR4/ng5tuDWPIkHNNjHt44IsniL9wqMAnneJRSfaFbTZQO7XxG4HO76ma6m
 BU7p5LXvuQ==
Received-SPF: none client-ip=212.227.17.24; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 12:30:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 4c5b97bfd0dd54dc27717ae8d1cd10e14eef1430=
:=0D
=0D
  Merge remote-tracking branch 'remotes/kraxel/tags/modules-20201022-pull-r=
eq=3D=0D
uest' into staging (2020-10-22 12:33:21 +0100)=0D
=0D
are available in the Git repository at:=0D
=0D
  git://github.com/vivier/qemu.git tags/trivial-branch-for-5.2-pull-request=
=0D
=0D
for you to fetch changes up to e83029fa605d6aa475be60b191f2af3954591093:=0D
=0D
  CHANGELOG: remove disused file (2020-10-27 16:48:50 +0100)=0D
=0D
----------------------------------------------------------------=0D
Pull request trivial branch 20201027=0D
=0D
----------------------------------------------------------------=0D
=0D
AlexChen (1):=0D
  elf2dmp: Fix memory leak on main() error paths=0D
=0D
Chetan Pant (2):=0D
  io: Fix Lesser GPL version number=0D
  cryptodev: Fix Lesser GPL version number=0D
=0D
Greg Kurz (2):=0D
  Makefile: Add *.[ch].inc files to cscope/ctags/TAGS=0D
  cpus: Drop declaration of cpu_remove()=0D
=0D
John Snow (2):=0D
  scripts/qmp: delete 'qmp' script=0D
  CHANGELOG: remove disused file=0D
=0D
Maxim Levitsky (1):=0D
  qdev: Fix two typos=0D
=0D
 Changelog                             | 580 --------------------------=0D
 Makefile                              |   2 +-=0D
 README.rst                            |   8 +=0D
 backends/cryptodev-builtin.c          |   2 +-=0D
 backends/cryptodev-vhost-user.c       |   2 +-=0D
 backends/cryptodev-vhost.c            |   2 +-=0D
 backends/cryptodev.c                  |   2 +-=0D
 contrib/elf2dmp/main.c                |   4 +-=0D
 include/hw/core/cpu.h                 |   8 -=0D
 include/hw/qdev-core.h                |   4 +-=0D
 include/io/channel-buffer.h           |   2 +-=0D
 include/io/channel-command.h          |   2 +-=0D
 include/io/channel-file.h             |   2 +-=0D
 include/io/channel-socket.h           |   2 +-=0D
 include/io/channel-tls.h              |   2 +-=0D
 include/io/channel-util.h             |   2 +-=0D
 include/io/channel-watch.h            |   2 +-=0D
 include/io/channel-websock.h          |   2 +-=0D
 include/io/channel.h                  |   2 +-=0D
 include/io/dns-resolver.h             |   2 +-=0D
 include/io/task.h                     |   2 +-=0D
 include/sysemu/cryptodev-vhost-user.h |   2 +-=0D
 include/sysemu/cryptodev-vhost.h      |   2 +-=0D
 include/sysemu/cryptodev.h            |   2 +-=0D
 io/channel-buffer.c                   |   2 +-=0D
 io/channel-command.c                  |   2 +-=0D
 io/channel-file.c                     |   2 +-=0D
 io/channel-socket.c                   |   2 +-=0D
 io/channel-tls.c                      |   2 +-=0D
 io/channel-util.c                     |   2 +-=0D
 io/channel-watch.c                    |   2 +-=0D
 io/channel-websock.c                  |   2 +-=0D
 io/channel.c                          |   2 +-=0D
 io/dns-resolver.c                     |   2 +-=0D
 io/task.c                             |   2 +-=0D
 scripts/qmp/qmp                       | 131 +-----=0D
 tests/test-io-channel-buffer.c        |   2 +-=0D
 tests/test-io-channel-command.c       |   2 +-=0D
 tests/test-io-channel-file.c          |   2 +-=0D
 tests/test-io-channel-socket.c        |   2 +-=0D
 tests/test-io-task.c                  |   2 +-=0D
 41 files changed, 54 insertions(+), 751 deletions(-)=0D
 delete mode 100644 Changelog=0D
=0D
--=3D20=0D
2.26.2=0D
=0D

