Received: from eggs.gnu.org ([2001:4830:134:3::10]:43437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXnbq-0005Gg-40
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 08:34:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXnbp-0001kL-1C
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 08:34:30 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:42468)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gXnbo-0001jZ-Ie
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 08:34:28 -0500
Received: by mail-ot1-x344.google.com with SMTP id v23so5366082otk.9
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 05:34:28 -0800 (PST)
MIME-Version: 1.0
References: <20181213223737.11793-1-pbonzini@redhat.com>
	<20181213223737.11793-3-pbonzini@redhat.com>
In-Reply-To: <20181213223737.11793-3-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Dec 2018 13:34:14 +0000
Message-ID: <CAFEAcA_aq2LftJbNPmQREghDhFWqFhM7tgRoK33uRbKbd-oeVQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 2/2] avoid TABs in files that only contain
 a few
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Weil <sw@weilnetz.de>, viktor.prutyanov@phystech.edu, Richard Henderson <rth@twiddle.net>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Amit Shah <amit@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony PERARD <anthony.perard@citrix.com>, andrzej zaborowski <balrogg@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, John Snow <jsnow@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>, Stefan Markovic <smarkovic@wavecomp.com>, Jason Wang <jasowang@redhat.com>, =?UTF-8?B?SmnFmcOtIFDDrXJrbw==?= <jiri@resnulli.us>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>, Fam Zheng <famz@redhat.com>, Magnus Damm <magnus.damm@gmail.com>, Igor Mammedov <imammedo@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>, Qemu-block <qemu-block@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, "open list:X86" <xen-devel@lists.xenproject.org>, qemu-ppc <qemu-ppc@nongnu.org>

On Thu, 13 Dec 2018 at 22:38, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Most files that have TABs only contain a handful of them.  Change
> them to spaces so that we don't confuse people.
>
> disas, standard-headers, linux-headers and libdecnumber are imported
> from other projects and probably should be exempted from the check.
> Outside those, after this patch the following files still contain both
> 8-space and TAB sequences at the beginning of the line.  Many of them
> have a majority of TABs, or were initially committed with all tabs.
>

> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 17f1b49d11..ad6fa8e3c6 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1854,7 +1854,7 @@ static const TypeInfo virt_machine_info = {
>      .instance_size = sizeof(VirtMachineState),
>      .class_size    = sizeof(VirtMachineClass),
>      .class_init    = virt_machine_class_init,
> -       .instance_init = virt_instance_init,
> +        .instance_init = virt_instance_init,
>      .interfaces = (InterfaceInfo[]) {
>           { TYPE_HOTPLUG_HANDLER },
>           { }

This one gets the alignment wrong -- the person who wrote
that must have had tabs set to 4-space. Eduardo has sent a
patch which fixes it up ("virt: Fix broken indentation"),
which I've queued, so this is just a heads-up about the
resulting trivial conflict.

thanks
-- PMM
