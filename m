Received: from eggs.gnu.org ([2001:4830:134:3::10]:53845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ej106-00051W-8z
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 06:01:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ej105-0006Wt-KH
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 06:01:22 -0500
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:35863)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1ej105-0006Wd-DL
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 06:01:21 -0500
Received: by mail-wm0-x230.google.com with SMTP id f3so3009031wmc.1
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 03:01:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <878tc6e8ng.fsf@dusky.pond.sub.org>
References: <20180111213250.16511-1-marcandre.lureau@redhat.com>
	<20180111213250.16511-4-marcandre.lureau@redhat.com>
	<878tc6e8ng.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 6 Feb 2018 12:01:19 +0100
Message-ID: <CAJ+F1CJQYTG4TL_XMf6bAPZquishO75Y4gQ7u3X2o7f8qhaCkg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 03/51] qapi: generate a literal qobject
 for introspection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, Cleber Rosa <crosa@redhat.com>, QEMU <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On Tue, Feb 6, 2018 at 11:04 AM, Markus Armbruster <armbru@redhat.com> wrot=
e:
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
>> Replace the generated json string with a literal qobject. The later is
>> easier to deal with, at run time as well as compile time: adding #if
>> conditionals will be easier than in a json string.
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>
> I verified that the output of query-qmp-schema is not changed.
> Mentioning that in the commit message wouldn't hurt.
>

Sure, feel free to touch if you pick it

--=20
Marc-Andr=C3=A9 Lureau
