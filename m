Received: from eggs.gnu.org ([2001:4830:134:3::10]:60137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cJVrd-0001P0-TE
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 20:38:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cJVrd-0002un-33
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 20:38:41 -0500
Date: Wed, 21 Dec 2016 09:38:32 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20161221013832.GD2994@lemon>
References: <20161220163139.12016-1-famz@redhat.com>
	<148227508365.73.4716554489460240685@790289a7ca88>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <148227508365.73.4716554489460240685@790289a7ca88>
Subject: Re: [Qemu-devel] [PATCH 0/4] RFC: A VFIO based block driver for
 NVMe device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com, borntraeger@de.ibm.com, stefanha@redhat.com, pbonzini@redhat.com, krister@redhat.com

On Tue, 12/20 15:04, no-reply@patchew.org wrote:
> ERROR: that open brace { should be on the previous line
> #287: FILE: util/vfio-helpers.c:214:
> +    struct vfio_group_status group_status =
> +    { .argsz = sizeof(group_status) };

Hmm, it may indeed look better.

> ERROR: Use of volatile is usually wrong: see Documentation/volatile-considered-harmful.txt
> #145: FILE: block/nvme.c:92:
> +    volatile uint32_t *doorbell;
> 
> ERROR: Use of volatile is usually wrong: see Documentation/volatile-considered-harmful.txt
> #169: FILE: block/nvme.c:116:
> +typedef volatile struct {

These are shared with hardware, even volatile-considered-harmful.txt admits it
can be valid:

> - Pointers to data structures in coherent memory which might be modified
>   by I/O devices can, sometimes, legitimately be volatile.  A ring buffer
>   used by a network adapter, where that adapter changes pointers to
>   indicate which descriptors have been processed, is an example of this
>   type of situation.

Fam
