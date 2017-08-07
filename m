Received: from eggs.gnu.org ([2001:4830:134:3::10]:37874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1deenp-0006Pb-VO
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 05:58:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1deenm-0005hh-SH
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 05:58:26 -0400
Received: from lhrrgout.huawei.com ([194.213.3.17]:20573)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1deenm-0005gm-L8
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 05:58:22 -0400
References: <1499182263-19139-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1499182263-19139-6-git-send-email-pradeep.jagadeesh@huawei.com>
	<877ezlctyk.fsf@dusky.pond.sub.org>
From: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
Message-ID: <9f9a83c4-a2b3-b5bc-5a42-fae85fe21b13@huawei.com>
Date: Mon, 7 Aug 2017 11:57:20 +0200
MIME-Version: 1.0
In-Reply-To: <877ezlctyk.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v7 5/6] fsdev: hmp interface for throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>
Cc: eric blake <eblake@redhat.com>, greg kurz <groug@kaod.org>, qemu-devel@nongnu.org, jani kokkonen <jani.kokkonen@huawei.com>, alberto
	garcia <berto@igalia.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 7/6/2017 8:15 PM, Markus Armbruster wrote:
> Pradeep Jagadeesh <pradeepkiruvale@gmail.com> writes:
>
>> This patch introduces hmp interfaces for the fsdev
>> devices.
>>
>> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
>
> Fails to compile, first error:
>
> /work/armbru/qemu/hmp.c: In function ‘hmp_fsdev_set_io_throttle’:
> /work/armbru/qemu/hmp.c:1791:5: warning: implicit declaration of function ‘qmp_fsdev_set_io_throttle’ [-Wimplicit-function-declaration]
>      qmp_fsdev_set_io_throttle(&throttle, &err);
>      ^~~~~~~~~~~~~~~~~~~~~~~~~
>
> Do you need to swap PATCH 5 and 6?
Hmm, yes better to swap, because of dependency.
I will do in V8.

-Pradeep
>
