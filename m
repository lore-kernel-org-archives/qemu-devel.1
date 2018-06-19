Received: from eggs.gnu.org ([2001:4830:134:3::10]:53744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVGpn-0000bs-3q
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 09:38:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVGpm-0002wC-9q
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 09:38:11 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:33625)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fVGpm-0002w1-5f
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 09:38:10 -0400
Received: by mail-ot0-x244.google.com with SMTP id h6-v6so22599639otj.0
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 06:38:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180619132200.12320-1-sameeh@daynix.com>
References: <20180619132200.12320-1-sameeh@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Jun 2018 14:37:49 +0100
Message-ID: <CAFEAcA-8sGy+2-5kO5K-tGQhHB664Gd2zVx8R5jNWOrg3Ow0-Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC 0/1] Add BPF suuport to Qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sameeh Jubran <sameeh@daynix.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>, Yan Vugenfirer <yan@daynix.com>, Amnon Ilan <ailan@redhat.com>

On 19 June 2018 at 14:21, Sameeh Jubran <sameeh@daynix.com> wrote:
> From: Sameeh Jubran <sjubran@redhat.com>
>
> The Berkeley Packet Filter has been in the kernel for a while now and I
> think it is time that it is introduced to Qemu. This patch is an
> infrastructure for any future usage of the BPF in Qemu.
>
> It is important to note that the tun driver had started supporting using
> BPF programs through ioctls (TUNSETSTEERINGEBPF and TUNSETFILTEREBPF).
>
> At first, instead of adding the syscall wrappers, I wanted to integrate libbpf
> library which resides in the Linux source tree under tools/lib/bpf. It appears
> to be that by default it compiles to x64 on x64 arch - which can't be
> integrated into Qemu  - and my attempts to compile the 32 bit versions have
> failed. What's more interesting is that the vendors don't provide this library
> in any package, which makes this library a nasty dependency.
>
> Please share your thoughts :)

My question is -- what's the use case? This patchset seems
to just add the bpf_syscall.c code to QEMU but without any
changes to actually use the new functionality. It's hard
to evaluate whether something's a worthwhile addition integrated
in the right way without the code changes that make use of it...

thanks
-- PMM
