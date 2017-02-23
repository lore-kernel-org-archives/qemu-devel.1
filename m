Received: from eggs.gnu.org ([2001:4830:134:3::10]:45933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cgyFR-0002DG-Bw
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 13:36:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cgyFQ-0000SF-JA
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 13:36:13 -0500
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:35293)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cgyFQ-0000Rt-Cx
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 13:36:12 -0500
Received: by mail-wr0-x232.google.com with SMTP id s27so27250754wrb.2
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 10:36:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1487850673-26455-2-git-send-email-vijay.kilari@gmail.com>
References: <1487850673-26455-1-git-send-email-vijay.kilari@gmail.com>
	<1487850673-26455-2-git-send-email-vijay.kilari@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Feb 2017 18:35:50 +0000
Message-ID: <CAFEAcA_rYx2+zGB16O4w=BjOP9e-jn5kSGT8rCosHsgubo-w_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v9 1/5] kernel: Add definitions for GICv3
 attributes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vijay Kilari <vijay.kilari@gmail.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, Christoffer Dall <christoffer.dall@linaro.org>, Eric Auger <eric.auger@redhat.com>, Pavel Fedin <p.fedin@samsung.com>, Marc Zyngier <marc.zyngier@arm.com>, QEMU Developers <qemu-devel@nongnu.org>, Vijaya Kumar K <Vijaya.Kumar@cavium.com>

On 23 February 2017 at 11:51,  <vijay.kilari@gmail.com> wrote:
> From: Vijaya Kumar K <Vijaya.Kumar@cavium.com>
>
> This temporary patch adds kernel API definitions.
> Use proper header update procedure after these features
> are released.

I can't put this patchset into QEMU with this temporary patch;
you need to do a proper kernel headers update with
the update-linux-headers.sh script.

thanks
-- PMM
