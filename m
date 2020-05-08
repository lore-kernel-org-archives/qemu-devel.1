Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F91DC38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 11:44:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22290208DB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 11:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gIfE0RDC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22290208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX1Qa-00034L-B8
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 07:44:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36970)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jX1Pu-0002X2-F2
 for qemu-devel@nongnu.org; Fri, 08 May 2020 07:43:46 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33526)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jX1Ps-0004Vz-Nb
 for qemu-devel@nongnu.org; Fri, 08 May 2020 07:43:46 -0400
Received: by mail-wr1-x444.google.com with SMTP id h9so1508861wrt.0
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 04:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=qKGhrUPEHY1fphcNoABX/IHv164kpoZpOU/cK61zd18=;
 b=gIfE0RDCPNifBmsmWO7ny5anKMbhPu3jhwrv8CXiPnxjeuz95+8OyDHZmJFYj7jAvd
 hpCHM8e4T4P8d2hDJpLvDDRrnT5y3+iZJ8F6F8kHQZiEE4vxnm+lK5PdS9HtaHxhG7d5
 jao8mgYREs4uQpenwhP3hLfKVRbTmhhUNyvNrOjwsbTLNl6P0mSPeHTnuTrr7PL41Xez
 hsrQHIUl9YmfMsCKshraJNWLs/opu6CzMxV23p29+SCRzRR6g7dRjGswaYNZkTuQi8SY
 DcaSsmRp4t/9qof9GgGaZWzBlMY1A0MdMJM/1tzO4eYLK87TuHUi2DKTvr3RB+mK9NEv
 k8BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=qKGhrUPEHY1fphcNoABX/IHv164kpoZpOU/cK61zd18=;
 b=dcrrzFng2NkdtxZiLwXzeRpFJfRm/qnfam3xKWvvrXj83FOWNkVobSseKNLWu/Xfg0
 HI5YNP6mwrLfWOFw7xnhokibWKu8LfVhuiqvJ/sFF2CV2IPHRpLGLQZpJHvrogPn6TcD
 NMq6/788F6vBRwn/mQkj9XtwbL5bF+zmXA64c6ymb91RF61j5/aFvE2tpD2A2wf8BFKl
 pOCC5fDOzE/1bMkBh3cv/Jf8l5WDiAKjcT/PFpSpJ3qP6b46qjmVFqglLxdwrHcCZyMH
 TqIjmklTab1IQn8II2bpN1Ty8do/ttElPK+/ymrv6mUKb8o3apk+tujpPiSbd+mNhRFE
 bvfA==
X-Gm-Message-State: AGi0PuaMG2svJ2hwlMgHk93sPt2O7wAvYd+Sc7q6CJ7Ys2JGwSqnQVQJ
 cBiiui9r1kFtE+eQ1aItfo9wVe+s2+UT8MZaR9o=
X-Google-Smtp-Source: APiQypK/2c0ZqyQa5bx07zYKDpZDBfCeDhkkWNQ5ES1fs2vEL0KHQqN5iu+gcwH1k/K8c88MGNYIffy75833IjusxZE=
X-Received: by 2002:adf:dc50:: with SMTP id m16mr2524484wrj.329.1588938222913; 
 Fri, 08 May 2020 04:43:42 -0700 (PDT)
MIME-Version: 1.0
References: <1588500367-1056-1-git-send-email-chenhc@lemote.com>
In-Reply-To: <1588500367-1056-1-git-send-email-chenhc@lemote.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Fri, 8 May 2020 13:43:30 +0200
Message-ID: <CAHiYmc4f1N-8mvMEZNcxVP+zbxjp0=OWFQc2pDDssnpmZ6eJig@mail.gmail.com>
Subject: Re: [PATCH V3 00/14] KVM: MIPS: Add Loongson-3 support (Host Side)
To: Huacai Chen <chenhc@lemote.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, kvm@vger.kernel.org,
 Huacai Chen <chenhuacai@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Fuxin Zhang <zhangfx@lemote.com>, Paolo Bonzini <pbonzini@redhat.com>,
 linux-mips@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D0=BD=D0=B5=D0=B4, 3. =D0=BC=D0=B0=D1=98 2020. =D1=83 12:06 Huacai Chen <c=
