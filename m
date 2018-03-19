Received: from eggs.gnu.org ([2001:4830:134:3::10]:48389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1exzTN-00088m-00
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 14:25:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1exzTL-0001S4-Rz
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 14:25:29 -0400
Received: from mail-oi0-x22a.google.com ([2607:f8b0:4003:c06::22a]:46710)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1exzTL-0001Rf-ME
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 14:25:27 -0400
Received: by mail-oi0-x22a.google.com with SMTP id x12so15133506oie.13
	for <qemu-devel@nongnu.org>; Mon, 19 Mar 2018 11:25:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180319154020.6d668399@igors-macbook-pro.local>
References: <20180313153458.26822-1-peter.maydell@linaro.org>
	<20180313153458.26822-9-peter.maydell@linaro.org>
	<MWHPR21MB018983B74A652443B70680F19ED20@MWHPR21MB0189.namprd21.prod.outlook.com>
	<CAFEAcA_9YQ4bSzHgM8yLAPtPZ2C70u13kTCLf4rHGPCBUgNiZA@mail.gmail.com>
	<20180319154020.6d668399@igors-macbook-pro.local>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Mar 2018 18:25:06 +0000
Message-ID: <CAFEAcA9fnw90pV462Aa5CYYdrgKAYG1RsuQbXHEd-5PcnXjE4g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 8/9] hw/arm/bcm2836: Hardcode correct CPU
 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Pekka Enberg <penberg@iki.fi>, "patches@linaro.org" <patches@linaro.org>

On 19 March 2018 at 14:40, Igor Mammedov <imammedo@redhat.com> wrote:
> On Thu, 15 Mar 2018 17:13:03 +0000
> Peter Maydell <peter.maydell@linaro.org> wrote:
>> Igor, can you help with this question? For a board that always
>> has one CPU type (because the real hardware only ever has
>> one SoC, and that SoC QOM object hard codes the CPU type)
>> does it still need to set the mc->default_cpu_type field in
>> its MachineClass, or does that become pointless ?
>
> Since board ignores whatever were specified on '-cpu' and
> there aren't any checks in board code for current_machine->cpu_type,
> removing mc->default_cpu_type won't really affect anything.
>
> With current code in vl.c and with default_cpu_type set, user will
> get error if he specified non existing cpu_model with -cpu.
> If default_cpu_type were NULL, -cpu is completely ignored.
>
> But once http://patchwork.ozlabs.org/patch/870297/ is applied
> it will error out the same way as if default_cpu_type were
> set since vl.c won't rely on it anymore for parsing cpu_model.
>
> So in short it's ok to remove mc->default_cpu_type here.

Thanks for the explanation. I think what I'll do is put these
in as-is, and then have a followup patch that cleans up the
default_cpu_types from raspi.c once that patch 870297 is in.

-- PMM
