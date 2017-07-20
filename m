Received: from eggs.gnu.org ([2001:4830:134:3::10]:33623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dY6eq-0004RE-UK
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 04:18:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dY6el-0000Zj-Uj
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 04:18:04 -0400
Received: from mail-qk0-x22a.google.com ([2607:f8b0:400d:c09::22a]:36331)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dY6el-0000ZK-P5
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 04:17:59 -0400
Received: by mail-qk0-x22a.google.com with SMTP id d136so10799061qkg.3
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 01:17:59 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500520169-23367-1-git-send-email-cota@braap.org>
	<1500520169-23367-44-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <be258abb-5f47-6d6b-3a2d-ac964b0c382d@twiddle.net>
Date: Wed, 19 Jul 2017 22:17:53 -1000
MIME-Version: 1.0
In-Reply-To: <1500520169-23367-44-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 43/43] tcg: enable multiple TCG contexts
 in softmmu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org

On 07/19/2017 05:09 PM, Emilio G. Cota wrote:
> +#ifdef CONFIG_SOFTMMU
> +/*
> + * It is likely that some vCPUs will translate more code than others, so we
> + * first try to set more regions than smp_cpus, with those regions being of
> + * reasonable size. If that's not possible we make do by evenly dividing
> + * the code_gen_buffer among the vCPUs.
> + */
> +static size_t tcg_n_regions(void)

Use #ifdef CONFIG_USER_ONLY here.

In the back of your mind, please remove the SOFTMMU == !USER_ONLY equality that 
tends to pervade the code base at present.

At some point in the (distant) future I want to be able to enable SOFTMMU for 
USER_ONLY.  There is *lots* that doesn't work when the host page size != guest 
page size.  Which is becoming more and more common (on non-x86) as enterprise 
operating systems enable 64k pages.

Otherwise,

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
