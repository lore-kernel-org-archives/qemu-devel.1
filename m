Received: from eggs.gnu.org ([2001:4830:134:3::10]:46662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1daf45-0004WK-SP
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 05:26:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1daf40-0007Q5-U0
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 05:26:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60042)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1daf40-0007Om-NT
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 05:26:36 -0400
Date: Thu, 27 Jul 2017 17:19:57 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170727091957.GC5117@lemon.lan>
References: <87o9so1hl7.fsf@dusky.pond.sub.org>
	<20170717103308.GI7163@stefanha-x1.localdomain>
	<8760epr9vw.fsf@dusky.pond.sub.org>
	<20170721153331.GL18014@stefanha-x1.localdomain>
	<026a093f-1f79-4af9-a5c9-d540342b472e@redhat.com>
	<8760eiuxu5.fsf@dusky.pond.sub.org>
	<9d4a3015-a3d2-e9d5-2254-0bcb77b37161@redhat.com>
	<871sp2gut9.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871sp2gut9.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] Improving QMP test coverage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Cleber Rosa <crosa@redhat.com>, =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Amador Pahim <apahim@redhat.com>, qemu-devel@nongnu.org, Cleber Rosa <cleber@redhat.com>

On Thu, 07/27 10:14, Markus Armbruster wrote:
> This brings some advantages of "verify output with diff" to tests that
> verify with code.  Improvement if it simplifies the verification code.
> 
> I'd still prefer *no* verification code (by delegating the job to diff)
> for tests where I can get away wit it.

Python based iotests can be (re)done in such a way that they print actual logs
(interactions with qtest/monitor, stdout/stderr of QEMU, etc) instead of the
current dot dot dot summary, then we automatically have diff based verification,
no?

One thing I feel painful with bash iotests is how harder it is to write
complicated test scenarios such as migration, incremental backup, etc.

On the other hand the iotests are more difficult to debug when things go wrong
because it eats the output which, if done with shell, should be very easy to
get.

Fam
