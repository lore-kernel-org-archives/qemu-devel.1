Received: from eggs.gnu.org ([2001:4830:134:3::10]:35127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cf2aY-0003Cb-BL
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 05:50:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cf2aT-0000ka-Ev
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 05:50:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cf2aT-0000kL-8s
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 05:49:57 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5CD6B85376
	for <qemu-devel@nongnu.org>; Sat, 18 Feb 2017 10:49:57 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1487363905-9480-1-git-send-email-armbru@redhat.com>
	<1487363905-9480-3-git-send-email-armbru@redhat.com>
	<b886937d-ed47-6ae5-f7da-3bea4f2d122d@redhat.com>
Date: Sat, 18 Feb 2017 11:49:54 +0100
In-Reply-To: <b886937d-ed47-6ae5-f7da-3bea4f2d122d@redhat.com> (Eric Blake's
	message of "Fri, 17 Feb 2017 16:34:44 -0600")
Message-ID: <877f4n6ael.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 02/14] check-qdict: Simplify
 qdict_crumple_test_recursive()
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

> On 02/17/2017 02:38 PM, Markus Armbruster wrote:
>> Use qdict_get_qdict(), qdict_get_qlist() instead of qdict_get()
>> followed by qobject_to_qdict(), qobject_to_qlist().
>
> Worth a Coccinelle script to make sure we catch it all?

I'm pretty sure I got them all: I examined all uses of the QType
enumeration constants for this series.

>> 
>> While there, drop some redundant code.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  tests/check-qdict.c | 25 +++++++++----------------
>>  1 file changed, 9 insertions(+), 16 deletions(-)
>> 
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
