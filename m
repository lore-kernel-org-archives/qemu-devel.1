Received: from eggs.gnu.org ([2001:4830:134:3::10]:54131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anatol.pomozov@gmail.com>) id 1eFoGr-0000cI-HM
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 16:33:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anatol.pomozov@gmail.com>) id 1eFoGq-0000qt-Qe
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 16:33:57 -0500
Received: from mail-ua0-x229.google.com ([2607:f8b0:400c:c08::229]:33012)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <anatol.pomozov@gmail.com>)
	id 1eFoGq-0000qQ-Mg
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 16:33:56 -0500
Received: by mail-ua0-x229.google.com with SMTP id q18so2378110uaa.0
	for <qemu-devel@nongnu.org>; Fri, 17 Nov 2017 13:33:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAOMFOmVQ0zWgqjMED-AWfS5Nt2caoHz5JxXmc690AEqD1Kji_w@mail.gmail.com>
References: <20171012235439.19457-1-anatol.pomozov@gmail.com>
	<20171012235439.19457-4-anatol.pomozov@gmail.com>
	<CAOMFOmUaJT+OdfN9Yin91AiP_+HXMbVFXuPY0FORb1PNvzYCmw@mail.gmail.com>
	<20171019093647.GA6195@localhost.localdomain>
	<CAOMFOmVQ0zWgqjMED-AWfS5Nt2caoHz5JxXmc690AEqD1Kji_w@mail.gmail.com>
From: Anatol Pomozov <anatol.pomozov@gmail.com>
Date: Fri, 17 Nov 2017 13:33:55 -0800
Message-ID: <CAOMFOmUNrgZhpzkXLx2Ne1RKpPS6AbVU7LvBmKE=E6QZiWnw8w@mail.gmail.com>
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

Hello

On Tue, Oct 31, 2017 at 11:38 AM, Anatol Pomozov
<anatol.pomozov@gmail.com> wrote:
> Hi
>
> On Thu, Oct 19, 2017 at 2:36 AM, Kevin Wolf <kwolf@redhat.com> wrote:
>> Am 18.10.2017 um 19:22 hat Anatol Pomozov geschrieben:
>>> Hello qemu-devs,
>>>
>>> This patchset has been posted a while ago. I would like to move
>>> forward with it and look at the next task (e.g. multiboot2 support in
>>> QEMU). Who is the multiboot code maintainer who can help to review
>>> this patchset and give go/no-go answer?
>>
>> I think that's exactly your problem, there is nobody who feels
>> responsible for Multiboot support. Officially, it is part of the PC/x86
>> subsystems:
>
> In this case I would like to become the official Qemu/Multiboot
> maintainer. I do development related to x86 osdev and actively use
> qemu for my projects. I am interested in having a feature-rich and
> robust Multiboot implementation.

It is very unfortunate to see lack of interest in improving
qemu/multiboot functionality. I guess my best option for now is to
avoid using qemu multiboot implementation and use grub instead.
