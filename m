Received: from eggs.gnu.org ([2001:4830:134:3::10]:49048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sochin.jiang@huawei.com>) id 1dM2Rj-0001ct-Q0
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 21:22:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sochin.jiang@huawei.com>) id 1dM2Rg-0001Uh-NG
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 21:22:39 -0400
References: <1497509253-28941-1-git-send-email-sochin.jiang@huawei.com>
	<49c65c67-5dcc-5822-c2f9-e1c3ff0181de@redhat.com>
From: "sochin.jiang" <sochin.jiang@huawei.com>
Message-ID: <099fe86b-add8-d8c9-5696-aef97f8dc1a3@huawei.com>
Date: Sat, 17 Jun 2017 09:22:06 +0800
MIME-Version: 1.0
In-Reply-To: <49c65c67-5dcc-5822-c2f9-e1c3ff0181de@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] fix: avoid an infinite loop or a dangling
 pointer problem in img_commit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, jcody@redhat.com, kwolf@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, eric.fangyi@huawei.com, subo7@huawei.com, xieyingtai@huawei.com, lina.lulina@huawei.com, zhangshuai13@huawei.com, lizhengui@huawei.com

Good advice, thank you, Max.


On 2017/6/16 21:27, Max Reitz wrote:
> On 2017-06-15 08:47, sochin.jiang wrote:
>> From: "sochin.jiang" <sochin.jiang@huawei.com>
>>
>> img_commit could fall into an infinite loop calling run_block_job() if
>> its blockjob fails on any I/O error, fix this already known problem.
>>
>> Signed-off-by: sochin.jiang <sochin.jiang@huawei.com>
>> ---
>>  blockjob.c               |  4 ++--
>>  include/block/blockjob.h | 18 ++++++++++++++++++
>>  qemu-img.c               | 20 +++++++++++++-------
>>  3 files changed, 33 insertions(+), 9 deletions(-)
> Thanks! I've applied the patch to my block branch:
>
> https://github.com/XanClic/qemu/commits/block
>
> PS: In the future, please change the subject prefix to "PATCH v2" (etc.)
> for updated versions of a patch.
>
> Max
>
