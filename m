Received: from eggs.gnu.org ([2001:4830:134:3::10]:53878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gUuIt-0006LV-K8
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 09:07:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gUuIs-0001CQ-TA
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 09:06:59 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:37095)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gUuIs-0001Ba-Lm
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 09:06:58 -0500
Received: by mail-ot1-x344.google.com with SMTP id 40so499381oth.4
	for <qemu-devel@nongnu.org>; Thu, 06 Dec 2018 06:06:58 -0800 (PST)
MIME-Version: 1.0
References: <20181205205827.19387-1-ehabkost@redhat.com>
	<20181205205827.19387-2-ehabkost@redhat.com>
In-Reply-To: <20181205205827.19387-2-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Dec 2018 14:06:46 +0000
Message-ID: <CAFEAcA8hxO_2+R-Y2aEa9HzbLnsHedcErAWAwMDw5mJRq+mcww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-4.0 1/5] virt: Eliminate separate
 instance_init functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, qemu-arm <qemu-arm@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>, Richard Henderson <rth@twiddle.net>

On Wed, 5 Dec 2018 at 20:58, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> All instance_init functions for all virt machine-types run
> exactly the same code, so we don't need separate functions.  We
> only need to set instance_init for TYPE_VIRT_MACHINE.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  hw/arm/virt.c | 87 +++++++++++++--------------------------------------
>  1 file changed, 21 insertions(+), 66 deletions(-)
>
> +static const TypeInfo virt_machine_info = {
> +    .name          = TYPE_VIRT_MACHINE,
> +    .parent        = TYPE_MACHINE,
> +    .abstract      = true,
> +    .instance_size = sizeof(VirtMachineState),
> +    .class_size    = sizeof(VirtMachineClass),
> +    .class_init    = virt_machine_class_init,
> +       .instance_init = virt_instance_init,

Indentation looks like it's not quite right here.

> +    .interfaces = (InterfaceInfo[]) {
> +         { TYPE_HOTPLUG_HANDLER },
> +         { }
> +    },
> +};

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
