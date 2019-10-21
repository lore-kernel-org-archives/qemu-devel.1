Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09113CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 13:57:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1CF4214B2
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 13:57:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1CF4214B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMYBn-0003RM-0s
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 09:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43452)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iMY8h-0000xh-Dr
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 09:54:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iMY8f-00059g-5z
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 09:54:27 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:34921)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iMY8e-00059B-T7; Mon, 21 Oct 2019 09:54:25 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1N6srH-1hxPAZ3Hmp-018KzF; Mon, 21 Oct 2019 15:53:25 +0200
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 peter.maydell@linaro.org
References: <20190910193408.28917-1-alex.bennee@linaro.org>
 <20190910193408.28917-3-alex.bennee@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [Qemu-devel] [PATCH v1 2/4] elf: move elf.h to elf/elf.h and
 split out types
Message-ID: <5be164f7-6a8a-07b8-8d16-18300638f9b5@vivier.eu>
Date: Mon, 21 Oct 2019 15:53:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190910193408.28917-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:UrU9uY7OIujC5YaRN0E+fwNBpa9rYt+PYXlbhF9qVKMBOHWLOP1
 zWsNRkxT+bWLlU1QfbgEOtA+VLiJRKxpCJLaF7EJYURyhDuwlkWBaguE+o+OIU+RRDx27Sf
 dsX3tkB9pgtkmmnP639kmtmQBHp8lGlrOgMi1zj8SCcTVsxQjF9LF69e7YLL05EcgsR9DJo
 /iiTXNtd+FOjLRuEJpblA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DzSdzy6Va90=:ZVRekwCtg0CmfWqxqJWxUT
 8easAEPESeDT5hC2WHzYOQQZ54Q3WcilnXtvqTj/Vl7hZvv6fsgJS5o6oRHchUyAZN2pV35+j
 q9P0r0lz3ulO4kB9QIDYy1TvtIJG9mYNPMOOsqBwRWCeyCcUCnNUDiHeaOwUYIxddQMi63kQ2
 euAq+DGKRWXDIKgCqJAQ1EbOSa/jHJKAZN1/nbDXwLXy4gvcrq1htHGbhquweZ9B6ug98wqy2
 punZB77rczxCXVwrEQN7Er+2Mg12QBdCSeggFV8Gg5bM+GTZOsNJty5K5QkXhJbZoRDW1EjFM
 xeUPY/2kVwvfMUMKxfamnn30vFSPJgAgMHmkWLoSvHiyB90cWt/ndku8a1Dobhl7vUs69h4K8
 uDQu8KZKNzNGRDm9ORWCCmUnzmIcLBNEPv1gvj7hUQjoCUnJpBd9fiOiTBOtTnO1Z15ybYO97
 xKRyV9YchZodQ5VmUM4OUMq4fZNSvbbUBPjQg7gR0LNC1rX//e2Aw4G4NQKFmlYH5VznKLXXR
 My9gBKta46aZTzS9Gtp4SrBCyzqxMP592Czcfh2mZIdbIzxR3bZdSKPBh+WZWq20eCSt2GMJM
 qB0WlZajd3eJ6gkzM1nG1Je+dZEej4MD+n+QJtr2SIvHeTmN80zmtoeS0jViW/E3UxczOAOt0
 cok+mLM4RoZ7oUFYBTyZrMW4JgO2XVo/o1y/J0rCx/OcJmEfzqS5Ut6YTreyRV9dDOut3iYf2
 RzqoHUF45MvegOGPmswirhUXisvdVgu5Gctvj2C52RuPN0A/IIprrWSCXeRSYUEvAcIlDrD3J
 41dq0T8W+l2/aXjzgNb4Nua1AHUdblctqusp/60BHpmTWoxpNhwDwPUn497K6lS2daQ83ebpz
 r4FJiUkg3qJ83XCCtTSqEhikMVriqA38S90uPfcjw=
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
Cc: Chris Wulff <crwulff@gmail.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Anthony Green <green@moxielogic.com>,
 Palmer Dabbelt <palmer@sifive.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Max Filippov <jcmvbkbc@gmail.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Marek Vasut <marex@denx.de>,
 Jia Liu <proljc@gmail.com>, Aleksandar Rikalo <arikalo@wavecomp.com>,
 Helge Deller <deller@gmx.de>, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Fabien Chouteau <chouteau@adacore.com>,
 "open list:S390-ccw boot" <qemu-s390x@nongnu.org>, qemu-arm@nongnu.org,
 Stafford Horne <shorne@gmail.com>, David Gibson <david@gibson.dropbear.id.au>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
 Thomas Huth <huth@tuxfamily.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, Michael Walle <michael@walle.cc>,
 "open list:PReP" <qemu-ppc@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 10/09/2019 à 21:34, Alex Bennée a écrit :
