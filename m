Received: from eggs.gnu.org ([2001:4830:134:3::10]:42720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dzgfd-00043D-4u
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:12:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dzgfc-0000ka-8x
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:12:53 -0400
MIME-Version: 1.0
In-Reply-To: <20171002140307.5292-5-armbru@redhat.com>
References: <20171002140307.5292-1-armbru@redhat.com>
	<20171002140307.5292-5-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 4 Oct 2017 12:12:51 +0200
Message-ID: <CAJ+F1C+Du=fv30bWzpyWPYvFaNNw1romQykJcwHfb1iODViz5w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/8] qemu-options: Move -iscsi under "Block
 device options"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Max Reitz <mreitz@redhat.com>

On Mon, Oct 2, 2017 at 4:03 PM, Markus Armbruster <armbru@redhat.com> wrote=
:
> -iscsi ended up under the "Device URL Syntax" heading by a sequence of
> errors, as explained in the previous commit.  Move it under the "Block
> device options" heading.  Nothing left under "Device URL Syntax";
> drop the heading.
>
> Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: qemu-block@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  qemu-options.hx | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/qemu-options.hx b/qemu-options.hx
> index f112281d37..c647fdde62 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -1172,6 +1172,13 @@ STEXI
>  Create synthetic file system image
>  ETEXI
>
> +DEF("iscsi", HAS_ARG, QEMU_OPTION_iscsi,
> +    "-iscsi [user=3Duser][,password=3Dpassword]\n"
> +    "       [,header-digest=3DCRC32C|CR32C-NONE|NONE-CRC32C|NONE\n"
> +    "       [,initiator-name=3Dinitiator-iqn][,id=3Dtarget-iqn]\n"
> +    "       [,timeout=3Dtimeout]\n"
> +    "                iSCSI session parameters\n", QEMU_ARCH_ALL)
> +
>  STEXI
>  @end table
>  ETEXI
> @@ -2811,14 +2818,6 @@ STEXI
>  ETEXI
>  DEFHEADING()
>
> -DEFHEADING(Device URL Syntax:)
> -DEF("iscsi", HAS_ARG, QEMU_OPTION_iscsi,
> -    "-iscsi [user=3Duser][,password=3Dpassword]\n"
> -    "       [,header-digest=3DCRC32C|CR32C-NONE|NONE-CRC32C|NONE\n"
> -    "       [,initiator-name=3Dinitiator-iqn][,id=3Dtarget-iqn]\n"
> -    "       [,timeout=3Dtimeout]\n"
> -    "                iSCSI session parameters\n", QEMU_ARCH_ALL)
> -
>  DEFHEADING(Bluetooth(R) options:)
>  STEXI
>  @table @option
> --
> 2.13.6
>
>



--=20
Marc-Andr=C3=A9 Lureau
