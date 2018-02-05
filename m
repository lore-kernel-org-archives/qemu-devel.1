Received: from eggs.gnu.org ([2001:4830:134:3::10]:51756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eilGk-0000bV-87
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 13:13:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eilGg-0001Ey-8l
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 13:13:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eilGg-0001Du-1r
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 13:13:26 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20180111213250.16511-1-marcandre.lureau@redhat.com>
	<20180111213250.16511-43-marcandre.lureau@redhat.com>
	<CAJ+F1CLrSaCthi3HZhg1629oycPS=cPHkOBs1PcVBsvFy=9M1w@mail.gmail.com>
Date: Mon, 05 Feb 2018 19:13:20 +0100
In-Reply-To: <CAJ+F1CLrSaCthi3HZhg1629oycPS=cPHkOBs1PcVBsvFy=9M1w@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Fri, 12 Jan 2018
	12:54:48 +0100")
Message-ID: <877erri9tr.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 42/51] qapi: add a 'unit' pragma
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Thu, Jan 11, 2018 at 10:32 PM, Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@redhat.com> wrote:
>> Add a pragma that allows to tag the following expressions in the
>> schema with a unit name. By default, an expression has no unit name.
>>
>> See the docs/devel/qapi-code-gen.txt for more details.
>>
>
> I inadvertently merged the following patch "qapi: add a -u/--unit
> option to specify which unit to visit" with this one.
>
> Fixed in the github branch: https://github.com/elmarco/qemu/commits/qapi-=
if

Looks like it's still messed up: the patch there adds the pragma to
docs/devel/qapi-code-gen.txt, the test cases, but no code.  Make check
fails.  The code appears to be in the next patch.  Please advise.

[...]
