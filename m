Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C218C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 17:26:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8590B20738
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 17:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eyiYAUQ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8590B20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFhOP-00016T-L0
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 13:26:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kFhNW-0000bs-Ko
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 13:25:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57944
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kFhNU-0008J3-9y
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 13:25:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599585955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6WjMnrl1+3+CXF/ihW6mU4aH+so1wzZfL2R1qSHXayk=;
 b=eyiYAUQ8Q+q2+CKL1gQl0/6N/eSD6jibvo5RIvmjtOM8rb0LwTW07+TgST7pkNbn6X9zKz
 ZXGh9rJoJd4az7gSGGhY3+NN9JnQnAvk3HW83ZH9PPPuHrHLz7jYu+ERVRHc8qiYpTdV6J
 5yVJM+LhDtQwUELdaG2Xnfh7YCS27hk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-kJ1mTR3DOl2z5eya63Tidw-1; Tue, 08 Sep 2020 13:25:53 -0400
X-MC-Unique: kJ1mTR3DOl2z5eya63Tidw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9220100A605;
 Tue,  8 Sep 2020 17:25:51 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-131.ams2.redhat.com [10.36.112.131])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9242F10013C4;
 Tue,  8 Sep 2020 17:25:48 +0000 (UTC)
Subject: Re: [PATCH V2 for-5.2] hw/null-machine: Add the kvm_type() hook for
 MIPS
To: Huacai Chen <zltjiangshi@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
References: <1598256668-12131-1-git-send-email-chenhc@lemote.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <caa3c014-ba68-0875-4dd5-faed9282ca95@redhat.com>
Date: Tue, 8 Sep 2020 19:25:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1598256668-12131-1-git-send-email-chenhc@lemote.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 02:10:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.626, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Huacai Chen <chenhuacai@gmail.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, David Gibson <dgibson@redhat.com>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/08/2020 10.11, Huacai Chen wrote:
> MIPS has two types of KVM: TE & VZ, and TE is the default type. Now,
> libvirt uses a null-machine to detect the kvm capability. In the MIPS
> case, it will return "KVM not supported" on a VZ platform by default.
> So, add the kvm_type() hook to the null-machine.
> 
> This seems not a very good solution, but I cannot do it better now.

This is still ugly. Why do the other architectures do not have the
same problem? Let's see... in kvm-all.c, we have:

    int type = 0;
    [...]
    kvm_type = qemu_opt_get(qemu_get_machine_opts(), "kvm-type");
    if (mc->kvm_type) {
        type = mc->kvm_type(ms, kvm_type);
    } else if (kvm_type) {
        ret = -EINVAL;
        fprintf(stderr, "Invalid argument kvm-type=%s\n", kvm_type);
        goto err;
    }

    do {
        ret = kvm_ioctl(s, KVM_CREATE_VM, type);
    } while (ret == -EINTR);

Thus the KVM_CREATE_VM ioctl is likely called with type = 0 in this
case (i.e. when libvirt probes with the "null"-machine).

Now let's have a look at the kernel. The "type" parameter is passed
there to the architecture specific function kvm_arch_init_vm().
For powerpc, this looks like:

	if (type == 0) {
		if (kvmppc_hv_ops)
			kvm_ops = kvmppc_hv_ops;
		else
			kvm_ops = kvmppc_pr_ops;
		if (!kvm_ops)
			goto err_out;
	} else	if (type == KVM_VM_PPC_HV) {
		if (!kvmppc_hv_ops)
			goto err_out;
		kvm_ops = kvmppc_hv_ops;
	} else if (type == KVM_VM_PPC_PR) {
		if (!kvmppc_pr_ops)
			goto err_out;
		kvm_ops = kvmppc_pr_ops;
	} else
		goto err_out;

That means for type == 0, it automatically detects the best
kvm-type.

For mips, this function looks like this:

	switch (type) {
#ifdef CONFIG_KVM_MIPS_VZ
	case KVM_VM_MIPS_VZ:
#else
	case KVM_VM_MIPS_TE:
#endif
		break;
	default:
		/* Unsupported KVM type */
		return -EINVAL;
	};

That means, for type == 0, it returns -EINVAL here!

Looking at the API docu in Documentation/virt/kvm/api.rst
the description of the type parameter is quite sparse, but it
says:

 "You probably want to use 0 as machine type."

So I think this is a bug in the implementation of KVM in the
mips kernel code. The kvm_arch_init_vm() in the mips code should
do the same as on powerpc, and use the best available KVM type
there instead of returning EINVAL. Once that is fixed there,
you don't need this patch here for QEMU anymore.

 HTH,
  Thomas


> Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  hw/core/meson.build    | 2 +-
>  hw/core/null-machine.c | 6 ++++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/core/meson.build b/hw/core/meson.build
> index fc91f98..b6591b9 100644
> --- a/hw/core/meson.build
> +++ b/hw/core/meson.build
> @@ -35,7 +35,6 @@ softmmu_ss.add(files(
>    'machine-hmp-cmds.c',
>    'machine.c',
>    'nmi.c',
> -  'null-machine.c',
>    'qdev-fw.c',
>    'qdev-properties-system.c',
>    'sysbus.c',
> @@ -45,5 +44,6 @@ softmmu_ss.add(files(
>  
>  specific_ss.add(when: 'CONFIG_SOFTMMU', if_true: files(
>    'machine-qmp-cmds.c',
> +  'null-machine.c',
>    'numa.c',
>  ))
> diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
> index 7e69352..4b4ab76 100644
> --- a/hw/core/null-machine.c
> +++ b/hw/core/null-machine.c
> @@ -17,6 +17,9 @@
>  #include "sysemu/sysemu.h"
>  #include "exec/address-spaces.h"
>  #include "hw/core/cpu.h"
> +#ifdef TARGET_MIPS
> +#include "kvm_mips.h"
> +#endif
>  
>  static void machine_none_init(MachineState *mch)
>  {
> @@ -55,6 +58,9 @@ static void machine_none_machine_init(MachineClass *mc)
>      mc->no_floppy = 1;
>      mc->no_cdrom = 1;
>      mc->no_sdcard = 1;
> +#ifdef TARGET_MIPS
> +    mc->kvm_type = mips_kvm_type;
> +#endif
>  }
>  
>  DEFINE_MACHINE("none", machine_none_machine_init)
> 


