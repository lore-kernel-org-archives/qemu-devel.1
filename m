Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30087C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 01:32:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 860062223C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 01:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pEITa1WV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 860062223C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGBRt-0007Lo-HE
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 21:32:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenhuacai@gmail.com>)
 id 1kGBR1-0006uh-C1
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 21:31:35 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:42582)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chenhuacai@gmail.com>)
 id 1kGBQz-0004e6-Li
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 21:31:35 -0400
Received: by mail-io1-xd42.google.com with SMTP id u6so5320626iow.9
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 18:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yyFeP2mu1m5EwFOImA/VQ+H/aID62eJ3G/P8GqJBJ4I=;
 b=pEITa1WV8W5ZORXpCTYz+Iy+OCoOtkEBEAI/I4F0g6YHjfmMSVOHSCsbGeZoxmHZ7h
 84F8NtEHZKYvgTlQWeHwe3989ra5LoTIYBT0IWxlvYj+ErfV2OhQ7IzDwb32LWDFGaCq
 QlGO+cz1yfyY+7rEWR619HECS1aLzFjP8o96LXvCsslTyaWB7r5YS84K/x0VQwmx1aqM
 S3PzXbCjzDi4i1tF4Jr3qTtDNApfvWomlE9VpFaoVxagDGDL32e51z5KYxolmuwfifBH
 10YiJrYKcciWN/SSAaAYB7l9pIvA4423HXs5LwI16jZVgfWMcI2v82KJbR3YPVSNMBTo
 W0Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yyFeP2mu1m5EwFOImA/VQ+H/aID62eJ3G/P8GqJBJ4I=;
 b=OAekirJfRJRJZTp2ys3+RsiE+0FYgOjyWf0Hw5dTXg77wC4f2GovMPDy/qlWVAmpgD
 pOUStyja4q0rienLjE2GJYJy3N1T2yZy+JFk6RektQj3cSLuF3EleIH0Q1RPD6BdAkdx
 iSskTl/sPT8jIEJPW9nnrAJbDG5QpIaIV9TlBh96rItI0UnseUq9tkd21a27mrQS7SfS
 7LEDGh/MPmrDs9JvAE9U6a8cJjG0jf26evMTNI9edd06MBoe0/5CK2PESYu6rCahiskn
 wvXFQyS1Lg3sLyLB9lW+d4dXu6MEHjCEPebGXv3v2Y03QW+RL11Kt6gsKaR+hOyR9T8i
 9sGA==
X-Gm-Message-State: AOAM531ionZ89MubDZqMIqMUIxRKz5NDHDGAlWwnouwq/RgMBGn4TOsx
 HCc/SaH0lhdlrujwRJp4tagUiBxd+3DP8+g0ck4=
X-Google-Smtp-Source: ABdhPJzbPY0iC60eK8v2Z0ViwM5aeljKFNEkgjJW/p4vUkKCZH4cHTylSzGk2GY66pv6iN3yrOvuD5m45dD209gvPWg=
X-Received: by 2002:a02:950e:: with SMTP id y14mr6781323jah.106.1599701491975; 
 Wed, 09 Sep 2020 18:31:31 -0700 (PDT)
MIME-Version: 1.0
References: <1598256668-12131-1-git-send-email-chenhc@lemote.com>
 <caa3c014-ba68-0875-4dd5-faed9282ca95@redhat.com>
 <CABDp7VoRCMsW6b17XEek3-EJLHgY=bCXnx5B1ZWCOkHq0aasxw@mail.gmail.com>
 <e3c09cb0-1cc5-2fb3-8dc7-d2a1aed74c04@redhat.com>
In-Reply-To: <e3c09cb0-1cc5-2fb3-8dc7-d2a1aed74c04@redhat.com>
From: Huacai Chen <chenhuacai@gmail.com>
Date: Thu, 10 Sep 2020 09:31:20 +0800
Message-ID: <CAAhV-H5W-YbooF5W0KgEFGe-qkCstt4_PKjR2JNkh3sZXRxRdg@mail.gmail.com>
Subject: Re: [PATCH V2 for-5.2] hw/null-machine: Add the kvm_type() hook for
 MIPS
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d42;
 envelope-from=chenhuacai@gmail.com; helo=mail-io1-xd42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, chen huacai <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 qemu-level <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Gibson <dgibson@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, Thomas,

