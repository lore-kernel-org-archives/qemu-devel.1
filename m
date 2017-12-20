Received: from eggs.gnu.org ([2001:4830:134:3::10]:43787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eRfcN-0003E8-Br
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 09:45:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eRfcM-0006Oa-H9
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 09:45:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1eRfcM-0006MU-Ai
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 09:45:10 -0500
References: <20171217125457.3429-1-marcel@redhat.com>
	<20171217125457.3429-4-marcel@redhat.com>
	<20171219194739-mutt-send-email-mst@kernel.org>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <283b99aa-7036-6cfd-17f8-b82fe65982db@redhat.com>
Date: Wed, 20 Dec 2017 16:45:06 +0200
MIME-Version: 1.0
In-Reply-To: <20171219194739-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V2 3/5] docs: add pvrdma device
 documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, imammedo@redhat.com, yuval.shaia@oracle.com, pbonzini@redhat.com

On 19/12/2017 19:47, Michael S. Tsirkin wrote:
> On Sun, Dec 17, 2017 at 02:54:55PM +0200, Marcel Apfelbaum wrote:
>> Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
>> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
>> ---
>>   docs/pvrdma.txt | 145 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 145 insertions(+)
>>   create mode 100644 docs/pvrdma.txt
>>
>> diff --git a/docs/pvrdma.txt b/docs/pvrdma.txt
>> new file mode 100644
>> index 0000000000..74c5cf2495
>> --- /dev/null
>> +++ b/docs/pvrdma.txt
>> @@ -0,0 +1,145 @@
>> +Paravirtualized RDMA Device (PVRDMA)
>> +====================================
>> +

[...]

>> +
>> +4. Implementation details
>> +=========================
>> +The device acts like a proxy between the Guest Driver and the host
>> +ibdevice interface.
>> +On configuration path:
>> + - For every hardware resource request (PD/QP/CQ/...) the pvrdma will request
>> +   a resource from the backend interface, maintaining a 1-1 mapping
>> +   between the guest and host.
>> +On data path:
>> + - Every post_send/receive received from the guest will be converted into
>> +   a post_send/receive for the backend. The buffers data will not be touched
>> +   or copied resulting in near bare-metal performance for large enough buffers.
>> + - Completions from the backend interface will result in completions for
>> +   the pvrdma device.
> 

Hi Michael,

> 
> Where's the host/guest interface documented?
> 

It is the VMware PVRDMA spec, I am not sure is publicly available,
we kind of reverse-engineered it.
We will add some info from the linked presentation on the PCI BARs
and how are they used.

Thanks,
Marcel

>> +
>> +
[...]
