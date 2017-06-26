Received: from eggs.gnu.org ([2001:4830:134:3::10]:60634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dPayB-0003Y3-Hw
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 16:50:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dPayA-0006lY-OO
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 16:50:51 -0400
References: <20170606073806.8180-1-quwenruo@cn.fujitsu.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <75d80dc9-377d-62fa-0c95-df2ae73039ca@redhat.com>
Date: Mon, 26 Jun 2017 16:50:42 -0400
MIME-Version: 1.0
In-Reply-To: <20170606073806.8180-1-quwenruo@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 1/2] nvme: Update header to
 include SGL related macros and members
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qu Wenruo <quwenruo@cn.fujitsu.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, keith.busch@intel.com

It looks like this patch hasn't gotten any attention in about a month. I
assume it's dead based on pending implementation that would actually
utilize these bits?

i.e., we don't need to check this patch in until the feature is actually
implemented, is that correct?

--js

On 06/06/2017 03:38 AM, Qu Wenruo wrote:
> Update nvme header to catch up with kernel.
> Most of the newly added members are from 1.2 and 1.3 spec, while the
> status code is only kept the same with kernel (around 1.1 spec).
> 
> The major update is to add Scatter Gather List related macros and
> members, for later SGL support implementation.
> 
> Signed-off-by: Qu Wenruo <quwenruo@cn.fujitsu.com>
> ---
>  hw/block/nvme.c |  16 ++++----
>  hw/block/nvme.h | 122 +++++++++++++++++++++++++++++++++++++++++++++++---------
>  2 files changed, 111 insertions(+), 27 deletions(-)
> 

[snip]
