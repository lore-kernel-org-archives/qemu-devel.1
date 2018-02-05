Received: from eggs.gnu.org ([2001:4830:134:3::10]:55060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eiZuE-00069R-Tl
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 01:05:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eiZu9-00030y-T2
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 01:05:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eiZu9-00030B-Hy
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 01:05:25 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 29ACCC0587D1
	for <qemu-devel@nongnu.org>; Mon,  5 Feb 2018 06:05:24 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180111213250.16511-1-marcandre.lureau@redhat.com>
	<20180111213250.16511-2-marcandre.lureau@redhat.com>
Date: Mon, 05 Feb 2018 07:05:20 +0100
In-Reply-To: <20180111213250.16511-2-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Thu, 11 Jan 2018 22:32:00 +0100")
Message-ID: <87h8qwynrz.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 01/51] qlit: use QType instead of int
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/qapi/qmp/qlit.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/qapi/qmp/qlit.h b/include/qapi/qmp/qlit.h
> index b18406bce9..0c6809ef3c 100644
> --- a/include/qapi/qmp/qlit.h
> +++ b/include/qapi/qmp/qlit.h
> @@ -21,7 +21,7 @@ typedef struct QLitDictEntry QLitDictEntry;
>  typedef struct QLitObject QLitObject;
>=20=20
>  struct QLitObject {
> -    int type;
> +    QType type;
>      union {
>          bool qbool;
>          int64_t qnum;

Reviewed-by: Markus Armbruster <armbru@redhat.com>
