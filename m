Received: from eggs.gnu.org ([2001:4830:134:3::10]:50434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gWyJx-0007vk-7w
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 01:48:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gWyJt-0004yB-DQ
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 01:48:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54236)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gWyJq-0004vv-BX
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 01:48:31 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181208111606.8505-1-marcandre.lureau@redhat.com>
	<20181208111606.8505-2-marcandre.lureau@redhat.com>
	<875zw1lne9.fsf@dusky.pond.sub.org>
	<CAJ+F1CKOgnJOmBAYSG1OYKt5XpB_BCgbfCcsexbrVNM0odymNw@mail.gmail.com>
	<87va41fr45.fsf@dusky.pond.sub.org> <20181211160525.GO921@redhat.com>
Date: Wed, 12 Dec 2018 07:48:27 +0100
In-Reply-To: <20181211160525.GO921@redhat.com> ("Daniel P. =?utf-8?Q?Berra?=
	=?utf-8?Q?ng=C3=A9=22's?= message
	of "Tue, 11 Dec 2018 16:05:25 +0000")
Message-ID: <87bm5rkzpg.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v7 01/27] qapi: make sure osdep.h
 is included in type headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>, QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Mon, Dec 10, 2018 at 02:28:26PM +0100, Markus Armbruster wrote:
[...]
>> checkpatch.pl could flag patches adding .c files that don't include
>> "qemu/osdep.h" first.  The "first" part might be a bit annoying to code.
>
> You can get this logic from GNULIBs syntax-check make rules. It uses
> this perl code to check that config.h is included first:
>
>     while (<>) {
>         if (/^# *include\b/) {
>             if (not m{^# *include <config\.h>}) {
>                 print "$ARGV\n";
>                 $$ret =3D 1;
>             }
>             close ARGV;
>         }
>     }

Thanks!
