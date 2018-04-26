Received: from eggs.gnu.org ([2001:4830:134:3::10]:55240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fBfWu-0000SF-9x
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 07:57:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fBfWr-00030G-8s
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 07:57:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51528 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fBfWr-000309-4S
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 07:57:37 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180424214550.32549-1-lersek@redhat.com>
	<20180424214550.32549-7-lersek@redhat.com>
	<8736zjagg3.fsf@dusky.pond.sub.org>
	<4509705a-43b2-db40-aa24-18eff649e750@redhat.com>
	<87sh7i4h5y.fsf@dusky.pond.sub.org>
	<ea646e6d-9512-559d-be8d-fd3c754cc301@redhat.com>
Date: Thu, 26 Apr 2018 13:57:27 +0200
In-Reply-To: <ea646e6d-9512-559d-be8d-fd3c754cc301@redhat.com> (Laszlo Ersek's
	message of "Thu, 26 Apr 2018 11:18:18 +0200")
Message-ID: <8736zi2na0.fsf@dusky.pond.sub.org>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>

Laszlo Ersek <lersek@redhat.com> writes:

> On 04/26/18 08:26, Markus Armbruster wrote:
>> Laszlo Ersek <lersek@redhat.com> writes:
>> 
>> [...]
>>> In brief, I think extending configure / the build system would only help
>>> with the less painful part of this (the scalar mapping), and so it's not
>>> worth doing.
>> 
>> We're going to leave deprecated query-cpus alone (see Eric's review of
>> the previous patch).
>
> Yes.
>
>> Does that change matters?
>
> It does.
>
>> PS: Instead of configure changes, #TARGET_BASE_ARCH might do.
>
> Does that already exist as a macro? Hmm... After grepping my build dir,
> it doesn't seem to, but maybe I can change that. Because,
> TARGET_BASE_ARCH is exactly what we need.

You're right, it's not in config-target.h, only in config-target.mak.
scripts/create_config would need a (trivial) patch.
