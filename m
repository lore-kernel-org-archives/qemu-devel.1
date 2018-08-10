Received: from eggs.gnu.org ([2001:4830:134:3::10]:45607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fo0YW-0004dp-3M
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 02:05:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fo0YV-0000Vv-70
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 02:05:48 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:40032)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fo0YU-0000Ul-WF
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 02:05:47 -0400
Received: by mail-wm0-x244.google.com with SMTP id y9-v6so612684wma.5
	for <qemu-devel@nongnu.org>; Thu, 09 Aug 2018 23:05:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180808210750.3915-3-jusual@mail.ru>
References: <20180808210750.3915-1-jusual@mail.ru>
	<20180808210750.3915-3-jusual@mail.ru>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 10 Aug 2018 07:05:45 +0100
Message-ID: <CAJSP0QXOOPDDY=5-hFngAD-Y50kJvX87LVj00N-NcgxbpuH_Ew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 2/4] hw/arm/nrf51_soc: Connect UART to
 nRF51 SoC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>
Cc: qemu-devel <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <mail@steffen-goertz.de>

On Wed, Aug 8, 2018 at 10:07 PM, Julia Suvorova <jusual@mail.ru> wrote:
> @@ -70,6 +73,19 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
>      }
>      memory_region_add_subregion(&s->container, SRAM_BASE, &s->sram);
>
> +    /* UART */
> +    qdev_prop_set_chr(DEVICE(&s->uart), "chardev", serial_hd(0));
> +    object_property_set_bool(OBJECT(&s->uart), true, "realized", &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;

Is there cleanup missing (e.g. unrealizing sub-devices or freeing resources)?
