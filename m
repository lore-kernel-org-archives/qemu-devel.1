Received: from eggs.gnu.org ([2001:4830:134:3::10]:37624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gRNiy-00042W-Ko
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:43:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gRNit-000295-WA
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:43:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44684)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gRNit-00028y-R3
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:43:15 -0500
References: <20181122121402.13764-1-yuval.shaia@oracle.com>
	<20181122121402.13764-11-yuval.shaia@oracle.com>
	<87bm6cnomg.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3858b9a3-8843-79bf-0f86-87a48c446ba4@redhat.com>
Date: Mon, 26 Nov 2018 14:43:13 -0600
MIME-Version: 1.0
In-Reply-To: <87bm6cnomg.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 10/24] qapi: Define new QMP message for
 pvrdma
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Yuval Shaia <yuval.shaia@oracle.com>
Cc: marcel.apfelbaum@gmail.com, dmitry.fleytman@gmail.com, jasowang@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, shamir.rabinovitch@oracle.com, cohuck@redhat.com

On 11/26/18 4:01 AM, Markus Armbruster wrote:
> Yuval Shaia <yuval.shaia@oracle.com> writes:
> 
>> pvrdma requires that the same GID attached to it will be attached to the
>> backend device in the host.
>>
>> A new QMP messages is defined so pvrdma device can broadcast any change
>> made to its GID table. This event is captured by libvirt which in turn
>> will update the GID table in the backend device.
>>
>> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
>> Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>> ---

>> +++ b/qapi/rdma.json
>> @@ -0,0 +1,38 @@
>> +# -*- Mode: Python -*-
>> +#
>> +
>> +##
>> +# = RDMA device
>> +##
>> +
>> +##
>> +# @RDMA_GID_STATUS_CHANGED:
>> +#
>> +# Emitted when guest driver adds/deletes GID to/from device
>> +#
>> +# @netdev: RoCE Network Device name - char *
>> +#
>> +# @gid-status: Add or delete indication - bool
>> +#
>> +# @subnet-prefix: Subnet Prefix - uint64
>> +#
>> +# @interface-id : Interface ID - uint64
>> +#
>> +# Since: 3.2

The next release will be 4.0, not 3.2 (we'll probably have to do a 
global search-and-replace in January to catch things that have slipped 
in, as your patch is not alone in that).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
