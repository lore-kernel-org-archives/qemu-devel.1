Received: from eggs.gnu.org ([2001:4830:134:3::10]:60869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dpAY0-0001uQ-K2
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:53:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dpAXv-0000xI-Uq
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:53:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41286)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dpAXv-0000wp-PA
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:53:27 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B867F130C
	for <qemu-devel@nongnu.org>; Tue,  5 Sep 2017 09:53:26 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170901180340.30009-1-eblake@redhat.com>
	<20170901180340.30009-3-eblake@redhat.com>
	<09983e6e-9506-ca02-a8ce-b1a1773d793c@redhat.com>
Date: Tue, 05 Sep 2017 11:53:22 +0200
In-Reply-To: <09983e6e-9506-ca02-a8ce-b1a1773d793c@redhat.com> (Thomas Huth's
	message of "Tue, 5 Sep 2017 09:20:50 +0200")
Message-ID: <874lshzd2l.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Thomas Huth <thuth@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, pbonzini@redhat.com, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

Thomas Huth <thuth@redhat.com> writes:

> On 01.09.2017 20:03, Eric Blake wrote:
>> It doesn't matter if things are unsorted, but finding stuff in a list
>> is easier when it is sorted.  (Sorted under LC_ALL=3DC rules, rather than
>> en_US.UTF-8).
>>=20
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>  tests/.gitignore | 30 +++++++++++++++---------------
>>  1 file changed, 15 insertions(+), 15 deletions(-)
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
>
> BTW, did you note the patch "build-sys: generate tests/.gitignore" from
> Marc-Andr=C3=A9 ? Maybe the list can be generated automatically, too...
>
>> diff --git a/tests/.gitignore b/tests/.gitignore
>> index 64ecd6683b..8d35a58751 100644
>> --- a/tests/.gitignore
>> +++ b/tests/.gitignore
>> @@ -1,25 +1,27 @@
>> +*-test
>
> ... but looking at this wildcard, I wonder if we just named most of our
> tests in a bad way. If we name the files something-test instead of
> test-something, we maybe do not need the automatic generation from
> Marc-Andr=C3=A9 (which is kind of ugly because it writes to the source
> directory - and this should not happen when doing out of tree builds).
>
> So what do you think about renaming our tests, so that the above
> wildcard applies instead?

Apropos naming tests: there's an (unspoken) convention to name unit
tests check-FOO or test-FOO and tests using libqtest FOO-test, but it's
not really honored anymore, probably because people creating tests
didn't know about it.
