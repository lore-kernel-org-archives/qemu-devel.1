Received: from eggs.gnu.org ([2001:4830:134:3::10]:33229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ceArH-0004o4-Jg
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 20:27:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ceArG-00025X-UA
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 20:27:43 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:32957)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ceArG-000258-NB
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 20:27:42 -0500
Received: by mail-pf0-x243.google.com with SMTP id e4so275473pfg.0
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 17:27:42 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170207005930.28327-1-laurent@vivier.eu>
	<20170207005930.28327-11-laurent@vivier.eu>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <13c239f3-f601-a3a2-c146-fb973373b37b@twiddle.net>
Date: Thu, 16 Feb 2017 12:27:32 +1100
MIME-Version: 1.0
In-Reply-To: <20170207005930.28327-11-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 10/16] target-m68k: add fscc.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>

On 02/07/2017 11:59 AM, Laurent Vivier wrote:
> +    addr = tcg_temp_local_new();
> +    tcg_gen_mov_i32(addr, taddr);
> +    l1 = gen_new_label();
> +    l2 = gen_new_label();
> +    gen_fjmpcc(s, ext & 0x3f, l1);
> +    gen_store(s, OS_BYTE, addr, tcg_const_i32(0x00));
> +    tcg_gen_br(l2);
> +    gen_set_label(l1);
> +    gen_store(s, OS_BYTE, addr, tcg_const_i32(0xff));
> +    gen_set_label(l2);
> +    tcg_temp_free(addr);

Use tcg_gen_setcond, like in scc.

> +    l1 = gen_new_label();
> +    tcg_gen_ori_i32(reg, reg, 0x000000ff);
> +    gen_fjmpcc(s, ext & 0x3f, l1);
> +    tcg_gen_andi_i32(reg, reg, 0xffffff00);
> +    gen_set_label(l1);

Likewise.


r~
