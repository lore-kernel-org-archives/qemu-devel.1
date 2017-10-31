Received: from eggs.gnu.org ([2001:4830:134:3::10]:60365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anatol.pomozov@gmail.com>) id 1e9bR6-0001AN-9S
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 14:38:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anatol.pomozov@gmail.com>) id 1e9bR5-00076K-5h
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 14:38:52 -0400
Received: from mail-vk0-x242.google.com ([2607:f8b0:400c:c05::242]:46879)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <anatol.pomozov@gmail.com>)
	id 1e9bR5-00075e-1Q
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 14:38:51 -0400
Received: by mail-vk0-x242.google.com with SMTP id k123so11032487vkb.3
	for <qemu-devel@nongnu.org>; Tue, 31 Oct 2017 11:38:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171019093647.GA6195@localhost.localdomain>
References: <20171012235439.19457-1-anatol.pomozov@gmail.com>
	<20171012235439.19457-4-anatol.pomozov@gmail.com>
	<CAOMFOmUaJT+OdfN9Yin91AiP_+HXMbVFXuPY0FORb1PNvzYCmw@mail.gmail.com>
	<20171019093647.GA6195@localhost.localdomain>
From: Anatol Pomozov <anatol.pomozov@gmail.com>
Date: Tue, 31 Oct 2017 11:38:49 -0700
Message-ID: <CAOMFOmVQ0zWgqjMED-AWfS5Nt2caoHz5JxXmc690AEqD1Kji_w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 3/4] multiboot: load elf sections and
 section headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>

Hi

On Thu, Oct 19, 2017 at 2:36 AM, Kevin Wolf <kwolf@redhat.com> wrote:
> Am 18.10.2017 um 19:22 hat Anatol Pomozov geschrieben:
>> Hello qemu-devs,
>>
>> This patchset has been posted a while ago. I would like to move
>> forward with it and look at the next task (e.g. multiboot2 support in
>> QEMU). Who is the multiboot code maintainer who can help to review
>> this patchset and give go/no-go answer?
>
> I think that's exactly your problem, there is nobody who feels
> responsible for Multiboot support. Officially, it is part of the PC/x86
> subsystems:

In this case I would like to become the official Qemu/Multiboot
maintainer. I do development related to x86 osdev and actively use
qemu for my projects. I am interested in having a feature-rich and
robust Multiboot implementation. In mid term I see several tasks for
me:
 - finish and merge my cleanup + MULTIBOOT_INFO_ELF_SHDR patch series
 - add Multiboot2 support
 - (optional) look at MIPS support for Multiboot. I do not have/use
MIPS but it is beneficial to add multiplatform support to Multiboot
 - reviewing incoming patches


A bit about me. My name is Anatol Pomozov and at my spare time I
participate at several open sources projects. I am an Arch developer
since 2013 where I maintain a bunch of packages (including Arch qemu
package [1]). I have ~40 patches in the Linux kernel tree, where the
biggest contribution is a driver for audio codec NAU8825. I
contributed a lot of small patches to numerous projects (compilers,
toolchains, ...)

[1] https://www.archlinux.org/packages/extra/i686/qemu/
