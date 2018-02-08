Received: from eggs.gnu.org ([2001:4830:134:3::10]:39587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1ejpDc-000078-Sf
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:38:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1ejpDY-0004nu-Uk
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:38:40 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46708 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1ejpDY-0004nf-PO
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:38:36 -0500
References: <1516291445-4572-1-git-send-email-xieyongji@baidu.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <811ef72e-a502-8d7b-8409-8eef5d51a98a@redhat.com>
Date: Thu, 8 Feb 2018 17:38:27 +0100
MIME-Version: 1.0
In-Reply-To: <1516291445-4572-1-git-send-email-xieyongji@baidu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] libvhost-user: Support
 across-memory-boundary access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongji Xie <elohimes@gmail.com>, mst@redhat.com, marcandre.lureau@redhat.com
Cc: dgilbert@redhat.com, f4bug@amsat.org, qemu-devel@nongnu.org



On 01/18/2018 05:04 PM, Yongji Xie wrote:
> The sg list/indirect descriptor table may be contigious
> in GPA but not in HVA address space. But libvhost-user
> wasn't aware of that. This would cause out-of-bounds
> access. Even a malicious guest could use it to get
> information from the vhost-user backend.
> 
> Introduce a plen parameter in vu_gpa_to_va() so we can
> handle this case, returning the actual mapped length.
> 
> Signed-off-by: Yongji Xie <xieyongji@baidu.com>
> ---
>   contrib/libvhost-user/libvhost-user.c |  133 +++++++++++++++++++++++++++++----
>   contrib/libvhost-user/libvhost-user.h |    3 +-
>   2 files changed, 122 insertions(+), 14 deletions(-)
> 

Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Thanks,
Maxime
