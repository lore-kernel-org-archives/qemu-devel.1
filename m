Received: from eggs.gnu.org ([2001:4830:134:3::10]:52145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fa3Ww-00030c-Ud
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 14:26:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fa3Wt-0003NQ-0F
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 14:26:30 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:44031)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fa3Ws-0003N9-Px
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 14:26:26 -0400
Received: by mail-qt0-x243.google.com with SMTP id f18-v6so2378014qtp.10
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 11:26:26 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180702175030.18621-1-f4bug@amsat.org>
	<20180702175030.18621-4-f4bug@amsat.org>
	<0c70f743-6c0b-73c2-943e-74ed3caece2d@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5f2ca177-234c-4cf2-c111-c1fe26292cbf@amsat.org>
Date: Mon, 2 Jul 2018 15:26:21 -0300
MIME-Version: 1.0
In-Reply-To: <0c70f743-6c0b-73c2-943e-74ed3caece2d@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 03/13] linux-user/strace: Display
 invalid pointer in print_timeval()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>

On 07/02/2018 03:18 PM, Laurent Vivier wrote:
> Le 02/07/2018 à 19:50, Philippe Mathieu-Daudé a écrit :
>> Suggested-by: Laurent Vivier <laurent@vivier.eu>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  linux-user/strace.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/linux-user/strace.c b/linux-user/strace.c
>> index bd897a3f20..311e63ef75 100644
>> --- a/linux-user/strace.c
>> +++ b/linux-user/strace.c
>> @@ -1173,8 +1173,10 @@ print_timeval(abi_ulong tv_addr, int last)
>>          struct target_timeval *tv;
>>  
>>          tv = lock_user(VERIFY_READ, tv_addr, sizeof(*tv), 1);
>> -        if (!tv)
>> +        if (!tv) {
>> +            print_pointer(tv, last);
> 
> tv is NULL here. we want to print the value of tv_addr.

Oops sorry I need to keep focused!
