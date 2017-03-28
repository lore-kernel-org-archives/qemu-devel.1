Received: from eggs.gnu.org ([2001:4830:134:3::10]:42645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cslyu-0003zT-Ih
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 03:55:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cslyt-0008Rb-Qc
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 03:55:56 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170327165005.22038-1-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d9d2fcdb-d744-4cff-4373-7bbb3fc5c6b7@redhat.com>
Date: Tue, 28 Mar 2017 09:55:46 +0200
MIME-Version: 1.0
In-Reply-To: <20170327165005.22038-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] iscsi: drop unused IscsiAIOCB.qiov field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>, qemu-block@nongnu.org, qemu-trivial@nongnu.org, Peter Lieven <pl@kamp.de>



On 27/03/2017 18:50, Stefan Hajnoczi wrote:
> The IscsiAIOCB.qiov field has been unused since commit
> 063c3378a9e3c25cc0afac3c72e4823d0621e352 ("block/iscsi: introduce
> bdrv_co_{readv, writev, flush_to_disk}") back in 2013.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  block/iscsi.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/block/iscsi.c b/block/iscsi.c
> index 75d8905..716e74a 100644
> --- a/block/iscsi.c
> +++ b/block/iscsi.c
> @@ -103,7 +103,6 @@ typedef struct IscsiTask {
>  
>  typedef struct IscsiAIOCB {
>      BlockAIOCB common;
> -    QEMUIOVector *qiov;
>      QEMUBH *bh;
>      IscsiLun *iscsilun;
>      struct scsi_task *task;
> 

Queued, thanks (don't know if for 2.9 or 2.10 right now).

Paolo
