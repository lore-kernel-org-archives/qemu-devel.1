Received: from eggs.gnu.org ([2001:4830:134:3::10]:33503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cUbV7-0002z9-Os
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 10:53:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cUbV4-0007KF-1w
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 10:53:17 -0500
Received: from mail-ua0-x232.google.com ([2607:f8b0:400c:c08::232]:33655)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cUbV3-0007Jt-U1
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 10:53:13 -0500
Received: by mail-ua0-x232.google.com with SMTP id i68so64877104uad.0
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 07:53:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1476117341-32690-3-git-send-email-drjones@redhat.com>
References: <1476117341-32690-1-git-send-email-drjones@redhat.com>
	<1476117341-32690-3-git-send-email-drjones@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Jan 2017 15:52:52 +0000
Message-ID: <CAFEAcA92X+oCMji_bnWkjRWvqQ+CyqrR0ogy-SKOGW7TRYsZ3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 2/2] hw/arm/virt: no ITS on older machine
 types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Eric Auger <eric.auger@redhat.com>

On 10 October 2016 at 17:35, Andrew Jones <drjones@redhat.com> wrote:
> We should avoid exposing new hardware (through DT and ACPI) on older
> machine types. This patch keeps 2.7 and older from changing, despite
> the introduction of ITS support for 2.8.
>
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> ---
>
> As Eduardo pointed out long ago for a different reason, we should
> probably replace VirtGuestInfo with direct use of VirtMachineClass,
> like x86 has done to replace PcGuestInfo with direct use of
> PCMachineClass. I'll work on that, but wanted to get this ITS
> fixup in sooner than later, so I'm posting this patch now, which
> requires 'no_its' to be duplicated.

So this patch added a no_its flag which gets set for virt-2.7
and earlier, but there's no user-facing way to say "I'd like
a virt-2.8 board with no ITS", right? That's a bit unfortunate
because the ITS can't be migrated, which means there's no way
to ask for a post-2.7 virt board which can be migrated...

thanks
-- PMM
