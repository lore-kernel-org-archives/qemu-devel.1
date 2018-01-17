Received: from eggs.gnu.org ([2001:4830:134:3::10]:40614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ebqQO-0001Si-TH
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:18:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ebqQO-0005Mj-5P
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:18:52 -0500
Received: from mail-oi0-x233.google.com ([2607:f8b0:4003:c06::233]:35997)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ebqQO-0005M4-06
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:18:52 -0500
Received: by mail-oi0-x233.google.com with SMTP id w135so13527016oie.3
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 08:18:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180117171540.7e892ce7@redhat.com>
References: <CAFEAcA8F4iO91c8OGtDbHQ_hqzY+9ka41PW4q+ES9sYGRUha0g@mail.gmail.com>
	<176e66bb-7990-20da-a82f-fbabd9b4ed88@redhat.com>
	<CAKv+Gu__twgv27OxV=ORHywzeotk3+TNYo_-=bSjdFokfmXyGw@mail.gmail.com>
	<20180117171540.7e892ce7@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 17 Jan 2018 16:18:30 +0000
Message-ID: <CAFEAcA89q-HzCHUsW7=9KovWx0tamPtgirPaiFHu7cFxhuoZnA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] QEMU virt board: extending various limits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Laszlo Ersek <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Andrew Jones <drjones@redhat.com>, Wei Huang <wei@redhat.com>, "Leif Lindholm (Linaro address)" <leif.lindholm@linaro.org>

On 17 January 2018 at 16:15, Igor Mammedov <imammedo@redhat.com> wrote:
> my idea was to drop fixed RAM base for virt board (at least for
> new machine types) so that QEMU could specify it dynamically and
> firmware would get base from x0 instead of compiled in constant.

"base of ram is fixed" is about the one thing we've told
people they can rely on without fishing it out of the
device tree, so I think I'll just rule changing that out
of consideration now :-)

thanks
-- PMM
