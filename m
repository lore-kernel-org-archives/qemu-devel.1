Received: from eggs.gnu.org ([2001:4830:134:3::10]:45943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gSjDV-0006Qp-9L
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 08:52:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gSjDU-0006iG-HF
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 08:52:25 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:37407)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gSjDU-0006i2-CB
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 08:52:24 -0500
Received: by mail-oi1-x243.google.com with SMTP id y23so4768820oia.4
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 05:52:24 -0800 (PST)
MIME-Version: 1.0
References: <1542765966-20244-1-git-send-email-lizhijian@cn.fujitsu.com>
	<1542765966-20244-2-git-send-email-lizhijian@cn.fujitsu.com>
	<1542765966-20244-3-git-send-email-lizhijian@cn.fujitsu.com>
	<1542765966-20244-4-git-send-email-lizhijian@cn.fujitsu.com>
	<1542765966-20244-5-git-send-email-lizhijian@cn.fujitsu.com>
In-Reply-To: <1542765966-20244-5-git-send-email-lizhijian@cn.fujitsu.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Nov 2018 13:52:12 +0000
Message-ID: <CAFEAcA9TOpkQH+gxon7y-iqoK+gotYZWErq_7ODTA2E8ruyjGw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 4/5] x86: exit qemu if load_image fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Zhijian <lizhijian@cn.fujitsu.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Philip Li <philip.li@intel.com>, zhijianx.li@intel.com, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Wed, 21 Nov 2018 at 02:11, Li Zhijian <lizhijian@cn.fujitsu.com> wrote:
>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Richard Henderson <rth@twiddle.net>
> CC: Eduardo Habkost <ehabkost@redhat.com>
> CC: "Michael S. Tsirkin" <mst@redhat.com>
> CC: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> ---
>  hw/i386/pc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index f095725..2ffe6fb 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -984,7 +984,10 @@ static void load_linux(PCMachineState *pcms,
>          initrd_addr = (initrd_max-initrd_size) & ~4095;
>
>          initrd_data = g_malloc(initrd_size);
> -        load_image(initrd_filename, initrd_data);
> +        if (load_image(initrd_filename, initrd_data) < 0) {
> +            fprintf(stderr, "failed to load initrd\n");
> +            exit(1);
> +        }

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
