Received: from eggs.gnu.org ([2001:4830:134:3::10]:53690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cspK2-00055U-5e
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 07:29:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cspK1-0002HW-9V
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 07:29:58 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:34550)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cspK1-0002HF-3T
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 07:29:57 -0400
Received: by mail-wr0-x22c.google.com with SMTP id l43so99843373wre.1
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 04:29:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CACJhumejPG6s_dewyHH=e5=QLcOUCzvzhakA7oSqm2Ms5cQvRA@mail.gmail.com>
References: <CACJhumejPG6s_dewyHH=e5=QLcOUCzvzhakA7oSqm2Ms5cQvRA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Mar 2017 12:29:35 +0100
Message-ID: <CAFEAcA-kKvS_6OZE1mKbFYgCzm4wPK2XJi_A03nFxu+K3ZA4hQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Aarch64: Qemu master or 2.9.0-rc1 breaks
 compatibility with 4.10 kernel.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Prakash B <bjsprakash.linux@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Eric Auger <eric.auger@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, Christoffer Dall <christoffer.dall@linaro.org>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>, "Kumar,
	Vijaya" <Vijaya.Kumar@cavium.com>, sgoutham@cavium.com, bprakash@caviumnetworks.com

On 28 March 2017 at 12:22, Prakash B <bjsprakash.linux@gmail.com> wrote:
> Qemu master or v2.9.0-rc1 doesn't launch guest  when host kernel
> version 4.10 or  lower on Aarch64 (cavium ThunderX), its failing with
> abort  "qemu-system-aarch64: KVM_GET_DEVICE_ATTR failed: No such
> device or address"
>
> "GICv3 live migration support"  patch breaks the  compatibility b/w
> kernel and qemu.
>
> Is this expected behaviour,  can we provide a fix without  breaking
> compatibility b/w kernel and qemu .

This is indeed not supposed to happen. Eric, can you take a look?

thanks
-- PMM
