Received: from eggs.gnu.org ([2001:4830:134:3::10]:57071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ejQmF-0005Nk-2A
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 09:32:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ejQmB-0005QP-4i
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 09:32:47 -0500
References: <20180207123833.211687-1-borntraeger@de.ibm.com>
	<db339d3b-2425-8055-0c1a-890a6f0d4039@redhat.com>
	<1216cef6-00fd-683d-2bf2-1673ee272c0d@de.ibm.com>
	<2bc7ae11-dde0-b195-e5c6-6a99aeb0e9be@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <87971bf8-a0fc-b7d4-5101-2120d126f9bc@redhat.com>
Date: Wed, 7 Feb 2018 15:32:40 +0100
MIME-Version: 1.0
In-Reply-To: <2bc7ae11-dde0-b195-e5c6-6a99aeb0e9be@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v6] s390x/cpu: expose the
 guest crash information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>
Cc: Thomas Huth <thuth@redhat.com>, Bjoern Walk <bwalk@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>


> 
> What about:
> 
> diff --git a/qapi/run-state.json b/qapi/run-state.json
> index 328c86b4bb..c7b2ab84be 100644
> --- a/qapi/run-state.json
> +++ b/qapi/run-state.json
> @@ -367,7 +367,8 @@
>  #
>  # @disabledwait: the CPU has entered a disabled wait state
>  #
> -# @extintloop: timer interrupt with new PSW enabled for timer
> +# @extintloop: clock comparator or cpu timer interrupt with new PSW enabled
> +#              for external interrupts
>  #
>  # @pgmintloop: program interrupt with BAD new PSW
>  #
> 

Sounds good to me!

-- 

Thanks,

David / dhildenb
