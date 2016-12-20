Received: from eggs.gnu.org ([2001:4830:134:3::10]:38375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1cJTjM-0006mi-Ks
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 18:22:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1cJTjL-0003wy-Ta
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 18:22:00 -0500
Received: from hera.aquilenet.fr ([2a01:474::1]:39556)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1cJTjL-0003wn-NC
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 18:21:59 -0500
Date: Wed, 21 Dec 2016 00:21:55 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20161220232155.GS3258@var.home>
References: <20161220230732.17862-1-samuel.thibault@ens-lyon.org>
	<148227574230.73.12239976842886455682@790289a7ca88>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <148227574230.73.12239976842886455682@790289a7ca88>
Subject: Re: [Qemu-devel] [PULL 0/2] slirp updates: MIN/MAX,
 tftp dynamic blocks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, stefanha@redhat.com, jan.kiszka@siemens.com

no-reply@patchew.org, on Tue 20 Dec 2016 15:15:43 -0800, wrote:
> Your series seems to have some coding style problems. See output below for
> more information:


> ERROR: suspect code indent for conditional statements (10, 14)
> #90: FILE: slirp/tftp.c:393:
> +          if (blksize > 0) {
> +              spt->block_size = MIN(blksize, TFTP_BLOCKSIZE_MAX);

This is a false positive.

Samuel
