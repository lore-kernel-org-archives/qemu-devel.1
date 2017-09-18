Received: from eggs.gnu.org ([2001:4830:134:3::10]:33142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dtyJr-0002Sc-4U
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 11:50:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dtyJq-0002jS-4N
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 11:50:47 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:56403)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dtyJp-0002iy-IB
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 11:50:45 -0400
Received: by mail-wr0-x229.google.com with SMTP id r74so866285wrb.13
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 08:50:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170711103859.GC25504@toto>
References: <1498830302-19274-1-git-send-email-edgar.iglesias@gmail.com>
	<1498830302-19274-3-git-send-email-edgar.iglesias@gmail.com>
	<CAFEAcA-dssYnbZjuWTjBta1aK3iL3pyRKh5Qs4hFh=bPONgnTA@mail.gmail.com>
	<20170711100334.GA25504@toto>
	<CAFEAcA_XTrkAN1ATpp6DLZqGh4aL1gECzQGyubJmoGjtw_pPbA@mail.gmail.com>
	<20170711103859.GC25504@toto>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Sep 2017 16:50:23 +0100
Message-ID: <CAFEAcA9wn_ozBCHBZqxqARB5eD4wX1snyGfM0JW1Yk103CTytQ@mail.gmail.com>
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

Edgar, did you ever have a go at implementing this?
I'm currently running into a similar issue with M profile,
where at the moment we stuff the information about what
kind of fault the MPU generates into a v7PMSA format
FSR value and reinterpret it into M profile exception
types and fault status register bits later. This works
OK, but for v8M we want to start reporting kinds of fault
(like SecureFault) that don't have equivalents in v7PMSA
at all, and maybe it would be better to clean this up rather
than assigning arbitrary bogus fsr values for internal use...

thanks
-- PMM
