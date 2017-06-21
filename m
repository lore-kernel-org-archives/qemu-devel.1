Received: from eggs.gnu.org ([2001:4830:134:3::10]:56051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dNhxj-0000xs-0a
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 11:54:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dNhxf-00089q-2g
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 11:54:35 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:35448)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dNhxe-00088z-Ur
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 11:54:31 -0400
Received: by mail-qk0-x244.google.com with SMTP id 16so10923046qkg.2
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 08:54:29 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170620205121.26515-1-laurent@vivier.eu>
	<20170620205121.26515-2-laurent@vivier.eu>
	<22b78092-4929-b51e-8e57-47ccb6cefc29@twiddle.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c0fc1c50-6ee5-7515-2f83-762e785d32e6@amsat.org>
Date: Wed, 21 Jun 2017 12:54:24 -0300
MIME-Version: 1.0
In-Reply-To: <22b78092-4929-b51e-8e57-47ccb6cefc29@twiddle.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 1/6] target-m68k: move fmove CR to a
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Thomas Huth <huth@tuxfamily.org>, Aurelien Jarno <aurelien@aurel32.net>

On 06/20/2017 07:50 PM, Richard Henderson wrote:
> On 06/20/2017 01:51 PM, Laurent Vivier wrote:
>> Move code of fmove to/from control register to a function
>>
>> Signed-off-by: Laurent Vivier<laurent@vivier.eu>
>> ---
>>   target/m68k/translate.c | 56
>> +++++++++++++++++++++++++++----------------------
>>   1 file changed, 31 insertions(+), 25 deletions(-)
>
> Reviewed-by: Richard Henderson <rth@twiddle.net>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>
>
> r~
>
