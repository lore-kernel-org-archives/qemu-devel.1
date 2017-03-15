Received: from eggs.gnu.org ([2001:4830:134:3::10]:44850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co36m-00073z-RP
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 03:12:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co36h-0001Na-TS
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 03:12:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59392)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1co36h-0001NH-OK
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 03:12:27 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-16-git-send-email-armbru@redhat.com>
	<da1f22b3-3a21-3ee7-25bf-3c9216cd2317@redhat.com>
Date: Wed, 15 Mar 2017 08:12:24 +0100
In-Reply-To: <da1f22b3-3a21-3ee7-25bf-3c9216cd2317@redhat.com> (Eric Blake's
	message of "Tue, 14 Mar 2017 12:16:04 -0500")
Message-ID: <87varbrp2f.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-2.9 15/47] qapi: Conjure up
 QAPIDoc.ArgSection for undocumented members
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

Eric Blake <eblake@redhat.com> writes:

> On 03/13/2017 01:18 AM, Markus Armbruster wrote:
>> qapi2texi.py already conjures up ArgSections for undocumented
>> enumeration values, in texi_enum).  Drop that, and conjure them up for
>
> Missing '('?

Or extra ')'.  I'll clean it up.

>> all kinds of "arguments" (enumeration values, object and alternate
>> type members) in qapi.py instead.
>> 
>> Take care to keep generated documentation exactly the same for now.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  scripts/qapi.py      |  5 ++---
>>  scripts/qapi2texi.py | 31 ++++++++++++++++---------------
>>  2 files changed, 18 insertions(+), 18 deletions(-)
>> 
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
