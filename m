Received: from eggs.gnu.org ([2001:4830:134:3::10]:50429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cZUqt-0007bj-3f
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 22:47:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cZUqq-0002MB-11
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 22:47:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34952)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cZUqp-0002M1-RH
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 22:47:55 -0500
References: <1485266748-15340-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1485266748-15340-2-git-send-email-zhang.zhanghailiang@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <4d0b52bc-bcdd-5b96-465c-f0e624cb4add@redhat.com>
Date: Fri, 3 Feb 2017 11:47:49 +0800
MIME-Version: 1.0
In-Reply-To: <1485266748-15340-2-git-send-email-zhang.zhanghailiang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] colo-compare: reconstruct the mutex
 lock usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhanghailiang <zhang.zhanghailiang@huawei.com>, qemu-devel@nongnu.org
Cc: zhangchen.fnst@cn.fujitsu.com, lizhijian@cn.fujitsu.com



On 2017=E5=B9=B401=E6=9C=8824=E6=97=A5 22:05, zhanghailiang wrote:
> The original 'timer_check_lock' mutex lock of struct CompareState
> is used to protect the 'conn_list' queue and its child queues which
> are 'primary_list' and 'secondary_list', which is a little abused
> and confusing
>
> To make it clearer, we rename 'timer_check_lock' to 'conn_list_lock'
> which is used to protect 'conn_list' queue, use another 'conn_lock'
> to protect 'primary_list' and 'secondary_list'.
>
> Besides, fix some missing places which need these mutex lock.
>
> Signed-off-by: zhanghailiang<zhang.zhanghailiang@huawei.com>

Instead of sticking to such kind of mutex, I think it's time to make=20
colo timer run in colo thread (there's a TODO in the code).

Thought?

Thanks
