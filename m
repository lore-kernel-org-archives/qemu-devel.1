Return-Path: <SRS0=giGJ=6X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B26C28CBC
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 04:25:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDF9321655
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 04:25:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDF9321655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemote.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXH3T-0000Kc-3j
	for qemu-devel@archiver.kernel.org; Sat, 09 May 2020 00:25:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenhuacai@gmail.com>)
 id 1jXH2l-0008MN-6x
 for qemu-devel@nongnu.org; Sat, 09 May 2020 00:24:55 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45981)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chenhuacai@gmail.com>)
 id 1jXH2i-0005mJ-5a
 for qemu-devel@nongnu.org; Sat, 09 May 2020 00:24:54 -0400
Received: by mail-io1-f65.google.com with SMTP id i19so3897973ioh.12
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 21:24:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=T729zuWLucZwsQ3fGdwS2CX71Nd+c9u7n/xXTLXgwos=;
 b=GGCD7lyNdSJyDDUPhcaUDilyezxS79OeFT+rCAVLmK9xA19FJJrNCXDhRFe2LJbbko
 zben0VEa015uEpqTO+I18NzbhQj8xAJomMsSaFdydyieljnSRGfxNQY1ms/tcPcVigJf
 LhNEzg8mIRjWHEQCmJDn3FXEQHQr6wMaphBEp8eZ1POyuBpUDO2LoQ7hyVPMOh5+rRB+
 GL1rajl0naYz9/kQC3zNo14k22JcUZ6IQV71MEP/Uwt0RUR2AJl0ceNyenXnVy0dQDOB
 4+cm7TodazzDjP2srVhaY6kUVgJa2KxgSB+0OAMmb7KrtZVDPzJOMnei4eJ3EJLrb7av
 dNNw==
X-Gm-Message-State: AGi0PuYo9AGb79SUXMHExsr94v8jfO1/0oP+2CDeIC9S9GTSCjLkCcF/
 DI+xY9Q99Swwy0CtOAqzwa3xuxaD9z/kkQAyl14=
X-Google-Smtp-Source: APiQypJh1BjUcRA4lxUJWeKav/PPITNxXFDGZKYVfEZckYRMBOyxoLqKXw7BuxYc66PDgEeX2hQ8fHq2fRWX+XNO74E=
X-Received: by 2002:a02:966a:: with SMTP id c97mr5911573jai.106.1588998290317; 
 Fri, 08 May 2020 21:24:50 -0700 (PDT)
MIME-Version: 1.0
References: <1588500367-1056-1-git-send-email-chenhc@lemote.com>
 <CAHiYmc4f1N-8mvMEZNcxVP+zbxjp0=OWFQc2pDDssnpmZ6eJig@mail.gmail.com>
In-Reply-To: <CAHiYmc4f1N-8mvMEZNcxVP+zbxjp0=OWFQc2pDDssnpmZ6eJig@mail.gmail.com>
From: Huacai Chen <chenhc@lemote.com>
Date: Sat, 9 May 2020 12:32:30 +0800
Message-ID: <CAAhV-H6521opsPrsorDK+Dk3qDHjOK=c7L5qmS=_O7cF4Uh=UA@mail.gmail.com>
Subject: Re: [PATCH V3 00/14] KVM: MIPS: Add Loongson-3 support (Host Side)
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.166.65; envelope-from=chenhuacai@gmail.com;
 helo=mail-io1-f65.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/09 00:24:50
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, kvm <kvm@vger.kernel.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Fuxin Zhang <zhangfx@lemote.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "open list:MIPS" <linux-mips@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, Aleksandar,

