Received: from eggs.gnu.org ([2001:4830:134:3::10]:33142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fIbpp-0002sp-Mb
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:25:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fIbpm-0006FN-IP
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:25:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38412 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fIbpm-0006FF-Dp
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:25:50 -0400
References: <20180515113348.10516-1-zyimin@linux.ibm.com>
	<20180515113348.10516-2-zyimin@linux.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7bd9074b-04ca-49f6-096b-808d36e4e8b0@redhat.com>
Date: Tue, 15 May 2018 10:25:46 -0500
MIME-Version: 1.0
In-Reply-To: <20180515113348.10516-2-zyimin@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/1] sandbox: disable -sandbox if
 CONFIG_SECCOMP undefined
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yi Min Zhao <zyimin@linux.ibm.com>, qemu-devel@nongnu.org
Cc: otubo@redhat.com, fiuczy@linux.ibm.com, jtomko@redhat.com, borntraeger@de.ibm.com, jferlan@redhat.com

On 05/15/2018 06:33 AM, Yi Min Zhao wrote:
> If CONFIG_SECCOMP is undefined, the option 'elevateprivileges' remains
> compiled. This would make libvirt set the corresponding capability and
> then trigger the guest startup fails. So this patch excludes the code

s/trigger the guest startup fails/trigger failure during guest startup/

> regarding seccomp staff if CONFIG_SECCOMP is undefined.

s/staff/command line options/

> 
> Signed-off-by: Yi Min Zhao <zyimin@linux.ibm.com>
> ---
>   vl.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
> 

A maintainer can touch up the commit message, so:
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
