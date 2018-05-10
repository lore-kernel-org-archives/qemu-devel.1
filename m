Received: from eggs.gnu.org ([2001:4830:134:3::10]:40311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thomas.tai@oracle.com>) id 1fGl7t-0000gD-9P
	for qemu-devel@nongnu.org; Thu, 10 May 2018 08:56:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thomas.tai@oracle.com>) id 1fGl7p-0003oF-Dm
	for qemu-devel@nongnu.org; Thu, 10 May 2018 08:56:53 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:39186)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thomas.tai@oracle.com>)
	id 1fGl7p-0003nC-1w
	for qemu-devel@nongnu.org; Thu, 10 May 2018 08:56:49 -0400
References: <1525895585-79023-1-git-send-email-thomas.tai@oracle.com>
	<1525895585-79023-2-git-send-email-thomas.tai@oracle.com>
	<20180510081819.GB1296@stefanha-x1.localdomain>
From: Thomas Tai <thomas.tai@oracle.com>
Message-ID: <7305d09c-176e-29a8-1200-4db1f4182ff1@oracle.com>
Date: Thu, 10 May 2018 08:56:43 -0400
MIME-Version: 1.0
In-Reply-To: <20180510081819.GB1296@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [virtio-dev] [PATCH V2 1/1] virtio-balloon: fix
 internal stat name array to match Linux kernel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: mst@redhat.com, jasowang@redhat.com, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, rob.gardner@oracle.com



On 2018-05-10 04:18 AM, Stefan Hajnoczi wrote:
> On Wed, May 09, 2018 at 03:53:05PM -0400, Thomas Tai wrote:
>> The Linux kernel commit b40000325044 ("virtio_balloon: add array
>> of stat names") defines an array of stat name strings for consumers
>> of the virtio interface to use via the virtio_balloon.h header
>> file, rather than requiring each consumer to define its own. But at
>> present, the stat names defined in this array by the Linux kernel
>> do not match up with those defined internally by QEMU.
>>
>> This patch fixes this inconsistency by importing the header file
>> from linux and use the new macro to construct the balloon_stat_names
>> array.
>>
>> Signed-off-by: Jonathan Helman <jonathan.helman@oracle.com>
>> Signed-off-by: Thomas Tai <thomas.tai@oracle.com>
>> Cc: Rob Gardner <rob.gardner@oracle.com>
>> ---
>>   docs/virtio-balloon-stats.txt                   |  2 ++
>>   hw/virtio/virtio-balloon.c                      | 13 ++-----------
>>   include/standard-headers/linux/virtio_balloon.h | 19 ++++++++++++++++++-
>>   3 files changed, 22 insertions(+), 12 deletions(-)
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> 

Thank you Stefan.

-Thomas
