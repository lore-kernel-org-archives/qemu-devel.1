Received: from eggs.gnu.org ([2001:4830:134:3::10]:55235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fo9AL-0008K3-4l
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 11:17:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fo9AH-0006wK-PR
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 11:17:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52508 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fo9AH-0006vG-LX
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 11:17:21 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D295D4000B74
	for <qemu-devel@nongnu.org>; Fri, 10 Aug 2018 15:17:20 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <51fa5967-1e9e-3f43-b79b-4a45930562c6@redhat.com> (Paolo
	Bonzini's message of "Fri, 10 Aug 2018 14:11:56 +0200")
References: <20180808114830.7169-1-quintela@redhat.com>
	<20180808114830.7169-5-quintela@redhat.com>
	<b30ab0a9-8250-b0da-7c2c-c455db0dddcd@redhat.com>
	<87r2j6v5q7.fsf@trasno.org>
	<51fa5967-1e9e-3f43-b79b-4a45930562c6@redhat.com>
Reply-To: quintela@redhat.com
Date: Fri, 10 Aug 2018 17:17:10 +0200
Message-ID: <87a7puuu89.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 04/22] check: Only test isa-testdev when
 it is compiled in
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 10/08/2018 13:08, Juan Quintela wrote:
>>> Emanuele's qos-test would do this automatically.  It would be nicer to
>>> convert the whole ISA subsystem to use libqos and qos-test...
>> Can we get this in until we get some volunteer for that other work?
>> /me full of things on his plate at the moment.
>
> Sure, but since this is RFC, I commented. :)

I didn't expect less of you O:-)

> With qos-test, all tests
> end up in a single binary that is generic for all QEMU targets, and
> there's no need to synchronize the configuration with the testing.
>
> The disadvantage of doing it at the Makefile level is that it relies on
> the devices being either in all targets or none.  For example
> CONFIG_ISA_TESTDEV cannot be removed from just
> default-configs/ppc-softmmu.mak if you are building both a PPC and an
> x86 target.

I can live with that.  My use case is:
- complining for more than one architecture: everything
  under the sun is compiled in
- development: I choose a single architecture and the minimal amount of
  devices for whatever I am testing

So, for me is perfect, thanks.

Later, Juan.
