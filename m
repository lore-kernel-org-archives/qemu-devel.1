Received: from eggs.gnu.org ([2001:4830:134:3::10]:59386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fONlj-0004Az-42
	for qemu-devel@nongnu.org; Thu, 31 May 2018 09:37:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fONlh-0004zM-Vr
	for qemu-devel@nongnu.org; Thu, 31 May 2018 09:37:31 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:33304)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fONlh-0004yp-LE
	for qemu-devel@nongnu.org; Thu, 31 May 2018 09:37:29 -0400
Received: by mail-ot0-x241.google.com with SMTP id h6-v6so6237258otj.0
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 06:37:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8XkCAK1GKHXKEBgxrVW75E9i3cDFw0iF68V7y7x8h-0A@mail.gmail.com>
References: <20180521140402.23318-1-peter.maydell@linaro.org>
	<87a9fff7-0a53-6b52-eb2c-e721556cf87b@redhat.com>
	<CAFEAcA8XkCAK1GKHXKEBgxrVW75E9i3cDFw0iF68V7y7x8h-0A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 May 2018 14:37:08 +0100
Message-ID: <CAFEAcA8vFEX0oMJcU112MMGyMue6k7BCmBD-L30b920RXqnLHA@mail.gmail.com>
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

On 31 May 2018 at 10:54, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 30 May 2018 at 17:58, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> Go ahead and apply it through the ARM tree.  Thanks!
>
> It needs a v2 (there are some patches that need fixing),
> and some of the tail end of the patchset hasn't been reviewed,
> and I'm not sure if we have consensus on the IOMMU API changes
> completely yet. But if you're happy we're going in the right
> direction I can apply 1-13 via target-arm.next (that's the
> "plumb TxAttrs through various functions" patches). That will
> reduce the size of the patchset and make conflicts less likely.

I'm putting patches 1-13 (initial plumbing) and 22 (adding
VMSTATE_BOOL_SUB_ARRAY) into target-arm.next.

The rest will need a respin to fix minor nits and some
conflicts with things that are now in master.

thanks
-- PMM
