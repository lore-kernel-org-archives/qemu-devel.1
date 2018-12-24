Received: from eggs.gnu.org ([208.118.235.92]:54509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcfaracco@gmail.com>) id 1gbS87-00027D-Pq
	for qemu-devel@nongnu.org; Mon, 24 Dec 2018 10:26:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcfaracco@gmail.com>) id 1gbS87-0000FS-3F
	for qemu-devel@nongnu.org; Mon, 24 Dec 2018 10:26:55 -0500
MIME-Version: 1.0
References: <20181223025939.15775-1-npes87184@gmail.com>
In-Reply-To: <20181223025939.15775-1-npes87184@gmail.com>
From: Julio Faracco <jcfaracco@gmail.com>
Date: Mon, 24 Dec 2018 13:26:42 -0200
Message-ID: <CAENf94J0DefrRC6sNk3Ko=kmu2YW1GTwKy+r_5bZRJR8BfgNgA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 0/3] dmg: fixing reading in
 dmg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuchenlin <npes87184@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

The series looks good to me.

I tested with existing DMGs and DMGs that I created by myself.
Both are working fine now.

Reviewed-by: Julio Faracco <jcfaracco@gmail.com>

Em dom, 23 de dez de 2018 =C3=A0s 01:01, yuchenlin <npes87184@gmail.com>
escreveu:

> There are two bugs in dmg reading.
>
> First, it may hang in binary search. this problem is solved by patch 1.
> Second, because of lacking zero chunk table, reading zero sector will
> return EIO. thie problem is solved by patch 2 and 3.
>
> Thanks
>
> v1 - >v2:
> * fix typos in patch 1
> * add patch 2 and patch 3
>
> yuchenlin (3):
>   dmg: fix binary search
>   dmg: use enumeration type instead of hard coding number
>   dmg: don't skip zero chunk
>
>  block/dmg.c | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
>
> --
> 2.17.1
>
>
>
