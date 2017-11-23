Received: from eggs.gnu.org ([2001:4830:134:3::10]:43767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eHlzv-00026X-QW
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 02:32:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eHlzr-00021M-T8
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 02:32:35 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:45167)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eHlzr-00020w-LX
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 02:32:31 -0500
Received: by mail-wm0-x242.google.com with SMTP id 9so14717925wme.4
	for <qemu-devel@nongnu.org>; Wed, 22 Nov 2017 23:32:31 -0800 (PST)
References: <20171122142627.73170-1-borntraeger@de.ibm.com>
	<20171122142627.73170-3-borntraeger@de.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7ca173f9-c4f3-2daa-04b0-38b4ade27504@linaro.org>
Date: Thu, 23 Nov 2017 08:32:26 +0100
MIME-Version: 1.0
In-Reply-To: <20171122142627.73170-3-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] pc-bios/s390-ccw: zero out bss section
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Richard Henderson <rth@twiddle.net>

On 11/22/2017 03:26 PM, Christian Borntraeger wrote:
> The QEMU ELF loader does not zero the bss segment.
> This resulted in several bugs, e.g. see
> 
> commit 5d739a4787a5 (s390-ccw.img: Fix sporadic errors with ccw boot image - initialize css)
> commit 6a40fa2669d3 (s390-ccw.img: Initialize next_idx)
> commit 8775d91a0f42 (pc-bios/s390-ccw: Fix problem with invalid virtio-scsi LUN when rebooting)
> 
> Lets fix this once and forever by letting the BIOS zero the bss itself.
> 
> Suggested-by: Alexander Graf <agraf@suse.de>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  pc-bios/s390-ccw/start.S | 30 +++++++++++++++++++++++++++---
>  1 file changed, 27 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
