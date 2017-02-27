Received: from eggs.gnu.org ([2001:4830:134:3::10]:38782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciDxm-0005gA-Ky
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 00:35:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciDxj-0002xW-Jg
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 00:35:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ciDxj-0002ww-EU
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 00:35:07 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9F15583F38
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 05:35:07 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1487886317-27400-1-git-send-email-armbru@redhat.com>
	<1487886317-27400-17-git-send-email-armbru@redhat.com>
	<79895263-30d6-ed80-7d47-d2f22dbd6c47@redhat.com>
Date: Mon, 27 Feb 2017 06:35:04 +0100
In-Reply-To: <79895263-30d6-ed80-7d47-d2f22dbd6c47@redhat.com> (Eric Blake's
	message of "Sat, 25 Feb 2017 10:30:25 -0600")
Message-ID: <87o9xonqlz.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 16/21] test-qobject-input-visitor: Use
 strict visitor
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

> On 02/23/2017 03:45 PM, Markus Armbruster wrote:
>> The qobject input visitor comes in a strict and a non-strict variant.
>> This test is the non-strict variant's last user.
>
> Well, depending on Paolo's proposed addition.

Needs a commit message tweak if Paolo's goes in first.

>>  Turns out it relies
>> on non-strict only in test_visitor_in_null(), and just out of
>> laziness.  We don't actually test the non-strict behavior.
>> 
>> Clean up test_visitor_in_null(), and switch to the strict variant.
>> The next commit will drop the non-strict variant.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  tests/test-qobject-input-visitor.c | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> I'm in favor of unifying the two tests into one and reducing the
> duplication (this and the next patch), whether or not we decide that

Patch after next, actually.

> Paolo's patch means we don't want to eliminate non-strict mode.
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
