Received: from eggs.gnu.org ([2001:4830:134:3::10]:51210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1eONdN-00020o-20
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 07:56:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1eONdK-0006w1-0g
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 07:56:37 -0500
Received: from [45.249.212.35] (port=43270 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <longpeng2@huawei.com>)
	id 1eONdJ-0006pL-Ko
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 07:56:33 -0500
Message-ID: <5A2E8067.4050000@huawei.com>
Date: Mon, 11 Dec 2017 20:56:07 +0800
From: "Longpeng (Mike)" <longpeng2@huawei.com>
MIME-Version: 1.0
References: <1512545840-10256-1-git-send-email-longpeng2@huawei.com>
	<1512545840-10256-2-git-send-email-longpeng2@huawei.com>
	<0209e49f-3d81-cbc9-eb07-13654a288a22@linux.vnet.ibm.com>
In-Reply-To: <0209e49f-3d81-cbc9-eb07-13654a288a22@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [v22 1/2] virtio-crypto: Add virtio crypto device
 specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, luonengjun@huawei.com, mst@redhat.com, cornelia.huck@de.ibm.com, stefanha@redhat.com, denglingli@chinamobile.com, Jani.Kokkonen@huawei.com, Ola.Liljedahl@arm.com, Varun.Sethi@freescale.com, xin.zeng@intel.com, brian.a.keating@intel.com, liang.j.ma@intel.com, john.griffin@intel.com, weidong.huang@huawei.com, agraf@suse.de, jasowang@redhat.com, vincent.jardin@6wind.com, arei.gonglei@huawei.com, wangxinxin.wang@huawei.com, jianjay.zhou@huawei.com



On 2017/12/6 19:01, Halil Pasic wrote:

> 
> 
> On 12/06/2017 08:37 AM, Longpeng(Mike) wrote:
>> +\field{outcome_len} is the size of struct virtio_crypto_session_input or
>> +ZERO for the session-destroy operation.
> 
> This ain't correct. It should have been something like virtio_crypto_destroy_session_input.
> 

Hi Halil,

I already fixed this just now.
Do you have any other comments on v22 ? I'll send v23 tomorrow if no. :)

-- 
Regards,
Longpeng(Mike)

>> +
>> +
>> +\paragraph{Session operation}\label{sec:Device Types / Crypto Device / Device
>> +Operation / Control Virtqueue / Session operation}
>> +
>> +The session is a handle which describes the cryptographic parameters to be
>> +applied to a number of buffers.
>> +
>> +The following structure stores the result of session creation set by the device:
>> +
>> +\begin{lstlisting}
>> +struct virtio_crypto_session_input {
>> +    /* Device write only portion */
>> +    le64 session_id;
>> +    le32 status;
>> +    le32 padding;
>> +};
>> +\end{lstlisting}
>> +
>> +A request to destroy a session includes the following information:
>> +
>> +\begin{lstlisting}
>> +struct virtio_crypto_destroy_session_flf {
>> +    /* Device read only portion */
>> +    le64  session_id;
>> +    /* Device write only portion */
> 
> This is the device writable portion and thus what we cal op_outcome above.
> So it should have been
> };
> 
> 
> struct virtio_crypto_destroy_session_input {
>> +    le32  status;
>> +    le32  padding;
>> +};
> 
> If we aren't consistent about it the dividing into parts (like op specific
> fixed and variable length (output) fields, operation outcome (input))
> isn't really helpful.
> 
> 
> Regards,
> Halil
>> +\end{lstlisting}
> 
> 
> .
> 


-- 
Regards,
Longpeng(Mike)
