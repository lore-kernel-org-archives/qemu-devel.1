Received: from eggs.gnu.org ([2001:4830:134:3::10]:35771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faNQo-0005u4-NZ
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:41:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faNQj-0001Yf-P2
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:41:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36252 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1faNQj-0001Xo-K8
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:41:25 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180703085358.13941-1-armbru@redhat.com>
	<20180703085358.13941-4-armbru@redhat.com>
	<d57bed39-f4b8-adda-b763-ef286bba6c9d@redhat.com>
Date: Tue, 03 Jul 2018 17:41:23 +0200
In-Reply-To: <d57bed39-f4b8-adda-b763-ef286bba6c9d@redhat.com> (Eric Blake's
	message of "Tue, 3 Jul 2018 10:31:51 -0500")
Message-ID: <871sckgwd8.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 03/32] docs/interop/qmp: Improve OOB
 documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, stefanha@redhat.com, peterx@redhat.com, dgilbert@redhat.com

Eric Blake <eblake@redhat.com> writes:

> On 07/03/2018 03:53 AM, Markus Armbruster wrote:
>> OOB documentation is spread over qmp-spec.txt sections 2.2.1
>> Capabilities and 2.3 Issuing Commands.  The amount of detail is a bit
>> distracting there.  Move the meat of the matter to new section 2.3.1
>> Out of band execution.
>>
>> Throw in a few other improvements while there:
>>
>> * 2.2 Server Greeting: Drop advice to search entire capabilities
>>    array; should be obvious.
>>
>> * 3. QMP Examples
>>
>>    - 3.1 Server Greeting: Update greeting to the one we expect for the
>>      release.  Now shows capability "oob".  Update qmp-intro.txt
>>      likewise.
>>
>>    - 3.2 Capabilities negotiation: Show client accepting capability
>>      "oob".
>>
>>    - 3.7 Out-of-band execution: New.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> ---
>
>> +++ b/docs/interop/qmp-intro.txt
>> @@ -52,13 +52,14 @@ Escape character is '^]'.
>>       "QMP": {
>>           "version": {
>>               "qemu": {
>> -                "micro": 50,
>> -                "minor": 6,
>> -                "major": 1
>> -            },
>> -            "package": ""
>> -        },
>> +                "micro": 0,
>> +                "minor": 0 ,
>
> Extra space.

Assuming my pull request goes through, I'll have to tidy that up in a
follow-up patch.

>> +                "major": 3
>> +            },
>> +            "package": "v3.0.0"
>> +        },
>>           "capabilities": [
>> +            "oob"
>>           ]
>>       }
>>   }
> R-b stands.

Thanks!
