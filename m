Received: from eggs.gnu.org ([2001:4830:134:3::10]:35489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fo6Gy-0002Fd-Aq
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 08:12:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fo6Gt-0001Ih-BU
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 08:12:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50390 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fo6Gt-0001IP-5g
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 08:11:59 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D09C0857AB
	for <qemu-devel@nongnu.org>; Fri, 10 Aug 2018 12:11:58 +0000 (UTC)
References: <20180808114830.7169-1-quintela@redhat.com>
	<20180808114830.7169-5-quintela@redhat.com>
	<b30ab0a9-8250-b0da-7c2c-c455db0dddcd@redhat.com>
	<87r2j6v5q7.fsf@trasno.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <51fa5967-1e9e-3f43-b79b-4a45930562c6@redhat.com>
Date: Fri, 10 Aug 2018 14:11:56 +0200
MIME-Version: 1.0
In-Reply-To: <87r2j6v5q7.fsf@trasno.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

On 10/08/2018 13:08, Juan Quintela wrote:
>> Emanuele's qos-test would do this automatically.  It would be nicer to
>> convert the whole ISA subsystem to use libqos and qos-test...
> Can we get this in until we get some volunteer for that other work?
> /me full of things on his plate at the moment.

Sure, but since this is RFC, I commented. :)  With qos-test, all tests
end up in a single binary that is generic for all QEMU targets, and
there's no need to synchronize the configuration with the testing.

The disadvantage of doing it at the Makefile level is that it relies on
the devices being either in all targets or none.  For example
CONFIG_ISA_TESTDEV cannot be removed from just
default-configs/ppc-softmmu.mak if you are building both a PPC and an
x86 target.

Paolo
