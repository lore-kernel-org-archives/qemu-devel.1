Received: from eggs.gnu.org ([2001:4830:134:3::10]:58254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1dAFNI-0006Re-55
	for qemu-devel@nongnu.org; Mon, 15 May 2017 08:45:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1dAFNF-0008CI-3Z
	for qemu-devel@nongnu.org; Mon, 15 May 2017 08:45:20 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3867)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1dAFNE-000857-Hy
	for qemu-devel@nongnu.org; Mon, 15 May 2017 08:45:17 -0400
References: <20170512160055.9081-1-quintela@redhat.com>
	<20170512160055.9081-6-quintela@redhat.com>
	<20170512175105.GI2069@work-vm> <87h90mfkjf.fsf@secure.mitica>
From: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Message-ID: <5919A2B8.5040005@huawei.com>
Date: Mon, 15 May 2017 20:44:40 +0800
MIME-Version: 1.0
In-Reply-To: <87h90mfkjf.fsf@secure.mitica>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 05/12] migration: Move colo.h to migration/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Tkid <zhangchen.fnst@cn.fujitsu.com>
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com

On 2017/5/15 19:04, Juan Quintela wrote:
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> D> * Juan Quintela (quintela@redhat.com) wrote:
>>> There are functions only used by migration code.
>> That's only mostly true; see the current 'integrate colo frame with
>> block replication and net compare' series (posted 22nd April).
>> That adds colo_handle_shutdown to this header and calls it from vl.c
>> ( https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg03901.html )
>> where should that go?
> Dropped.
>
> It compiled, but who knows O:-)
>
>> There's also a net/colo.h as well, so using the
>>    #include "colo.h" in migration is correct but that's
>> really scary when there are two files of the same name.

Ha, I'd like to suggest it be renamed as colo-proxy.h (colo-net.h ? ) for net/colo.h,
which is saner,  hmm, together with colo.c, colo-proxy.c ? colo-net.c ? Or any other proper name ?
( I didn't notice that until it went into upstream.  O:-) )

Cc:  Zhang Chen <zhangchen.fnst@cn.fujitsu.com>

> Yeap, it is scary ...
>
>
>
