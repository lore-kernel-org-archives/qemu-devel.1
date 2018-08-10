Received: from eggs.gnu.org ([2001:4830:134:3::10]:50032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fo5Hy-0002KN-Af
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 07:09:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fo5Hv-0003tV-2D
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 07:09:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43590 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fo5Hu-0003sr-Tm
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 07:08:58 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7596B4023351
	for <qemu-devel@nongnu.org>; Fri, 10 Aug 2018 11:08:58 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <b30ab0a9-8250-b0da-7c2c-c455db0dddcd@redhat.com> (Paolo
	Bonzini's message of "Fri, 10 Aug 2018 12:20:28 +0200")
References: <20180808114830.7169-1-quintela@redhat.com>
	<20180808114830.7169-5-quintela@redhat.com>
	<b30ab0a9-8250-b0da-7c2c-c455db0dddcd@redhat.com>
Reply-To: quintela@redhat.com
Date: Fri, 10 Aug 2018 13:08:48 +0200
Message-ID: <87r2j6v5q7.fsf@trasno.org>
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
> On 08/08/2018 13:48, Juan Quintela wrote:
>> Once there, untangle endianness-test and boot-serial-test.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>
> Emanuele's qos-test would do this automatically.  It would be nicer to
> convert the whole ISA subsystem to use libqos and qos-test...

Can we get this in until we get some volunteer for that other work?
/me full of things on his plate at the moment.

Thanks, Juan.
