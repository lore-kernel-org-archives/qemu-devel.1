Received: from eggs.gnu.org ([209.51.188.92]:57067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gqb8C-0007Ec-Ow
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 05:05:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gqb8B-0000AD-PG
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 05:05:36 -0500
References: <87y378n5iy.fsf@dusky.pond.sub.org>
	<CAFEAcA9b+7m1hL9atdm2_0fq66HPGWDhpAfZCRfPbegr2hKyGg@mail.gmail.com>
	<87o97yi67d.fsf@dusky.pond.sub.org>
	<300bdcd7-fbde-d7a3-12a0-eafdc0aa58f6@redhat.com>
	<87d0oddxu2.fsf@dusky.pond.sub.org>
	<f4528a7d-4bb5-f607-760e-72db3eaa34ad@redhat.com>
	<877eelcgf9.fsf@dusky.pond.sub.org>
	<9c4e222f-3941-426e-3195-5598b2af1501@redhat.com>
	<87munh9gb6.fsf@dusky.pond.sub.org>
	<cb465eba-8c54-af8e-fe0e-ce90f71d213a@redhat.com>
	<002701d4b9bc$b1fe72e0$15fb58a0$@phi.nz>
	<3ace3624-893b-82e1-3132-0dcd1896ec94@redhat.com>
	<C29659EAAA3E0143B583467412621C605E408079@SHSMSX101.ccr.corp.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2294a001-ccfc-ab32-8b07-9f2f2c7f5cbd@redhat.com>
Date: Mon, 4 Feb 2019 11:00:12 +0100
MIME-Version: 1.0
In-Reply-To: <C29659EAAA3E0143B583467412621C605E408079@SHSMSX101.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Configuring pflash devices for OVMF firmware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Ning, Yu" <yu.ning@intel.com>, Alexandro Sanchez Bach <alexandro@phi.nz>
Cc: 'Peter Maydell' <peter.maydell@linaro.org>, 'Peter Krempa' <pkrempa@redhat.com>, 'Qemu-block' <qemu-block@nongnu.org>, 'Libvirt' <libvir-list@redhat.com>, 'QEMU Developers' <qemu-devel@nongnu.org>, =?UTF-8?B?J0zDoXN6bMOzIMOJcnNlayc=?= <lersek@redhat.com>, "'Justin Terry (VM)'" <juterry@microsoft.com>, 'Markus Armbruster' <armbru@redhat.com>

On 01/02/19 03:49, Ning, Yu wrote:
> Thank you both for outlining the changes we have to make in order to
> support ROMD memory regions!  The only question is whether we should
> pass a new flag to HAX_VM_IOCTL_SET_RAM2 for ROMD, so the hypervisor
> could respond differently to writes to ROM and ROMD regions.  Would
> that be useful at all?  What would happen if HAXM asked QEMU to
> emulate a write to ROM?

It's more about backwards compatibility.  As far as QEMU is concerned
it's okay if all ROM reads are handled as MMIO.  However, other
emulators may not expect that, so maybe you want to add another flag.

Paolo

> HAXM didn't implement ROMD support at first, because the guests we
> tested could boot without it (including Chrome OS).  Now that this
> feature has become more popular (and we want to be able to boot
> OVMF), I think it's time to get it done.  I'd like to get to it after
> the Lunar New Year holidays, but if anyone can finish it sooner, I'll
> be happy to merge their patch into HAXM.
