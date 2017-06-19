Received: from eggs.gnu.org ([2001:4830:134:3::10]:36552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dN4ZU-0001bD-10
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 17:50:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dN4ZQ-00020A-1l
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 17:50:56 -0400
Received: from mail-qk0-x231.google.com ([2607:f8b0:400d:c09::231]:35069)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dN4ZP-0001zw-SJ
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 17:50:51 -0400
Received: by mail-qk0-x231.google.com with SMTP id a199so44265035qkb.2
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 14:50:51 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1497468113-2874-1-git-send-email-thuth@redhat.com>
	<1497468113-2874-3-git-send-email-thuth@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <d650f166-c561-c7c9-07aa-eff38ca831ae@twiddle.net>
Date: Mon, 19 Jun 2017 14:50:48 -0700
MIME-Version: 1.0
In-Reply-To: <1497468113-2874-3-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/4] include/exec/poison: Mark some CONFIG
 defines as poisoned, too
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On 06/14/2017 12:21 PM, Thomas Huth wrote:
> +#pragma GCC poison CONFIG_ALPHA_DIS
> +#pragma GCC poison CONFIG_ARM_A64_DIS
> +#pragma GCC poison CONFIG_ARM_DIS
> +#pragma GCC poison CONFIG_CRIS_DIS
> +#pragma GCC poison CONFIG_I386_DIS
> +#pragma GCC poison CONFIG_LM32_DIS
> +#pragma GCC poison CONFIG_M68K_DIS
> +#pragma GCC poison CONFIG_MICROBLAZE_DIS
> +#pragma GCC poison CONFIG_MIPS_DIS
> +#pragma GCC poison CONFIG_MOXIE_DIS
> +#pragma GCC poison CONFIG_NIOS2_DIS
> +#pragma GCC poison CONFIG_PPC_DIS
> +#pragma GCC poison CONFIG_S390_DIS
> +#pragma GCC poison CONFIG_SH4_DIS
> +#pragma GCC poison CONFIG_SPARC_DIS
> +#pragma GCC poison CONFIG_XTENSA_DIS

Also missing a couple.


r~
