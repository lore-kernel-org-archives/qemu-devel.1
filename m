Received: from eggs.gnu.org ([2001:4830:134:3::10]:49705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fBd2s-0000Dk-9w
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 05:18:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fBd2p-00040D-2Y
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 05:18:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45292 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1fBd2o-0003zt-U4
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 05:18:27 -0400
References: <20180424214550.32549-1-lersek@redhat.com>
	<20180424214550.32549-7-lersek@redhat.com>
	<8736zjagg3.fsf@dusky.pond.sub.org>
	<4509705a-43b2-db40-aa24-18eff649e750@redhat.com>
	<87sh7i4h5y.fsf@dusky.pond.sub.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <ea646e6d-9512-559d-be8d-fd3c754cc301@redhat.com>
Date: Thu, 26 Apr 2018 11:18:18 +0200
MIME-Version: 1.0
In-Reply-To: <87sh7i4h5y.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

On 04/26/18 08:26, Markus Armbruster wrote:
> Laszlo Ersek <lersek@redhat.com> writes:
> 
> [...]
>> In brief, I think extending configure / the build system would only help
>> with the less painful part of this (the scalar mapping), and so it's not
>> worth doing.
> 
> We're going to leave deprecated query-cpus alone (see Eric's review of
> the previous patch).

Yes.

> Does that change matters?

It does.

> PS: Instead of configure changes, #TARGET_BASE_ARCH might do.

Does that already exist as a macro? Hmm... After grepping my build dir,
it doesn't seem to, but maybe I can change that. Because,
TARGET_BASE_ARCH is exactly what we need.

Thanks!
Laszlo
