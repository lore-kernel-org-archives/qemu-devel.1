Received: from eggs.gnu.org ([2001:4830:134:3::10]:34440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1eOJcF-00027l-T9
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 03:39:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1eOJcF-0002ND-1K
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 03:39:11 -0500
References: <1512735034-35327-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1512735034-35327-4-git-send-email-anton.nefedov@virtuozzo.com>
	<7dfd884c-c938-cff1-a077-9e159609aad4@redhat.com>
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <0eb17549-90b1-a190-007c-cd747b59d8b2@virtuozzo.com>
Date: Mon, 11 Dec 2017 11:38:57 +0300
MIME-Version: 1.0
In-Reply-To: <7dfd884c-c938-cff1-a077-9e159609aad4@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] ide: abort TRIM operation for invalid
 range
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org

On 8/12/2017 10:51 PM, John Snow wrote:
> 
> Looks about right, just remember that this flow won't call
> block_acct_invalid because you're bypassing the return to ide_dma_cb. I
> assume you'll get to that in your next series.
> 

Yes; I meant to keep the trim accounting in ide_issue_trim_cb()

> For now, this should properly reject bogus TRIM commands. When you send
> your next series, may I ask for a simple test case if possible?
> 

Sure, I'll look into it

> 1-3:
> Reviewed-by: John Snow <jsnow@redhat.com>
> 
