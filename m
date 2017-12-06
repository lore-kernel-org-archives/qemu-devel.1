Received: from eggs.gnu.org ([2001:4830:134:3::10]:53211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eMbuQ-0005nn-IC
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 10:46:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eMbuL-0002EP-JG
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 10:46:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44306)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eMbuL-0002ED-CU
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 10:46:49 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20170911110623.24981-1-marcandre.lureau@redhat.com>
	<20170911110623.24981-5-marcandre.lureau@redhat.com>
Date: Wed, 06 Dec 2017 16:46:34 +0100
In-Reply-To: <20170911110623.24981-5-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Mon, 11 Sep 2017 13:05:37 +0200")
Message-ID: <87fu8nzwo5.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 04/50] qapi: add 'if' to top-level
 expressions
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

> Accept 'if' key in top-level elements, accepted as string or list of
> string type. The following patches will modify the test visitor to
> check the value is correctly saved, and generate #if/#endif code (as a
> single #if/endif line or a series for a list).
>
> Example of 'if' key:
> { 'struct': 'TestIfStruct', 'data': { 'foo': 'int' },
>   'if': 'defined(TEST_IF_STRUCT)' }
>
> The generated code is for now *unconditional*. Later patches generate
> the conditionals.
>
> A following patch for qapi-code-gen.txt will provide more complete
> documentation for 'if' usage.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
