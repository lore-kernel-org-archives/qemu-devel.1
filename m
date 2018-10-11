Received: from eggs.gnu.org ([2001:4830:134:3::10]:60644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gAipE-0002n4-51
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 17:48:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gAipB-0006SY-0a
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 17:48:56 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:37852)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gAipA-0006Q3-RS
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 17:48:52 -0400
Received: by mail-it1-f193.google.com with SMTP id e74-v6so15486731ita.2
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 14:48:52 -0700 (PDT)
MIME-Version: 1.0
References: <20181011171254.32428-1-philmd@redhat.com>
In-Reply-To: <20181011171254.32428-1-philmd@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 12 Oct 2018 01:48:39 +0400
Message-ID: <CAMxuvay4Hs_Aa1km5vav75GAdxtzo0YO=xfe8H-_=-7oS1ej-w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vl: Print error when using incorrect
 backend for debugcon
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: philmd@redhat.com
Cc: "Bonzini, Paolo" <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

On Thu, Oct 11, 2018 at 9:13 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> When using an incorrect backend for the debugcon, QEMU exits silently
> without any error indication, which is confusing.
> Add a message that the character backend is invalid.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  vl.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/vl.c b/vl.c
> index 4e25c78bff..61305b5891 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2466,6 +2466,7 @@ static int debugcon_parse(const char *devname)
>      QemuOpts *opts;
>
>      if (!qemu_chr_new_mux_mon("debugcon", devname)) {
> +        error_report("invalid character backend '%s'", devname);
>          exit(1);
>      }
>      opts =3D qemu_opts_create(qemu_find_opts("device"), "debugcon", 1, N=
ULL);
> --
> 2.17.1
>
