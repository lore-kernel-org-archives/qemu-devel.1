Received: from eggs.gnu.org ([2001:4830:134:3::10]:39611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0p8A-0003cl-Lr
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 09:59:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0p86-0006TW-OZ
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 09:59:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57846 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f0p86-0006TE-J8
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 09:59:14 -0400
References: <20180327123800.28851-1-sathnaga@linux.vnet.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <686b98e4-cf4e-00c9-e4fd-a3efd9f52994@redhat.com>
Date: Tue, 27 Mar 2018 08:59:04 -0500
MIME-Version: 1.0
In-Reply-To: <20180327123800.28851-1-sathnaga@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.12] hmp.c: Revert hmp_info_cpus
 output format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: sathnaga@linux.vnet.ibm.com, qemu-devel@nongnu.org
Cc: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>

On 03/27/2018 07:38 AM, sathnaga@linux.vnet.ibm.com wrote:
> From: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
> 
> This commit 137b5cb6ab565cb3781d5337591e155932b4230e
> refactors info cpus output and changes output format from
> 'thread_id' to 'thread-id', this would break parsing
> of output in above layers like libvirt, test framework etc.
> 
> This patch just reverts back output format to 'thread_id'.
> 
> CC: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
> Signed-off-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
> ---
>   hmp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

I'm not opposed to this patch (because it is a trivial way to keep older 
stuff working), but agree with Daniel that HMP output can change at any 
time, so other stuff relying on HMP should be fixed.  Libvirt is not 
affected, so if we DO take this into 2.12, we should update the commit 
message to drop mention of libvirt being impacted, maybe along the lines of:

Commit 137b5cb6 refactored 'info cpus' output, changing 'thread_id' to 
'thread-id'.  While HMP is not a stable interface, it is trivial to keep 
the spelling consistent for test frameworks that have not yet updated to 
using QMP.

With the improved commit message,
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
