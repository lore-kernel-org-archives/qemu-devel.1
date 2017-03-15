Received: from eggs.gnu.org ([2001:4830:134:3::10]:46935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co3Hy-0002XG-86
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 03:24:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co3Ht-0004fV-CQ
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 03:24:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60258)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1co3Ht-0004fP-6q
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 03:24:01 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-25-git-send-email-armbru@redhat.com>
	<7fee33e8-ba6f-35bf-ebd8-571f35849641@redhat.com>
Date: Wed, 15 Mar 2017 08:23:58 +0100
In-Reply-To: <7fee33e8-ba6f-35bf-ebd8-571f35849641@redhat.com> (Eric Blake's
	message of "Tue, 14 Mar 2017 14:12:36 -0500")
Message-ID: <87bmt3roj5.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-2.9 24/47] qapi2texi: Implement boxed
 argument documentation
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
>> This replaces manual references like "For the arguments, see the
>> documentation of ..." by a generated reference "Arguments: the members
>> of ...".
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  qapi-schema.json     |  2 +-
>>  qapi/block-core.json | 10 ----------
>>  scripts/qapi2texi.py |  8 +++++++-
>>  3 files changed, 8 insertions(+), 12 deletions(-)
>
> Should be even more handy when you add html links to the type
> documentation from the command documentation, later in the series.

Yes, but actual links are left to a later series.

> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
