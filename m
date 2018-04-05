Received: from eggs.gnu.org ([2001:4830:134:3::10]:50708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f43yW-0002kG-5R
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 08:26:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f43yV-00013B-Dn
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 08:26:44 -0400
Received: from mail-ot0-x22f.google.com ([2607:f8b0:4003:c0f::22f]:46514)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f43yV-00012H-8R
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 08:26:43 -0400
Received: by mail-ot0-x22f.google.com with SMTP id v64-v6so26927978otb.13
	for <qemu-devel@nongnu.org>; Thu, 05 Apr 2018 05:26:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1521841386-27498-1-git-send-email-onursahin08@gmail.com>
References: <CAFEAcA9G3xVjmjys2R4-NXRHiZwLVLRO7ZQDZ0AhNMHHFhHV8A@mail.gmail.com>
	<1521841386-27498-1-git-send-email-onursahin08@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Apr 2018 13:26:22 +0100
Message-ID: <CAFEAcA8M-Q8nWnP1VWtuz2RpVs7_bZhhVfE4fcCzaU5tsnfGtg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] target-arm: Check undefined opcodes for
 SWP in A32 decoder
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Onur Sahin <onursahin08@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 23 March 2018 at 21:43, Onur Sahin <onursahin08@gmail.com> wrote:
> Thanks for the feedback Peter. Removing the redundant check on bit
> 23 and adding checks for the "should be" bits as well (bits [11:8]).
>
> The following patch should make sure we are not treating
> architecturally Undefined instructions as a SWP, by verifying
> the opcodes as per section A8.8.229 of ARMv7-A specification.
>
> Best,
> Onur
>
> Signed-off-by: Onur Sahin <onursahin08@gmail.com>
> ---

Thanks; I've applied this patch to target-arm.next for 2.12,
with some minor tweaks to the commit message.

-- PMM
