Received: from eggs.gnu.org ([2001:4830:134:3::10]:53650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1du7KQ-000280-3u
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 21:27:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1du7KL-0000Gv-Ax
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 21:27:58 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:60750
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1du7KK-0000GM-VI
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 21:27:53 -0400
References: <cover.1505737465.git.maozy.fnst@cn.fujitsu.com>
	<7f98890b-ee32-d539-0823-06544849457a@redhat.com>
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Message-ID: <bec757f5-faa8-3d36-6fa7-cfd08324798d@cn.fujitsu.com>
Date: Tue, 19 Sep 2017 09:25:23 +0800
MIME-Version: 1.0
In-Reply-To: <7f98890b-ee32-d539-0823-06544849457a@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/6] Convert to realize and improve
 error handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Keith Busch <keith.busch@intel.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>



On 09/19/2017 07:59 AM, John Snow wrote:
>
>
> On 09/18/2017 10:05 AM, Mao Zhongyi wrote:
>> This series mainly implements the conversions of ide, floppy and nvme
>> device to realize. Add some error handling messages and remove the local
>> variable local_err, use errp to propagate the error directly. Also
>> fix the unusual function name.
>>
>> v3:
>>   -patch1: update the test output in 051  [John Snow]
>>   -patch2: update the test putput in 172  [John Snow]
>>
>> v2:
>>   -use bool as the return type instead of int. [Markus Armbruster & Stefan Hajnoczi]
>>
>> Cc: John Snow <jsnow@redhat.com>
>> Cc: Kevin Wolf <kwolf@redhat.com>
>> Cc: Max Reitz <mreitz@redhat.com>
>> Cc: Keith Busch <keith.busch@intel.com>
>> Cc: Stefan Hajnoczi <stefanha@redhat.com>
>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>> Cc: Markus Armbruster <armbru@redhat.com>
>>
>> Mao Zhongyi (6):
>>   hw/ide: Convert DeviceClass init to realize
>>   hw/block/fdc: Convert to realize
>>   hw/block/nvme: Convert to realize
>>   hw/block: Fix the return type
>>   hw/block: Use errp directly rather than local_err
>>   dev-storage: Fix the unusual function name
>>
>>  hw/block/block.c                | 15 ++++---
>>  hw/block/dataplane/virtio-blk.c | 12 +++---
>>  hw/block/dataplane/virtio-blk.h |  2 +-
>>  hw/block/fdc.c                  | 48 +++++++++------------
>>  hw/block/nvme.c                 | 24 +++++------
>>  hw/block/virtio-blk.c           | 17 +++-----
>>  hw/ide/core.c                   |  7 +--
>>  hw/ide/qdev.c                   | 94 +++++++++++++++++++----------------------
>>  hw/scsi/scsi-disk.c             | 13 ++----
>>  hw/usb/dev-storage.c            | 29 ++++++-------
>>  include/hw/block/block.h        |  4 +-
>>  include/hw/ide/internal.h       |  5 ++-
>>  tests/qemu-iotests/051.pc.out   | 10 +----
>>  tests/qemu-iotests/172.out      |  8 ----
>>  14 files changed, 127 insertions(+), 161 deletions(-)
>>
>
> Hi Mao Zhongyi:
>
> I've staged patches one and two here for my IDE pull request.
>
> I think patches 3-6 here would belong to Kevin.
>
> Thanks,
> John
>

Hi, John

OK, I see.

Thanks for the quick review. :)
--
Mao
