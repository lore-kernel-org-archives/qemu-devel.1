Received: from eggs.gnu.org ([2001:4830:134:3::10]:42490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eK54f-0001no-09
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 11:19:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eK54b-0008SL-Nv
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 11:19:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39898)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eK54b-0008Rw-I3
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 11:18:57 -0500
References: <20171128044656.10592-1-linzhecheng@huawei.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cd2bad80-1790-aa01-fde4-4979b4c53b97@redhat.com>
Date: Wed, 29 Nov 2017 10:18:51 -0600
MIME-Version: 1.0
In-Reply-To: <20171128044656.10592-1-linzhecheng@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4] thread: move detach_thread from
 creating thread to created thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linzhecheng <linzhecheng@huawei.com>, qemu-devel@nongnu.org
Cc: aliguori@us.ibm.com, famz@redhat.com, wangxinxin.wang@huawei.com, arei.gonglei@huawei.com, pbonzini@redhat.com

On 11/27/2017 10:46 PM, linzhecheng wrote:
> If we create a thread with QEMU_THREAD_DETACHED mode, QEMU may get a segfault in a low probability.
> 

> 
> The root cause of this problem is a bug of glibc(version 2.17,the latest version has the same bug),
> let's see what happened in glibc's code.

Have you reported this bug to the glibc folks, and if so, can we include 
a URL to the glibc bugzilla?

Working around the glibc bug is nice, but glibc should really be fixed 
so that other projects do not have to continue working around it.


> 
> QEMU get a segfault at line 50, becasue pd is an invalid address.
> pd is still valid at line 38 when set pd->joinid = pd, at this moment,
> created thread is just exiting(only keeps runing for a short time),

s/runing/running/

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
