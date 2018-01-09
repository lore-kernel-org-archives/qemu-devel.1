Received: from eggs.gnu.org ([2001:4830:134:3::10]:38571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eYqqN-0001am-EJ
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 05:09:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eYqqJ-0006Or-FW
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 05:09:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54178)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1eYqqJ-0006OX-8p
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 05:09:15 -0500
References: <20180107123224.100877-1-marcel@redhat.com>
	<20180107123224.100877-4-marcel@redhat.com>
	<20180109101748.4cfeda03.cohuck@redhat.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <1dc8f8d8-141a-5e75-4650-545f98dcfbef@redhat.com>
Date: Tue, 9 Jan 2018 12:09:14 +0200
MIME-Version: 1.0
In-Reply-To: <20180109101748.4cfeda03.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V6 3/5] docs: add pvrdma device
 documentation.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, imammedo@redhat.com, yuval.shaia@oracle.com, pbonzini@redhat.com, mst@redhat.com, borntraeger@de.ibm.com

On 09/01/2018 11:17, Cornelia Huck wrote:
> On Sun,  7 Jan 2018 14:32:22 +0200
> Marcel Apfelbaum <marcel@redhat.com> wrote:
> 
>> Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
>> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
>> Reviewed-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
>> ---
>>   docs/pvrdma.txt | 254 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 254 insertions(+)
>>   create mode 100644 docs/pvrdma.txt
> 
>> +5. Limitations
>> +==============
>> +- The device obviously is limited by the Guest Linux Driver features implementation
>> +  of the VMware device API.
>> +- Memory registration mechanism requires mremap for every page in the buffer in order
>> +  to map it to a contiguous virtual address range. Since this is not the data path
>> +  it should not matter much.
>> +- The device requires target page size to be the same as the host page size.
>> +- QEMU cannot map guest RAM from a file descriptor if a pvrdma device is attached,
>> +  so it can't work with huge pages. The limitation will be addressed in the future,
>> +  however QEMU allocates Gust RAM with MADV_HUGEPAGE so if there are enough huge
> 
> s/Gust/Guest/

Fixed (for V7)

Thanks!
Marcel

> 
>> +  pages available, QEMU will use them.
>> +- As previously stated, migration is not supported yet, however with some hardware
>> +  support can be done.
