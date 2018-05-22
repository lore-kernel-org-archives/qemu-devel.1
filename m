Received: from eggs.gnu.org ([2001:4830:134:3::10]:41856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fL88v-0002G6-O8
	for qemu-devel@nongnu.org; Tue, 22 May 2018 10:20:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fL88u-0005X6-T8
	for qemu-devel@nongnu.org; Tue, 22 May 2018 10:20:01 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:34167)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fL88u-0005Vw-O5
	for qemu-devel@nongnu.org; Tue, 22 May 2018 10:20:00 -0400
Received: by mail-ot0-x243.google.com with SMTP id i5-v6so21172005otf.1
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 07:19:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <595dcb89-3856-3755-e8db-7791c1374284@redhat.com>
References: <20180521140402.23318-1-peter.maydell@linaro.org>
	<20180521140402.23318-15-peter.maydell@linaro.org>
	<47281818-f0cf-0ed1-c479-fbcaca5c5167@redhat.com>
	<CAFEAcA-R9t4K488viYM9ipmfArA=ijMMJn+FD1wekPdAbNOHvQ@mail.gmail.com>
	<595dcb89-3856-3755-e8db-7791c1374284@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 May 2018 15:19:38 +0100
Message-ID: <CAFEAcA8Eq+EvtL1JuqtHePWMLPdkHG9zzAh7Wkrw7sNYw8jzUQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 14/27] iommu: Add IOMMU index concept to
 IOMMU API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: "patches@linaro.org" <patches@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>

On 22 May 2018 at 15:11, Auger Eric <eric.auger@redhat.com> wrote:
> Hi Peter,
>
> On 05/22/2018 03:22 PM, Peter Maydell wrote:
>> How many substream IDs do we expect to see in practice?
>
> Spec says max 20 bits, matching the max size of the PASID

Right, but do we actually expect to see transactions from
devices that use the whole 2^20 possible values, or will
they in practice mostly use 1..5, or somethnig else?

thanks
-- PMM
