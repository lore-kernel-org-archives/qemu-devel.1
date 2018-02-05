Received: from eggs.gnu.org ([2001:4830:134:3::10]:43476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1eijR9-0006Pa-8n
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 11:16:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1eijR6-0002rQ-3k
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 11:16:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56062)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1eijR5-0002b4-Su
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 11:16:04 -0500
References: <7e30d2cc-6c42-15e9-78ef-1085e081a386@redhat.com>
	<20180125141158.GC28396@stefanha-x1.localdomain>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <8b706e9f-a5b4-88e7-75fd-46f9cfae13ef@redhat.com>
Date: Mon, 5 Feb 2018 11:15:50 -0500
MIME-Version: 1.0
In-Reply-To: <20180125141158.GC28396@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Functional tests (AKA Avocado-based tests)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, Amador Pahim <apahim@redhat.com>, Jeff Nelson <jen@redhat.com>



On 01/25/2018 09:11 AM, Stefan Hajnoczi wrote:
> On Wed, Jan 17, 2018 at 03:05:54AM -0500, Cleber Rosa wrote:
>> This is about how QEMU developers can get started with functional
>> tests that are built on top of the Avocado libraries (and meant to be
>> run with the Avocado test runner).
> 
> Here is my guess at where this fits into QEMU's testing landscape:
> 
> Avocado can help us write a new kind of test - functional (acceptance)
> tests - that run full-blown guest operating systems, invoke shell
> commands inside guests, and also use QMP.  Avocado can probably test
> guest OS installation and boot.
> 

That is the main goal indeed.  Then at the same time, tests that won't
"run full-brown guest operating systems" should also be easy to
write[1].  For instance, I gave myself a few minutes, literally, to
prove this point and wrote a few VNC related tests[2].

> There is some overlap with what exists in tests/ today, but I guess it
> won't replace check (unit tests), qtests, or qemu-iotests.
> 

There's no *need* whatsoever to replace anything.  People may see value
in using the Avocado test runner to run other tests at some point, but
that's completely unrelated to your original question and our goal.

> Is this how you envision Avocado usage in QEMU?
> 
> Stefan
> 

In short, yes.  The long answer has already been given above.

- Cleber.

[1] - As opposed to say, Avocado-VT, where a lot of pre/post processing,
including guest operating system images, will usually happen by default.

[2] -
https://github.com/clebergnu/qemu/blob/vnc_tests/tests/avocado/test_vnc.py

-- 
Cleber Rosa
[ Sr Software Engineer - Virtualization Team - Red Hat ]
[ Avocado Test Framework - avocado-framework.github.io ]
[  7ABB 96EB 8B46 B94D 5E0F  E9BB 657E 8D33 A5F2 09F3  ]
