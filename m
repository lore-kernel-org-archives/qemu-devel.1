Received: from eggs.gnu.org ([2001:4830:134:3::10]:50260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eyJba-00069J-Al
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 11:55:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eyJbQ-0000Gq-R2
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 11:55:18 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:33704)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eyJbQ-0000Fc-MG
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 11:55:08 -0400
Received: by mail-ot0-x243.google.com with SMTP id y11-v6so2255666otg.0
	for <qemu-devel@nongnu.org>; Tue, 20 Mar 2018 08:55:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180320174957-mutt-send-email-mst@kernel.org>
References: <1521515720-612046-1-git-send-email-mst@redhat.com>
	<CAFEAcA_EbFC2qJvMGKj1gzTBnSgytLaJJfhDcn0FjEsjnvz1Sg@mail.gmail.com>
	<20180320170328-mutt-send-email-mst@kernel.org>
	<CAFEAcA8Dxs9u1KyzGmND9H7mPi9+KrBdKzkxTB4+hQYN54JPmg@mail.gmail.com>
	<20180320174957-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Mar 2018 15:54:47 +0000
Message-ID: <CAFEAcA-FzKzh8HVC4oX8=g_gS5WDaf51_nBmNgOqX7HDNk3DqA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/50] virtio, vhost, pci, pc: features,
 cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 20 March 2018 at 15:51, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Tue, Mar 20, 2018 at 03:41:54PM +0000, Peter Maydell wrote:
>> CONFIG_EVENTFD is set. __NR_userfaultfd is not. It isn't
>> defined in the system headers, and it's not defined in
>> our linux-headers/asm-arm64/. Only x86, s390, powerpc
>> and arm (32-bit) define it. I suspect the build would also
>> fail on MIPS if I had a mips host in the build set.

> Let's update headers for arm and mips then?

Shouldn't that happen automatically?

thanks
-- PMM
