Received: from eggs.gnu.org ([2001:4830:134:3::10]:56231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dnmQ0-0003rU-V1
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 09:55:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dnmQ0-0004yg-4r
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 09:55:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51860)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dnmPz-0004yD-Ul
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 09:55:32 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C8C617E439
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 13:55:30 +0000 (UTC)
References: <1502389816-29772-1-git-send-email-armbru@redhat.com>
	<17b1385e-c14f-d933-661f-56217077ff79@redhat.com>
	<87shgy4gl8.fsf@dusky.pond.sub.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <fe594ae6-09e7-6f74-faa0-4b56f8dcea4f@redhat.com>
Date: Fri, 1 Sep 2017 15:55:27 +0200
MIME-Version: 1.0
In-Reply-To: <87shgy4gl8.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tests/qmp-test: Add generic,
 basic test of query commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, crosa@redhat.com

On 11.08.2017 11:08, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
> 
>> On 08/10/2017 01:30 PM, Markus Armbruster wrote:
[...]
>>> We get basic test coverage for the following commands:
>>
>> Cool!
>>
>>>
>>>     qom-list-types
>>>     query-acpi-ospm-status
>>>     query-balloon               (expected to fail)
>>
>>>     query-vm-generation-id      (expected to fail)
>>
>>> Most tested commands are expected to succeed.  The test does not check
>>> the return value then.  A few commands are expected to fail because
>>> they need special arguments to succeed, and this test is too dumb to
>>> supply them.
>>
>> Sounds like it would just be a matter of adding additional command line
>> parameters to the qemu being invoked for testing those commands?
> 
> In theory, setting up the state required for a query to succeed could be
> too complex for this stupid test.
> 
> In practice, query-balloon should need just "-device virtio-balloon",
> and query-vm-generation-id should need just "-device vmgenid" and ACPI
> (I think).  Not all machines can do these devices.  Let's what I can do
> in v2.

FWIW: I think the balloon testing could also go into
tests/virtio-balloon-test.c instead ... that test is only run on
architectures where the device should be available.

 Thomas
