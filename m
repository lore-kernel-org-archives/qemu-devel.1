Received: from eggs.gnu.org ([2001:4830:134:3::10]:47057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faEoY-0003Wq-4r
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 02:29:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faEoV-0007NO-1w
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 02:29:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45220 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1faEoU-0007NC-Sm
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 02:29:22 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7A22B857AB
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 06:29:22 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180702162218.13678-1-armbru@redhat.com>
	<20180702162218.13678-11-armbru@redhat.com>
	<20bc5022-ba5f-218d-6d68-d5548b12209b@redhat.com>
Date: Tue, 03 Jul 2018 08:29:18 +0200
In-Reply-To: <20bc5022-ba5f-218d-6d68-d5548b12209b@redhat.com> (Eric Blake's
	message of "Mon, 2 Jul 2018 20:47:20 -0500")
Message-ID: <87va9w6ddt.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 10/32] tests/test-qga: Demonstrate the
 guest-agent ignores "control"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, peterx@redhat.com, dgilbert@redhat.com

Eric Blake <eblake@redhat.com> writes:

> On 07/02/2018 11:21 AM, Markus Armbruster wrote:
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   tests/test-qga.c | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>
> Well, if we get rid of 'control' in favor of 'exec-oob', this test
> would still have to test that QGA doesn't support oob.
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

PATCH 12 gets rid of it, but the test still serves to cover "random crap
gets rejected" then.
