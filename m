Received: from eggs.gnu.org ([2001:4830:134:3::10]:32830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1elGmK-0002sQ-Gz
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 11:16:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1elGmJ-0001mN-Mm
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 11:16:28 -0500
References: <1518441241-32557-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1518441241-32557-2-git-send-email-anton.nefedov@virtuozzo.com>
	<w51po5a8aps.fsf@maestria.local.igalia.com>
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <74ffe6ba-04e8-acda-1753-b91e4e0f83ff@virtuozzo.com>
Date: Mon, 12 Feb 2018 19:16:14 +0300
MIME-Version: 1.0
In-Reply-To: <w51po5a8aps.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/2] iotest 033: add misaligned
 write-zeroes test via truncate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, stefanha@redhat.com, famz@redhat.com, eblake@redhat.com



On 12/2/2018 6:54 PM, Alberto Garcia wrote:
> On Mon 12 Feb 2018 02:14:00 PM CET, Anton Nefedov wrote:
>> +# Trigger truncate that would shrink qcow2 L1 table, which is done by
>> +#   clearing one entry (8 bytes) with bdrv_co_pwrite_zeroes()
>> +
>> +echo
>> +echo "=== Test misaligned write zeroes via truncate ==="
>> +echo
>> +
>> +CLUSTER_SIZE=$((64 * 1024))
>> +L2_COVERAGE=$(($CLUSTER_SIZE * $CLUSTER_SIZE / 8))
>> +_make_test_img $(($L2_COVERAGE * 2))
> 
> If my numbers are correct, that's a 1GB image. For qcow2 this is not a
> problem but I wonder if it's ok to create such large images for other
> formats (for raw they should be sparse by default, but still).
> 
> Berto
> 

Good point. Actually even 512 byte clusters will work here, resulting
in a just 64k image.
