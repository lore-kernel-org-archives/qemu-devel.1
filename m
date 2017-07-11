Received: from eggs.gnu.org ([2001:4830:134:3::10]:34467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUsjY-0000w6-AX
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 06:49:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUsjX-0005IQ-D3
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 06:49:36 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:35366)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dUsjX-0005IA-5K
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 06:49:35 -0400
Received: by mail-wr0-x22e.google.com with SMTP id k67so177115156wrc.2
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 03:49:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170711103859.GC25504@toto>
References: <1498830302-19274-1-git-send-email-edgar.iglesias@gmail.com>
	<1498830302-19274-3-git-send-email-edgar.iglesias@gmail.com>
	<CAFEAcA-dssYnbZjuWTjBta1aK3iL3pyRKh5Qs4hFh=bPONgnTA@mail.gmail.com>
	<20170711100334.GA25504@toto>
	<CAFEAcA_XTrkAN1ATpp6DLZqGh4aL1gECzQGyubJmoGjtw_pPbA@mail.gmail.com>
	<20170711103859.GC25504@toto>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Jul 2017 11:49:13 +0100
Message-ID: <CAFEAcA-qqu7TzPQfMniErU-dSzpnXz7ni2sr7VF-RqHi7U+Uwg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 2/2] target-arm: Extend PAR format
 determination
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-arm <qemu-arm@nongnu.org>

On 11 July 2017 at 11:38, Edgar E. Iglesias <edgar.iglesias@xilinx.com> wrote:
> Another way could also be to have get_phys_addr() fill in generic
> fields in the FaultInfo struct and then have a faultinfo_to_fsr
> mapping function to populate FSR/PAR. Do you see any issues with that?

Yes, that's probably better. It's how the pseudocode in the ARM ARM
deals with the problem: there's a FaultRecord structure which is
populated by AArch32.CreateFaultRecord() and AArch64.CreateFaultRecord(),
and then it isn't actually turned into an FSR or ESR_ELx format
value until needed (eg in AArch64.FaultSyndrome which calls EncodeLDFSC
to get the long-form fault code bits, or similar functions on the AArch32
side which end up calling EncodeSDFSC() for short-form code bits).

thanks
-- PMM
