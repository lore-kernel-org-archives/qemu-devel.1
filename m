Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4604C4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 09:18:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7982221852
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 09:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="N2TZDWN1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7982221852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iA9cY-0000aK-FT
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 05:18:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33547)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1iA9bk-000067-Ad
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 05:17:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1iA9bh-0002Eu-2F
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 05:17:10 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:48746)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
 id 1iA9bg-0002Bo-CL
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 05:17:09 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net
 [IPv6:2a02:6b8:0:1402::301])
 by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 50DB72E14CB;
 Tue, 17 Sep 2019 12:17:03 +0300 (MSK)
Received: from localhost (localhost [::1])
 by mxbackcorp1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
 yyRhqfpTjZ-H22KAZ0H; Tue, 17 Sep 2019 12:17:03 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1568711823; bh=Af1ZBD9aiia+bIPcIPR+0AfhctCIRuUfvdgRVe7PntM=;
 h=Subject:In-Reply-To:Date:References:To:From:Message-Id;
 b=N2TZDWN1mjBpfTO7iCJfh6qNWGBuU20NfLDMxDwxZdO0Hyn4azl07R97kszJUzSxs
 9mibXuR1DLNKbFMoRv+AjDDMIKv+mkjjT5bx0yTDM04HANV22zRMHkfCdjyZehAYRb
 D9oLUHm8FZPQCfh1RRNcDOvRumoYIU/Tum7V0PVc=
Authentication-Results: mxbackcorp1g.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
X-Yandex-Sender-Uid: 1120000000071945
X-Yandex-Avir: 1
Received: from mxbackcorp1j.mail.yandex.net (localhost [::1])
 by mxbackcorp1j.mail.yandex.net with LMTP id UfpiGzvVxh-gcTByfCw
 for <yury-kotov@yandex-team.ru>; Tue, 17 Sep 2019 12:16:52 +0300
Received: by sas1-fc7737ec834f.qloud-c.yandex.net with HTTP;
 Tue, 17 Sep 2019 12:16:51 +0300
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
In-Reply-To: <1568646858-17065-1-git-send-email-pbonzini@redhat.com>
References: <1568646858-17065-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Tue, 17 Sep 2019 12:17:01 +0300
Message-Id: <1330281568711811@sas1-fc7737ec834f.qloud-c.yandex.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.45.199.163
Subject: Re: [Qemu-devel] [PULL v2 00/29] Misc patches for 2019-09-16
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi!

16.09.2019, 19:17, "Paolo Bonzini" <pbonzini@redhat.com>:
> The following changes since commit 138985c1ef8b66e4e5b383354e133e05d01d=
0b5f:
>
> =C2=A0=C2=A0Merge remote-tracking branch 'remotes/amarkovic/tags/mips-q=
ueue-sep-12-2019' into staging (2019-09-13 16:04:46 +0100)
>
> are available in the git repository at:
>
> =C2=A0=C2=A0git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 149c50cabcc4ea46a460d35fc876346ed441304c=
:
>
> =C2=A0=C2=A0hw/i386/pc: Extract the x86 generic fw_cfg code (2019-09-16=
 17:13:09 +0200)
