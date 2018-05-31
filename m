Received: from eggs.gnu.org ([2001:4830:134:3::10]:57553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fOKIE-0005wv-84
	for qemu-devel@nongnu.org; Thu, 31 May 2018 05:54:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fOKID-0006xN-ID
	for qemu-devel@nongnu.org; Thu, 31 May 2018 05:54:50 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:39989)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fOKID-0006x2-BA
	for qemu-devel@nongnu.org; Thu, 31 May 2018 05:54:49 -0400
Received: by mail-oi0-x244.google.com with SMTP id f79-v6so5036203oib.7
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 02:54:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87a9fff7-0a53-6b52-eb2c-e721556cf87b@redhat.com>
References: <20180521140402.23318-1-peter.maydell@linaro.org>
	<87a9fff7-0a53-6b52-eb2c-e721556cf87b@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 May 2018 10:54:28 +0100
Message-ID: <CAFEAcA8XkCAK1GKHXKEBgxrVW75E9i3cDFw0iF68V7y7x8h-0A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 00/27] iommu: support txattrs,
 support TCG execution, implement TZ MPC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "patches@linaro.org" <patches@linaro.org>

On 30 May 2018 at 17:58, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 21/05/2018 16:03, Peter Maydell wrote:
>> This patchset is a rather large one, but the first half is all
>> fairly simple plumbing. It does four things:
>>  * support IOMMUs that are aware of memory transaction attributes and
>>    may generate different translations for different attributes
>>  * support TCG execution out of memory which is behind an IOMMU
>>  * implement the Arm TrustZone Memory Protection Controller
>>    (which needs both the above features in the IOMMU core code)
>>  * use the MPC in the mps2-an505 board
>
> Go ahead and apply it through the ARM tree.  Thanks!

It needs a v2 (there are some patches that need fixing),
and some of the tail end of the patchset hasn't been reviewed,
and I'm not sure if we have consensus on the IOMMU API changes
completely yet. But if you're happy we're going in the right
direction I can apply 1-13 via target-arm.next (that's the
"plumb TxAttrs through various functions" patches). That will
reduce the size of the patchset and make conflicts less likely.

thanks
-- PMM
