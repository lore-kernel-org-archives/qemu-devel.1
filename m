Received: from eggs.gnu.org ([2001:4830:134:3::10]:45432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co39s-0008PT-Dk
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 03:15:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co39n-0002QB-Gy
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 03:15:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57854)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1co39n-0002Pq-BT
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 03:15:39 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-18-git-send-email-armbru@redhat.com>
	<1bc48113-aed0-5a5e-0818-f842c984ac64@redhat.com>
Date: Wed, 15 Mar 2017 08:15:36 +0100
In-Reply-To: <1bc48113-aed0-5a5e-0818-f842c984ac64@redhat.com> (Eric Blake's
	message of "Tue, 14 Mar 2017 15:14:57 -0500")
Message-ID: <87lgs7rox3.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-2.9 17/47] qapi: The #optional tag is
 redundant, drop
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
>> We traditionally mark optional members #optional in the doc comment.
>> Before commit 3313b61, this was entirely manual.
>> 
>> Commit 3313b61 added some automation because its qapi2texi.py relied
>> on #optional to determine whether a member is optional.  This is no
>> longer the case since the previous commit: the only thing qapi2texi.py
>> still does with #optional is stripping it out.  We still reject bogus
>> qapi-schema.json and six places for qga/qapi-schema.json.
>> 
>> Thus, you can't actually rely on #optional to see whether something is
>> optional.  Yet we still make people add it manually.  That's just
>> busy-work.
>> 
>> Drop the code to check, fix up and strip out #optional, along with all
>> instances of #optional.  To keep it out, add code to reject it, to be
>> dropped again once the dust settles.
>> 
>> No change to generated documentation.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  docs/qapi-code-gen.txt              |  16 +-
>>  docs/writing-qmp-commands.txt       |   4 +-
>>  qapi-schema.json                    | 378 ++++++++++++++++----------------
>>  qapi/block-core.json                | 418 ++++++++++++++++++------------------
>
> You'll have to rebase this on master, due to ...
>
>
>> @@ -2349,17 +2349,17 @@
>>  #
>>  # @volume:              Name of the Archipelago volume image
>>  #
>> -# @mport:               #optional The port number on which mapperd is
>> +# @mport:               The port number on which mapperd is
>>  #                       listening. This is optional
>>  #                       and if not specified, QEMU will make Archipelago
>>  #                       use the default port (1001).
>>  #
>
> ...commit e32ccbc killing broken archipelago

Yes.  Thanks for the heads-up.
