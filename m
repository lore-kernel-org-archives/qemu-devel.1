Received: from eggs.gnu.org ([208.118.235.92]:52719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ehKph-0000cf-R8
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 14:48:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ehKod-0001ou-VQ
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 14:47:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52708)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1ehKod-0001oN-AL
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 14:46:35 -0500
References: <20180117095421.124787-1-marcel@redhat.com>
	<20180117095421.124787-4-marcel@redhat.com>
	<20180201210547-mutt-send-email-mst@kernel.org>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <ec93db26-0297-cf2b-cb5b-d7e32dc2a946@redhat.com>
Date: Thu, 1 Feb 2018 21:46:15 +0200
MIME-Version: 1.0
In-Reply-To: <20180201210547-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V8 3/4] pvrdma: initial implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, imammedo@redhat.com, yuval.shaia@oracle.com, pbonzini@redhat.com, borntraeger@de.ibm.com, cohuck@redhat.com, f4bug@amsat.org

Hi Michael,

On 01/02/2018 21:10, Michael S. Tsirkin wrote:
>> diff --git a/hw/rdma/vmw/vmw_pvrdma-abi.h b/hw/rdma/vmw/vmw_pvrdma-abi.h
>> new file mode 100644
>> index 0000000000..8cfb9d7745
>> --- /dev/null
>> +++ b/hw/rdma/vmw/vmw_pvrdma-abi.h
> 
> Why do you copy this here? Why not import it
> from include/uapi/rdma/vmw_pvrdma-abi.h in Linux into
> standard headers?
> 

Do you mean adding it to QEMU's include/standard-headers/ ?
I am sorry for the possibly dumb question, but is there
a special way to do it or we simply copy it?


Regarding why I am not sure is worth it (Cornelia asked the same question
some time ago):
We are only using the header because we are too lazy to copy the structs
that are passed between the guest driver and QEMU.
This ABI is against the pvrdma device and we don't want/need to update
it every time it gets updated in Linux kernel.
If such ABI will be changed, the command channel version will be updated
but we will support only the current version.

The bottom line: we don't want to depend on the Linux kernel version,
we want to import it only once. When we will want to upgrade, we want
us to be the ones to decide and not re-act.

(We saw the same pattern in other implementations)

Thanks,
Marcel
