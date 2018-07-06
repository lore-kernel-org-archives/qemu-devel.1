Received: from eggs.gnu.org ([2001:4830:134:3::10]:39609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fbN0D-0006gS-CR
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 05:26:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fbN0C-0002Wt-ET
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 05:26:09 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:51111)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fbN0C-0002RS-7O
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 05:26:08 -0400
Received: by mail-wm0-x230.google.com with SMTP id v25-v6so14231440wmc.0
	for <qemu-devel@nongnu.org>; Fri, 06 Jul 2018 02:26:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180706080615.25974-1-alex.bennee@linaro.org>
References: <20180706080615.25974-1-alex.bennee@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 6 Jul 2018 11:26:06 +0200
Message-ID: <CAJ+F1CLrc5d2f17brVydEjzV1zLUBZb4CV37Grb2Ab4T_1qRNw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU <qemu-devel@nongnu.org>, Stefan Berger <stefanb@linux.vnet.ibm.com>

Hi

On Fri, Jul 6, 2018 at 10:06 AM, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
> We see various failures on Travis so lets just double the timeout and
> see if that makes them go away.

This is just waiting for the thread to start and open a socket. It
shouldn't be a problem to wait longer, but do you have a Travis error
log?

>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  tests/tpm-emu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/tpm-emu.c b/tests/tpm-emu.c
> index 8c2bd53cad..308f1884f6 100644
> --- a/tests/tpm-emu.c
> +++ b/tests/tpm-emu.c
> @@ -20,7 +20,7 @@
>
>  void tpm_emu_test_wait_cond(TestState *s)
>  {
> -    gint64 end_time =3D g_get_monotonic_time() + 5 * G_TIME_SPAN_SECOND;
> +    gint64 end_time =3D g_get_monotonic_time() + 10 * G_TIME_SPAN_SECOND=
;
>
>      g_mutex_lock(&s->data_mutex);
>      if (!g_cond_wait_until(&s->data_cond, &s->data_mutex, end_time)) {
> --
> 2.17.1
>
>



--=20
Marc-Andr=C3=A9 Lureau
