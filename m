Received: from eggs.gnu.org ([2001:4830:134:3::10]:40057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fByg2-0008Fo-UF
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 04:24:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fByfy-000755-Vi
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 04:24:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60390 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fByfy-00074x-Qs
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 04:24:18 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 801B08DC43
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 08:24:14 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180419150145.24795-1-marcandre.lureau@redhat.com>
	<20180419150145.24795-3-marcandre.lureau@redhat.com>
Date: Fri, 27 Apr 2018 10:24:08 +0200
In-Reply-To: <20180419150145.24795-3-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Thu, 19 Apr 2018 17:01:42 +0200")
Message-ID: <87po2lqcpj.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 2/5] qobject: use a QObjectBase_ struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> By moving the base fields to a QObjectBase_, QObject can be a type
> which also has a 'base' field. This allows writing a generic QOBJECT()
> macro that will work with any QObject type, including QObject
> itself. The container_of() macro ensures that the object to cast has a
> QObjectBase_ base field, giving some type safety guarantees. QObject
> must have no members but QObjectBase_ base, or else QOBJECT() breaks.
>
> QObjectBase_ is not a typedef and uses a trailing underscore to make
> it obvious it is not for normal use and to avoid potential abuse.

The omission of typedef to signal "internal use" is unusual in QEMU.
Doesn't bother *me*, but then I wouldn't typedef any struct or union if
consistency with the bulk of QEMU's code didn't demand it.

I can add the typedef and update the commit message if desired.

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

I would've been tempted to try an unnamed field, but (1) that might've
been too clever, and (2) this patch exists and works.

With or without the typedef:
Reviewed-by: Markus Armbruster <armbru@redhat.com>
