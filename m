Received: from eggs.gnu.org ([2001:4830:134:3::10]:48720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cRctx-0000bI-0N
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 05:46:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cRcts-0007a8-4z
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 05:46:37 -0500
References: <20161212173151.18092-1-marcandre.lureau@redhat.com>
	<20161212173151.18092-2-marcandre.lureau@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <cd10cc95-39dc-d960-ac06-f7c9f0946df3@msgid.tls.msk.ru>
Date: Thu, 12 Jan 2017 13:46:30 +0300
MIME-Version: 1.0
In-Reply-To: <20161212173151.18092-2-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] object.h: improve OBJECT/OBJECT_CLASS
 doc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

12.12.2016 20:31, Marc-Andr=C3=A9 Lureau wrote:
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/qom/object.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/qom/object.h b/include/qom/object.h
> index c5e6fc1f5d..c5456db05d 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -467,7 +467,7 @@ struct TypeInfo
>   * OBJECT:
>   * @obj: A derivative of #Object
>   *
> - * Converts an object to a #Object.  Since all objects are #Objects,
> + * Converts an object to a #Object.  Since all objects are #Object,
>   * this function will always succeed.

I'm not sure this is a good change. Yes the type name is "Object"
(singular), but we refer to multiple objectS (plural), so... :)
If we had some coloring, we'd wrote it like, eg, #<b>Object</b>s,
with "s" being outside of the type name.

Thanks,

/mjt
