Received: from eggs.gnu.org ([2001:4830:134:3::10]:54321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cdFTu-0006vm-FE
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 07:11:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cdFTq-00031I-GK
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 07:11:46 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:34754)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cdFTq-000315-AN
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 07:11:42 -0500
Received: by mail-wm0-x242.google.com with SMTP id c85so19121098wmi.1
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 04:11:42 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1486969742-16539-1-git-send-email-den@openvz.org>
	<1486969742-16539-2-git-send-email-den@openvz.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0c681e39-ba65-0e7f-b14a-920d772f3c25@redhat.com>
Date: Mon, 13 Feb 2017 13:11:39 +0100
MIME-Version: 1.0
In-Reply-To: <1486969742-16539-2-git-send-email-den@openvz.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/3] i386/cpu: add crash-information QOM
 property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>



On 13/02/2017 08:09, Denis V. Lunev wrote:
> +void kvm_arch_save_crash_info(CPUState *cpu);
>  #endif
> diff --git a/kvm-all.c b/kvm-all.c
> index a27c880..abfe92d 100644
> --- a/kvm-all.c
> +++ b/kvm-all.c
> @@ -2000,6 +2000,7 @@ int kvm_cpu_exec(CPUState *cpu)
>                  ret = EXCP_INTERRUPT;
>                  break;
>              case KVM_SYSTEM_EVENT_CRASH:
> +                kvm_arch_save_crash_info(cpu);

Would it work to use

    kvm_cpu_synchronize_state(cpu);

instead?

Thanks,

Paolo
