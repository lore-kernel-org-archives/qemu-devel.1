Received: from eggs.gnu.org ([2001:4830:134:3::10]:57738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQ823-0000hj-Ic
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 05:13:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQ822-0003cf-BT
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 05:13:35 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:36313)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fQ822-0003cN-4Q
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 05:13:34 -0400
Received: by mail-ot0-x241.google.com with SMTP id m11-v6so1935526otf.3
	for <qemu-devel@nongnu.org>; Tue, 05 Jun 2018 02:13:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180605073937.GD9216@xz-mi>
References: <20180604152941.20374-1-peter.maydell@linaro.org>
	<20180605073937.GD9216@xz-mi>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Jun 2018 10:13:12 +0100
Message-ID: <CAFEAcA-=WtB8bCM2Q=CATM9YBM7whRf5uK1fLhaJH_mfkip1uw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 00/13] iommu: support txattrs,
 support TCG execution, implement TZ MPC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Eric Auger <eric.auger@redhat.com>

On 5 June 2018 at 08:39, Peter Xu <peterx@redhat.com> wrote:
> On Mon, Jun 04, 2018 at 04:29:28PM +0100, Peter Maydell wrote:
>> Hi; this is v2 of my iommu patchset, which does:
>>  * support IOMMUs that are aware of memory transaction attributes and
>>    may generate different translations for different attributes
>>  * support TCG execution out of memory which is behind an IOMMU
>>  * implement the Arm TrustZone Memory Protection Controller
>>    (which needs both the above features in the IOMMU core code)
>>  * use the MPC in the mps2-an505 board

> It seems that this series is still using the IOMMU index way.  In case
> I missed anything... Could you elaborate a bit on why this IOMMU index
> solution is preferred comparing to the way to pass in MemTxAttrs?  Or
> was there any further discussion I missed on the topic?
>
> My last post to previous series is here:
>
> https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg05702.html
>
> In that, I was still confused on why we couldn't use the existing
> MemTxAttrs directly instead of the new IOMMU index (and I explained on
> why that was prefered at least to me). I didn't see replies
> afterwards.

Broadly speaking I didn't think I had any further better
explanation than I'd already given in that thread, eg here:
https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg05250.html
and here:
https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg05513.html

If you want to make a specific (detailed) counterproposal of a
different API, I'm happy to look at whether that works for
the use cases I care about and whether it's a nicer way to do it.

thanks
-- PMM