>
> ----------------------------------------------------------------
> * Fix Patchew CI failures (myself)
> * i386 fw_cfg refactoring (Philippe)
> * pmem bugfix (Stefan)
> * Support for accessing cstate MSRs (Wanpeng)
> * exec.c cleanups (Wei Yang)
> * Improved throttling (Yury)
> * elf-ops.h coverity fix (Stefano)
>
> ----------------------------------------------------------------
> v1->v2: missing S-o-b lines
>
> Cole Robinson (1):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hw/i386: Move CONFIG_ACPI_PCI to CO=
NFIG_PC
>
> Paolo Bonzini (4):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0win32: fix README file in NSIS inst=
aller
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0test-char: fix AddressSanitizer fai=
lure
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0memory: inline and optimize devend_=
memop
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hw/i386/pc: Replace PCMachineState =
argument with MachineState in fw_cfg_arch_create
>
> Philippe Mathieu-Daud=C3=A9 (14):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hw/i386/pc: Use e820_get_num_entrie=
s() to access e820_entries
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hw/i386/pc: Extract e820 memory lay=
out code
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hw/i386/pc: Use address_space_memor=
y in place
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hw/i386/pc: Rename bochs_bios_init =
as more generic fw_cfg_arch_create
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hw/i386/pc: Pass the boot_cpus valu=
e by argument
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hw/i386/pc: Pass the apic_id_limit =
value by argument
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hw/i386/pc: Pass the CPUArchIdList =
array by argument
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hw/i386/pc: Let pc_build_smbios() t=
ake a FWCfgState argument
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hw/i386/pc: Let pc_build_smbios() t=
ake a generic MachineState argument
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hw/i386/pc: Rename pc_build_smbios(=
) as generic fw_cfg_build_smbios()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hw/i386/pc: Let pc_build_feature_co=
ntrol() take a FWCfgState argument
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hw/i386/pc: Let pc_build_feature_co=
ntrol() take a MachineState argument
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hw/i386/pc: Rename pc_build_feature=
_control() as generic fw_cfg_build_*
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hw/i386/pc: Extract the x86 generic=
 fw_cfg code
>
> Stefan Hajnoczi (1):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0memory: fetch pmem size in get_file=
_size()
>
> Stefano Garzarella (1):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0elf-ops.h: fix int overflow in load=
_elf()
>
> Wanpeng Li (1):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0i386/kvm: support guest access CORE=
 cstate
>
> Wei Yang (5):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0exec.c: replace hwaddr with uint64_=
t for better understanding
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0exec.c: get nodes_nb_alloc with one=
 MAX calculation
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0exec.c: subpage->sub_section is alr=
eady initialized to 0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0exec.c: correct the maximum skip va=
lue during compact
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0exec.c: add a check between constan=
ts to see whether we could skip
>
> Yury Kotov (2):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0qemu-thread: Add qemu_cond_timedwai=
t
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cpus: Fix throttling during vm_stop
>

Sorry, it looks like that you've missed the 3rd patch in the
"High downtime with 95+ throttle pct" series:
    tests/migration: Add a test for auto converge

Or was there a reason for not adding it to PR?

> =C2=A0backends/hostmem-file.c | 22 -----
> =C2=A0cpus.c | 25 +++--
> =C2=A0default-configs/i386-softmmu.mak | 1 -
> =C2=A0exec.c | 54 ++++++++---
> =C2=A0hw/core/loader.c | 2 +
> =C2=A0hw/i386/Kconfig | 1 +
> =C2=A0hw/i386/Makefile.objs | 2 +-
> =C2=A0hw/i386/e820_memory_layout.c | 59 +++++++++++
> =C2=A0hw/i386/e820_memory_layout.h | 42 ++++++++
> =C2=A0hw/i386/fw_cfg.c | 137 ++++++++++++++++++++++++++
> =C2=A0hw/i386/fw_cfg.h | 7 ++
> =C2=A0hw/i386/pc.c | 204 ++-------------------------------------
> =C2=A0include/exec/memory.h | 19 +++-
> =C2=A0include/hw/elf_ops.h | 5 +
> =C2=A0include/hw/i386/pc.h | 11 ---
> =C2=A0include/hw/loader.h | 1 +
> =C2=A0include/qemu/osdep.h | 13 ---
> =C2=A0include/qemu/thread.h | 19 ++++
> =C2=A0linux-headers/linux/kvm.h | 4 +-
> =C2=A0memory.c | 18 ----
> =C2=A0qemu.nsi | 4 +-
> =C2=A0target/i386/kvm.c | 4 +-
> =C2=A0tests/test-char.c | 44 ++++-----
> =C2=A0util/oslib-posix.c | 54 -----------
> =C2=A0util/oslib-win32.c | 6 --
> =C2=A0util/qemu-thread-posix.c | 41 +++++---
> =C2=A0util/qemu-thread-win32.c | 17 ++++
> =C2=A0util/qsp.c | 20 ++++
> =C2=A028 files changed, 456 insertions(+), 380 deletions(-)
> =C2=A0create mode 100644 hw/i386/e820_memory_layout.c
> =C2=A0create mode 100644 hw/i386/e820_memory_layout.h
> --
> 1.8.3.1

Regards,
Yury

