Received: from eggs.gnu.org ([2001:4830:134:3::10]:51932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fVBhN-0002il-QI
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 04:09:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fVBhI-0002uG-D4
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 04:09:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49540 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fVBhI-0002u5-8T
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 04:09:04 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D6A1387A7C
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 08:09:03 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180321115211.17937-1-marcandre.lureau@redhat.com>
	<20180321115211.17937-5-marcandre.lureau@redhat.com>
Date: Tue, 19 Jun 2018 10:09:02 +0200
In-Reply-To: <20180321115211.17937-5-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Wed, 21 Mar 2018 12:51:26 +0100")
Message-ID: <87lgbbyz8h.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 04/49] qapi: pass 'if' condition into
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
Cc: qemu-devel@nongnu.org, armbru@redhat.com

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Built-in objects remain unconditional.  Explicitly defined objects
> use the condition specified in the schema.  Implicitly defined
> objects inherit their condition from their users.  For most of them,
> there is exactly one user, so the condition to use is obvious.  The
> exception is the wrapped type's generated for simple union variants,

Editing accident in v4: you changed "is the wrapper types" to "is the
wrapped type's" here instead of...

> which can be shared by any number of simple unions.  The tight
> condition would be the disjunction of the conditions of these simple
> unions.  For now, use wrapped type's condition instead.  Much

... changing "use wrapped type's" to "use the wrapped type's" here.  Can
touch up on commit.

> simpler and good enough for now.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

R-by stands.
