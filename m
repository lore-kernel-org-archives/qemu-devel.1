Received: from eggs.gnu.org ([2001:4830:134:3::10]:46084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehcgi-0007H7-G7
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:51:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehcge-0007Ej-JX
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:51:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47170)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ehcge-0007EQ-D2
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:51:32 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20170911110623.24981-1-marcandre.lureau@redhat.com>
	<20170911110623.24981-25-marcandre.lureau@redhat.com>
	<87609g6zh5.fsf@dusky.pond.sub.org>
	<CAJ+F1CJbzrhr5xSaLX5B2mR3oVJkjDLnQRL0Y2fOcSkitPj12Q@mail.gmail.com>
Date: Fri, 02 Feb 2018 15:51:29 +0100
In-Reply-To: <CAJ+F1CJbzrhr5xSaLX5B2mR3oVJkjDLnQRL0Y2fOcSkitPj12Q@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Thu, 11 Jan 2018
	22:31:50 +0100")
Message-ID: <87372jla1a.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 24/50] qapi: add some struct member tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Sat, Dec 9, 2017 at 10:07 AM, Markus Armbruster <armbru@redhat.com> wr=
ote:
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
[...]
>>> diff --git a/tests/qapi-schema/struct-member-type.json b/tests/qapi-sch=
ema/struct-member-type.json
>>> new file mode 100644
>>> index 0000000000..8b33027817
>>> --- /dev/null
>>> +++ b/tests/qapi-schema/struct-member-type.json
>>> @@ -0,0 +1,2 @@
>>> +# check member 'a' with 'type' key only
>>> +{ 'struct': 'foo', 'data': { 'a': { 'type': 'str' } } }
>>> diff --git a/tests/qapi-schema/struct-member-type.out b/tests/qapi-sche=
ma/struct-member-type.out
>>> new file mode 100644
>>> index 0000000000..04b969d2e3
>>> --- /dev/null
>>> +++ b/tests/qapi-schema/struct-member-type.out
>>> @@ -0,0 +1,12 @@
>>> +enum QType
>>> +    prefix QTYPE
>>> +    member none:
>>> +    member qnull:
>>> +    member qnum:
>>> +    member qstring:
>>> +    member qdict:
>>> +    member qlist:
>>> +    member qbool:
>>> +object foo
>>> +    member a: str optional=3DFalse
>>> +object q_empty
>>
>> This is a positive test, isn't it?  Positive tests go into
>> qapi-schema-test.json.
>>
>
> Right, I wonder why we have .exit files then. Perhaps the few ones
> that return 0 shouldn't exist.

There are a few legitimate positive test cases, such as empty.json and
doc-good.json.

Moreover, we occasionally add negative test cases that fail to fail,
demonstrating a bug.  Example: quoted-structural-chars in commit
98626572f1, fixed in commit c7a3f25200.
