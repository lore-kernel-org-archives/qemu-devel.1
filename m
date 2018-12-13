Received: from eggs.gnu.org ([2001:4830:134:3::10]:59150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXJHX-00040v-5W
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 00:11:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXJHT-0007Uj-Nt
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 00:11:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57006)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gXJHP-0007LA-NA
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 00:11:25 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181208111606.8505-1-marcandre.lureau@redhat.com>
	<87va3yfytv.fsf@dusky.pond.sub.org>
	<CAJ+F1CJ-=Nk5_PDT5u+Jv3+8Yecu7GFrBCih-tnMvNnqvWxQnw@mail.gmail.com>
Date: Thu, 13 Dec 2018 06:11:14 +0100
In-Reply-To: <CAJ+F1CJ-=Nk5_PDT5u+Jv3+8Yecu7GFrBCih-tnMvNnqvWxQnw@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Wed, 12 Dec 2018
	22:13:01 +0400")
Message-ID: <8736r2dn9p.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v7 00/27] Hi,
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Markus Armbruster <armbru@redhat.com>, QEMU <qemu-devel@nongnu.org>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Wed, Dec 12, 2018 at 9:18 PM Markus Armbruster <armbru@redhat.com> wro=
te:
>>
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>>
>> > This is the second part of the "add #if pre-processor conditions to
>> > generated code" series, adding schema member conditions (roughly
>> > 16-38/49).
>> >
>> > Members can be exploded as dictionnary with 'type'/'if' keys:
>> >
>> > { 'struct': 'TestIfStruct', 'data':
>> >   { 'foo': 'int',
>> >     'bar': { 'type': 'int', 'if': 'defined(TEST_IF_STRUCT_BAR)'} } }
>> >
>> > Enum values can be exploded as dictionnary with 'type'/'if' keys:
>> >
>> > { 'enum': 'TestIfEnum', 'data':
>> >   [ 'foo',
>> >     { 'name' : 'bar', 'if': 'defined(TEST_IF_ENUM_BAR)' } ] }
>>
>> PATCH 03,18,20,25 are only losely related to this second part.  They are
>> also ready.  Queued on branch qapi-next in my public repository, with
>> PATCH 18 and 20 squashed together.
>>
>> I took the liberty to implement the the idea on normalization I
>> mentioned in review of PATCH 08.  I also squashed a few patches that are
>> essentially fixups into the patches they fix.  I did not address any
>> other review comments.  Result is on branch qapi-if-2.  Please have a
>> look.
>>
>
> Looks good to me.  Is there something left to rework from this branch
> or it is good to go?
> thanks

I adressed only the one review comment that was hard to explain, plus
some patch squashing.  The other review comments still need to be
considered and worked in.
