Received: from eggs.gnu.org ([2001:4830:134:3::10]:59316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dpBLa-0002Mz-U4
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 06:44:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dpBLW-0001Uu-0k
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 06:44:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39956)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dpBLV-0001UF-Oa
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 06:44:41 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C32B5C058EDD
	for <qemu-devel@nongnu.org>; Tue,  5 Sep 2017 10:44:40 +0000 (UTC)
References: <20170901180340.30009-1-eblake@redhat.com>
	<20170901180340.30009-3-eblake@redhat.com>
	<09983e6e-9506-ca02-a8ce-b1a1773d793c@redhat.com>
	<874lshzd2l.fsf@dusky.pond.sub.org> <20170905101003.GD311@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b75a0b41-3dd1-f0d8-0368-210fb03b1d81@redhat.com>
Date: Tue, 5 Sep 2017 12:44:35 +0200
MIME-Version: 1.0
In-Reply-To: <20170905101003.GD311@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 02/29] tests: Sort .gitignore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 05.09.2017 12:10, Daniel P. Berrange wrote:
> On Tue, Sep 05, 2017 at 11:53:22AM +0200, Markus Armbruster wrote:
>> Thomas Huth <thuth@redhat.com> writes:
>>
>>> On 01.09.2017 20:03, Eric Blake wrote:
>>>> It doesn't matter if things are unsorted, but finding stuff in a lis=
t
>>>> is easier when it is sorted.  (Sorted under LC_ALL=3DC rules, rather=
 than
>>>> en_US.UTF-8).
>>>>
>>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>>> ---
>>>>  tests/.gitignore | 30 +++++++++++++++---------------
>>>>  1 file changed, 15 insertions(+), 15 deletions(-)
>>>
>>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>>
>>> BTW, did you note the patch "build-sys: generate tests/.gitignore" fr=
om
>>> Marc-Andr=C3=A9 ? Maybe the list can be generated automatically, too.=
..
>>>
>>>> diff --git a/tests/.gitignore b/tests/.gitignore
>>>> index 64ecd6683b..8d35a58751 100644
>>>> --- a/tests/.gitignore
>>>> +++ b/tests/.gitignore
>>>> @@ -1,25 +1,27 @@
>>>> +*-test
>>>
>>> ... but looking at this wildcard, I wonder if we just named most of o=
ur
>>> tests in a bad way. If we name the files something-test instead of
>>> test-something, we maybe do not need the automatic generation from
>>> Marc-Andr=C3=A9 (which is kind of ugly because it writes to the sourc=
e
>>> directory - and this should not happen when doing out of tree builds)=
.
>>>
>>> So what do you think about renaming our tests, so that the above
>>> wildcard applies instead?
>>
>> Apropos naming tests: there's an (unspoken) convention to name unit
>> tests check-FOO or test-FOO and tests using libqtest FOO-test, but it'=
s
>> not really honored anymore, probably because people creating tests
>> didn't know about it.
>=20
> $ ls *test.c | wc -l
> 67
> $ ls test*.c | wc -l
> 73
> $ ls check*.c | wc -l
> 8
>=20
> Fairly even split between 'test' as a prefix vs suffix. 'check' as a
> prefix should clearly be killed as a minority pattern. Any appetite
> for standardizing naming of everything else ?
>=20
> A further idea might be to actually have separate sub-directories for
> unit tests vs qtests. eg go for
>=20
>   tests
>     +- unit
>     +- qtest
>     +- iotests

That sounds like a good idea to me, too.

 Thomas
