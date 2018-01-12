Received: from eggs.gnu.org ([2001:4830:134:3::10]:33194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ea2n5-0002C7-1S
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 12:06:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ea2n4-0000Hx-5S
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 12:06:51 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:43435)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1ea2n4-0000HJ-05
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 12:06:50 -0500
Received: by mail-wm0-x244.google.com with SMTP id g1so13437489wmg.2
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 09:06:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1512682213-4354-7-git-send-email-minyard@acm.org>
References: <1512682213-4354-1-git-send-email-minyard@acm.org>
	<1512682213-4354-7-git-send-email-minyard@acm.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 12 Jan 2018 18:06:48 +0100
Message-ID: <CAJ+F1CKUK_uRa9imNcOLzvNZyNaC7ciNqLppzGWVZjKGJ8ggRQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 6/8] vl.c: disallow command line fw cfg
 without opt/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Corey Minyard <minyard@acm.org>
Cc: QEMU <qemu-devel@nongnu.org>, Corey Minyard <cminyard@mvista.com>, "Michael S. Tsirkin" <mst@redhat.com>

Hi

On Thu, Dec 7, 2017 at 10:30 PM,  <minyard@acm.org> wrote:
> From: "Michael S. Tsirkin" <mst@redhat.com>
>
> Allowing arbitary file names on command line is setting us up for
> failure: future guests will look for a specific QEMU-specified name and
> will get confused finding a user file there.
>

Why is this part of a IPMI series?
There was a lengthy discussion on this patch earlier, could you
summarize the conclusion?

thanks

> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> [Change "warning" to "error" in the error report.]
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> ---
>  vl.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/vl.c b/vl.c
> index 1ad1c04..fae9300 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2400,8 +2400,9 @@ static int parse_fw_cfg(void *opaque, QemuOpts *opt=
s, Error **errp)
>          return -1;
>      }
>      if (strncmp(name, "opt/", 4) !=3D 0) {
> -        warn_report("externally provided fw_cfg item names "
> -                    "should be prefixed with \"opt/\"");
> +        error_report("error: externally provided fw_cfg item names "
> +                     "should be prefixed with \"opt/\"");
> +        return -1;
>      }
>      if (nonempty_str(str)) {
>          size =3D strlen(str); /* NUL terminator NOT included in fw_cfg b=
lob */
> --
> 2.7.4
>
>



--=20
Marc-Andr=C3=A9 Lureau
