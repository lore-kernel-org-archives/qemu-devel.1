Received: from eggs.gnu.org ([2001:4830:134:3::10]:35643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fdLyV-0004BO-Tw
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 16:44:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fdLyR-0007ba-2f
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 16:44:35 -0400
Received: from mail-io0-x244.google.com ([2607:f8b0:4001:c06::244]:40314)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fdLyQ-0007bI-Ic
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 16:44:30 -0400
Received: by mail-io0-x244.google.com with SMTP id l14-v6so15659612iob.7
	for <qemu-devel@nongnu.org>; Wed, 11 Jul 2018 13:44:30 -0700 (PDT)
References: <20180711164025.10924-1-laurent@vivier.eu>
	<515ab6e6-14b3-2687-18b9-582d63b82903@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c50e56af-0eff-afff-4704-b01dee538581@linaro.org>
Date: Wed, 11 Jul 2018 15:44:27 -0500
MIME-Version: 1.0
In-Reply-To: <515ab6e6-14b3-2687-18b9-582d63b82903@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] linux-user: fix mmap_find_vma_reserved()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>

On 07/11/2018 01:27 PM, Laurent Vivier wrote:
> Richard,
> 
> I think this fix could be merged into your "linux-user: Fix shmat
> emulation by honoring host SHMLBA" patch, by adding something like this
> instead:

Well, not "instead", but "in addition".

Nothing works right when the guest adjustment itself is unaligned, as is the
case with reserved_va as you noted, and with (non-reserved) guest_base as I
noted in that patch.

For v2, I'll split the guest_base fix out to a separate patch.


r~