On Wed, Sep 9, 2020 at 3:20 PM Thomas Huth <thuth@redhat.com> wrote:
>
> On 09/09/2020 04.57, chen huacai wrote:
> > Hi, all,
> >
> > On Wed, Sep 9, 2020 at 1:25 AM Thomas Huth <thuth@redhat.com> wrote:
> >>
> >> On 24/08/2020 10.11, Huacai Chen wrote:
> >>> MIPS has two types of KVM: TE & VZ, and TE is the default type. Now,
> >>> libvirt uses a null-machine to detect the kvm capability. In the MIPS
> >>> case, it will return "KVM not supported" on a VZ platform by default.
> >>> So, add the kvm_type() hook to the null-machine.
> >>>
> >>> This seems not a very good solution, but I cannot do it better now.
> >>
> >> This is still ugly. Why do the other architectures do not have the
> >> same problem? Let's see... in kvm-all.c, we have:
> >>
> >>     int type = 0;
> >>     [...]
> >>     kvm_type = qemu_opt_get(qemu_get_machine_opts(), "kvm-type");
> >>     if (mc->kvm_type) {
> >>         type = mc->kvm_type(ms, kvm_type);
> >>     } else if (kvm_type) {
> >>         ret = -EINVAL;
> >>         fprintf(stderr, "Invalid argument kvm-type=%s\n", kvm_type);
> >>         goto err;
> >>     }
> >>
> >>     do {
> >>         ret = kvm_ioctl(s, KVM_CREATE_VM, type);
> >>     } while (ret == -EINTR);
> >>
> >> Thus the KVM_CREATE_VM ioctl is likely called with type = 0 in this
> >> case (i.e. when libvirt probes with the "null"-machine).
> >>
> >> Now let's have a look at the kernel. The "type" parameter is passed
> >> there to the architecture specific function kvm_arch_init_vm().
> >> For powerpc, this looks like:
> >>
> >>         if (type == 0) {
> >>                 if (kvmppc_hv_ops)
> >>                         kvm_ops = kvmppc_hv_ops;
> >>                 else
> >>                         kvm_ops = kvmppc_pr_ops;
> >>                 if (!kvm_ops)
> >>                         goto err_out;
> >>         } else  if (type == KVM_VM_PPC_HV) {
> >>                 if (!kvmppc_hv_ops)
> >>                         goto err_out;
> >>                 kvm_ops = kvmppc_hv_ops;
> >>         } else if (type == KVM_VM_PPC_PR) {
> >>                 if (!kvmppc_pr_ops)
> >>                         goto err_out;
> >>                 kvm_ops = kvmppc_pr_ops;
> >>         } else
> >>                 goto err_out;
> >>
> >> That means for type == 0, it automatically detects the best
> >> kvm-type.
> >>
> >> For mips, this function looks like this:
> >>
> >>         switch (type) {
> >> #ifdef CONFIG_KVM_MIPS_VZ
> >>         case KVM_VM_MIPS_VZ:
> >> #else
> >>         case KVM_VM_MIPS_TE:
> >> #endif
> >>                 break;
> >>         default:
> >>                 /* Unsupported KVM type */
> >>                 return -EINVAL;
> >>         };
> >>
> >> That means, for type == 0, it returns -EINVAL here!
> >>
> >> Looking at the API docu in Documentation/virt/kvm/api.rst
> >> the description of the type parameter is quite sparse, but it
> >> says:
> >>
> >>  "You probably want to use 0 as machine type."
> >>
> >> So I think this is a bug in the implementation of KVM in the
> >> mips kernel code. The kvm_arch_init_vm() in the mips code should
> >> do the same as on powerpc, and use the best available KVM type
> >> there instead of returning EINVAL. Once that is fixed there,
> >> you don't need this patch here for QEMU anymore.
> > Yes, PPC use a good method, because it can use 0 as "automatic"
> > #define KVM_VM_PPC_HV 1
> > #define KVM_VM_PPC_PR 2
> >
> > Unfortunately, MIPS cannot do like this because it define 0 as "TE":
> > #define KVM_VM_MIPS_TE          0
> > #define KVM_VM_MIPS_VZ          1
> >
> > So, it cannot be solved in kernel side, unless changing the definition
> > of TE/VZ, but I think changing their definition is also unacceptable.
>
> Ouch, ok, now I understood the problem. That sounds like a really bad
> decision on the kernel side.
>
> But I think you could at least try to get it fixed on the kernel side:
> Propose a patch to rename KVM_VM_MIPS_TE to KVM_VM_MIPS_DEFAULT and use
> 2 as new value for TE. The code that handles the default 0 case should
> then prefer TE over VZ, so that old userspace applications that provide
> 0 will continue to work as they did before, so I hope that the change is
> acceptable by the kernel folks. You should add a remark to the patch
> description that 0 is the established default value for probing in the
> QEMU/libvirt stack and that your patch is required on the kernel side to
> avoid ugly hacks in QEMU userspace code.
>
> If they still reject your patch, I guess we have to bite the bullet and
> add your patch here...
OK, let me try.

Huacai
>
> Thanks,
>  Thomas
>

