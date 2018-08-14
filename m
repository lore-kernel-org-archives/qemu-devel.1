Received: from eggs.gnu.org ([2001:4830:134:3::10]:47363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fpYtl-0004U7-Pb
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 08:58:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fpYtk-0003mv-WE
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 08:58:09 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:36029)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fpYtk-0003mU-Pv
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 08:58:08 -0400
Received: by mail-oi0-x241.google.com with SMTP id n21-v6so33380894oig.3
	for <qemu-devel@nongnu.org>; Tue, 14 Aug 2018 05:58:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <e23307f9-981f-1322-3dc1-136bc83b8ad9@redhat.com>
References: <20180808114830.7169-1-quintela@redhat.com>
	<20180808114830.7169-3-quintela@redhat.com>
	<6c9bcc5b-21f0-60a8-bb8d-56861c2d4bd9@redhat.com>
	<87ftzhw50t.fsf@trasno.org>
	<1169fde5-2c97-bf04-d3eb-8b43d49b37f6@redhat.com>
	<CAFEAcA-OY_4v3apC4xcB7HQwN=BGqdxuQenhnPntOXqybUx5hA@mail.gmail.com>
	<e23307f9-981f-1322-3dc1-136bc83b8ad9@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Aug 2018 13:57:47 +0100
Message-ID: <CAFEAcA-F3aemS1-OuRYOmg_20V3qeX2EhMNRQ6wxbjud=k=98g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 02/22] config: CONFIG_SERIAL* is already
 in pci.mak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, Laurent Vivier <lvivier@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 14 August 2018 at 13:56, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 14/08/2018 14:06, Peter Maydell wrote:
>> What about the boards that use the serial.c code but do not
>> have PCI, ISA or a superio chip? That is, all the boards/devices
>> that call serial_mm_init() directly to create a memory-mapped
>> 16550.
>
> They just add
>
>    CONFIG_SERIAL=y
>
> to the .mak file.

...but the patch that has kicked off this thread is *removing*
CONFIG_SERIAL=y from the various .mak files...

thanks
-- PMM
