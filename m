Received: from eggs.gnu.org ([2001:4830:134:3::10]:39451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1ejpCy-00085C-Bf
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:38:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1ejpCu-0004Bb-Em
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:38:00 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44586 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1ejpCu-0004Ad-9g
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:37:56 -0500
References: <1516290116-4366-1-git-send-email-xieyongji@baidu.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <84961f30-58cd-8ecb-5400-6aa2f0e582dd@redhat.com>
Date: Thu, 8 Feb 2018 17:37:47 +0100
MIME-Version: 1.0
In-Reply-To: <1516290116-4366-1-git-send-email-xieyongji@baidu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] libvhost-user: Fix resource leak
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



On 01/18/2018 04:41 PM, Yongji Xie wrote:
> Free the mmaped memory when we need to mmap new memory
> space on vu_set_mem_table_exec() and vu_set_log_base_exec() to
> avoid memory leak.
> 
> Also close the corresponding fd after mmap() on
> vu_set_log_base_exec() to avoid fd leak.
> 
> Signed-off-by: Yongji Xie <xieyongji@baidu.com>
> ---
>   contrib/libvhost-user/libvhost-user.c |   14 ++++++++++++++
>   1 file changed, 14 insertions(+)

Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Thanks,
Maxime
