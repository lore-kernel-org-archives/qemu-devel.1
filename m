Received: from eggs.gnu.org ([2001:4830:134:3::10]:46098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cUcKG-0005Ot-TZ
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:46:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cUcKF-0004u3-N1
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:46:08 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1484579832-18589-1-git-send-email-pl@kamp.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0c39b1de-bef4-6fa6-76be-bccc096abe2f@redhat.com>
Date: Fri, 20 Jan 2017 17:45:51 +0100
MIME-Version: 1.0
In-Reply-To: <1484579832-18589-1-git-send-email-pl@kamp.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] block/iscsi: avoid data corruption with
 cache=writeback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, qemu-block@nongnu.org



On 16/01/2017 16:17, Peter Lieven wrote:
> nb_cls_shrunk in iscsi_allocmap_update can become -1 if the
> request starts and ends within the same cluster. This results
> in passing -1 to bitmap_set and bitmap_clear and they don't
> handle negative values properly. In the end this leads to data
> corruption.
> 
> Fixes: e1123a3b40a1a9a625a29c8ed4debb7e206ea690
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Lieven <pl@kamp.de>
> ---
>  block/iscsi.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Queued, thanks.

Paolo
