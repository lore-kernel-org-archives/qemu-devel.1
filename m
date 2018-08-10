Received: from eggs.gnu.org ([2001:4830:134:3::10]:34502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fo6DH-0007Ul-Ut
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 08:08:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fo6DG-0006F2-PN
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 08:08:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50244 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fo6DG-0006Es-J5
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 08:08:14 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 436145A747
	for <qemu-devel@nongnu.org>; Fri, 10 Aug 2018 12:08:14 +0000 (UTC)
References: <20180808114830.7169-1-quintela@redhat.com>
	<20180808114830.7169-3-quintela@redhat.com>
	<6c9bcc5b-21f0-60a8-bb8d-56861c2d4bd9@redhat.com>
	<87zhxuv5tn.fsf@trasno.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0739c44f-409d-4789-3869-3bb7a69439b7@redhat.com>
Date: Fri, 10 Aug 2018 14:08:09 +0200
MIME-Version: 1.0
In-Reply-To: <87zhxuv5tn.fsf@trasno.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 02/22] config: CONFIG_SERIAL* is already
 in pci.mak
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

On 10/08/2018 13:06, Juan Quintela wrote:
>> I don't think CONFIG_SERIAL_ISA should be in pci.mak though, and
>> CONFIG_SERIAL is a dependency of both CONFIG_SERIAL and
>> CONFIG_SERIAL_PCI.  Perhaps introduce a superio.mak with all the legacy
>> ISA devices?
>
> Hi
> 
> Several things here.
> 
> a- I am just removing bits that are duplicated in this patch
>    So I think it should got in as it is.

The right thing to do perhaps would be to remove CONFIG_SERIAL_ISA from
pci.mak.  There's no reason why a pSeries-only QEMU would include
CONFIG_SERIAL_ISA, I think.  Thomas, Laurent?

> b- SuperIO: I would really be able to remove isapc machine type and
>    isa-bus and related friends. (Yes, as put before, I know that all
>    pc's have an isa bus, but no need for things like mmouse nowadays)

Not sure how isapc and a hypothetical superio.mak are related.

> c- untangling piix and q35 is a bit of work.  The things that I remember
>    from memory:
>    * tests: we have tests for both on the same file (we can split the
>      file)

Again, you're duplicating what qos-test is doing, and again I'm not sure
how (c) is related to the other parts.

Paolo
