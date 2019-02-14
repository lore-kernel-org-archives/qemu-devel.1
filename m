Received: from eggs.gnu.org ([209.51.188.92]:55687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guKdT-0006ia-No
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:17:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guKcs-0000mb-Lw
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:16:43 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:38730)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guKcs-0000kS-Fd
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:16:42 -0500
Received: by mail-ot1-x344.google.com with SMTP id m1so11786580otf.5
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 09:16:42 -0800 (PST)
MIME-Version: 1.0
References: <20190205173306.20483-1-eric.auger@redhat.com>
	<20190205173306.20483-9-eric.auger@redhat.com>
In-Reply-To: <20190205173306.20483-9-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 17:16:30 +0000
Message-ID: <CAFEAcA96jCVKkX8NwaZhnzEXkJBU3Djr3ivAUJWzdhtv+FOaiA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v6 08/18] vl: Set machine ram_size,
 maxram_size and ram_slots earlier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: Eric Auger <eric.auger.pro@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, Igor Mammedov <imammedo@redhat.com>, David Hildenbrand <david@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Andrew Jones <drjones@redhat.com>

On Tue, 5 Feb 2019 at 17:33, Eric Auger <eric.auger@redhat.com> wrote:
>
> The machine RAM attributes will need to be analyzed during the
> configure_accelerator() process. especially kvm_type() arm64
> machine callback will use them to know how many IPA/GPA bits are
> needed to model the whole RAM range. So let's assign those machine
> state fields before calling configure_accelerator.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>
> ---
>
> v4: new
> ---
>  vl.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/vl.c b/vl.c
> index 9cf0fbe0b8..28f6bbebe2 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4324,6 +4324,9 @@ int main(int argc, char **argv, char **envp)
>      machine_opts = qemu_get_machine_opts();
>      qemu_opt_foreach(machine_opts, machine_set_property, current_machine,
>                       &error_fatal);
> +    current_machine->ram_size = ram_size;
> +    current_machine->maxram_size = maxram_size;
> +    current_machine->ram_slots = ram_slots;
>
>      configure_accelerator(current_machine, argv[0]);

This is still after the call to set_memory_options(), so it's OK.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