henhc@lemote.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=
=D0=BB=D0=B0:
>
> We are preparing to add KVM support for Loongson-3. VZ extension is
> fully supported in Loongson-3A R4+, and we will not care about old CPUs
> (at least now). We already have a full functional Linux kernel (based
> on Linux-5.4.x LTS) and QEMU (based on 5.0.0-rc2) and their git
> repositories are here:
>
> QEMU: https://github.com/chenhuacai/qemu
> Kernel: https://github.com/chenhuacai/linux
>
> Of course these two repositories need to be rework and not suitable for
> upstream (especially the commits need to be splitted). We show them here
> is just to tell others what we have done, and how KVM/Loongson will look
> like.
>
> Our plan is make the KVM host side be upstream first, and after that,
> we will make the KVM guest side and QEMU emulator be upstream.
>

Huacei, I absolutely salute this series, as it is, in my opinion, of
tremendous significance not only for Loongson, but also for KVM for
MIPS in general.

As you probably know, James Hogan left KVM for MIPS kernel
maintainership some time ago. It was really too bad, as he was and
still is, from my direct experience, an excellent colleague and
engineer.

KVM for MIPS kernel maintainership left orphaned put me (as the
maintainer for KVM for MIPS in QEMU) in an awkward position.

May I ask that you and me jointly assume KVM for MIPS kernel
maintainership? For me, it makes perfect sense, and I would certainly
enjoy working with you. If you agree, please add such patch at the end
of this series, in its next version.

Yours,
Aleksandar


> V1 -> V2:
> 1, Remove "mips: define pud_index() regardless of page table folding"
>    because it has been applied.
> 2, Make Loongson-specific code be guarded by CONFIG_CPU_LOONGSON64.
>
> V2 -> V3:
> 1, Emulate a reduced feature list of CPUCFG.
> 2, Fix all possible checkpatch.pl errors and warnings.
>
> Xing Li(2):
>  KVM: MIPS: Define KVM_ENTRYHI_ASID to cpu_asid_mask(&boot_cpu_data)
>  KVM: MIPS: Fix VPN2_MASK definition for variable cpu_vmbits
>
> Huacai Chen(12):
>  KVM: MIPS: Increase KVM_MAX_VCPUS and KVM_USER_MEM_SLOTS to 16
>  KVM: MIPS: Add EVENTFD support which is needed by VHOST
>  KVM: MIPS: Use lddir/ldpte instructions to lookup gpa_mm.pgd
>  KVM: MIPS: Introduce and use cpu_guest_has_ldpte
>  KVM: MIPS: Use root tlb to control guest's CCA for Loongson-3
>  KVM: MIPS: Let indexed cacheops cause guest exit on Loongson-3
>  KVM: MIPS: Add more types of virtual interrupts
>  KVM: MIPS: Add Loongson-3 Virtual IPI interrupt support
>  KVM: MIPS: Add CPUCFG emulation for Loongson-3
>  KVM: MIPS: Add CONFIG6 and DIAG registers emulation
>  KVM: MIPS: Add more MMIO load/store instructions emulation
>  KVM: MIPS: Enable KVM support for Loongson-3
>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>  arch/mips/Kconfig                    |   1 +
>  arch/mips/include/asm/cpu-features.h |   3 +
>  arch/mips/include/asm/kvm_host.h     |  52 +++-
>  arch/mips/include/asm/mipsregs.h     |   7 +
>  arch/mips/include/uapi/asm/inst.h    |  11 +
>  arch/mips/kernel/cpu-probe.c         |   2 +
>  arch/mips/kvm/Kconfig                |   1 +
>  arch/mips/kvm/Makefile               |   5 +-
>  arch/mips/kvm/emulate.c              | 503 +++++++++++++++++++++++++++++=
+++++-
>  arch/mips/kvm/entry.c                |  19 +-
>  arch/mips/kvm/interrupt.c            |  93 +------
>  arch/mips/kvm/interrupt.h            |  14 +-
>  arch/mips/kvm/loongson_ipi.c         | 214 +++++++++++++++
>  arch/mips/kvm/mips.c                 |  49 +++-
>  arch/mips/kvm/tlb.c                  |  41 +++
>  arch/mips/kvm/trap_emul.c            |   3 +
>  arch/mips/kvm/vz.c                   | 235 +++++++++++-----
>  17 files changed, 1087 insertions(+), 166 deletions(-)
>  create mode 100644 arch/mips/kvm/loongson_ipi.c
> --
> 2.7.0

