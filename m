Received: from eggs.gnu.org ([2001:4830:134:3::10]:35314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eicAu-0002S3-H7
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 03:30:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eicAr-0002Ze-8v
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 03:30:52 -0500
References: <20180202094241.59537-1-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <293c0a3a-c449-feeb-5ab2-a9a282b1fad0@redhat.com>
Date: Mon, 5 Feb 2018 09:30:44 +0100
MIME-Version: 1.0
In-Reply-To: <20180202094241.59537-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH] s390x/sclp: fix event mask
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, qemu-stable@nongnu.org, qemu-devel@nongnu.org, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

On 02.02.2018 10:42, Christian Borntraeger wrote:
> commit 67915de9f038 ("s390x/event-facility: variable-length event
> masks") switches the sclp receive/send mask. This broke the sclp
> lm console.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Fixes: commit 67915de9f038 ("s390x/event-facility: variable-length event masks")
> Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
> Cc: Jason J. Herne <jjherne@linux.vnet.ibm.com>
> Cc: qemu-stable@nongnu.org
> ---
>  hw/s390x/event-facility.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
> index b0f71f4554..155a69467b 100644
> --- a/hw/s390x/event-facility.c
> +++ b/hw/s390x/event-facility.c
> @@ -293,10 +293,10 @@ static void write_event_mask(SCLPEventFacility *ef, SCCB *sccb)
>      ef->receive_mask = be32_to_cpu(tmp_mask);
>  
>      /* return the SCLP's capability masks to the guest */
> -    tmp_mask = cpu_to_be32(get_host_send_mask(ef));
> +    tmp_mask = cpu_to_be32(get_host_receive_mask(ef));
>      copy_mask(WEM_RECEIVE_MASK(we_mask, mask_length), (uint8_t *)&tmp_mask,
>                mask_length, sizeof(tmp_mask));
> -    tmp_mask = cpu_to_be32(get_host_receive_mask(ef));
> +    tmp_mask = cpu_to_be32(get_host_send_mask(ef));
>      copy_mask(WEM_SEND_MASK(we_mask, mask_length), (uint8_t *)&tmp_mask,
>                mask_length, sizeof(tmp_mask));
>  
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
