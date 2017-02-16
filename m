Received: from eggs.gnu.org ([2001:4830:134:3::10]:56522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ceLmG-0006k4-1J
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:07:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ceLmC-0006Ek-RU
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:07:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60200)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ceLmC-0006ET-Lm
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:07:12 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DC7C3461C3
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 13:07:12 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
	<1487067971-10443-5-git-send-email-armbru@redhat.com>
	<8fe3098f-6e5a-b052-478b-710542253854@redhat.com>
Date: Thu, 16 Feb 2017 14:07:09 +0100
In-Reply-To: <8fe3098f-6e5a-b052-478b-710542253854@redhat.com> (Eric Blake's
	message of "Tue, 14 Feb 2017 15:28:29 -0600")
Message-ID: <87mvdmgu82.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 04/24] tests/test-cutils: Clean up
 qemu_strtoul() result checks
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
>> Use unsigned comparisons to check the result of qemu_strtoul() and
>> strtoull().
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  tests/test-cutils.c | 60 ++++++++++++++++++++++++++---------------------------
>>  1 file changed, 30 insertions(+), 30 deletions(-)
>> 
>
> No real difference except when the test fails (better printed result if
> the number being printed exceeds the max signed counterpart value), but
> never hurts to be more precise.

Sadly, my version of glib prints signed all the same.

I'll use g_assert_cmphex() where useful in v2.

> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
