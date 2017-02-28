Received: from eggs.gnu.org ([2001:4830:134:3::10]:52698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ciWoF-0005Rk-OG
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 20:42:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ciWoE-0001eq-PW
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 20:42:35 -0500
Received: from mail-oi0-x22d.google.com ([2607:f8b0:4003:c06::22d]:36014)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1ciWoE-0001ee-LD
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 20:42:34 -0500
Received: by mail-oi0-x22d.google.com with SMTP id f192so28545573oic.3
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 17:42:33 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <CAFEAcA8O7QEcXQU0iMguSAfT-qsQgmYC_gOCjGmV5ph2w5EVmw@mail.gmail.com>
References: <1485377117-18105-1-git-send-email-thuth@redhat.com>
	<f60c6090-0ca8-8ce9-8015-4e8e34123a5a@vivier.eu>
	<CAKmqyKMyzquxEGTF4Un_1WvwBNXOoJU1g67_9fFarVy-yeff+Q@mail.gmail.com>
	<8a528a03-d97e-7c16-70f6-229b80563b2d@redhat.com>
	<CAFEAcA8O7QEcXQU0iMguSAfT-qsQgmYC_gOCjGmV5ph2w5EVmw@mail.gmail.com>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 28 Feb 2017 11:42:01 +1000
Message-ID: <CAKmqyKPO6MfnwmsyeLLZ5XW0UgovOrWYdgESUT_gGUnBXjmjSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] hw/core/generic-loader: Fix crash when
 running without CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>, Alistair Francis <alistair.francis@xilinx.com>

On Fri, Jan 27, 2017 at 9:06 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 26 January 2017 at 05:50, Thomas Huth <thuth@redhat.com> wrote:
>> I think there is no real use case yet. But this fix is 1) simpler than
>> doing an error_report() + exit() here, and 2) maybe the vision of
>> constructing machines on the fly with QEMU will eventually come true one
>> day in the distant future, so with that patch here, the code would
>> already be prepared for the case when QEMU gets started without CPUs and
>> the CPUs are then later added via QOM...
>
> For the latter to work you'd need to do something more anyway,
> because you still need to be able to say "load this image
> into this CPU's address space", even if the CPUs are getting
> added later via QOM. You'd need to say "delay the image
> load until we actually have a CPU to load it for" or
> something... Passing a NULL address space to load_elf_as()
> etc is saying "I am definitely a board which has
> system_address_space as its one and only address space",
> which is OK if you're a board model but a bit more dubious
> if you're a generic device like this one.

Doesn't this not just crashing at least move us a step closer in the
right direction (even if it isn't the correct address space)? The
other option of just printing an error and exit doesn't seem super
useful.

Either is better then a segfault though, so we need to do something here.

Thanks,

Alistair

>
> thanks
> -- PMM
>
