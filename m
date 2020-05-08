Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB92C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 10:10:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDFF920870
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 10:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JE0hxLvY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDFF920870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWzxG-0003GR-1b
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 06:10:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jWzwg-0002Ym-Is
 for qemu-devel@nongnu.org; Fri, 08 May 2020 06:09:30 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33682)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jWzwe-0004mt-G4
 for qemu-devel@nongnu.org; Fri, 08 May 2020 06:09:30 -0400
Received: by mail-wr1-x441.google.com with SMTP id h9so1210543wrt.0
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 03:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=8VKYlrpPH4YRMjE2iFfbycMZkHwOVHse6ZGSGY3uPKY=;
 b=JE0hxLvYsuxWE64dvjF2JUhfJ3IzSYJ9wp7QtA+M/MTuvoK7F98ieiQn8DJeN1eMGU
 GUNKkxeGUEYbCzyAXz+y+STyTh715A2PVe1n3J+XPY/W7K40+JbE/FaZHjjhMQMXggBQ
 +Kgg/FwsVhFvs6PzNlRKyZVIgXF/0kWSWE+WKELLZZymYCc1LjB6M6zTM/MBykl8VeG5
 IepMWO5t0tQEMhDqH3a4NuYN4eF9pL9QNGdodn7C5XsQn236R/CM/YR5od1AbKYtPNY9
 TreG/Z5Mr9dJ1jAfGi+9M9zrbNZc+ToV0+SOeUe5CwDlSg58ACXPwcfw0USieQOcf+XD
 ZiGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=8VKYlrpPH4YRMjE2iFfbycMZkHwOVHse6ZGSGY3uPKY=;
 b=QMhVKYFNrl5T6aAeIFwO3Coj1XgtpNjO20+sh0K4AgfrZQbrJ9xzW7MWa3qIwuXnme
 4M+FGwhNeNcFHLI1oDmfq5uPRIpDF27Sbhyf14p9KxCmDTpeuxOkjkV2oZz0rRwJvRMe
 hBwzrlNgfR3Dn4hlR0aymAf9qtbPc6PDnDYYnTK3C7fxjWkF0zOqqk46EzlmKIDePhs5
 M1k83aRGjFtJMbLMhVuaLV76Gz9291dtwEQ6/DMZ+omuu26k969On8daxvr37U3vN4Gv
 YT0D3lloBOZzSGe/3KYGsPaW++H+OlefiBKY89dLB+gjJ/lyPtJRVJv+keljMgSJxR/w
 yI0A==
X-Gm-Message-State: AGi0PubFEYSRZYnm1CIxEDzjetXfBx8KdL7esm4G7dyGX+CAXop8ucZo
 n9LgzSKQ4ATV5W0ni9mhaRD+SaybWvJCL9RK1gQ=
X-Google-Smtp-Source: APiQypKIhO1+vEDdCLtLXyBrlYKHzVc0jr7QIpvq+o6OY332o917S1E6kc51ietEUOZ8OykjxapWccBATB+XXAm+S6k=
X-Received: by 2002:adf:94a6:: with SMTP id 35mr2036714wrr.420.1588932566539; 
 Fri, 08 May 2020 03:09:26 -0700 (PDT)
MIME-Version: 1.0
References: <1588500367-1056-1-git-send-email-chenhc@lemote.com>
 <1588500367-1056-5-git-send-email-chenhc@lemote.com>
 <CAHiYmc42QJ_XzHxoBKyccocb7sJCn42UtOuQ-2LNCzK=RqkEVQ@mail.gmail.com>
In-Reply-To: <CAHiYmc42QJ_XzHxoBKyccocb7sJCn42UtOuQ-2LNCzK=RqkEVQ@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Fri, 8 May 2020 12:08:56 +0200
Message-ID: <CAHiYmc4VfRG=vYzjNfPBUTcjWngaGo7gJBxLJ5NJKAseh7CrdQ@mail.gmail.com>
Subject: Re: [PATCH V3 04/14] KVM: MIPS: Add EVENTFD support which is needed
 by VHOST
