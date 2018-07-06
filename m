Received: from eggs.gnu.org ([2001:4830:134:3::10]:51250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fbNpg-00054t-4l
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:19:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fbNpZ-0005D5-K4
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:19:20 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:37602)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fbNpZ-000575-AT
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:19:13 -0400
Received: by mail-wr1-x434.google.com with SMTP id q10-v6so3653769wrd.4
	for <qemu-devel@nongnu.org>; Fri, 06 Jul 2018 03:19:13 -0700 (PDT)
References: <20180706080615.25974-1-alex.bennee@linaro.org>
	<CAJ+F1CLrc5d2f17brVydEjzV1zLUBZb4CV37Grb2Ab4T_1qRNw@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAJ+F1CLrc5d2f17brVydEjzV1zLUBZb4CV37Grb2Ab4T_1qRNw@mail.gmail.com>
Date: Fri, 06 Jul 2018 11:19:10 +0100
Message-ID: <874lhc8y5d.fsf@linaro.org>
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

> Hi
>
> On Fri, Jul 6, 2018 at 10:06 AM, Alex Benn=C3=A9e <alex.bennee@linaro.org=
> wrote:
>> We see various failures on Travis so lets just double the timeout and
>> see if that makes them go away.
>
> This is just waiting for the thread to start and open a socket. It
> shouldn't be a problem to wait longer, but do you have a Travis error
> log?

For example:

https://travis-ci.org/qemu/qemu/jobs/400436724#L8971

  GTESTER check-qtest-i386
**
ERROR:tests/tpm-emu.c:27:tpm_emu_test_wait_cond: code should not be reached

>
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  tests/tpm-emu.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tests/tpm-emu.c b/tests/tpm-emu.c
>> index 8c2bd53cad..308f1884f6 100644
>> --- a/tests/tpm-emu.c
>> +++ b/tests/tpm-emu.c
>> @@ -20,7 +20,7 @@
>>
>>  void tpm_emu_test_wait_cond(TestState *s)
>>  {
>> -    gint64 end_time =3D g_get_monotonic_time() + 5 * G_TIME_SPAN_SECOND;
>> +    gint64 end_time =3D g_get_monotonic_time() + 10 * G_TIME_SPAN_SECON=
D;
>>
>>      g_mutex_lock(&s->data_mutex);
>>      if (!g_cond_wait_until(&s->data_cond, &s->data_mutex, end_time)) {
>> --
>> 2.17.1
>>
>>


--
Alex Benn=C3=A9e
