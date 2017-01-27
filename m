Received: from eggs.gnu.org ([2001:4830:134:3::10]:50610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cX9m5-0002cb-5E
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 11:53:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cX9m4-00071E-BV
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 11:53:21 -0500
Received: from mail-ua0-x22b.google.com ([2607:f8b0:400c:c08::22b]:33314)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cX9m4-000714-6k
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 11:53:20 -0500
Received: by mail-ua0-x22b.google.com with SMTP id i68so208803071uad.0
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 08:53:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAKmqyKOGTgKfGdjX4AYvh_yz=mSAgSdAWV=58=0s4w7LXjy2qw@mail.gmail.com>
References: <1485528688-29914-1-git-send-email-thuth@redhat.com>
	<CAKmqyKOGTgKfGdjX4AYvh_yz=mSAgSdAWV=58=0s4w7LXjy2qw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Jan 2017 16:52:59 +0000
Message-ID: <CAFEAcA-fSMkEVh3DOAh0d-JV=SPF6JqfT0SQ4OjwPbss-Jan_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] hw/core/or-irq: Mark the device with
 cannot_instantiate_with_device_add_yet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: Thomas Huth <thuth@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>, Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On 27 January 2017 at 16:40, Alistair Francis
<alistair.francis@xilinx.com> wrote:
> On Fri, Jan 27, 2017 at 6:51 AM, Thomas Huth <thuth@redhat.com> wrote:
>> The "or-irq" device is just used internally. It's strange to
>> see this device showing up in the "-device ?" help text. Let's mark it
>> with cannot_instantiate_with_device_add_yet to hide it from the users.
>
> I agree that it is strange to be showing up to users, but is this
> really the best way to do this?
>
> I thought we were trying to get rid of
> cannot_instantiate_with_device_add_yet. Would it maybe be better to
> have an internal filed that sets this device as internal?

Yes, I agree; the reason for cannot_instantiate_with_device_add_yet
being such a long and ugly name is so it's easy to grep for
things we in theory might want to fix some day. "We'd rather
this didn't show up in help" is a different question.

(Like a lot of devices, it's pretty useless via -device, though,
because we have no way to wire up qemu_irq lines on the command
line.)

thanks
-- PMM