> Most of the users of elf.h just want the standard Elf definitions. The
> couple that want more than that want an expansion based on ELF_CLASS
> which can be used for size agnostic code. The later is moved into
> elf/elf-types.inc.h to make it clearer what it is for. While doing
> that I also removed the whitespace damage.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  bsd-user/elfload.c               |  2 +-
>  contrib/elf2dmp/qemu_elf.h       |  2 +-
>  disas.c                          |  2 +-
>  dump/dump.c                      |  2 +-
>  dump/win_dump.c                  |  2 +-
>  hw/alpha/dp264.c                 |  2 +-
>  hw/arm/armv7m.c                  |  2 +-
>  hw/arm/boot.c                    |  2 +-
>  hw/core/loader.c                 |  3 +-
>  hw/cris/axis_dev88.c             |  2 +-
>  hw/cris/boot.c                   |  2 +-
>  hw/hppa/machine.c                |  2 +-
>  hw/i386/multiboot.c              |  2 +-
>  hw/i386/pc.c                     |  2 +-
>  hw/lm32/lm32_boards.c            |  2 +-
>  hw/lm32/milkymist.c              |  2 +-
>  hw/m68k/an5206.c                 |  2 +-
>  hw/m68k/mcf5208.c                |  2 +-
>  hw/microblaze/boot.c             |  2 +-
>  hw/mips/mips_fulong2e.c          |  2 +-
>  hw/mips/mips_malta.c             |  2 +-
>  hw/mips/mips_mipssim.c           |  2 +-
>  hw/mips/mips_r4k.c               |  2 +-
>  hw/moxie/moxiesim.c              |  2 +-
>  hw/nios2/boot.c                  |  2 +-
>  hw/openrisc/openrisc_sim.c       |  2 +-
>  hw/pci-host/prep.c               |  2 +-
>  hw/ppc/e500.c                    |  2 +-
>  hw/ppc/mac_newworld.c            |  2 +-
>  hw/ppc/mac_oldworld.c            |  2 +-
>  hw/ppc/ppc440_bamboo.c           |  2 +-
>  hw/ppc/prep.c                    |  2 +-
>  hw/ppc/sam460ex.c                |  2 +-
>  hw/ppc/spapr.c                   |  2 +-
>  hw/ppc/spapr_vio.c               |  2 +-
>  hw/ppc/virtex_ml507.c            |  2 +-
>  hw/riscv/boot.c                  |  2 +-
>  hw/s390x/ipl.c                   |  2 +-
>  hw/sparc/leon3.c                 |  2 +-
>  hw/sparc/sun4m.c                 |  2 +-
>  hw/sparc64/sun4u.c               |  2 +-
>  hw/tricore/tricore_testboard.c   |  2 +-
>  hw/xtensa/sim.c                  |  2 +-
>  hw/xtensa/xtfpga.c               |  2 +-
>  include/elf/elf-types.inc.h      | 63 ++++++++++++++++++++++++++++++++
>  include/{ => elf}/elf.h          | 42 ---------------------
>  include/hw/core/generic-loader.h |  2 +-
>  linux-user/arm/cpu_loop.c        |  2 +-
>  linux-user/elfload.c             |  5 +--
>  linux-user/main.c                |  2 +-
>  linux-user/mips/cpu_loop.c       |  2 +-
>  linux-user/riscv/cpu_loop.c      |  2 +-
>  target/arm/arch_dump.c           |  2 +-
>  target/i386/arch_dump.c          |  2 +-
>  target/ppc/arch_dump.c           |  2 +-
>  target/ppc/kvm.c                 |  2 +-
>  target/s390x/arch_dump.c         |  2 +-
>  tcg/arm/tcg-target.inc.c         |  2 +-
>  tcg/ppc/tcg-target.inc.c         |  2 +-
>  tcg/s390/tcg-target.inc.c        |  2 +-
>  tcg/tcg.c                        |  5 ++-
>  util/getauxval.c                 |  2 +-
>  62 files changed, 128 insertions(+), 104 deletions(-)
>  create mode 100644 include/elf/elf-types.inc.h

The patch looks good, but why did you call the file "elf-types.inc.h"
and not "elf-types.h"?

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

Thanks,
LAurent

