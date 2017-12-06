Received: from eggs.gnu.org ([2001:4830:134:3::10]:44681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <martin.petersen@oracle.com>) id 1eMgVd-00080S-Te
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 15:41:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <martin.petersen@oracle.com>) id 1eMgVd-0008Ot-5f
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 15:41:37 -0500
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <cover.1512589016.git.mark.kanda@oracle.com>
	<cover.1512589016.git.mark.kanda@oracle.com>
	<0a69463200d64d81dc27898ff92ecd10b126d968.1512589016.git.mark.kanda@oracle.com>
Date: Wed, 06 Dec 2017 15:41:20 -0500
In-Reply-To: <0a69463200d64d81dc27898ff92ecd10b126d968.1512589016.git.mark.kanda@oracle.com>
	(Mark Kanda's message of "Wed, 6 Dec 2017 13:54:01 -0600")
Message-ID: <yq1wp1zzj0v.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/2] virtio-blk: reject configs with
 logical block size > physical block size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Kanda <mark.kanda@oracle.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, stefanha@redhat.com, konrad.wilk@oracle.com, martin.petersen@oracle.com, ameya.more@oracle.com, karl.heubaum@oracle.com


Mark,

> virtio-blk logical block size should never be larger than physical block
> size because it doesn't make sense to have such configurations. QEMU doesn't
> have a way to effectively express this condition; the best it can do is
> report the physical block exponent as 0 - indicating the logical block size
> equals the physical block size.
>
> This is identical to commit 3da023b5827543ee4c022986ea2ad9d1274410b2
> but applied to virtio-blk (instead of virtio-scsi).

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
