Received: from eggs.gnu.org ([2001:4830:134:3::10]:34882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fo7ng-0001bF-Bc
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 09:49:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fo7nc-0000HZ-9g
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 09:49:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57528 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fo7nc-0000HF-4c
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 09:49:52 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-5-armbru@redhat.com>
	<8db80373-f9fb-ca83-5c56-4439b807e78e@redhat.com>
Date: Fri, 10 Aug 2018 15:49:47 +0200
In-Reply-To: <8db80373-f9fb-ca83-5c56-4439b807e78e@redhat.com> (Eric Blake's
	message of "Thu, 9 Aug 2018 08:38:06 -0500")
Message-ID: <87in4imiv8.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 04/56] qmp-cmd-test: Split off qmp-test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

Eric Blake <eblake@redhat.com> writes:

> On 08/08/2018 07:02 AM, Markus Armbruster wrote:
>> qmp-test is for QMP protocol tests.  Commit e4a426e75ef added generic,
>> basic tests of query commands to it.  Move them to their own test
>> program qmp-cmd-test, to keep qmp-test focused on the protocol.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   MAINTAINERS            |   1 +
>>   tests/Makefile.include |   3 +
>>   tests/qmp-cmd-test.c   | 213 +++++++++++++++++++++++++++++++++++++++++
>>   tests/qmp-test.c       | 191 +-----------------------------------
>>   4 files changed, 218 insertions(+), 190 deletions(-)
>>   create mode 100644 tests/qmp-cmd-test.c
>>
>
>> +++ b/tests/qmp-cmd-test.c
>> @@ -0,0 +1,213 @@
>> +/*
>> + * QMP command test cases
>> + *
>> + * Copyright (c) 2017 Red Hat Inc.
>
> Worth adding 2018?

I'll do that in one of the patches that adds something new.

>> + *
>> + * Authors:
>> + *  Markus Armbruster <armbru@redhat.com>,
>> + *
>
> Trailing comma is odd. And these days, I'm inclined to omit Author
> lines (git history is more reliable, anyways)

Comma inherited from qmp-test.c.  I'm fixing both.

> Those are minor issues, where it is up to you if/how to clean them, so
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
