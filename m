Received: from eggs.gnu.org ([2001:4830:134:3::10]:50910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dVNyS-0003Di-54
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 16:11:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dVNyO-0005B3-6U
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 16:11:04 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:34160)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dVNyO-0005Aq-2O
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 16:11:00 -0400
Received: by mail-qt0-x244.google.com with SMTP id m54so3520791qtb.1
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 13:11:00 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <CGME20170712134924eucas1p128160f1573036dd5293f9167e190e9f8@eucas1p1.samsung.com>
	<001d01d2fb15$ab737040$025a50c0$@samsung.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <df3c868e-d4a3-cc52-4231-c3ea7c3d2329@twiddle.net>
Date: Wed, 12 Jul 2017 10:10:54 -1000
MIME-Version: 1.0
In-Reply-To: <001d01d2fb15$ab737040$025a50c0$@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] tcg/tci: Remove unnecessary TODO() for
 INDEX_op_bswap16_i64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jaroslaw Pelczar <j.pelczar@samsung.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 07/12/2017 03:49 AM, Jaroslaw Pelczar wrote:
> @@ -1046,7 +1046,6 @@ uintptr_t tcg_qemu_tb_exec(CPUArchState *env, uint8_t
> *tb_ptr)
> 
>               break;
> 
> #if TCG_TARGET_HAS_bswap16_i64
> 
>           case INDEX_op_bswap16_i64:
> 
> -            TODO();
> 
>               t0 = *tb_ptr++;
> 
>               t1 = tci_read_r16(&tb_ptr);
> 
>               tci_write_reg64(t0, bswap16(t1));

An identical patch has already been submitted

   https://patchwork.ozlabs.org/patch/774278/

and it is (now) waiting in the tcg-next queue.


r~
