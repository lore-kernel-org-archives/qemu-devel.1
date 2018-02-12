Received: from eggs.gnu.org ([2001:4830:134:3::10]:36394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1elEF4-0006EP-LK
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 08:33:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1elEF1-0007Tc-NL
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 08:33:58 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50340 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1elEF1-0007Sr-IH
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 08:33:55 -0500
Date: Mon, 12 Feb 2018 14:33:52 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180212133352.GE5103@localhost.localdomain>
References: <20171012235439.19457-1-anatol.pomozov@gmail.com>
	<20171012235439.19457-2-anatol.pomozov@gmail.com>
	<20180115144944.GG32271@localhost.localdomain>
	<CAOMFOmU4pLtJMQ_SLqffpritydx4ghs9gUJBfyVT+zN_fudCRA@mail.gmail.com>
	<20180129200210.GT6141@localhost.localdomain>
	<CAOMFOmXrp8x18Jph8ipR+m52FxdjcpaLoHP_Xh-4F6X95pG+8Q@mail.gmail.com>
	<CAOMFOmWSZ3kBoHRmQcmg_qu6xfEbEjVsH0xycvaxPBLFA6xf5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMFOmWSZ3kBoHRmQcmg_qu6xfEbEjVsH0xycvaxPBLFA6xf5g@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH 1/4] multiboot: Change multiboot_info from
 array of bytes to a C struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anatol Pomozov <anatol.pomozov@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Alexander Graf <agraf@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

Am 09.02.2018 um 22:52 hat Anatol Pomozov geschrieben:
> Actually I just fetched recent chnages and tests/multiboot/run_test.sh
> does not work for me anymore. I rebuilt 'master' branch without my
> changes and see the same issue. It looks like debug console does not
> print to stdio anymore.
> 
> Does anyone see the same issue?

Still works for me on current git master.

Kevin
