Received: from eggs.gnu.org ([2001:4830:134:3::10]:48250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eAiUI-0000A3-QJ
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 16:22:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eAiUF-0005IJ-MV
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 16:22:46 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <ad3990d7-4356-4764-4da2-01cc59a63075@redhat.com>
References: <cover.1509718618.git.berto@igalia.com>
	<fb53467cf48e95ff3330def1cf1003a5b862b7d9.1509718618.git.berto@igalia.com>
	<ad3990d7-4356-4764-4da2-01cc59a63075@redhat.com>
Date: Fri, 03 Nov 2017 21:22:39 +0100
Message-ID: <w518tfnglio.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 3/7] qcow2: Prevent allocating
 compressed clusters at offset 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Thomas Huth <thuth@redhat.com>, "R . Nageswara Sastry" <nasastry@in.ibm.com>

On Fri 03 Nov 2017 05:27:59 PM CET, Max Reitz wrote:
>> +            if (new_cluster == 0) {
>> +                qcow2_signal_corruption(bs, true, -1, -1, "Preventing invalid "
>> +                                        "allocation of compressed cluster "
>> +                                        "at offset 0");
>> +                return -EIO;
>> +            }
>> +
>>              if (!offset || ROUND_UP(offset, s->cluster_size) != new_cluster) {
>>                  offset = new_cluster;
>>                  free_in_cluster = s->cluster_size;
>> @@ -1090,7 +1097,6 @@ int64_t qcow2_alloc_bytes(BlockDriverState *bs, int size)
>>              }
>>          }
>>  
>> -        assert(offset);
>
> I don't think this assert() was meant as a protection against offset
> being 0. :-)

After the new check offset is now guaranteed to be 0, so what's the
point of keeping the assert() ?

Berto
