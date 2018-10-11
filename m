Received: from eggs.gnu.org ([2001:4830:134:3::10]:34933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gAZdy-0002gm-Pi
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 08:00:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gAZdo-0006gF-R6
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 08:00:42 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:40723)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gAZdo-0006Z2-C8
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 08:00:32 -0400
Received: by mail-ot1-x342.google.com with SMTP id w67so8620816ota.7
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 05:00:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181011075544.GR27120@redhat.com>
References: <cover.1538683492.git.alistair.francis@wdc.com>
	<5dd21056229d12a1af8d65e9208f4de43ba4a2ae.camel@redhat.com>
	<892d54c5-2851-74ec-bdf2-286c1665c44f@gmail.com>
	<7d54ec114745b00b82601875416ccfe6a5f9fe6f.camel@redhat.com>
	<20181011075544.GR27120@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Oct 2018 13:00:05 +0100
Message-ID: <CAFEAcA8RDvDdoTd6pgKi+P_XuGR_vAJor03rW6Cf5XZnahPqyQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 0/5] Connect a PCIe host and graphics
 support to RISC-V
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: Andrea Bolognani <abologna@redhat.com>, "palmer@sifive.com" <palmer@sifive.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mjc@sifive.com" <mjc@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, Alistair <alistair23@gmail.com>, "stephen@eideticom.com" <stephen@eideticom.com>, Edgar Iglesias <edgar.iglesias@xilinx.com>

On 11 October 2018 at 08:55, Richard W.M. Jones <rjones@redhat.com> wrote:
> Can we ignore non-PCIe guests?  virtio-mmio should die.

I note that Edgar's recent Xilinx Versal patchset adds a
new user of virtio-mmio. If that statement is meant to
apply generally it might be worth starting the discussion
in that patchthread too.

thanks
-- PMM
