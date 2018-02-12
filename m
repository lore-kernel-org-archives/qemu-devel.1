Received: from eggs.gnu.org ([2001:4830:134:3::10]:54188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1elAss-0005nx-86
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 04:58:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1elAsr-0005wI-GW
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 04:58:50 -0500
References: <20180207162920.28386-1-pbonzini@redhat.com>
	<84467de4-5563-8293-9838-a5d48878597f@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b1278b08-0881-1dec-05c7-22da222cab93@redhat.com>
Date: Mon, 12 Feb 2018 10:58:31 +0100
MIME-Version: 1.0
In-Reply-To: <84467de4-5563-8293-9838-a5d48878597f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] block: early check for blockers on
 drive-mirror
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org

On 10/02/2018 00:07, John Snow wrote:
>> +    /* Early check to avoid creating target */
>> +    if (bdrv_op_is_blocked(bs, BLOCK_OP_TYPE_MIRROR_SOURCE, errp)) {
>> +        return;
>> +    }
>> +
>>      aio_context = bdrv_get_aio_context(bs);
>>      aio_context_acquire(aio_context);
>>  
>>
> What's the implication of the temporarily-extant target node that it
> needs to be avoided so strictly?
> 

Creating a file on disk, that no one will ever remvoe. :)

Paolo
