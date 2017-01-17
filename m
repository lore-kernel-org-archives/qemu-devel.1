Received: from eggs.gnu.org ([2001:4830:134:3::10]:55636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cTQ5F-0004k2-2a
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 04:29:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cTQ5E-0004s5-DY
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 04:29:41 -0500
Received: from mail-ua0-x22e.google.com ([2607:f8b0:400c:c08::22e]:34369)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cTQ5E-0004rv-8v
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 04:29:40 -0500
Received: by mail-ua0-x22e.google.com with SMTP id 35so98658532uak.1
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 01:29:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170116194453.GD3491@thinpad.lan.raisama.net>
References: <1484376662-32063-1-git-send-email-thuth@redhat.com>
	<2296ffa3-8bb9-4652-ebd6-4da5b09596ca@vivier.eu>
	<1ed4fded-4468-16cd-96e2-f70c1b85ab7d@redhat.com>
	<CAKmqyKP0ejNQOd=AYYP+jNNtgMm6Mv8V7bQms2MVbDuDDAtquQ@mail.gmail.com>
	<20170116192520.GB3491@thinpad.lan.raisama.net>
	<CAFEAcA9GdZoM0JPX0bf6gnVbnQ-yP7UvbWoj7QLdtd5OomN2zQ@mail.gmail.com>
	<20170116194453.GD3491@thinpad.lan.raisama.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Jan 2017 09:29:19 +0000
Message-ID: <CAFEAcA_KO+bANvKLV0AQ3FdS6qBxKk5c16ey7v9gYtcNPP2KsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] hw/core/null-machine: Add the possibility
 to instantiate a CPU, RAM and kernel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

On 16 January 2017 at 19:44, Eduardo Habkost <ehabkost@redhat.com> wrote:
> On Mon, Jan 16, 2017 at 07:27:21PM +0000, Peter Maydell wrote:
>> On 16 January 2017 at 19:25, Eduardo Habkost <ehabkost@redhat.com> wrote:
>> > On Mon, Jan 16, 2017 at 10:53:07AM -0800, Alistair Francis wrote:
>> >> On Sun, Jan 15, 2017 at 11:59 PM, Thomas Huth <thuth@redhat.com> wrote:
>> >> > But I think the users also expect the "-kernel" parameter to be working,
>> >> > so I think we should add the loader code in null-machine.c anyway.
>> >>
>> >> I agree that uses probably expect the '-kernel' option to work as well.
>> >
>> > So, is it possible to write a generic load_kernel() function that
>> > simply reuses the generic-loader code?
>>
>> No, because users expect -kernel to actually load a Linux kernel
>> (meaning with the calling conventions etc the kernel requires),
>> whereas generic-loader is just "load a binary blob and start there".
>
> I don't mean a generic function that works for all machines and
> architectures, but a generic function that is good enough for
> "-machine none". Isn't "load a binary blob and start there"
> exactly what machine_none_load_kernel() in this patch does?

If you just want "load a blob and start it" then we already
have -device loader. Making -kernel have yet another set of
semantics that this time depends on the machine being selected
seems like a bad idea. If -kernel doesn't do what it does
for the other machines of the same architecture then we should
just not accept it.

thanks
-- PMM
