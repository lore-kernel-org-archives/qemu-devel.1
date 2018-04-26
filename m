Received: from eggs.gnu.org ([2001:4830:134:3::10]:60882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fBaMi-0006gR-94
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 02:26:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fBaMd-0001wf-Aw
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 02:26:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45694 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fBaMd-0001w1-6D
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 02:26:43 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180424214550.32549-1-lersek@redhat.com>
	<20180424214550.32549-7-lersek@redhat.com>
	<8736zjagg3.fsf@dusky.pond.sub.org>
	<4509705a-43b2-db40-aa24-18eff649e750@redhat.com>
Date: Thu, 26 Apr 2018 08:26:33 +0200
In-Reply-To: <4509705a-43b2-db40-aa24-18eff649e750@redhat.com> (Laszlo Ersek's
	message of "Wed, 25 Apr 2018 15:47:10 +0200")
Message-ID: <87sh7i4h5y.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 6/6] qapi: discriminate CpuInfo[Fast] on
 SysEmuTarget, not CpuInfoArch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

Laszlo Ersek <lersek@redhat.com> writes:

[...]
> In brief, I think extending configure / the build system would only help
> with the less painful part of this (the scalar mapping), and so it's not
> worth doing.

We're going to leave deprecated query-cpus alone (see Eric's review of
the previous patch).  Does that change matters?

PS: Instead of configure changes, #TARGET_BASE_ARCH might do.
