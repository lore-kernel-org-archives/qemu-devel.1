Received: from eggs.gnu.org ([2001:4830:134:3::10]:44197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ffq2L-0006Cp-AK
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 13:14:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ffq2I-0005fk-3y
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 13:14:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49810 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ffq2H-0005fU-VR
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 13:14:46 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180709091136.28849-1-e.emanuelegiuseppe@gmail.com>
	<20180711152737.GR31228@stefanha-x1.localdomain>
Date: Wed, 18 Jul 2018 19:14:43 +0200
In-Reply-To: <20180711152737.GR31228@stefanha-x1.localdomain> (Stefan
	Hajnoczi's message of "Wed, 11 Jul 2018 16:27:37 +0100")
Message-ID: <874lgwlb3w.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 0/7] Qtest driver framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Stefan Hajnoczi <stefanha@gmail.com> writes:

> On Mon, Jul 09, 2018 at 11:11:29AM +0200, Emanuele Giuseppe Esposito wrote:
>> This work is being done as Google Summer of Code 2018 project for QEMU,
>> my mentors are Paolo Bonzini and Laurent Vivier.
>> Additional infos on the project can be found at:
>> https://wiki.qemu.org/Features/qtest_driver_framework
>
> Thanks, I've finished reviewing this version.  It looks like a good
> start!
>
> The main challenge to me seems "how can we make tests simpler?".  The
> presence of a new API and object model raises the bar for writing and
> running tests.  I hope all qtests will use qgraph but if the complexity
> is too high then qgraph may only be used in a few niche cases where
> authors think it's worth abstracting machine types and others will
> continue to write qtests without qgraph.

The #1 reason for writing code a certain way is following existing
examples.  As long as "qtest without qgraph" is prevalent in existing
tests, it'll remain prevalent in new tests.  I'm afraid we'll need a
conversion effort.

> What are the next steps and do you have plans for making qgraph more
> integral to libqos?

Good questions.
