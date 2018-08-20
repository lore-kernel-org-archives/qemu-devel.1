Received: from eggs.gnu.org ([2001:4830:134:3::10]:47753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1frgYt-00032s-GW
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 05:33:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1frgYp-0000w8-Gz
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 05:33:23 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180817171932.31976-3-marcandre.lureau@redhat.com>
References: <20180817171932.31976-1-marcandre.lureau@redhat.com>
	<20180817171932.31976-3-marcandre.lureau@redhat.com>
Date: Mon, 20 Aug 2018 11:32:40 +0200
Message-ID: <w51h8jpids7.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] qobject: modify qobject_ref() to
 assert on NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "open
	list:Block layer core" <qemu-block@nongnu.org>

On Fri 17 Aug 2018 07:19:32 PM CEST, Marc-Andr=C3=A9 Lureau wrote:
> diff --git a/block/quorum.c b/block/quorum.c
> index 9152da8c58..96cd094ede 100644
> --- a/block/quorum.c
> +++ b/block/quorum.c
> @@ -1089,7 +1089,8 @@ static void quorum_refresh_filename(BlockDriverStat=
e *bs, QDict *options)
>      children =3D qlist_new();
>      for (i =3D 0; i < s->num_children; i++) {
>          qlist_append(children,
> -                     qobject_ref(s->children[i]->bs->full_open_options));
> +                     s->children[i]->bs->full_open_options ?
> +                     qobject_ref(s->children[i]->bs->full_open_options) =
: NULL);
>      }
>=20=20
>      opts =3D qdict_new();

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
