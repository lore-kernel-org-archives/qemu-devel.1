Received: from eggs.gnu.org ([2001:4830:134:3::10]:51467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dsSQG-0003xg-7Z
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 07:35:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dsSQC-0001lK-AH
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 07:35:08 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:54181)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1dsSQB-0001gr-VJ
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 07:35:04 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <59BA4ED4.6070108@huawei.com>
References: <59BA4ED4.6070108@huawei.com>
Date: Thu, 14 Sep 2017 13:34:54 +0200
Message-ID: <w51shfpikdd.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel]
 =?utf-8?q?question=EF=BC=9Aa_question_about_throttl?=
 =?utf-8?q?e_and_hot-unplug?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "WangJie (Captain)" <wangjie88@huawei.com>, Kevin Wolf <kwolf@redhat.com>
Cc: stefanha@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

On Thu 14 Sep 2017 11:41:40 AM CEST, WangJie (Captain) wrote:

> the patch you commited: https://github.com/qemu/qemu/commit/7ca7f0f6db1fedd28d490795d778cf23979a2aa7#diff-ea36ba0f79150cc299732696a069caba
>
> remove blk_io_limits_disable from blk_remove_bs
>
> Then, if a disk which configured qos hot-unplug from VM, the backend
> of the disk reminds in throttle group.
>
> So when I hot-unplug and hot-plug a disk, and use the same throttle
> group name, will lead to qemu crash.
>
> and Eric committed a path as fallow fixed the bug on qemu-kvm 2.9.0-rc4:
> https://github.com/qemu/qemu/commit/1606e4cf8a976513ecac70ad6642a7ec45744cf5#diff-7cb66df56045598b75a219eebc27efb6
>
> Is what I said as below correct?

That sounds correct to me. Here's the original discussion for reference:

https://lists.gnu.org/archive/html/qemu-block/2017-04/msg00019.html

Berto
