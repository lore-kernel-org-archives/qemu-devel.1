Received: from eggs.gnu.org ([2001:4830:134:3::10]:57599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gWh32-0003eZ-SP
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 07:22:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gWh2x-0000OX-9F
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 07:22:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59560)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gWh2w-0000NJ-SE
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 07:21:55 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181208111606.8505-1-marcandre.lureau@redhat.com>
	<20181208111606.8505-20-marcandre.lureau@redhat.com>
Date: Tue, 11 Dec 2018 13:21:49 +0100
In-Reply-To: <20181208111606.8505-20-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Sat, 8 Dec 2018 15:15:58 +0400")
Message-ID: <87va40qmn6.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v7 19/27] qapi: add 'if' to
 alternate members
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

> Add 'if' key to alternate members:
>
> { 'alternate': 'TestIfAlternate', 'data':
>   { 'alt': { 'type': 'TestStruct', 'if': 'COND' } } }
>
> Generated code is not changed by this patch but with "qapi: add #if
> conditions to generated code".
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
