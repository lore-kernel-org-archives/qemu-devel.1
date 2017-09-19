Received: from eggs.gnu.org ([2001:4830:134:3::10]:44987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1duESu-0006Jl-De
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 05:05:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1duESt-0003YO-GS
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 05:05:12 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:47399)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1duESt-0003Xk-B3
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 05:05:11 -0400
Received: by mail-wm0-x229.google.com with SMTP id 13so3228010wmq.2
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 02:05:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170919044346.GA32572@toto>
References: <1498830302-19274-1-git-send-email-edgar.iglesias@gmail.com>
	<1498830302-19274-3-git-send-email-edgar.iglesias@gmail.com>
	<CAFEAcA-dssYnbZjuWTjBta1aK3iL3pyRKh5Qs4hFh=bPONgnTA@mail.gmail.com>
	<20170711100334.GA25504@toto>
	<CAFEAcA_XTrkAN1ATpp6DLZqGh4aL1gECzQGyubJmoGjtw_pPbA@mail.gmail.com>
	<20170711103859.GC25504@toto>
	<CAFEAcA9wn_ozBCHBZqxqARB5eD4wX1snyGfM0JW1Yk103CTytQ@mail.gmail.com>
	<20170919044346.GA32572@toto>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Sep 2017 10:04:49 +0100
Message-ID: <CAFEAcA-hNHaDkgAYtJFsSa7=eNAh+usUcEkOcf0rcdGRFV7UqQ@mail.gmail.com>
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

On 19 September 2017 at 05:43, Edgar E. Iglesias
<edgar.iglesias@xilinx.com> wrote:
> On Mon, Sep 18, 2017 at 04:50:23PM +0100, Peter Maydell wrote:
>> I'm currently running into a similar issue with M profile,
>> where at the moment we stuff the information about what
>> kind of fault the MPU generates into a v7PMSA format
>> FSR value and reinterpret it into M profile exception
>> types and fault status register bits later. This works
>> OK, but for v8M we want to start reporting kinds of fault
>> (like SecureFault) that don't have equivalents in v7PMSA
>> at all, and maybe it would be better to clean this up rather
>> than assigning arbitrary bogus fsr values for internal use...
>
> I see, yes that sounds like a similar issue.
> If you'd like to take over this, that'd be great :-)

For the moment I've taken the easy approach of using dummy
FSR values. We'll see if that gets through code review :-)

thanks
-- PMM
