Received: from eggs.gnu.org ([2001:4830:134:3::10]:41917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cjqeb-0000DJ-2y
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 12:06:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cjqea-0007Tb-0l
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 12:06:05 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1488491046-2549-1-git-send-email-armbru@redhat.com>
	<1488491046-2549-14-git-send-email-armbru@redhat.com>
	<90d9033f-49b2-6f00-d984-dbfd4f21f1da@redhat.com>
Date: Fri, 03 Mar 2017 18:05:56 +0100
In-Reply-To: <90d9033f-49b2-6f00-d984-dbfd4f21f1da@redhat.com> (Eric Blake's
	message of "Fri, 3 Mar 2017 10:31:08 -0600")
Message-ID: <87zih2mgsr.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 13/15] qapi-schema: Rename GlusterServer to
 SocketAddressFlat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, mitake.hitoshi@lab.ntt.co.jp, jcody@redhat.com, qemu-block@nongnu.org, namei.unix@gmail.com

Eric Blake <eblake@redhat.com> writes:

> On 03/02/2017 03:44 PM, Markus Armbruster wrote:
>> As its documentation says, it's not specific to Gluster.  Rename it,
>> as I'm going to use it for something else.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  block/gluster.c      | 38 +++++++++++++++++++-------------------
>>  qapi-schema.json     | 38 ++++++++++++++++++++++++++++++++++++++
>>  qapi/block-core.json | 46 +---------------------------------------------
>>  3 files changed, 58 insertions(+), 64 deletions(-)
>
> Mostly mechanical once you deal with the cross-file motion.  Changing
> the type name has no impact on the wire representation, so it's safe.
>
> Reviewed-by: Eric Blake <eblake@redhat.com>
>
>> +++ b/qapi-schema.json
>> @@ -4101,6 +4101,44 @@
>>      'fd': 'String' } }
>>  
>>  ##
>> +# @SocketAddressFlatType:
>> +#
>> +# Available SocketAddressFlat types
>> +#
>> +# @tcp:   Internet address
>> +#
>> +# @unix:  Unix domain socket
>> +#
>> +# Since: 2.9
>
> I probably would have listed 'since: 2.7', since the type is unchanged
> from its pre-move location...

I'd have to bump it right in the next patch :)

>> +#
>> +# Since: 2.9
>> +##
>> +{ 'union': 'SocketAddressFlat',
>
> and again
>
>
>> +++ b/qapi/block-core.json
>> @@ -2533,50 +2533,6 @@
>>              '*read-pattern': 'QuorumReadPattern' } }
>>  
>>  ##
>> -# @GlusterTransport:
>> -#
>> -# An enumeration of Gluster transport types
>> -#
>> -# @tcp:   TCP   - Transmission Control Protocol
>> -#
>> -# @unix:  UNIX  - Unix domain socket
>> -#
>> -# Since: 2.7
>
> ...here.
