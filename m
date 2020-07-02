Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D65C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 15:43:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ECEF20748
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 15:43:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ECEF20748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr1N9-0001hn-B1
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 11:43:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jr1AB-0005Hx-6d
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 11:30:11 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:50469)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jr1A8-0006oH-AU
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 11:30:10 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MowT0-1j1fhD2pjS-00qUEZ; Thu, 02 Jul 2020 17:30:05 +0200
Subject: Re: [PULL v2 00/12] Linux user for 5.1 patches
To: qemu-devel@nongnu.org
References: <20200702152710.84602-1-laurent@vivier.eu>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <7f5f7a8d-ac0b-0528-1b7d-c88c4c45486d@vivier.eu>
Date: Thu, 2 Jul 2020 17:30:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200702152710.84602-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:cjZz21acT4UgOLK852nD3Ij1PJPc8j4IyIyf/XTalh8RyMLf8fJ
 OQVyehJ9soVyy4iEU1aoj9o8GeILMGkdlXH4cBrIeebHCwc3rCqbSpV3fdP1WLcdSUhHfk3
 NL3Vh6AGyMns3VzurBKoo95Ragbub8WnnT9EnxILytWASgqtZA4G9wZWvrA66hRJ/pHuFb9
 y3XJTAJq23cN5AMhc8nLA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:veBTMJzZJAo=:dT2uSoQD8G/igDlcOWHVZh
 SStiD8puEqiMsCvBfKF67Dk4t4qbo/InoFxA9tKpvVFyIfoPD8nJ0XdNlMqTPeCD+CLFXTVQb
 9w/C0bSdIHdovgrqcSL3hIqxgcgDJJGCuEH3gMgQApPDC7E2PDepVCVtiTJSLK67IdCDPeyCL
 BXaOaOtOc+DN4qTFFCOIns757pQdmUBXziylGbKoDPksof51B2QXt4OK7YlXUVDcHz1S93xX/
 ZixYoWisTzNFVg05p2Zi28Nvnng+g5y5VRpwpf7n1QRZZfuMzNX5modK/dDYC3Gf00pO0d/1S
 dhxXhy/Gz8jd7LkgsWYwhVNWgGlliZyTQEgvqN2Wf0ZDuSXcWH11k3hlDGfZX/Lbbji8GDO9C
 RzZGTJxgstmlEdg8XBlKoE04SuVGXrLDou0nAvvVIPX6erC44ylPegCLBcteCs2rW+sytoZgB
 yB+4cByqZGwlpkTxO/VqWtaEK1rxkSUq2Bnsp+TqY187I4XINajBHZWqwqkSICB5rJQ2LdKKt
 rxdziTxSDwOHdaSEJyGEaYUYB40d2reHkJxPhbWUNJaDC5NX+7ng+cdr7Sdw04h2H3ZvfMOJn
 e2kB7xAO9lzBvgPoH2Pf1w9l/c/vcQDnevDhMeYZu3MZOfzzufR8hHEpfkTQf4FETDFA9hNxi
 3Llkr6KW1ASYySz3zwOGy1PM2rjTCdArfsl5HFV2qyk2Rd0tFFaENXoyM1wbxgnGZ6N8OMu9Z
 0V2oSGskKuqe9ny/mxL8BxVKXEEBKqPavXGlHNQ66OQZTK8Feb4pHRcSkpM8wtH+qor9Ka41U
 WyCcehrtON2+nQ/GwmIh/pExRwkyJNPUtetwWbHH24SMdyIFWHd9b2esoYgaBI33f1+BxUF
Received-SPF: none client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 10:57:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 02/07/2020 à 17:26, Laurent Vivier a écrit :
> The following changes since commit e7651153a8801dad6805d450ea8bef9b46c1adf5:
> 
>   Merge remote-tracking branch 'remotes/amarkovic/tags/mips-gsoc-queue-jun-27-2020' into staging (2020-06-27 22:57:36 +0100)
> 
> are available in the Git repository at:
> 
>   git://github.com/vivier/qemu.git tags/linux-user-for-5.1-pull-request
> 
> for you to fetch changes up to 89ddeec7f060a9f403aead414bb883a52f2b5024:
> 
>   MAINTAINERS: update linux-user maintainer (2020-07-02 16:55:16 +0200)
> 
> ----------------------------------------------------------------
> linux-user pull request 2020-07-02
> 
> Update linux-user maintainer
> Improve strace output for some syscalls
> Display contents of ioctl() parameters
> Fix sparc64 flushw operation
> 
> ----------------------------------------------------------------
> 
> Chen Gang (1):
>   linux-user: syscall: ioctls: support DRM_IOCTL_VERSION
> 
> Filip Bozuta (8):
>   linux-user: Extend strace support to enable argument printing after
>     syscall execution
>   linux-user: Add strace support for a group of syscalls
>   linux-user: Add strace support for printing argument of syscalls used
>     for extended attributes
>   linux-user: Add strace support for printing arguments of lseek()
>   linux-user: Add strace support for printing arguments of
>     chown()/lchown()
>   linux-user: Add strace support for printing arguments of fallocate()
>   linux-user: Add thunk argument types for SIOCGSTAMP and SIOCGSTAMPNS
>   linux-user: Add strace support for printing arguments of ioctl()
> 
> Giuseppe Musacchio (2):
>   target/sparc: Translate flushw opcode
>   linux-user/sparc64: Fix the handling of window spill trap
> 
> Riku Voipio (1):
>   MAINTAINERS: update linux-user maintainer
> 
>  MAINTAINERS                 |   3 +-
>  bsd-user/main.c             |   6 +-
>  configure                   |  10 +
>  include/exec/user/thunk.h   |   1 +
>  linux-user/ioctls.h         |  17 +-
>  linux-user/qemu.h           |  40 +++-
>  linux-user/sparc/cpu_loop.c |   6 +-
>  linux-user/strace.c         | 435 +++++++++++++++++++++++++++++++-----
>  linux-user/strace.list      |  40 ++--
>  linux-user/syscall.c        | 136 ++++++++---
>  linux-user/syscall_defs.h   |  15 ++
>  linux-user/syscall_types.h  |  33 +++
>  target/sparc/translate.c    |   2 +
>  thunk.c                     | 154 +++++++++++++
>  14 files changed, 782 insertions(+), 116 deletions(-)
> 

It's not a v2: I forgot to reset my gitpublishprefix before sending my
PR after my previous PR with a v2.

Thanks,
Laurent

