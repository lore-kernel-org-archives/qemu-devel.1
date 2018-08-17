Received: from eggs.gnu.org ([2001:4830:134:3::10]:34196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqfqU-0000Gk-19
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 10:35:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqfqP-00037D-Tb
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 10:35:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42326 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fqfqL-00035M-QI
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 10:35:15 -0400
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-57-armbru@redhat.com>
	<0b4553ab-1938-0632-89a4-fa77d0518d76@redhat.com>
	<87y3d51bvn.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <78da721f-78d5-d89c-0d4e-d1d272b99514@redhat.com>
Date: Fri, 17 Aug 2018 09:35:10 -0500
MIME-Version: 1.0
In-Reply-To: <87y3d51bvn.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 56/56] docs/interop/qmp-spec: How to force
 known good parser state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

On 08/17/2018 06:16 AM, Markus Armbruster wrote:

>>> +2.7 QGA Synchronization
>>>    -----------------------
>>>      When using QGA, an additional synchronization feature is built
>>> into
>>> -the protocol.  If the Client sends a raw 0xFF sentinel byte (not valid
>>> -JSON), then the Server will reset its state and discard all pending
>>> -data prior to the sentinel.  Conversely, if the Client makes use of
>>> -the 'guest-sync-delimited' command, the Server will send a raw 0xFF
>>> -sentinel byte prior to its response, to aid the Client in discarding
>>> -any data prior to the sentinel.
>>> +the protocol. If the Client makes use of the 'guest-sync-delimited'
>>> +command, the Server will send a raw 0xFF sentinel byte prior to its
>>> +response, to aid the Client in discarding any data prior to the
>>> +sentinel.
>>
>> Maybe worth mentioning "including error messages reported about any
>> lexical errors received prior to the guest-sync-delimited command"
>>
>>>        3. QMP Examples
>>>
> 
> What about:
> 
>      2.7 QGA Synchronization
>      -----------------------
> 
>      When a client connects to QGA over a transport lacking proper
>      connection semantics such as virtio-serial, QGA may have read partial
>      input from a previous client.  The client needs to force QGA's parser
>      into known-good state using the previous section's technique.
>      Moreover, the client may receive output a previous client didn't read.
>      To help with skipping that output, QGA provides the
>      'guest-sync-delimited' command.  Refer to its documentation for
>      details.

That works for me.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
