Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74376C433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 13:17:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EA53206A2
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 13:17:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EA53206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhYh8-0007cc-E3
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 09:17:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhYfc-00061k-3I
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 09:15:32 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:45545)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhYfa-0007Zx-Sa
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 09:15:31 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MSbp1-1jWOcz1wMr-00SxsR; Sat, 06 Jun 2020 15:15:20 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/19] Linux user for 5.1 patches
Date: Sat,  6 Jun 2020 15:14:58 +0200
Message-Id: <20200606131517.1250346-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:q+Me6wAcjXbXZ4kpqYocGt7zMJVEc9yh3jP4+DMWhVMcXwRXP5e
 P/HzWTDKkJt/oORhBXEEXV4um3P+3irBivX3CJ9M465pCBkjltaajOBvA8z+fbwNhIQgYXK
 VWVIiPIQ63i+EOTTAvOKW9zOc0RfC5q2plbRJcV7hJLVjV14MTvYphH0GO9SvElutnwZt3d
 gkzmtbPC/TV4xDZcemjTQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nNkOCqJNcho=:gjNHru2yLe9jmdW3MBEtbO
 DyTWF1ejGHR2P4TU12YYuaaPrj74eQl0tz9fE2NFlhPwVxTJbgE0KQ5RdNWqscxx/xf/oNmtk
 +nI9gAz155Upu3BCiMmI4LXdEpohxZwQK+xtTtUcfPG30UMq7ND2Evj29Yv9j0xm8Po0wHe7b
 KsfCry4F05NFUHgNcDiMqPy56H/8It7CSF4EZKecNO0jCl56Ju86nZ96Fxe9Bmx8Wdqqr8hHa
 Xl8FBUyq3+CxfHDzWIsxA7/vJKEV8TUtr6TDHD81uRLLhLp6vZsBRFQM2vl8yFKN9dauJxTmL
 wB2NC0Ea87cRBNB0hoHNyk3r/Q5YRvIG1FwwM35a7ZI/pS7EREGlgDV17dC/8QA2T3Qrauj0P
 fhnxZld1OqOsC8g165lfG51aYKEN3MN2iLKCgu0CKuDk/fxnKtLbux+Y9gzZprG1gHr9aiLtb
 VTpx9eRLors+61YECfp/PZmM6oFlD63gAXeGWd8PpVdGP+62Wo5puKwJWhw0YKAN9U//Bic86
 2udP0DRvP5BIJpKp1D81pbnpzUw6Zgd5+dDREiFxhDagl/BCF2eBUq65FGsJwXs7Wu+TiRgID
 ZrakiidImgk/bkUNVC6KgsFnpdkQrydHzT392ddemc+LYiJjtVSJD0FWwUz+sXScpaIQc9L/D
 IAWjoW7GUA7uQre7mDdM2iImG8p6gp+S5BTiOcs7b0A1NPlvOICunANs0ReRdDT7kgYwvxzyv
 Qj0xgnWQHPHgu6QtfhN8uF4/9R2rBi/rmPtdrFK1xTqReR/OLHO4CWpEYRDpptE3xb1wPqVjj
 35xGlMZUpB5K/orG9PH1rnN2uCG4ki6Xeur4jtqk4VN1aATLZcXWHzwBysEfl3YeKfnZFBc
Received-SPF: none client-ip=212.227.17.10; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/06 09:15:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit ddc760832fa8cf5e93b9d9e6e854a5114ac63510=
:=0D
=0D
  Merge remote-tracking branch 'remotes/gkurz/tags/9p-next-2020-05-26' into=
 s=3D=0D
taging (2020-05-26 14:05:53 +0100)=0D
=0D
are available in the Git repository at:=0D
=0D
  git://github.com/vivier/qemu.git tags/linux-user-for-5.1-pull-request=0D
=0D
for you to fetch changes up to 95722b27845b972250a7d4f93b693b01e2a0c3a1:=0D
=0D
  stubs: Restrict ui/win32-kbd-hook to system-mode (2020-06-05 21:23:22 +02=
00)=0D
=0D
----------------------------------------------------------------=0D
linux-user pull request 20200605-v2=0D
=0D
Implement F_OFD_ fcntl() command, /proc/cpuinfo for hppa=0D
Fix socket(), prnctl() error codes, underflow in target_mremap,=0D
    epoll_create() strace, oldumount for alpha=0D
User-mode build dependencies improvement=0D
=0D
----------------------------------------------------------------=0D
=0D
Andreas Schwab (1):=0D
  linux-user: implement OFD locks=0D
=0D
Helge Deller (2):=0D
  linux-user: return target error codes for socket() and prctl()=0D
  linux-user: Add support for /proc/cpuinfo on hppa platform=0D
=0D
Jonathan Marler (1):=0D
  linux-user/mmap.c: fix integer underflow in target_mremap=0D
=0D
Laurent Vivier (1):=0D
  linux-user, alpha: fix oldumount syscall=0D
=0D
Philippe Mathieu-Daud=3DC3=3DA9 (13):=0D
  Makefile: Only build virtiofsd if system-mode is enabled=0D
  configure: Avoid building TCG when not needed=0D
  tests/Makefile: Only display TCG-related tests when TCG is available=0D
  tests/Makefile: Restrict some softmmu-only tests=0D
  util/Makefile: Reduce the user-mode object list=0D
  stubs/Makefile: Reduce the user-mode object list=0D
  target/riscv/cpu: Restrict CPU migration to system-mode=0D
  exec: Assert CPU migration is not used on user-only build=0D
  arch_init: Remove unused 'qapi-commands-misc.h' include=0D
  target/i386: Restrict CpuClass::get_crash_info() to system-mode=0D
  target/s390x: Restrict CpuClass::get_crash_info() to system-mode=0D
  hw/core: Restrict CpuClass::get_crash_info() to system-mode=0D
  stubs: Restrict ui/win32-kbd-hook to system-mode=0D
=0D
Sergei Trofimovich (1):=0D
  linux-user/strace.list: fix epoll_create{,1} -strace output=0D
=0D
 Makefile                   |  2 +-=0D
 arch_init.c                |  1 -=0D
 configure                  |  4 +++=0D
 exec.c                     |  4 ++-=0D
 hw/core/cpu.c              |  2 ++=0D
 include/hw/core/cpu.h      |  7 ++++-=0D
 linux-user/generic/fcntl.h |  4 +++=0D
 linux-user/mmap.c          |  2 +-=0D
 linux-user/strace.list     |  4 +--=0D
 linux-user/syscall.c       | 33 +++++++++++++++++----=0D
 stubs/Makefile.objs        | 52 +++++++++++++++++++--------------=0D
 target/i386/cpu.c          |  6 +++-=0D
 target/riscv/cpu.c         |  6 ++--=0D
 target/s390x/cpu.c         | 12 ++++----=0D
 tests/Makefile.include     | 18 ++++++------=0D
 util/Makefile.objs         | 59 ++++++++++++++++++++++++--------------=0D
 16 files changed, 143 insertions(+), 73 deletions(-)=0D
=0D
--=3D20=0D
2.26.2=0D
=0D

