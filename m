Received: from eggs.gnu.org ([2001:4830:134:3::10]:59089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqiWd-0005NM-41
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 11:50:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqiWc-0002dJ-3n
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 11:50:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60588)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cqiWb-0002d6-U6
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 11:50:14 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D5DF167BB0
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 15:50:13 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1490115473-24839-1-git-send-email-armbru@redhat.com>
	<dbbe78d8-2c09-2832-89f4-51b50ee6bb8f@redhat.com>
Date: Wed, 22 Mar 2017 16:50:10 +0100
In-Reply-To: <dbbe78d8-2c09-2832-89f4-51b50ee6bb8f@redhat.com> (Max Reitz's
	message of "Wed, 22 Mar 2017 15:10:47 +0100")
Message-ID: <874lylgvkd.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-2.9] block: Declare blockdev-add and
 blockdev-del supported
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, pkrempa@redhat.com

Max Reitz <mreitz@redhat.com> writes:

> On 21.03.2017 17:57, Markus Armbruster wrote:
>> It's been a long journey, but here we are.
>> 
>> x-blockdev-remove-medium, x-blockdev-insert-medium and
>> x-blockdev-change need a bit more work, so leave them alone for now.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  blockdev.c             |  4 ++--
>>  qapi/block-core.json   | 14 +++++---------
>>  tests/qemu-iotests/139 |  8 ++++----
>>  tests/qemu-iotests/141 |  4 ++--
>>  tests/qemu-iotests/147 |  2 +-
>>  5 files changed, 14 insertions(+), 18 deletions(-)
>
> [...]
>
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index 0f132fc..5d913d4 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -2907,11 +2907,7 @@
>>  # BlockBackend will be created; otherwise, @node-name is mandatory at the top
>>  # level and no BlockBackend will be created.
>>  #
>> -# Note: This command is still a work in progress.  It doesn't support all
>> -# block drivers among other things.  Stay away from it unless you want
>> -# to help with its development.
>> -#
>> -# Since: 1.7
>> +# Since: 2.9
>>  #
>>  # Example:
>>  #
>> @@ -2957,7 +2953,7 @@
>>  { 'command': 'blockdev-add', 'data': 'BlockdevOptions', 'boxed': true }
>>  
>>  ##
>> -# @x-blockdev-del:
>> +# @blockdev-del:
>>  #
>>  # Deletes a block device that has been added using blockdev-add.
>>  # The command will fail if the node is attached to a device or is
>> @@ -2969,7 +2965,7 @@
>>  # experimental. Stay away from it unless you want to help with its
>>  # development.
>
> This part of the comment very much looks like it should be removed.

v2 coming up, thanks!

> Max
>
>>  #
>> -# Since: 2.5
>> +# Since: 2.9
>>  #
>>  # Example:
>>  #
>
> [...]
