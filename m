Received: from eggs.gnu.org ([2001:4830:134:3::10]:52606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dXlse-0004oc-Ci
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 06:06:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dXlsd-0000je-11
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 06:06:56 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:38528)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dXlsc-0000ir-Qv
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 06:06:54 -0400
Received: by mail-lf0-x241.google.com with SMTP id l125so9179lfg.5
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 03:06:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1500448182-21376-1-git-send-email-armbru@redhat.com>
References: <1500448182-21376-1-git-send-email-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 19 Jul 2017 12:06:52 +0200
Message-ID: <CAJ+F1C+tNiGEkzC3aBf=_92oxb7NvG+UeYaUPLy9vKY8ym936g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vnc: Clarify documentation of QMP command
 change
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

Hi

On Wed, Jul 19, 2017 at 9:09 AM, Markus Armbruster <armbru@redhat.com> wrot=
e:
> QMP command
>
>     { "execute": "change",
>       "arguments": { "device": "vnc", "target": "password", "arg": PWD } =
}
>
> behaves just like
>
>     { "execute": "change-vnc-password",
>       "arguments": { "password", "arg": PWD } }
>
> Their documentation differs, however.  According to
> change-vnc-password's documentation, "an empty password [...] will set
> the password to the empty string", while change's documentation claims
> "no future logins will be allowed".  The former is actually correct.
> Replace the incorrect claim by a reference to change-vnc-password.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


The password would have to be NULL to disallow further login, is that
what your other series will allow to do?

> ---
>  qapi-schema.json | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/qapi-schema.json b/qapi-schema.json
> index 8b015be..58d3a02 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -3011,8 +3011,7 @@
>  # @arg:    If @device is a block device, then this is an optional format=
 to open
>  #          the device with.
>  #          If @device is 'vnc' and @target is 'password', this is the ne=
w VNC
> -#          password to set.  If this argument is an empty string, then n=
o future
> -#          logins will be allowed.
> +#          password to set.  See change-vnc-password for additional note=
s.
>  #
>  # Returns: Nothing on success.
>  #          If @device is not a valid block device, DeviceNotFound
> --
> 2.7.5
>
>



--=20
Marc-Andr=C3=A9 Lureau