To: Huacai Chen <chenhc@lemote.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x441.google.com
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

=D0=BF=D0=B5=D1=82, 8. =D0=BC=D0=B0=D1=98 2020. =D1=83 11:08 Aleksandar Mar=
kovic
<aleksandar.qemu.devel@gmail.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=
=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> =D0=BD=D0=B5=D0=B4, 3. =D0=BC=D0=B0=D1=98 2020. =D1=83 12:09 Huacai Chen =
<chenhc@lemote.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE=
/=D0=BB=D0=B0:
> >
> > Add EVENTFD support for KVM/MIPS, which is needed by VHOST. Tested on
> > Loongson-3 platform.
> >
> > Signed-off-by: Huacai Chen <chenhc@lemote.com>
> > Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > ---
>
> Perhaps this patch needs rebasing to land cleanly into master.
>

Or, maybe, my tree was out-of-date. Sorry if that was the case.

Yours,
Aleksandar

> But, in general, for what is worth:
>
> Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
>
>
> >  arch/mips/kvm/Kconfig     | 1 +
> >  arch/mips/kvm/Makefile    | 2 +-
> >  arch/mips/kvm/trap_emul.c | 3 +++
> >  arch/mips/kvm/vz.c        | 3 +++
> >  4 files changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/mips/kvm/Kconfig b/arch/mips/kvm/Kconfig
> > index b91d145..d697752 100644
> > --- a/arch/mips/kvm/Kconfig
> > +++ b/arch/mips/kvm/Kconfig
> > @@ -22,6 +22,7 @@ config KVM
> >         select EXPORT_UASM
> >         select PREEMPT_NOTIFIERS
> >         select KVM_GENERIC_DIRTYLOG_READ_PROTECT
> > +       select HAVE_KVM_EVENTFD
> >         select HAVE_KVM_VCPU_ASYNC_IOCTL
> >         select KVM_MMIO
> >         select MMU_NOTIFIER
> > diff --git a/arch/mips/kvm/Makefile b/arch/mips/kvm/Makefile
> > index 01affc1..0a3cef6 100644
> > --- a/arch/mips/kvm/Makefile
> > +++ b/arch/mips/kvm/Makefile
> > @@ -2,7 +2,7 @@
> >  # Makefile for KVM support for MIPS
> >  #
> >
> > -common-objs-y =3D $(addprefix ../../../virt/kvm/, kvm_main.o coalesced=
_mmio.o)
> > +common-objs-y =3D $(addprefix ../../../virt/kvm/, kvm_main.o coalesced=
_mmio.o eventfd.o)
> >
> >  EXTRA_CFLAGS +=3D -Ivirt/kvm -Iarch/mips/kvm
> >
> > diff --git a/arch/mips/kvm/trap_emul.c b/arch/mips/kvm/trap_emul.c
> > index 5a11e83..f464506b 100644
> > --- a/arch/mips/kvm/trap_emul.c
> > +++ b/arch/mips/kvm/trap_emul.c
> > @@ -529,6 +529,9 @@ static int kvm_trap_emul_check_extension(struct kvm=
 *kvm, long ext)
> >         case KVM_CAP_MIPS_TE:
> >                 r =3D 1;
> >                 break;
> > +       case KVM_CAP_IOEVENTFD:
> > +               r =3D 1;
> > +               break;
> >         default:
> >                 r =3D 0;
> >                 break;
> > diff --git a/arch/mips/kvm/vz.c b/arch/mips/kvm/vz.c
> > index dde2088..17932ab 100644
> > --- a/arch/mips/kvm/vz.c
> > +++ b/arch/mips/kvm/vz.c
> > @@ -2927,6 +2927,9 @@ static int kvm_vz_check_extension(struct kvm *kvm=
, long ext)
> >                 r =3D 2;
> >                 break;
> >  #endif
> > +       case KVM_CAP_IOEVENTFD:
> > +               r =3D 1;
> > +               break;
> >         default:
> >                 r =3D 0;
> >                 break;
> > --
> > 2.7.0
> >

