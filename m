Received: from eggs.gnu.org ([2001:4830:134:3::10]:44807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cfcEh-0008KT-2p
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 19:53:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cfcEd-0001XX-W7
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 19:53:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40248)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cfcEd-0001Wd-Pz
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 19:53:47 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1487053524-18674-1-git-send-email-den@openvz.org>
	<1487053524-18674-2-git-send-email-den@openvz.org>
	<f805c30f-47d1-6f79-c01b-ac1155d6859a@redhat.com>
Date: Mon, 20 Feb 2017 01:53:42 +0100
In-Reply-To: <f805c30f-47d1-6f79-c01b-ac1155d6859a@redhat.com> (Eric Blake's
	message of "Wed, 15 Feb 2017 13:41:57 -0600")
Message-ID: <87bmtxvg15.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 1/3] i386/cpu: add crash-information QOM
 property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org, Anton Nefedov <anton.nefedov@virtuozzo.com>

Eric Blake <eblake@redhat.com> writes:

> On 02/14/2017 12:25 AM, Denis V. Lunev wrote:
>> From: Anton Nefedov <anton.nefedov@virtuozzo.com>
>> 
>> Windows reports BSOD parameters through Hyper-V crash MSRs. This
>> information is very useful for initial crash analysis and thus
>> it would be nice to have a way to fetch it.
>> 
>> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> ---
>
>> +++ b/qapi-schema.json
>> @@ -5846,6 +5846,30 @@
>>    'data': [ 'pause', 'poweroff' ] }
>>  
>>  ##
>> +# @GuestPanicInformation:
>> +#
>> +# Information about a guest panic
>> +#
>> +# Since: 2.9
>> +##
>> +{'union': 'GuestPanicInformation',
>> + 'data': { 'hyper-v': 'GuestPanicInformationHyperV' } }
>> +
>
> Markus has been trying to eliminate the addition of new "simple unions"
> - while they are syntactically shorter in the .json file, they are
> bulkier over the wire with extra {} nesting, and more verbose in the C
> code, when compared to using a flat union instead.  I won't necessarily
> hold up this patch as-is, but if we are going to avoid new simple
> unions, we have to change this before 2.9 bakes in the {} nesting (we
> can convert a simple union to a flat union without breaking QMP
> back-compat, but it's messier than if we avoid the nesting to begin with).

We should not add new simple unions.  Please have a look at my
"[PATCH 0/2] Flatten simple unions where we still can".

Message-Id: <1486569864-17005-1-git-send-email-armbru@redhat.com>
https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg01689.html