On Fri, May 8, 2020 at 7:43 PM Aleksandar Markovic
<aleksandar.qemu.devel@gmail.com> wrote:
>
> =D0=BD=D0=B5=D0=B4, 3. =D0=BC=D0=B0=D1=98 2020. =D1=83 12:06 Huacai Chen =
<chenhc@lemote.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE=
/=D0=BB=D0=B0:
> >
> > We are preparing to add KVM support for Loongson-3. VZ extension is
> > fully supported in Loongson-3A R4+, and we will not care about old CPUs
> > (at least now). We already have a full functional Linux kernel (based
> > on Linux-5.4.x LTS) and QEMU (based on 5.0.0-rc2) and their git
> > repositories are here:
> >
> > QEMU: https://github.com/chenhuacai/qemu
> > Kernel: https://github.com/chenhuacai/linux
> >
> > Of course these two repositories need to be rework and not suitable for
> > upstream (especially the commits need to be splitted). We show them her=
e
> > is just to tell others what we have done, and how KVM/Loongson will loo=
k
> > like.
> >
> > Our plan is make the KVM host side be upstream first, and after that,
> > we will make the KVM guest side and QEMU emulator be upstream.
> >
>
> Huacei, I absolutely salute this series, as it is, in my opinion, of
> tremendous significance not only for Loongson, but also for KVM for
> MIPS in general.
>
> As you probably know, James Hogan left KVM for MIPS kernel
> maintainership some time ago. It was really too bad, as he was and
> still is, from my direct experience, an excellent colleague and
> engineer.
>
> KVM for MIPS kernel maintainership left orphaned put me (as the
> maintainer for KVM for MIPS in QEMU) in an awkward position.
>
> May I ask that you and me jointly assume KVM for MIPS kernel
> maintainership? For me, it makes perfect sense, and I would certainly
> enjoy working with you. If you agree, please add such patch at the end
> of this series, in its next version.
I'm very glad to join maintainership with you, thank you for your invitatio=
n.

Regards,
Huacai

>
> Yours,
> Aleksandar
>
>
> > V1 -> V2:
> > 1, Remove "mips: define pud_index() regardless of page table folding"
> >    because it has been applied.
> > 2, Make Loongson-specific code be guarded by CONFIG_CPU_LOONGSON64.
> >
> > V2 -> V3:
> > 1, Emulate a reduced feature list of CPUCFG.
> > 2, Fix all possible checkpatch.pl errors and warnings.
> >
> > Xing Li(2):
> >  KVM: MIPS: Define KVM_ENTRYHI_ASID to cpu_asid_mask(&boot_cpu_data)
> >  KVM: MIPS: Fix VPN2_MASK definition for variable cpu_vmbits
> >
> > Huacai Chen(12):
> >  KVM: MIPS: Increase KVM_MAX_VCPUS and KVM_USER_MEM_SLOTS to 16
> >  KVM: MIPS: Add EVENTFD support which is needed by VHOST
> >  KVM: MIPS: Use lddir/ldpte instructions to lookup gpa_mm.pgd
> >  KVM: MIPS: Introduce and use cpu_guest_has_ldpte
> >  KVM: MIPS: Use root tlb to control guest's CCA for Loongson-3
> >  KVM: MIPS: Let indexed cacheops cause guest exit on Loongson-3
> >  KVM: MIPS: Add more types of virtual interrupts
> >  KVM: MIPS: Add Loongson-3 Virtual IPI interrupt support
> >  KVM: MIPS: Add CPUCFG emulation for Loongson-3
> >  KVM: MIPS: Add CONFIG6 and DIAG registers emulation
> >  KVM: MIPS: Add more MMIO load/store instructions emulation
> >  KVM: MIPS: Enable KVM support for Loongson-3
> >
> > Signed-off-by: Huacai Chen <chenhc@lemote.com>
> > ---
> >  arch/mips/Kconfig                    |   1 +
> >  arch/mips/include/asm/cpu-features.h |   3 +
> >  arch/mips/include/asm/kvm_host.h     |  52 +++-
> >  arch/mips/include/asm/mipsregs.h     |   7 +
> >  arch/mips/include/uapi/asm/inst.h    |  11 +
> >  arch/mips/kernel/cpu-probe.c         |   2 +
> >  arch/mips/kvm/Kconfig                |   1 +
> >  arch/mips/kvm/Makefile               |   5 +-
> >  arch/mips/kvm/emulate.c              | 503 +++++++++++++++++++++++++++=
+++++++-
> >  arch/mips/kvm/entry.c                |  19 +-
> >  arch/mips/kvm/interrupt.c            |  93 +------
> >  arch/mips/kvm/interrupt.h            |  14 +-
> >  arch/mips/kvm/loongson_ipi.c         | 214 +++++++++++++++
> >  arch/mips/kvm/mips.c                 |  49 +++-
> >  arch/mips/kvm/tlb.c                  |  41 +++
> >  arch/mips/kvm/trap_emul.c            |   3 +
> >  arch/mips/kvm/vz.c                   | 235 +++++++++++-----
> >  17 files changed, 1087 insertions(+), 166 deletions(-)
> >  create mode 100644 arch/mips/kvm/loongson_ipi.c
> > --
> > 2.7.0

