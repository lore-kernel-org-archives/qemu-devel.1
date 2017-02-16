Received: from eggs.gnu.org ([2001:4830:134:3::10]:47695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ceMui-00085P-8Y
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:20:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ceMuf-0001Lj-0n
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:20:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51588)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ceMue-0001Lc-Ri
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:20:00 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D1C91800
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 14:20:00 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
	<1487067971-10443-12-git-send-email-armbru@redhat.com>
	<a2866efe-40be-8338-8e02-4e1f7faf5264@redhat.com>
Date: Thu, 16 Feb 2017 15:19:57 +0100
In-Reply-To: <a2866efe-40be-8338-8e02-4e1f7faf5264@redhat.com> (Eric Blake's
	message of "Tue, 14 Feb 2017 16:53:27 -0600")
Message-ID: <87fujegquq.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 11/24] tests/test-cutils: Cover
 qemu_strtosz() invalid input
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

> On 02/14/2017 04:25 AM, Markus Armbruster wrote:
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  tests/test-cutils.c | 24 ++++++++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>> 
>
> Perhaps you could also add a test of "-".  Either way,

The test cases match the ones for qemu_strtol() & friends:
test_qemu_stro*_{empty,whitespace,invalid}().  If we add "-" here, we
should probably add it there as well.  I think we totally should if we
were testing a strtol() implementation.  But we're only testing a
wrapper, and other test cases cover the "strtol() fails without
converting anything" case, so I think we're okay.

> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
