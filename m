Received: from eggs.gnu.org ([2001:4830:134:3::10]:42911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dhxrP-000688-BD
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 08:55:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dhxrK-0004a5-9j
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 08:55:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dhxrK-0004Zt-3A
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 08:55:42 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170727154126.11339-1-marcandre.lureau@redhat.com>
	<20170727154126.11339-7-marcandre.lureau@redhat.com>
Date: Wed, 16 Aug 2017 14:55:37 +0200
In-Reply-To: <20170727154126.11339-7-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Thu, 27 Jul 2017 17:41:06 +0200")
Message-ID: <871sob8yeu.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 06/26] qapi2texi: minor python code
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
>  scripts/qapi2texi.py | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
> index 9e015002ef..639eb1d042 100755
> --- a/scripts/qapi2texi.py
> +++ b/scripts/qapi2texi.py
> @@ -136,10 +136,9 @@ def texi_enum_value(value):
>  def texi_member(member, suffix=3D''):
>      """Format a table of members item for an object type member"""
>      typ =3D member.type.doc_type()
> -    return '@item @code{%s%s%s}%s%s\n' % (
> +    return '@item @code{%s%s}%s%s\n' % (
>          member.name,
> -        ': ' if typ else '',
> -        typ if typ else '',
> +        ': %s' % typ if typ else '',
>          ' (optional)' if member.optional else '',
>          suffix)

Is nested interpolation really simpler?
