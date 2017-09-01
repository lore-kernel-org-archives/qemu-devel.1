Received: from eggs.gnu.org ([2001:4830:134:3::10]:55317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dnoCi-0002hO-DN
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:50:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dnoCd-0006co-HW
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:49:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41626)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dnoCd-0006cX-Bi
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:49:51 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
	<20170822132255.23945-15-marcandre.lureau@redhat.com>
Date: Fri, 01 Sep 2017 17:49:46 +0200
In-Reply-To: <20170822132255.23945-15-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 22 Aug 2017
	15:22:15 +0200")
Message-ID: <87d17axvtx.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 14/54] qapi2texi: minor python code
 simplification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/qapi2texi.py | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
> index a317526e51..8b542f9fff 100755
> --- a/scripts/qapi2texi.py
> +++ b/scripts/qapi2texi.py
> @@ -136,10 +136,9 @@ def texi_enum_value(value):
>  def texi_member(member, suffix=3D''):
>      """Format a table of members item for an object type member"""
>      typ =3D member.type.doc_type()
> -    return '@item @code{%s%s%s}%s%s\n' % (
> -        member.name,
> -        ': ' if typ else '',
> -        typ if typ else '',
> +    membertype =3D ': %s' % typ if typ else ''

I'd use string concatenation (': ' + typ) instead of interpolation.
Matter of taste.  Could make the change when I apply.

> +    return '@item @code{%s%s}%s%s\n' % (
> +        member.name, membertype,
>          ' (optional)' if member.optional else '',
>          suffix)

Reviewed-by: Markus Armbruster <armbru@redhat.com>
