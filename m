Received: from eggs.gnu.org ([2001:4830:134:3::10]:40137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fJIZk-0000VQ-Ml
	for qemu-devel@nongnu.org; Thu, 17 May 2018 09:04:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fJIZf-0000pR-2Z
	for qemu-devel@nongnu.org; Thu, 17 May 2018 09:04:08 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:42620)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fJIZe-0000pG-UE
	for qemu-devel@nongnu.org; Thu, 17 May 2018 09:04:03 -0400
Received: by mail-oi0-x242.google.com with SMTP id t27-v6so3883839oij.9
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 06:04:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <2d52e9bd-93e7-58fd-af73-8eccda3bcb63@redhat.com>
References: <20180501085939.6201-1-peter.maydell@linaro.org>
	<c338d0d3-2b02-26e7-f745-fbc5c1893453@redhat.com>
	<CAFEAcA_Dei48HtKk6GnEgXYcXdY2htCXej4pSfY+q9V6f=abdA@mail.gmail.com>
	<1738f78f-b310-3cde-ac5e-1a147d3ca5f6@redhat.com>
	<CAFEAcA-o3M2ruUfU7hk89S=eGgCP=b+hPyKrSdSR79OP_Ug9vg@mail.gmail.com>
	<2d52e9bd-93e7-58fd-af73-8eccda3bcb63@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 May 2018 14:03:41 +0100
Message-ID: <CAFEAcA-DhNwT04nouBUqJPeGukAhUmw0QQvi5oduKeLw7b6iJA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC PATCH v2 00/12] iommu: add MemTxAttrs
 argument to IOMMU translate function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Eric Auger <eric.auger@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 17 May 2018 at 13:46, Paolo Bonzini <pbonzini@redhat.com> wrote:
> Yes, this also sounds good.  It does have the same issue for VFIO that
> get_num_indexes() would be called too late to fail (and again, in a
> place where it's hard to fail).
>
> Maybe the index count and the index-from/to-attrs translation should be
> static (index-to-attrs could use the same pair of MemTxAttrs for "which
> bits matter" and "what value should they have"), so that VFIO can
> inspect it and decide if it's okay to proceed with e.g. the first iommu_idx?

Well, they need to be static in the sense that the IOMMU can't
change its opinion later about what it has. So as long as you
have a pointer to the IOMMU you can ask it how many indexes it has.

thanks
-- PMM
