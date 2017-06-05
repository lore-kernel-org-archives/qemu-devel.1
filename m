Received: from eggs.gnu.org ([2001:4830:134:3::10]:45215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dI1Kp-0001wI-H3
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 19:22:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dI1Ko-0004UQ-PJ
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 19:22:55 -0400
References: <20170511022036.32225-1-eblake@redhat.com>
	<20170511022036.32225-21-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <0462a717-69f0-95ad-3515-f559e116de01@redhat.com>
Date: Mon, 5 Jun 2017 19:22:41 -0400
MIME-Version: 1.0
In-Reply-To: <20170511022036.32225-21-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 20/20] block: Make
 bdrv_is_allocated_above() byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, Wen Congyang <wencongyang2@huawei.com>, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Xie Changlong <xiechanglong.d@gmail.com>



On 05/10/2017 10:20 PM, Eric Blake wrote:
> -                            int64_t sector_num, int nb_sectors, int *pnum);
> +                            int64_t offset, int64_t bytes, int64_t *pnum);

Minor context conflict after this that, for whichever reason, git could
not resolve on its own for me.
