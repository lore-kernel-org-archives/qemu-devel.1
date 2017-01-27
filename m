Received: from eggs.gnu.org ([2001:4830:134:3::10]:48372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1cX9ab-00052n-S2
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 11:41:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1cX9ab-0003kf-5Q
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 11:41:29 -0500
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <1485528688-29914-1-git-send-email-thuth@redhat.com>
References: <1485528688-29914-1-git-send-email-thuth@redhat.com>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 27 Jan 2017 08:40:56 -0800
Message-ID: <CAKmqyKOGTgKfGdjX4AYvh_yz=mSAgSdAWV=58=0s4w7LXjy2qw@mail.gmail.com>
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
To: Thomas Huth <thuth@redhat.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Markus Armbruster <armbru@redhat.com>

On Fri, Jan 27, 2017 at 6:51 AM, Thomas Huth <thuth@redhat.com> wrote:
> The "or-irq" device is just used internally. It's strange to
> see this device showing up in the "-device ?" help text. Let's mark it
> with cannot_instantiate_with_device_add_yet to hide it from the users.

I agree that it is strange to be showing up to users, but is this
really the best way to do this?

I thought we were trying to get rid of
cannot_instantiate_with_device_add_yet. Would it maybe be better to
have an internal filed that sets this device as internal?

Thanks,

Alistair

>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/core/or-irq.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/hw/core/or-irq.c b/hw/core/or-irq.c
> index 1ac090d..2487fa3 100644
> --- a/hw/core/or-irq.c
> +++ b/hw/core/or-irq.c
> @@ -89,6 +89,9 @@ static void or_irq_class_init(ObjectClass *klass, void *data)
>      dc->props = or_irq_properties;
>      dc->realize = or_irq_realize;
>      dc->vmsd = &vmstate_or_irq;
> +
> +    /* It's just used internally, and should not be exposed to users */
> +    dc->cannot_instantiate_with_device_add_yet = true;
>  }
>
>  static const TypeInfo or_irq_type_info = {
> --
> 1.8.3.1
>
>
