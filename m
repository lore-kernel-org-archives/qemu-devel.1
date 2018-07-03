Received: from eggs.gnu.org ([2001:4830:134:3::10]:51447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1faGx6-0005vZ-0S
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:46:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1faGx5-0001dR-8Y
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:46:24 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:40849)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1faGx5-0001cZ-25
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:46:23 -0400
Received: by mail-oi0-x244.google.com with SMTP id w126-v6so2226903oie.7
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 01:46:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180703100044.5d265acb@bahia.lan>
References: <20180702163125.28729-1-pbonzini@redhat.com>
	<20180703100044.5d265acb@bahia.lan>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Jul 2018 09:46:01 +0100
Message-ID: <CAFEAcA9qdYYnCNTNSotEfMzvOPCBj_baxANmixGmQKBbHejnww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] fsdev: fix compilation with VIRTIO but not
 VIRTIO_9P
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 3 July 2018 at 09:00, Greg Kurz <groug@kaod.org> wrote:
> On Mon,  2 Jul 2018 18:31:25 +0200
> Paolo Bonzini <pbonzini@redhat.com> wrote:
>
>> hw/9pfs/Makefile.objs uses CONFIG_VIRTIO_9P to guard the definition for
>> FileOperations structs, while fsdev/Makefile.objs uses CONFIG_VIRTIO
>> to guard the use.  Mismatch causes linking to fail when CONFIG_VIRTIO
>> is set but CONFIG_VIRTIO_9P is not.
>>
>> Fix it and use if/else to clarify that the two lines are for opposite
>> conditions.
>>
>> Reported-by: Peter Maydell <peter.maydell@linaro.org>
>> Fixes: b5dfdb082fc350f3e68dfa61dc988d97cad28cfe
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>
> Acked-by: Greg Kurz <groug@kaod.org>
> Tested-by: Greg Kurz <groug@kaod.org>
>
> Peter,
>
> I see this patch is needed for the latest RISC-V pull req.

It isn't, because that pullreq only fails because of what
looks to me like a rebase mismerge that made it change how
the riscv default-configs enable virtio. The riscv pullreq
should be fixed. This is just a cleanup, really.

thanks
-- PMM
