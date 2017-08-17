Received: from eggs.gnu.org ([2001:4830:134:3::10]:57634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1diHiQ-0003Ws-Db
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 06:07:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1diHiL-00071g-Ox
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 06:07:50 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:34355
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1diHiL-000713-D4
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 06:07:45 -0400
References: <1502951113-4246-1-git-send-email-thuth@redhat.com>
	<1502951113-4246-2-git-send-email-thuth@redhat.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <ff5b973a-61f0-dd30-3405-8487b87ac835@cn.fujitsu.com>
Date: Thu, 17 Aug 2017 18:09:08 +0800
MIME-Version: 1.0
In-Reply-To: <1502951113-4246-2-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 1/6] tests: Run filter-redirector and
 -mirror test only on POSIX systems
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: zhangchen.fnst@cn.fujitsu.com, Eric Farman <farman@linux.vnet.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Jason J Herne <jjherne@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, Farhan Ali <alifm@linux.vnet.ibm.com>, Jing Liu <liujbjl@linux.vnet.ibm.com>, Fan Zhang <zhangfan@linux.vnet.ibm.com>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, QingFeng Hao <haoqf@linux.vnet.ibm.com>, Michael S Tsirkin <mst@redhat.com>, Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>, Fei Li <sherrylf@linux.vnet.ibm.com>, Cleber Rosa <crosa@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Yang Chen <bjcyang@linux.vnet.ibm.com>, Marc Mari <markmb@redhat.com>



On 08/17/2017 02:25 PM, Thomas Huth wrote:
> This way we can get rid of the ugly #ifdefs in the code which makes
> it easier to extend later.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Zhang Chen<zhangchen.fnst@cn.fujitsu.com>

It's better for my code.

Thanks
Zhang Chen

> ---
>   tests/Makefile.include         |  8 ++++----
>   tests/test-filter-mirror.c     |  5 -----
>   tests/test-filter-redirector.c | 10 ----------
>   3 files changed, 4 insertions(+), 19 deletions(-)
>

-- 
Thanks
Zhang Chen
