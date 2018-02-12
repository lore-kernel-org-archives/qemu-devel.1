Received: from eggs.gnu.org ([2001:4830:134:3::10]:60783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elICk-0005Eb-K6
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 12:47:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elICi-0007P4-2u
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 12:47:50 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54452 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1elICh-0007OB-Sh
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 12:47:47 -0500
References: <20180212142506.28445-1-danielhb@linux.vnet.ibm.com>
	<20180212142506.28445-2-danielhb@linux.vnet.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0fc757fc-427d-65cf-910b-a2e611177f46@redhat.com>
Date: Mon, 12 Feb 2018 11:47:29 -0600
MIME-Version: 1.0
In-Reply-To: <20180212142506.28445-2-danielhb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/1] dump.c: allow fd_write_vmcore to
 return errno on failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, Yasmin Beatriz <yasmins@linux.vnet.ibm.com>, Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>

On 02/12/2018 08:25 AM, Daniel Henrique Barboza wrote:
> From: Yasmin Beatriz <yasmins@linux.vnet.ibm.com>
> 
> fd_write_vmcore can fail to execute for a lot of reasons that can be
> retrieved by errno, but it only returns -1. This makes difficult for
> the caller to know what happened and only a generic error message is
> propagated back to the user. This is an example using dump-guest-memory:
> 
> (qemu) dump-guest-memory /home/yasmin/mnt/test.dump
> dump: failed to save memory
> 
...
> This is the same dump-guest-memory example with this patch applied:
> 
> (qemu) dump-guest-memory /home/yasmin/mnt/test.dump
> dump: failed to save memory: No space left on device
> (qemu)
> 
> This example illustrates an error of fd_write_vmcore when called
> from write_data. All other callers will benefit from better
> error messages as well.
> 
> Reported-by: yilzhang@redhat.com
> Cc: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
> Signed-off-by: Yasmin Beatriz <yasmins@linux.vnet.ibm.com>
> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
> ---
>   dump.c | 23 ++++++++++++++---------
>   1 file changed, 14 insertions(+), 9 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
