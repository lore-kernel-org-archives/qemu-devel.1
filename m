Received: from eggs.gnu.org ([2001:4830:134:3::10]:57243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eia5Q-0000sM-76
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 01:17:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eia5L-0000Qf-9Y
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 01:17:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48686)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eia5L-0000PG-3O
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 01:16:59 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20180111213250.16511-1-marcandre.lureau@redhat.com>
	<20180111213250.16511-7-marcandre.lureau@redhat.com>
Date: Mon, 05 Feb 2018 07:16:54 +0100
In-Reply-To: <20180111213250.16511-7-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Thu, 11 Jan 2018 22:32:05 +0100")
Message-ID: <87efm0yn8p.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 06/51] qapi: pass 'if' condition into
 QAPISchemaEntity objects
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Cleber Rosa <crosa@redhat.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Built-in objects remain unconditional.  Explicitly defined objects
> use the condition specified in the schema.  Implicitly defined
> objects inherit their condition from their users.  For most of them,
> there is exactly one user, so the condition to use is obvious.  The
> exception is the wrapped type's generated for simple union variants,

Editing accident: you changed "is the wrapper types" to "is the wrapped
type's" here instead of

> which can be shared by any number of simple unions.  The tight
> condition would be the disjunction of the conditions of these simple
> unions.  For now, use wrapped type's condition instead.  Much

changing "use wrapped type's"  to "use the wrapped type's" here.  Can
touch up on commit.

> simpler and good enough for now.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

R-by stands.
