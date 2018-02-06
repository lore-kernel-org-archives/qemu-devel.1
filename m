Received: from eggs.gnu.org ([2001:4830:134:3::10]:52988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ej2dZ-0006OR-CD
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 07:46:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ej2dY-0000Ji-EM
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 07:46:13 -0500
Received: from mail-ot0-x233.google.com ([2607:f8b0:4003:c0f::233]:46932)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ej2dY-0000ID-9I
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 07:46:12 -0500
Received: by mail-ot0-x233.google.com with SMTP id f56so1568157otj.13
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 04:46:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5c98e7b7-ca50-ed3e-6e0c-671cd793b175@redhat.com>
References: <151784238084.63.357873266609338192@bdbb90650ae5>
	<5c98e7b7-ca50-ed3e-6e0c-671cd793b175@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Feb 2018 12:45:51 +0000
Message-ID: <CAFEAcA9m9x0Vz6-A95P7_WUj+oJS=NLQyWFPJubC2ttOJZWhWQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v8 00/14] ARM SMMUv3 Emulation Support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>, eric.auger.pro@gmail.com, qemu-arm <qemu-arm@nongnu.org>, Prem Mallappa <prem.mallappa@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Tomasz Nowicki <tn@semihalf.com>, Peter Xu <peterx@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, linuc.decode@gmail.com, Bharat Bhushan <bharat.bhushan@nxp.com>, Christoffer Dall <christoffer.dall@linaro.org>

On 6 February 2018 at 12:22, Auger Eric <eric.auger@redhat.com> wrote:
> I will add
> #include "qemu/log.h" in smmuv3-internal.h in next release, to fix this
> mingw compilation issue.

It's an issue with configs that don't use the 'log' trace
backend, rather than mingw specifically. (It just happens
that patchew's mingw backend is the one that's configured
with a different trace backend.) The default backend means
trace.h includes log.h.

I really ought to write some patches to make this be an
error always rather than only if you configured a different
trace backend...

thanks
-- PMM
