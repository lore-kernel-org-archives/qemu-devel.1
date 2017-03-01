Received: from eggs.gnu.org ([2001:4830:134:3::10]:42471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cisln-0008WV-GG
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 20:09:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cislk-0001vW-CH
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 20:09:31 -0500
Received: from [45.249.212.188] (port=2947 helo=dggrg02-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cislj-0001v8-Oq
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 20:09:28 -0500
References: <1452169208-840-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<CAN9JPjHxb1RgtG=3f9+HWz80gwARymEKgX0N+OLGTi5Svgy6qw@mail.gmail.com>
	<577B1238.7040605@huawei.com>
	<CAN9JPjH_AQjHGbMMdSZofRp8nxcfgtkzpK6LZsd7bWyfGhJkCQ@mail.gmail.com>
	<577B8BA7.6010001@huawei.com>
	<20160818155636.l46t4ha65eybnnhe@redhat.com>
	<57B7F948.9040701@huawei.com>
	<cc27b58b-8751-f720-1370-d30c20c8d76a@virtualopensystems.com>
	<58B4D6EA.5050804@huawei.com> <20170228161404.GL5816@redhat.com>
From: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Message-ID: <58B61F29.3090203@huawei.com>
Date: Wed, 1 Mar 2017 09:08:57 +0800
MIME-Version: 1.0
In-Reply-To: <20170228161404.GL5816@redhat.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 00/13] Live memory snapshot based on
 userfaultfd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Arcangeli <aarcange@redhat.com>
Cc: xuquan8@huawei.com, Christian Pinto <c.pinto@virtualopensystems.com>, Juan Quintela <quintela@redhat.com>, dgilbert@redhat.com, peter.huangpeng@huawei.com, Baptiste Reynal <b.reynal@virtualopensystems.com>, qemu list <qemu-devel@nongnu.org>, "Huangweidong (C)" <weidong.huang@huawei.com>, colo-ft@hotmail.com

On 2017/3/1 0:14, Andrea Arcangeli wrote:
> Hello,
>
> On Tue, Feb 28, 2017 at 09:48:26AM +0800, Hailiang Zhang wrote:
>> Yes, for current implementing of live snapshot, it supports tcg,
>> but does not support kvm mode, the reason i have mentioned above,
>> if you try to implement it, i think you need to start from userfaultfd
>> supporting KVM. There is scenario for it, But I'm blocked by other things
>> these days. I'm glad to discuss with you if you planed to do it.
>
> Yes, there were other urgent userfaultfd features needed by QEMU and
> CRIU queued for merging (hugetlbfs/shmem/non-cooperative support) and
> they're all included upstream now. Now that such work is finished,
> fixing the WP support to work with KVM and to provide full accuracy
> will be the next thing to do.
>

Great, looking forward to it. thanks.

> Thanks,
> Andrea
>
> .
>
