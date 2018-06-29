Received: from eggs.gnu.org ([2001:4830:134:3::10]:56153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fYqfS-0008OO-Lc
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 06:30:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fYqfR-0005FG-R3
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 06:30:18 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:37904)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fYqfR-0005EQ-Jz
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 06:30:17 -0400
Received: by mail-wr0-x243.google.com with SMTP id w16-v6so614412wrn.5
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 03:30:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <876024by1h.fsf@dusky.pond.sub.org>
References: <20180321115211.17937-1-marcandre.lureau@redhat.com>
	<20180321115211.17937-6-marcandre.lureau@redhat.com>
	<87a7rrywk7.fsf@dusky.pond.sub.org>
	<CAJ+F1CKb8vgToF_VKyu2ARVQZP-XfHBoMm_cMd9YJRaziHWQNQ@mail.gmail.com>
	<876024by1h.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 29 Jun 2018 12:30:15 +0200
Message-ID: <CAJ+F1CJO0ZQrPVG9-AmYX7+=-KrNCqZSPw1a93_iFYNar6HeTg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 05/49] qapi: leave the ifcond attribute
 undefined until check()
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

On Wed, Jun 27, 2018 at 7:26 AM, Markus Armbruster <armbru@redhat.com> wrot=
e:
>>> This is hardly a rigorous proof.  Just enough to make me believe your
>>> code works.
>>>
>>> However, I suspect adding the inheritance feature at the entity level
>>> complicates the correctness argument without real need.  Can we restric=
t
>>> it to array elements?  Have QAPISchemaArrayType.check() resolve
>>> type-valued ._ifcond, and all the others choke on it?
>>
>> There is also implicit object types.
>
> Can you give an example?
>

{ 'union': 'Foo', 'data': { 'foo': 'Test' } }

will create implicit QAPISchemaObjectType q_obj_Test-wrapper in
_make_simple_variant()

This happens before check(), so we pass the Test type as ifcond.

--=20
Marc-Andr=C3=A9 Lureau
