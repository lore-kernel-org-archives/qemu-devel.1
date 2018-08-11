Received: from eggs.gnu.org ([2001:4830:134:3::10]:50768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <oleksandr@natalenko.name>) id 1foXrr-0003WF-Q0
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 13:40:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <oleksandr@natalenko.name>) id 1foXrq-0005x6-Qf
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 13:39:59 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Sat, 11 Aug 2018 19:39:56 +0200
From: Oleksandr Natalenko <oleksandr@natalenko.name>
In-Reply-To: <CACVXFVO1pN=CZvNY8Q4wBrAoA=3w8Ew38aGqpOSHJ1uYAM-sxw@mail.gmail.com>
References: <f40092b20856d07bd7f870abf5ea939e@natalenko.name>
	<CACVXFVO1pN=CZvNY8Q4wBrAoA=3w8Ew38aGqpOSHJ1uYAM-sxw@mail.gmail.com>
Message-ID: <98344e68266e447826f133ad14d0c83d@natalenko.name>
Subject: Re: [Qemu-devel] Slow boot in QEMU with virtio-scsi disks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Ming Lei <ming.lei@redhat.com>, Omar Sandoval <osandov@fb.com>, "Martin
	K. Petersen" <martin.petersen@oracle.com>, Christoph Hellwig <hch@lst.de>, Paolo Bonzini <pbonzini@redhat.com>, Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>, Linux SCSI List <linux-scsi@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kurz <groug@kaod.org>, qemu-discuss@nongnu.org, qemu-devel <qemu-devel@nongnu.org>

Hi.

On 11.08.2018 14:23, Ming Lei wrote:
> Please test for-4.19/block:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/log/?h=for-4.19/block
> 
> This slow boot issue should have been fixed by the following commits:
> 
> 1311326cf475 blk-mq: avoid to synchronize rcu inside 
> blk_cleanup_queue()
> 97889f9ac24f blk-mq: remove synchronize_rcu() from 
> blk_mq_del_queue_tag_set()
> 5815839b3ca1 blk-mq: introduce new lock for protecting 
> hctx->dispatch_wait
> 2278d69f030f blk-mq: don't pass **hctx to blk_mq_mark_tag_wait()
> 8ab6bb9ee8d0 blk-mq: cleanup blk_mq_get_driver_tag()

Indeed, I can confirm that these commits fix the issue.

Thanks a lot.

-- 
   Oleksandr Natalenko (post-factum)
