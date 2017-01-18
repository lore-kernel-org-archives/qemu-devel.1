Received: from eggs.gnu.org ([2001:4830:134:3::10]:47435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cTwSl-00086U-Q4
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 15:04:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cTwSl-0002KQ-4P
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 15:04:08 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:33868)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1cTwSk-0002Jc-VI
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 15:04:07 -0500
Received: by mail-ot0-x244.google.com with SMTP id 73so2211590otj.1
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 12:04:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <7a6dc301-1e55-48f8-5d28-7562562c98c6@vivier.eu>
References: <20170118192428.2661-1-bobby.prani@gmail.com>
	<7a6dc301-1e55-48f8-5d28-7562562c98c6@vivier.eu>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Wed, 18 Jan 2017 15:03:35 -0500
Message-ID: <CAJhHMCC-2eL9u_HXrxok6vRiA=JuKEgf-sNbB0b7mk0k3ky2Tw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/2] linux-user: fix settime old value
 location
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-devel <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>

On Wed, Jan 18, 2017 at 2:59 PM, Laurent Vivier <laurent@vivier.eu> wrote:
> Le 18/01/2017 =C3=A0 20:24, Pranith Kumar a =C3=A9crit :
>> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>
>> old_value is the 4th argument of timer_settime(), not the 2nd.
>>
>> CC: Laurent Vivier <laurent@vivier.eu>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> [pranith: review comments]
>> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
>> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  linux-user/syscall.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>> index 7b77503f94..724607be43 100644
>> --- a/linux-user/syscall.c
>> +++ b/linux-user/syscall.c
>> @@ -12027,7 +12027,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_=
long arg1,
>>              target_to_host_itimerspec(&hspec_new, arg3);
>
> as said by Peter in his first comment, target_to_host_itimerspec() can
> return -TARGET_EFAULT. You should fix that too.

Hmm, shoddy job by me. I missed his comments from the first time. Will fix =
them.

Thanks,
--=20
Pranith
