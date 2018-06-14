Received: from eggs.gnu.org ([2001:4830:134:3::10]:40810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTVT8-0000Lz-Ie
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 12:51:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTVT6-0000aL-8N
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 12:51:30 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:44343)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fTVT5-0000Zh-L8
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 12:51:28 -0400
Received: by mail-oi0-x242.google.com with SMTP id c128-v6so6272577oig.11
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 09:51:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180604152941.20374-1-peter.maydell@linaro.org>
References: <20180604152941.20374-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Jun 2018 17:51:06 +0100
Message-ID: <CAFEAcA8OO0SdmE4nJhcQg6kWPcqs-5g8BkjOREw40aUchc6RXw@mail.gmail.com>
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
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: "patches@linaro.org" <patches@linaro.org>, Peter Xu <peterx@redhat.com>, Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>

On 4 June 2018 at 16:29, Peter Maydell <peter.maydell@linaro.org> wrote:
> Hi; this is v2 of my iommu patchset, which does:
>  * support IOMMUs that are aware of memory transaction attributes and
>    may generate different translations for different attributes
>  * support TCG execution out of memory which is behind an IOMMU
>  * implement the Arm TrustZone Memory Protection Controller
>    (which needs both the above features in the IOMMU core code)
>  * use the MPC in the mps2-an505 board

> Unreviewed patches: 4, 6, 7, 8, 9, 10

Ping for further reviews, comments, etc, please. I'd like
to put this in via target-arm.next in the not too distant
future.

thanks
-- PMM
