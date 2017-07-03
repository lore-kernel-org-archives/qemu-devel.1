Received: from eggs.gnu.org ([2001:4830:134:3::10]:59273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dS7ji-00020N-Ol
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 16:14:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dS7jh-0000lp-Sh
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 16:14:22 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:35725)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dS7jh-0000li-P2
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 16:14:21 -0400
Received: by mail-qt0-x241.google.com with SMTP id w12so24754943qta.2
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 13:14:21 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1499099693-22903-1-git-send-email-pbonzini@redhat.com>
	<1499099693-22903-19-git-send-email-pbonzini@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <0d634c91-df90-3513-b77a-cae63903dfce@twiddle.net>
Date: Mon, 3 Jul 2017 13:14:16 -0700
MIME-Version: 1.0
In-Reply-To: <1499099693-22903-19-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 18/22] target/i386: split cpu_set_mxcsr()
 and make cpu_set_fpuc() inline
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
> +static inline void cpu_set_mxcsr(CPUX86State *env, uint32_t mxcsr)
> +{
> +    env->mxcsr = mxcsr;
> +    if (tcg_enabled()) {
> +        tcg_update_mxcsr(env);

I'd prefer update_mxcsr_status for this new name.

> +    }
> +}
> +
> +static inline void cpu_set_fpuc(CPUX86State *env, uint16_t fpuc)
> +{
> +     env->fpuc = fpuc;
> +     if (tcg_enabled()) {
> +        update_fp_status(env);
> +     }
> +}

to match this, and to avoid the implication that it's a function in tcg/.


r~
