Received: from eggs.gnu.org ([2001:4830:134:3::10]:51441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ez0hB-00008B-4Q
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 09:55:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ez0hA-0007fy-6f
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 09:55:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40804 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ez0hA-0007fd-2o
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 09:55:56 -0400
References: <cover.1521717086.git.berto@igalia.com>
	<cb7dcdf3685e430783b24cce3a3cbd3aaa997cb7.1521717086.git.berto@igalia.com>
	<297790d0-cac0-8609-7516-d6025b4759a8@redhat.com>
	<w51sh8sdy64.fsf@maestria.local.igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <613d0116-6251-6c6b-a4f8-255d7ff7c648@redhat.com>
Date: Thu, 22 Mar 2018 08:55:53 -0500
MIME-Version: 1.0
In-Reply-To: <w51sh8sdy64.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.12 v3 2/2] iotests: Update 186 after
 commit ac64273c66ab136c44043259162
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 03/22/2018 08:42 AM, Alberto Garcia wrote:
> On Thu 22 Mar 2018 02:17:23 PM CET, Eric Blake wrote:
>>> --- a/tests/qemu-iotests/186.out
>>> +++ b/tests/qemu-iotests/186.out
>>> @@ -404,7 +404,7 @@ Testing: -drive if=floppy
>>>    QEMU X.Y.Z monitor - type 'help' for more information
>>>    (qemu) info block
>>>    floppy0: [not inserted]
>>> -    Attached to:      /machine/unattached/device[17]
>>> +    Attached to:      /machine/unattached/device[13]
>>
>> It looks like this name is quite flexible; would it not be better to
>> enhance 186 to sed out the name (s/Attached to:.*/Attached to: PATH/)
>> and then adjust the .out so that it is no longer sensitive to these
>> types of internal renames?
> 
> That's a good idea, shall we hide the number only?  (i.e. leave
> "/machine/unattached/device[INDEX]" or something like that), or can the
> rest of the path also change?

I don't see the value in knowing whether the device is unattached, or if 
a future attaches it somewhere, so changing the entire thing to PATH 
seems reasonable, rather than trying to just focus on the index.  (That 
is, the sed expression I mentioned is sufficient)

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
