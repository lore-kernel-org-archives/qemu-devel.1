Received: from eggs.gnu.org ([2001:4830:134:3::10]:59117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eik6b-00026l-1D
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 11:58:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eik6X-0003pM-VJ
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 11:58:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34990)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eik6X-0003mP-Pe
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 11:58:53 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20180111213250.16511-1-marcandre.lureau@redhat.com>
	<20180111213250.16511-42-marcandre.lureau@redhat.com>
Date: Mon, 05 Feb 2018 17:58:49 +0100
In-Reply-To: <20180111213250.16511-42-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Thu, 11 Jan 2018
	22:32:40 +0100")
Message-ID: <87fu6fid9y.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 41/51] qapi: add -i/--include filename.h
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

> Add a new option to add user-specified #include lines in the generated
> headers. This will help to split a schema, where one generated header
> will depend on another.
>
> Fix some pycodestyle on the way.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

With my alternative way to split up the generated monolith[*], required
generated headers should be included without the user's help.

We might conceivably need an ability to add includes for other purposes.
As far as I can tell, this is not the case in your series.

If we need the ability, then I'd rather use a directive in the schema
than a command line option.


[*] [PATCH RFC 00/21] Modularize generated QAPI code
Message-Id: <20180202130336.24719-1-armbru@redhat.com>
