Received: from eggs.gnu.org ([2001:4830:134:3::10]:52232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gHtaq-0000Oi-Lq
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:43:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gHtak-0002Co-7l
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:43:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36202)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gHtai-00023k-Ux
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:43:37 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20181029145709.26359-1-marcandre.lureau@redhat.com>
	<87d0rqqh0g.fsf@dusky.pond.sub.org>
	<CAJ+F1CL3uL-TGqAg8-WcHTNOhvPFZzOdQDS4Pp3VfWN3DDd01A@mail.gmail.com>
Date: Wed, 31 Oct 2018 17:43:13 +0100
In-Reply-To: <CAJ+F1CL3uL-TGqAg8-WcHTNOhvPFZzOdQDS4Pp3VfWN3DDd01A@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Wed, 31 Oct 2018
	19:31:12 +0400")
Message-ID: <87wopynk2m.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests: add qmp/missing-any-arg test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Thomas Huth <thuth@redhat.com>, QEMU <qemu-devel@nongnu.org>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
> On Wed, Oct 31, 2018 at 7:22 PM Markus Armbruster <armbru@redhat.com> wro=
te:
>>
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>>
>> > test_qmp_missing_any_arg() is about a bug in infrastructure used by
>> > the QMP core, fixed in commit c489780203.  We covered the bug in
>> > infrastructure unit tests (commit bce3035a44).  I wrote that test
>> > earlier, to cover QMP level as well, the test could go into qmp-test.
>>
>> The last sentence is confusing.  What about replacing it by "Let's test
>> it at the QMP level as well"?
>
> sure, I assume you do that on commit thanks

Can do.

Meanwhile,
Reviewed-by: Markus Armbruster <armbru@redhat.com>
