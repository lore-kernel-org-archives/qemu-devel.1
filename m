Received: from eggs.gnu.org ([2001:4830:134:3::10]:57206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1egn8r-0000AN-HK
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 02:49:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1egn8o-0008PI-Fa
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 02:49:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60096)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1egn8o-0008Od-9C
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 02:49:10 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 781FE3AD8E
	for <qemu-devel@nongnu.org>; Wed, 31 Jan 2018 07:49:09 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180130102202.28519-1-armbru@redhat.com>
	<20180130102202.28519-3-armbru@redhat.com>
	<32879051-3924-b8ec-d2e9-5765d1bb6ac8@redhat.com>
Date: Wed, 31 Jan 2018 08:49:07 +0100
In-Reply-To: <32879051-3924-b8ec-d2e9-5765d1bb6ac8@redhat.com> (Eric Blake's
	message of "Tue, 30 Jan 2018 09:46:34 -0600")
Message-ID: <87h8r279jg.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 02/18] Drop superfluous includes of
 qapi-types.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org

Eric Blake <eblake@redhat.com> writes:

> On 01/30/2018 04:21 AM, Markus Armbruster wrote:
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>
>> +++ b/tests/test-clone-visitor.c
>> @@ -11,7 +11,6 @@
>>  
>>  #include "qemu-common.h"
>>  #include "qapi/clone-visitor.h"
>> -#include "test-qapi-types.h"
>
> Overactive sed pattern?  This is a different header.  While the tests
> still pass after deleting this include, removal of the test-qapi-types.h
> line here and in other tests/ files should be a separate patch, or else
> the commit message updated to mention it.

Intentional.  I'll amend the commit message.
