Received: from eggs.gnu.org ([2001:4830:134:3::10]:48933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1d2w2m-0005L4-NA
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 04:41:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1d2w2j-0001h8-Go
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 04:41:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40602)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1d2w2j-0001fo-AK
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 04:41:53 -0400
References: <1492674416-9408-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1492674416-9408-2-git-send-email-zhang.zhanghailiang@huawei.com>
	<df05a73b-fba8-a6d3-bf6a-648304458257@redhat.com>
	<58FD9546.5000104@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <82c50df3-28c9-fb21-f2c6-76a99f864bee@redhat.com>
Date: Tue, 25 Apr 2017 16:41:45 +0800
MIME-Version: 1.0
In-Reply-To: <58FD9546.5000104@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] colo-compare: serialize compare
 thread's initialization with main thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hailiang Zhang <zhang.zhanghailiang@huawei.com>, zhangchen.fnst@cn.fujitsu.com
Cc: xuquan8@huawei.com, qemu-devel@nongnu.org, weidong.huang@huawei.com



On 2017=E5=B9=B404=E6=9C=8824=E6=97=A5 14:03, Hailiang Zhang wrote:
> On 2017/4/24 12:10, Jason Wang wrote:
>>
>> On 2017=E5=B9=B404=E6=9C=8820=E6=97=A5 15:46, zhanghailiang wrote:
>>> We call qemu_chr_fe_set_handlers() in colo-compare thread, it is used
>>> to detach watched fd from default main context, so it has chance to
>>> handle the same watched fd with main thread concurrently, which will
>>> trigger an error report:
>>> "qemu-char.c:918: io_watch_poll_finalize: Assertion `iwp->src =3D=3D=20
>>> ((void *)0)' failed."
>> Anyway to prevent fd from being handled by main thread before creating
>> colo thread? Using semaphore seems not elegant.
>
> So how about calling qemu_mutex_lock_iothread() before=20
> qemu_chr_fe_set_handlers() ?

Looks better, but I needs more information e.g how main thread can touch =
it?

Thanks
