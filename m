Received: from eggs.gnu.org ([2001:4830:134:3::10]:55084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anatol.pomozov@gmail.com>) id 1ekGaT-0003mP-GQ
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 16:52:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anatol.pomozov@gmail.com>) id 1ekGaS-0002Dj-SO
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 16:52:05 -0500
Received: from mail-ua0-x22f.google.com ([2607:f8b0:400c:c08::22f]:45165)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <anatol.pomozov@gmail.com>)
	id 1ekGaS-0002Dd-Nb
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 16:52:04 -0500
Received: by mail-ua0-x22f.google.com with SMTP id z3so6066058uae.12
	for <qemu-devel@nongnu.org>; Fri, 09 Feb 2018 13:52:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAOMFOmXrp8x18Jph8ipR+m52FxdjcpaLoHP_Xh-4F6X95pG+8Q@mail.gmail.com>
References: <20171012235439.19457-1-anatol.pomozov@gmail.com>
	<20171012235439.19457-2-anatol.pomozov@gmail.com>
	<20180115144944.GG32271@localhost.localdomain>
	<CAOMFOmU4pLtJMQ_SLqffpritydx4ghs9gUJBfyVT+zN_fudCRA@mail.gmail.com>
	<20180129200210.GT6141@localhost.localdomain>
	<CAOMFOmXrp8x18Jph8ipR+m52FxdjcpaLoHP_Xh-4F6X95pG+8Q@mail.gmail.com>
From: Anatol Pomozov <anatol.pomozov@gmail.com>
Date: Fri, 9 Feb 2018 13:52:03 -0800
Message-ID: <CAOMFOmWSZ3kBoHRmQcmg_qu6xfEbEjVsH0xycvaxPBLFA6xf5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Kevin Wolf <kwolf@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Alexander Graf <agraf@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

Hello

Actually I just fetched recent chnages and tests/multiboot/run_test.sh
does not work for me anymore. I rebuilt 'master' branch without my
changes and see the same issue. It looks like debug console does not
print to stdio anymore.

Does anyone see the same issue?
