Received: from eggs.gnu.org ([2001:4830:134:3::10]:58494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dS7hS-0008Ld-75
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 16:12:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dS7hP-0007OO-0S
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 16:12:02 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:35844)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dS7hO-0007Nm-Rr
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 16:11:58 -0400
Received: by mail-qk0-x242.google.com with SMTP id v143so12508200qkb.3
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 13:11:58 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1499099693-22903-1-git-send-email-pbonzini@redhat.com>
	<1499099693-22903-17-git-send-email-pbonzini@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <41a48910-cc1e-e0ba-44a7-d0a62326b591@twiddle.net>
Date: Mon, 3 Jul 2017 13:11:53 -0700
MIME-Version: 1.0
In-Reply-To: <1499099693-22903-17-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 16/22] target/i386: move
 cpu_sync_bndcs_hflags() function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, anthony.xu@intel.com, berrange@redhat.com, a.rigo@virtualopensystems.com, yang.zhong@intel.com

On 07/03/2017 09:34 AM, Paolo Bonzini wrote:
> @@ -1302,10 +1332,12 @@ void cpu_report_tpr_access(CPUX86State *env, TPRAccess access)
>           env->tpr_access_type = access;
>   
>           cpu_interrupt(cs, CPU_INTERRUPT_TPR);
> -    } else {
> +    } else if (tcg_enabled()) {
>           cpu_restore_state(cs, cs->mem_io_pc);
>   
>           apic_handle_tpr_access_report(cpu->apic_state, env->eip, access);
> +    } else {
> +        abort();
>       }
>   }
>   #endif /* !CONFIG_USER_ONLY */

This hunk belongs in another patch.


r~
