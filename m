Received: from eggs.gnu.org ([2001:4830:134:3::10]:50584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dXVIe-0005mt-KW
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 12:24:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dXVIb-0007pV-Ez
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 12:24:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54198)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dXVIb-0007oE-91
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 12:24:37 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <87o9so1hl7.fsf@dusky.pond.sub.org>
	<20170717103308.GI7163@stefanha-x1.localdomain>
Date: Tue, 18 Jul 2017 18:24:19 +0200
In-Reply-To: <20170717103308.GI7163@stefanha-x1.localdomain> (Stefan
	Hajnoczi's message of "Mon, 17 Jul 2017 11:33:08 +0100")
Message-ID: <8760epr9vw.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] Improving QMP test coverage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>, Amador Pahim <apahim@redhat.com>, qemu-devel@nongnu.org, Cleber Rosa <cleber@redhat.com>

Stefan Hajnoczi <stefanha@gmail.com> writes:

> On Thu, Jul 13, 2017 at 05:28:52PM +0200, Markus Armbruster wrote:
>> What can we do to improve QMP testing?  Sadly, I don't have the master
>> plan ready.  I can tell people their new code needs to come with tests,
>> but that won't help much unless subsystem maintainers pick up the habit,
>> too.  There are a few obvious tests to write for old code, such as a
>> generic test of query-like commands without arguments and without side
>> effects, similar to what test-hmp.c does for HMP command info (I hope to
>> get around to that one).  But for much of the old code, we don't even
>> know where the test coverage holes are.
>> 
>> Ideas anyone?
>
> It makes sense for maintainers to ask that new QMP commands come with
> comprehensive tests.
>
> For me the main question is how to begin?  What is the easiest and
> preferred way to write QMP command test cases?
>
> Today the most common approach is a qtest test case that sends commands
> and verifies that the expected response is returned.  This approach
> works but we could benefit from a discussion about the alternatives
> (e.g.  qemu-iotests style shell scripts with output diffing).

Output testing style delegates checking ouput to diff.  I rather like it
when text output is readily available.  It is when testing QMP.  A
non-trivial example using this style could be useful, as discussing
ideas tends to be more productive when they come with patches.

> If it's easy to write tests then developers will contribute more tests.

Yes.  Maintainers can more easily demand them, too.
