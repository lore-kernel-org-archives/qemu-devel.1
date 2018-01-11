Received: from eggs.gnu.org ([2001:4830:134:3::10]:48774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eZkSS-0003aa-Ej
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:32:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eZkSR-0007so-Kd
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:32:20 -0500
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:42726)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eZkSR-0007sB-FJ
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:32:19 -0500
Received: by mail-wr0-x232.google.com with SMTP id e41so3213207wre.9
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 13:32:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87r2rxuvao.fsf@dusky.pond.sub.org>
References: <20170911110623.24981-1-marcandre.lureau@redhat.com>
	<20170911110623.24981-44-marcandre.lureau@redhat.com>
	<87r2rxuvao.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 11 Jan 2018 22:32:17 +0100
Message-ID: <CAJ+F1CJH8gY1kw8AtqNmKX2TMMkQ1ROW77cufRCbWQA-py1xRw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 43/50] build-sys: move qmp-introspect
 per target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

Hi

On Thu, Dec 14, 2017 at 5:30 PM, Markus Armbruster <armbru@redhat.com> wrot=
e:
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
>> The following patches are going to introduce per-target #ifdef, and
>> but the introspection data is generated only once, and must thus be
>> built with the target.
>
> "and but"?
>
>> Drop "do_test_visitor_in_qmp_introspect(&&qmp_schema_qlit)" since it
>
> s/&&/&/
>
>> is no longer in a common object, and covered by "query-qmp-schema
>> test" instead.
>
> Do you mean test /x86_64/qmp/query-qmp-schema of tests/qmp-test.c?
>

I updated the commit message.

> That test tests significantly less.  It runs the command, tests it
> succeeds and returns something.  The test you remove additionally tests
> the returned value conforms to the schema, by passing it to
> visit_type_SchemaInfoList().
>
> Perhaps we can enhance the test you keep to avoid this loss.
>

It does call visit_type_SchemaInfoList() already on the return value.

thanks

--=20
Marc-Andr=C3=A9 Lureau
