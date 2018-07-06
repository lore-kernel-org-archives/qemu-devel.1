Received: from eggs.gnu.org ([2001:4830:134:3::10]:49688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fbQB1-00016Y-4d
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 08:49:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fbQAx-0002Nh-7V
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 08:49:31 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:40111)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fbQAw-0002Ly-UU
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 08:49:27 -0400
Received: by mail-wr1-x435.google.com with SMTP id t6-v6so4091247wrn.7
	for <qemu-devel@nongnu.org>; Fri, 06 Jul 2018 05:49:26 -0700 (PDT)
References: <20180706080615.25974-1-alex.bennee@linaro.org>
	<CAJ+F1CLrc5d2f17brVydEjzV1zLUBZb4CV37Grb2Ab4T_1qRNw@mail.gmail.com>
	<874lhc8y5d.fsf@linaro.org>
	<CAJ+F1C+1PP61u9DcEqFoP6yuK2QPaUK-dhyeesmW_u5UhBT+tw@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAJ+F1C+1PP61u9DcEqFoP6yuK2QPaUK-dhyeesmW_u5UhBT+tw@mail.gmail.com>
Date: Fri, 06 Jul 2018 12:07:14 +0100
Message-ID: <871scg8vx9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC for 3.0] tests/tpm-emu: double the timeout
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU <qemu-devel@nongnu.org>, Stefan Berger <stefanb@linux.vnet.ibm.com>


Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> On Fri, Jul 6, 2018 at 12:19 PM, Alex Benn=C3=A9e <alex.bennee@linaro.org=
> wrote:
>>
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
>>
>>> Hi
>>>
>>> On Fri, Jul 6, 2018 at 10:06 AM, Alex Benn=C3=A9e <alex.bennee@linaro.o=
rg> wrote:
>>>> We see various failures on Travis so lets just double the timeout and
>>>> see if that makes them go away.
>>>
>>> This is just waiting for the thread to start and open a socket. It
>>> shouldn't be a problem to wait longer, but do you have a Travis error
>>> log?
>>
>> For example:
>>
>> https://travis-ci.org/qemu/qemu/jobs/400436724#L8971
>>
>>   GTESTER check-qtest-i386
>> **
>> ERROR:tests/tpm-emu.c:27:tpm_emu_test_wait_cond: code should not be reac=
hed
>>
>
> thanks, what about increasing the timeout to 30s ? I am afraid x2
> might not be enough for such overloaded systems.

Sure - the Travis servers are certainly hammered most of the time.

>
>>>>
>>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>>> ---
>>>>  tests/tpm-emu.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/tests/tpm-emu.c b/tests/tpm-emu.c
>>>> index 8c2bd53cad..308f1884f6 100644
>>>> --- a/tests/tpm-emu.c
>>>> +++ b/tests/tpm-emu.c
>>>> @@ -20,7 +20,7 @@
>>>>
>>>>  void tpm_emu_test_wait_cond(TestState *s)
>>>>  {
>>>> -    gint64 end_time =3D g_get_monotonic_time() + 5 * G_TIME_SPAN_SECO=
ND;
>>>> +    gint64 end_time =3D g_get_monotonic_time() + 10 * G_TIME_SPAN_SEC=
OND;
>>>>
>>>>      g_mutex_lock(&s->data_mutex);
>>>>      if (!g_cond_wait_until(&s->data_cond, &s->data_mutex, end_time)) {
>>>> --
>>>> 2.17.1
>>>>
>>>>
>>
>>
>> --
>> Alex Benn=C3=A9e


--
Alex Benn=C3=A9e
