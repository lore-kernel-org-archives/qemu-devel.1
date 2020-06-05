Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198DEC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 11:43:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E31E3206E6
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 11:43:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E31E3206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhAlD-0005VC-7y
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 07:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhAj9-0002BX-2t
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 07:41:35 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:56589)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhAj8-0005ew-2k
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 07:41:34 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MVJZv-1jZDwg2oB5-00SQkQ; Fri, 05 Jun 2020 13:41:25 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 00/19] Linux user for 5.1 patches
Date: Fri,  5 Jun 2020 13:41:01 +0200
Message-Id: <20200605114120.1051236-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XBEOuTH1DJf3LKDfI6k8kVQTKX9ZJp3IOWVH22Pgl9D5fGnJk4B
 xGLZuyZXnvzGOv91okM2uOnCiSeZ+OhLl08Okrps93vjeXWdacu36if+dVE5B+P7G6hZl3X
 2UhFOY1TcmdML0AAWENf/4kQXk1tWI7ELetTlWVkkts8He+aoV0bbLXcROt9/qWdh/DJgPI
 2nbFRLRhMuFSuCqGAYH/g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gdQYRqFPS8c=:HRG+GC22HVYnLusCSnQrB0
 F2MMC0/U4cSlSPfdUgTFexph0C5FxtYC1bzS5zsGBXULvcOhR7F1m7xjLMZID8cRsWfHE2EER
 kxdU4rWE6rVrVlU0Hh3welYUc96XxH/aRzN/MVYlkfx4mDoiapsIuTa9ecQqDKlg5yR73PbLU
 +guV7PtIemFl5YujrUiyDiK9+jC4tiGWAu0bCAVyNVCL74/p/PWjHVa5J/AtUHpr/fN1NBaZc
 yDys4dlOwr6CSmoyTozTasvt547qArDd+AHJRrvH4+Qr64DA90W5zK5vOV7NXbr240iDCGGO8
 BrI4DHQIh0sa/+LeQ3jKgWfLxyE2hoHU8heUp845OmxDzjlj15bk8evoaTP/zdsmo1B9H5gWk
 Au5wId+C3+BUBIedSjP8GiqLeITPxA3xaUUNiiVMhJ23uwIyOgnMudNd4Zi9L0N8L1LM9AARp
 k+bjUnS6a0PuFPbQlfk2gC+WWmfwqRprsoD+6nWwX4bP0TCJQ8qs/sE+DheUBqFUFoSvkEZX+
 gAv4q2pXpVx/YYyBuSyuyXagDqAVHBqmfwN709vtPM9+fS8BqzPoouOW4LIaLekdSKOBo15At
 8VHOjyMrXwS1WTRRq/JnQcG2O2iKj8h2E6DSS0F3wTqNkKIOzdRytvUQvVH5uTaz40XTzUmUJ
 sB6PIwxkqPA3A1Y+AfQCxfK06bV8AT9rBKGJUmN2WfLrMFXL1KwizFtKlfEb9Gu4vua+oX3sf
 xG02pwJcDMuRYmmYu0bHCAAwY3u5pA4VZYyM5bMmgi9MqsvUqzEyXG0T5tSldLfHzu3zOlqHF
 GE/lfTeo76Z9M9tyhl1M0NpeAtER1kDaNv1p2WFfKeoeuyC7k5zeRYbqijI2/pQ78x4ZLFB
Received-SPF: none client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 07:41:32
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
for you to fetch changes up to aa3d2045d4ca760bd8c22935a2d73ee4f3480bd5:=0D
=0D
  stubs: Restrict ui/win32-kbd-hook to system-mode (2020-06-05 11:36:00 +02=
00)=0D
=0D
----------------------------------------------------------------=0D
linux-user pull request 20200605=0D
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
 linux-user/syscall.c       | 31 +++++++++++++++++---=0D
 stubs/Makefile.objs        | 52 +++++++++++++++++++--------------=0D
 target/i386/cpu.c          |  6 +++-=0D
 target/riscv/cpu.c         |  6 ++--=0D
 target/s390x/cpu.c         | 12 ++++----=0D
 tests/Makefile.include     | 18 ++++++------=0D
 util/Makefile.objs         | 59 ++++++++++++++++++++++++--------------=0D
 16 files changed, 142 insertions(+), 72 deletions(-)=0D
=0D
--=3D20=0D
2.26.2=0D
=0D

