Received: from eggs.gnu.org ([2001:4830:134:3::10]:56421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d8PNT-0007jr-2X
	for qemu-devel@nongnu.org; Wed, 10 May 2017 07:01:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d8PNQ-00007S-0J
	for qemu-devel@nongnu.org; Wed, 10 May 2017 07:01:55 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:35938)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d8PNP-00007O-SD
	for qemu-devel@nongnu.org; Wed, 10 May 2017 07:01:51 -0400
Received: by mail-qk0-x242.google.com with SMTP id y128so4077687qka.3
	for <qemu-devel@nongnu.org>; Wed, 10 May 2017 04:01:51 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170506111431.12548-1-aurelien@aurel32.net>
	<20170506111431.12548-10-aurelien@aurel32.net>
	<a98c67f8-3c5c-b68d-beea-f1972bb3dc0d@twiddle.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <30148bda-68e9-b4a6-bb16-5df52157c644@amsat.org>
Date: Wed, 10 May 2017 08:01:48 -0300
MIME-Version: 1.0
In-Reply-To: <a98c67f8-3c5c-b68d-beea-f1972bb3dc0d@twiddle.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 09/14] target/sh4: optimize
 gen_store_fpr64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org

On 05/09/2017 06:09 PM, Richard Henderson wrote:
> On 05/06/2017 04:14 AM, Aurelien Jarno wrote:
>> +    tcg_gen_extrl_i64_i32(cpu_fregs[reg + 1], t);
>> +    tcg_gen_extrh_i64_i32(cpu_fregs[reg], t);
>
> This is
>
>   tcg_gen_extr_i64_i32(cpu_fregs[reg + 1], cpu_fregs[reg], t);

nicer :)

>
> Otherwise,
>
> Reviewed-by: Richard Henderson <rth@twiddle.net>
>
>
> r~
>
