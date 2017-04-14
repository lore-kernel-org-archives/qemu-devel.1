Received: from eggs.gnu.org ([2001:4830:134:3::10]:39908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1cypY8-00089s-7J
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 20:57:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1cypY7-0002oy-3g
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 20:57:20 -0400
MIME-Version: 1.0
In-Reply-To: <20170413141617.GD13387@stefanha-x1.localdomain>
References: <1492050868-16200-1-git-send-email-lidongchen@tencent.com>
	<20170413141617.GD13387@stefanha-x1.localdomain>
From: 858585 jemmy <jemmy858585@gmail.com>
Date: Fri, 14 Apr 2017 08:57:17 +0800
Message-ID: <CAOGPPbevJLdt5+C4jZEOC1iCFUK9RY8NF0Uu0C3xBh8DgbnbjQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6] migration/block: use blk_pwrite_zeroes
 for each zero cluster
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, quintela@redhat.com, dgilbert@redhat.com, qemu-block@nongnu.org, Lidong Chen <lidongchen@tencent.com>

On Thu, Apr 13, 2017 at 10:16 PM, Stefan Hajnoczi <stefanha@redhat.com> wro=
te:
> On Thu, Apr 13, 2017 at 10:34:28AM +0800, jemmy858585@gmail.com wrote:
>> From: Lidong Chen <lidongchen@tencent.com>
>>
>> BLOCK_SIZE is (1 << 20), qcow2 cluster size is 65536 by default,
>> this may cause the qcow2 file size to be bigger after migration.
>> This patch checks each cluster, using blk_pwrite_zeroes for each
>> zero cluster.
>>
>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>> Signed-off-by: Lidong Chen <lidongchen@tencent.com>
>> ---
>> v6 changelog:
>> Fix up some grammar in the comment.
>> ---
>>  migration/block.c | 35 +++++++++++++++++++++++++++++++++--
>>  1 file changed, 33 insertions(+), 2 deletions(-)
>
> I fixed the following gcc warning when merging the patch:
>
>   migration/block.c:958:25: error: =E2=80=98cluster_size=E2=80=99 may be =
used uninitialized in this function [-Werror=3Dmaybe-uninitialized]
>                             buffer_is_zero(cur_buf, cluster_size)) {

Thanks=EF=BC=8Ci will check gcc warning next time.

>
> Thanks, applied to my block-next tree:
> https://github.com/stefanha/qemu/commits/block-next
>
> Stefan
