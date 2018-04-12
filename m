Received: from eggs.gnu.org ([2001:4830:134:3::10]:49763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6grj-0005pz-0d
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 14:22:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6gri-0007Tk-97
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 14:22:35 -0400
Received: from mail-ot0-x22c.google.com ([2607:f8b0:4003:c0f::22c]:36726)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f6gri-0007TQ-3H
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 14:22:34 -0400
Received: by mail-ot0-x22c.google.com with SMTP id n40-v6so7086420otd.3
	for <qemu-devel@nongnu.org>; Thu, 12 Apr 2018 11:22:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1523551221-11612-2-git-send-email-imammedo@redhat.com>
References: <1523551221-11612-1-git-send-email-imammedo@redhat.com>
	<1523551221-11612-2-git-send-email-imammedo@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Apr 2018 19:22:13 +0100
Message-ID: <CAFEAcA9LVUfmHGor=OmnXf0Dhj5zP_e++WELKwtx0Ru7VcRA-g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-2.13 1/4] arm: reuse
 arm_boot_address_space() in armv7m_load_kernel()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Eric Auger <eric.auger@redhat.com>

On 12 April 2018 at 17:40, Igor Mammedov <imammedo@redhat.com> wrote:
> reduce code duplication by resusing arm_boot_address_space()
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  include/hw/arm/arm.h |  2 ++
>  hw/arm/armv7m.c      | 10 +---------
>  hw/arm/boot.c        | 16 ++++++++--------
>  3 files changed, 11 insertions(+), 17 deletions(-)

This minor duplication was deliberate, because hw/arm/armv7m.c
is for M profile cores only, and hw/arm/boot.c is for
A/R profile cores only. I don't think that saving a
single if/else in armv7m.c really justifies blurring
that dividing line.

thanks
-- PMM
