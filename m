Received: from eggs.gnu.org ([2001:4830:134:3::10]:34938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cUESf-0007jI-66
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 10:17:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cUESe-0007CO-8X
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 10:17:13 -0500
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:34695)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1cUESe-0007C2-3p
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 10:17:12 -0500
Received: by mail-oi0-x242.google.com with SMTP id w144so3410812oiw.1
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 07:17:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <96ad6596-573e-2b29-83ab-fc45b74a1ce0@vivier.eu>
References: <20170119142311.8310-1-bobby.prani@gmail.com>
	<96ad6596-573e-2b29-83ab-fc45b74a1ce0@vivier.eu>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Thu, 19 Jan 2017 10:16:41 -0500
Message-ID: <CAJhHMCCKgG1v8A6mcTpxBgg+JfVSY-jqKcTbdP5k851XJ104vw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/2] linux-user: fix settime old value
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

On Thu, Jan 19, 2017 at 10:05 AM, Laurent Vivier <laurent@vivier.eu> wrote:
> Le 19/01/2017 =C3=A0 15:23, Pranith Kumar a =C3=A9crit :
>> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>
>> old_value is the 4th argument of timer_settime(), not the 2nd.
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
>> ---
>>  linux-user/syscall.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>> index 7b77503f94..a393764a17 100644
>> --- a/linux-user/syscall.c
>> +++ b/linux-user/syscall.c
>> @@ -12024,10 +12024,14 @@ abi_long do_syscall(void *cpu_env, int num, ab=
i_long arg1,
>>              timer_t htimer =3D g_posix_timers[timerid];
>>              struct itimerspec hspec_new =3D {{0},}, hspec_old =3D {{0},=
};
>>
>> -            target_to_host_itimerspec(&hspec_new, arg3);
>> +            if (arg3 && target_to_host_itimerspec(&hspec_new, arg3)) {
>
> arg3 cannot be NULL, see 8 lines above, you need to only check the
> result of target_to_host_itimerspec().
>

OK, I updated this and sent a new patch.

Thanks for the review.
--=20
Pranith
