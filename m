Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C37DC4727C
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 21:04:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F3122083B
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 21:04:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F3122083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kN0KE-0000xi-TL
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 17:04:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kN0J3-0000W0-8p
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 17:03:33 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:60705)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kN0J1-0006Bm-1R
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 17:03:32 -0400
Received: from [192.168.100.1] ([82.252.129.222]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MtO06-1khPER493G-00utdj; Mon, 28 Sep 2020 23:03:02 +0200
To: Taylor Simpson <tsimpson@quicinc.com>, qemu-devel@nongnu.org
References: <1601314138-9930-1-git-send-email-tsimpson@quicinc.com>
 <1601314138-9930-28-git-send-email-tsimpson@quicinc.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [RFC PATCH v4 27/29] Hexagon (linux-user/hexagon) Linux user
 emulation
Message-ID: <97b7864c-f4b2-ae8a-9ad0-d1d3c1fb309c@vivier.eu>
Date: Mon, 28 Sep 2020 23:02:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1601314138-9930-28-git-send-email-tsimpson@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Cn7IKsBlRsOQMG5X3Vj4IHRJy1UXSXvRungYas7hYtfvl2qmscp
 Zf+2eqXH/lsJfmzMo3X9lcaigY8Vcdcwo2ON/QCTvFDaZKKQJjPr+sqdEE30ELB51zNzjdU
 2vIkXKcQE75VY+6TEEPiXcTBpvLERM/SpnPCCCEk3OZdBjIKPZ0Lbl4Jcl6pVzCtta6mcpW
 zMUkrIvvkDXyy7YhxM35A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dFntXas7S48=:l4knDt4Hufar59h2C+LQpI
 afzEFLlXCVAUs/Gtjz7xa21+pksZYb/v9U/ltC+awQhabqRVOujtvI6dgHNrSVd4JdBxXqJYD
 i8G7fUVPSYpZbBlEypd6weJ9LZkXdIQafn6JUU1fswLucdPktTW4iyF+NavHcoNwpTMqWI/pG
 E8n1pAv/oq/BUCHX3JPIQ8YsO9UQ8gINVUgWWMLjHa4WMmBHHBM6mcwnegUSX5wCkPzQC50F2
 IJMx3dbPOWgc69eX5NOiG5b2aly1ux6vJBjEDizxk4KVQ10+K7DcMNGj1G22J0MKnNwqTOX+M
 TP2oiamTGpIKfhmWaJK0Jqe/s3Uhb62/N6q73m+EDGtQZUkPXlzAmAbCuTakGtL37ytoVCm1j
 qqInqkgU9ks0+/xsY1frisHysLdmqRqB4w17PBcoZMxgLOUAwud/fgtFFIQiAIN7DJsDVX8fS
 Ckm1oHhypPHSGG7hJzO5mmzySv1I5gb/+mEStisPecytkfPgxqMpgIZiqp+UMoIZNtdJh4eqH
 Epo+nN7SimD7F2/ReNKwmDljK66zOo+4+kA4HlrpCWQ+r09mUmgVzQtF+FiwqZUclWgX/1iQM
 hlX8zqK6ZdcU5dFjJKatrzHitLhcqg09OcjohCqBp/Z2S4GzROsbmYhrUykOh0q33Wa5kLbly
 iooWLMzELRScelq9uIEqykpiqjhTs7NuOTQRle0PuQ69KOtRvVdbIHQQ5YB296bdB2QE1Qg2e
 T8a2DmJJOiYGN+KC/Sx0Mvch5aU1kYETaLdPFARdlAjzrum6A9LGFDQbkIX8c5dVvCceKZLP6
 VddbqfmE5LyzDYyncB7U3Qw9StZZTI3B2bDww3pdEWNsiFDB3yNfqVf8Z9L5MU0BzOLPM7l
Received-SPF: none client-ip=212.227.126.133; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 17:03:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.614, SPF_HELO_NONE=0.001,
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
Cc: ale@rev.ng, philmd@redhat.com, riku.voipio@iki.fi,
 richard.henderson@linaro.org, aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 28/09/2020 à 19:28, Taylor Simpson a écrit :
> Implementation of Linux user emulation for Hexagon
> Some common files modified in addition to new files in linux-user/hexagon
> 
> Signed-off-by: Taylor Simpson <tsimpson@quicinc.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/hexagon/sockbits.h       |  18 ++
>  linux-user/hexagon/syscall_nr.h     | 343 ++++++++++++++++++++++++++++++++++++
>  linux-user/hexagon/target_cpu.h     |  44 +++++
>  linux-user/hexagon/target_elf.h     |  40 +++++
>  linux-user/hexagon/target_fcntl.h   |  18 ++
>  linux-user/hexagon/target_signal.h  |  34 ++++
>  linux-user/hexagon/target_structs.h |  46 +++++
>  linux-user/hexagon/target_syscall.h |  36 ++++
>  linux-user/hexagon/termbits.h       |  18 ++
>  linux-user/qemu.h                   |   2 +
>  linux-user/syscall_defs.h           |  33 ++++
>  linux-user/elfload.c                |  16 ++
>  linux-user/hexagon/cpu_loop.c       |  99 +++++++++++
>  linux-user/hexagon/signal.c         | 276 +++++++++++++++++++++++++++++
>  linux-user/hexagon/meson.build      |  22 +++
>  linux-user/meson.build              |   1 +
>  scripts/gensyscalls.sh              |   3 +-
>  17 files changed, 1048 insertions(+), 1 deletion(-)
>  create mode 100644 linux-user/hexagon/sockbits.h
>  create mode 100644 linux-user/hexagon/syscall_nr.h
>  create mode 100644 linux-user/hexagon/target_cpu.h
>  create mode 100644 linux-user/hexagon/target_elf.h
>  create mode 100644 linux-user/hexagon/target_fcntl.h
>  create mode 100644 linux-user/hexagon/target_signal.h
>  create mode 100644 linux-user/hexagon/target_structs.h
>  create mode 100644 linux-user/hexagon/target_syscall.h
>  create mode 100644 linux-user/hexagon/termbits.h
>  create mode 100644 linux-user/hexagon/cpu_loop.c
>  create mode 100644 linux-user/hexagon/signal.c
>  create mode 100644 linux-user/hexagon/meson.build
> 
...
> diff --git a/linux-user/hexagon/meson.build b/linux-user/hexagon/meson.build
> new file mode 100644
> index 0000000..7158e52
> --- /dev/null
> +++ b/linux-user/hexagon/meson.build
> @@ -0,0 +1,22 @@
> +##
> +##  Copyright(c) 2020 Qualcomm Innovation Center, Inc. All Rights Reserved.
> +##
> +##  This program is free software; you can redistribute it and/or modify
> +##  it under the terms of the GNU General Public License as published by
> +##  the Free Software Foundation; either version 2 of the License, or
> +##  (at your option) any later version.
> +##
> +##  This program is distributed in the hope that it will be useful,
> +##  but WITHOUT ANY WARRANTY; without even the implied warranty of
> +##  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +##  GNU General Public License for more details.
> +##
> +##  You should have received a copy of the GNU General Public License
> +##  along with this program; if not, see <http://www.gnu.org/licenses/>.
> +##
> +
> +syscall_nr_generators += {
> +  'hexagon': generator(sh,
> +                       arguments: [ 'cat', 'syscall_nr.h', '>', '@OUTPUT@' ],
> +                     output: '@BASENAME@_nr.h')

Why do we need that?
The syscall_nr_generators is used to generate syscall_nr.h from syscall.tbl

> +}
> diff --git a/linux-user/meson.build b/linux-user/meson.build
> index 2b94e4b..8b1dfc8 100644
> --- a/linux-user/meson.build
> +++ b/linux-user/meson.build
> @@ -22,6 +22,7 @@ syscall_nr_generators = {}
>  
>  subdir('alpha')
>  subdir('arm')
> +subdir('hexagon')

so you don't need that either

>  subdir('hppa')
>  subdir('i386')
>  subdir('m68k')
> diff --git a/scripts/gensyscalls.sh b/scripts/gensyscalls.sh
> index b7b8456..e2ee60a 100755
> --- a/scripts/gensyscalls.sh
> +++ b/scripts/gensyscalls.sh
> @@ -53,7 +53,7 @@ read_includes()
>  
>  filter_defines()
>  {
> -    grep -e "#define __NR_" -e "#define __NR3264"
> +    grep -e "#define __NR_" -e "#define __NR3264" | grep -v __NR_syscalls

Why do you remove __NR_syscalls?

>  }
>  
>  rename_defines()
> @@ -99,4 +99,5 @@ generate_syscall_nr openrisc 32 "$output/linux-user/openrisc/syscall_nr.h"
>  
>  generate_syscall_nr riscv 32 "$output/linux-user/riscv/syscall32_nr.h"
>  generate_syscall_nr riscv 64 "$output/linux-user/riscv/syscall64_nr.h"
> +generate_syscall_nr hexagon 32 "$output/linux-user/hexagon/syscall_nr.h"

Please, move this line to the previous block (that generates
syscall_nr.h and not syscallXX_nr.h)

>  rm -fr "$TMP"
> 

Thanks,
Laurent

