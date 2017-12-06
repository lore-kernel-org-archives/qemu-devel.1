Received: from eggs.gnu.org ([2001:4830:134:3::10]:38054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eMbRp-0003zY-Sz
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 10:17:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eMbRp-0002J0-4J
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 10:17:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eMbRo-0002HZ-Ti
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 10:17:21 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20170911110623.24981-1-marcandre.lureau@redhat.com>
	<20170911110623.24981-3-marcandre.lureau@redhat.com>
Date: Wed, 06 Dec 2017 16:17:14 +0100
In-Reply-To: <20170911110623.24981-3-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Mon, 11 Sep 2017 13:05:35 +0200")
Message-ID: <87o9nbzy11.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 02/50] qapi: generate a literal qobject
 for introspection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Replace the generated json string with a literal qobject. The later is
> easier to deal with, at run time as well as compile time: adding #if
> conditionals will be easier than in a json string.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
