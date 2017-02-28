Received: from eggs.gnu.org ([2001:4830:134:3::10]:44685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cikK1-0005wu-5e
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:08:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cikJw-0007km-7M
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:08:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43624)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cikJw-0007kb-1K
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:08:12 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4C1147E9D1
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 16:08:12 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1488145424-14974-1-git-send-email-armbru@redhat.com>
	<1488145424-14974-20-git-send-email-armbru@redhat.com>
	<c4df7917-1081-9fce-7bec-28a1467e88e1@redhat.com>
Date: Tue, 28 Feb 2017 17:08:09 +0100
In-Reply-To: <c4df7917-1081-9fce-7bec-28a1467e88e1@redhat.com> (Eric Blake's
	message of "Tue, 28 Feb 2017 09:44:55 -0600")
Message-ID: <87y3wqnvrq.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 19/26] test-string-input-visitor: Tear
 down existing test automatically
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

> On 02/26/2017 03:43 PM, Markus Armbruster wrote:
>> Call visitor_input_teardown() from visitor_input_test_init(), so you
>> don't have to call it from the actial tests.
>
> s/actial/actual/

Will fix!

>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  tests/test-string-input-visitor.c | 19 ++-----------------
>>  1 file changed, 2 insertions(+), 17 deletions(-)
>> 
>
> Reviewed-by: Eric Blake <eblake@redhat.com>
>
> I tested this one under valgrind to ensure no weird memory issues
> cropped up, so you can also add:
>
> Tested-by: Eric Blake <eblake@redhat.com>

Thanks!
