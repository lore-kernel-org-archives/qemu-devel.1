Received: from eggs.gnu.org ([209.51.188.92]:60195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hJEue-00055J-V3
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 06:14:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hJEhy-0005BA-Eo
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 06:00:55 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40554)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1hJEhy-00057x-48
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 06:00:54 -0400
Received: by mail-wm1-x342.google.com with SMTP id z24so4155138wmi.5
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 03:00:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190424094557.28404-1-thuth@redhat.com>
In-Reply-To: <20190424094557.28404-1-thuth@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 24 Apr 2019 12:00:39 +0200
Message-ID: <CAJ+F1CLWyeT+dGycXso_nDV6YyAm_pte2hhC9YzePZbs67aYOQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests/tpm-tests: Use g_test_skip() to mark
 skipped tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Stefan Berger <stefanb@linux.ibm.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Wed, Apr 24, 2019 at 11:49 AM Thomas Huth <thuth@redhat.com> wrote:
>
> Since we do not use gtester anymore (which had a bug here),
> we can now use g_test_skip() to mark skipped tests.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  tests/tpm-tests.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/tpm-tests.c b/tests/tpm-tests.c
> index 582ec0cfd4..e640777aa9 100644
> --- a/tests/tpm-tests.c
> +++ b/tests/tpm-tests.c
> @@ -22,7 +22,7 @@ static bool
>  tpm_test_swtpm_skip(void)
>  {
>      if (!tpm_util_swtpm_has_tpm2()) {
> -        g_test_message("swtpm not in PATH or missing --tpm2 support");
> +        g_test_skip("swtpm not in PATH or missing --tpm2 support");
>          return true;
>      }
>
> --
> 2.21.0
>
>


--=20
Marc-Andr=C3=A9 Lureau
