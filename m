Received: from eggs.gnu.org ([2001:4830:134:3::10]:46964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1chPdt-000586-AB
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 18:51:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1chPdq-0006Mx-7J
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 18:51:17 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:34204)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1chPdq-0006Ma-1d
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 18:51:14 -0500
Received: by mail-pg0-x241.google.com with SMTP id s67so4725168pgb.1
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 15:51:13 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170224135045.10613-1-mbenes@suse.cz>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <d9d4d2c5-bede-6ea6-81cf-c2eaa2fccbd5@twiddle.net>
Date: Sat, 25 Feb 2017 10:51:06 +1100
MIME-Version: 1.0
In-Reply-To: <20170224135045.10613-1-mbenes@suse.cz>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target-s390x: Implement lpp instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Miroslav Benes <mbenes@suse.cz>, agraf@suse.de
Cc: qemu-devel@nongnu.org, mmarek@suse.com, ebischoff@suse.com

On 02/25/2017 12:50 AM, Miroslav Benes wrote:
> Linux arch/s390/kernel/head(64).S uses lpp instruction if it is
> available in facilities list provided by stfl/stfle instruction. This is
> the case of newer z/System generations and their qemu definition.
>
> Signed-off-by: Miroslav Benes <mbenes@suse.cz>
> ---

I can't find LPP in my PoO 11th edition...

> +static ExitStatus op_lpp(DisasContext *s, DisasOps *o)
> +{
> +    check_privileged(s);
> +    potential_page_fault(s);
> +
> +    tcg_gen_st_i64(o->in2, cpu_env, offsetof(CPUS390XState, pp));

But you don't need the potential_page_fault, since this is not a store to guest 
memory.


r~
