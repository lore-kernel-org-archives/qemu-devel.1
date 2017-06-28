Received: from eggs.gnu.org ([2001:4830:134:3::10]:54625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dQ4ed-0005Yg-30
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 00:32:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dQ4ec-0003Wu-BS
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 00:32:39 -0400
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242]:33797)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dQ4ec-0003Wn-5w
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 00:32:38 -0400
Received: by mail-io0-x242.google.com with SMTP id m19so4350544ioe.1
	for <qemu-devel@nongnu.org>; Tue, 27 Jun 2017 21:32:38 -0700 (PDT)
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <c0a2b62c80ddf46f99885b43215899a51a81ebc3.1498596157.git.alistair.francis@xilinx.com>
References: <cover.1498596157.git.alistair.francis@xilinx.com>
	<c0a2b62c80ddf46f99885b43215899a51a81ebc3.1498596157.git.alistair.francis@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philippe@mathieu-daude.net>
Date: Wed, 28 Jun 2017 01:32:36 -0300
Message-ID: <CAAdtpL5OL5MAue11GRuegt-i=JVET1BPejbwU6Dkn40hhkCogw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v1 1/3] util/qemu-error: Rename
 error_print_loc() to be more generic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Alistair Francis <alistair23@gmail.com>

On Tue, Jun 27, 2017 at 5:45 PM, Alistair Francis
<alistair.francis@xilinx.com> wrote:
> Rename the error_print_loc() function in preperation for using it to

preparation

> print warnings as well.
>
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

> ---
>
>  util/qemu-error.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/util/qemu-error.c b/util/qemu-error.c
> index b331f8f4a4..1c5e35ecdb 100644
> --- a/util/qemu-error.c
> +++ b/util/qemu-error.c
> @@ -146,7 +146,7 @@ const char *error_get_progname(void)
>  /*
>   * Print current location to current monitor if we have one, else to std=
err.
>   */
> -static void error_print_loc(void)
> +static void print_loc(void)
>  {
>      const char *sep =3D "";
>      int i;
> @@ -197,7 +197,7 @@ void error_vreport(const char *fmt, va_list ap)
>          g_free(timestr);
>      }
>
> -    error_print_loc();
> +    print_loc();
>      error_vprintf(fmt, ap);
>      error_printf("\n");
>  }
> --
> 2.11.0
>
>
