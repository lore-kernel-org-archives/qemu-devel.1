Received: from eggs.gnu.org ([2001:4830:134:3::10]:34360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gXSLc-0001XL-US
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:52:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gXSLc-0002sI-0m
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:52:20 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36035)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gXSLb-0002qk-OV
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:52:19 -0500
Received: by mail-wr1-x443.google.com with SMTP id u4so1325870wrp.3
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 06:52:19 -0800 (PST)
MIME-Version: 1.0
References: <20181213123724.4866-1-marcandre.lureau@redhat.com>
	<87r2elo54a.fsf@dusky.pond.sub.org>
In-Reply-To: <87r2elo54a.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 13 Dec 2018 18:52:06 +0400
Message-ID: <CAJ+F1CJfN757apUmV-RfenT5jaH=emhe516Xm7_9rDguipcG_w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 00/22] qapi: add #if pre-processor
 conditions to generated code (part 2)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>

Hi

On Thu, Dec 13, 2018 at 6:49 PM Markus Armbruster <armbru@redhat.com> wrote=
:
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > This is the second part of the "add #if pre-processor conditions to
> > generated code" series, adding schema member conditions (roughly
> > 16-38/49).
> >
> > Members can be exploded as dictionnary with 'type'/'if' keys:
> >
> > { 'struct': 'TestIfStruct', 'data':
> >   { 'foo': 'int',
> >     'bar': { 'type': 'int', 'if': 'defined(TEST_IF_STRUCT_BAR)'} } }
> >
> > Enum values can be exploded as dictionnary with 'type'/'if' keys:
> >
> > { 'enum': 'TestIfEnum', 'data':
> >   [ 'foo',
> >     { 'name' : 'bar', 'if': 'defined(TEST_IF_ENUM_BAR)' } ] }
> >
> > Based-on: git://repo.or.cz/qemu/armbru.git qapi-next
>
> I found nothing I can't easily tidy up when I apply.  Thanks!
>

Cool, thanks! I can prepare part 3 :)

--=20
Marc-Andr=C3=A9 Lureau
