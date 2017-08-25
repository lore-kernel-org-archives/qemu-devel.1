Received: from eggs.gnu.org ([2001:4830:134:3::10]:42327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dlApl-0004aI-Jg
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 05:23:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dlApk-000520-Qd
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 05:23:21 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:37933)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dlApk-00051Y-Jd
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 05:23:20 -0400
Received: by mail-wm0-x231.google.com with SMTP id z132so7898154wmg.1
	for <qemu-devel@nongnu.org>; Fri, 25 Aug 2017 02:23:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4608a2c1-5c74-efea-d901-3b5cfa0519e6@redhat.com>
References: <20170824123006.GK5379@umbus.fritz.box>
	<20170825083123.47432-1-aik@ozlabs.ru>
	<4608a2c1-5c74-efea-d901-3b5cfa0519e6@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Aug 2017 10:22:58 +0100
Message-ID: <CAFEAcA_Z3wWv3_x0kCqD0tEwP=GTV-uoCLmUr5YpWjdD1GyMew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC PATCH qemu] exec: Destroy dispatch immediately
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, QEMU Developers <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>

On 25 August 2017 at 09:53, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The solution is to: 1) share the FlatView structures if they refer to
> the same root memory region; 2) have one AddressSpaceDispatch per
> FlatView instead of one per AddressSpace, so that FlatView reference
> counting takes care of clearing the AddressSpaceDispatch too.  Neither
> is particularly hard.

If we did this we could get rid of address_space_init_shareable(),
right? (It's a bit of a cheesy hack aimed at avoiding having duplicate
address space structures for the same root memory region, but if
the underlying code is better at not duplicating all the data
structures unless necessary then the benefit of having the
separate API goes away I think.)

thanks
-- PMM
