Received: from eggs.gnu.org ([2001:4830:134:3::10]:39707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCH3s-0006K2-3S
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 22:29:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCH3o-0001Hj-4X
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 22:29:56 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:56845)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCH3n-0001Hb-Vw
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 22:29:52 -0500
Received: by mail-qk0-x242.google.com with SMTP id 2so911300qkg.13
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 19:29:51 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171108022828.7242-1-f4bug@amsat.org>
	<20171108022828.7242-7-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ef7c6cb8-1fad-29fa-558c-c801b777ca9e@amsat.org>
Date: Wed, 8 Nov 2017 00:29:47 -0300
MIME-Version: 1.0
In-Reply-To: <20171108022828.7242-7-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 6/6] hw/i386: deprecate the "isapc"
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org

On 11/07/2017 11:28 PM, Philippe Mathieu-Daudé wrote:
> Deprecated since 2.9.0, guests should be able to use "pc" instead.

I forgot to add Paolo's comment:

"but firmware code paths would be different, do we care?"

> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/i386/pc_piix.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index c462b702ff..df4669c6d3 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -1114,6 +1114,7 @@ static void isapc_machine_options(MachineClass *m)
>      pcmc->smbios_legacy_mode = true;
>      pcmc->has_reserved_memory = false;
>      m->default_cpu_type = X86_CPU_TYPE_NAME("486");
> +    m->deprecated_reason = "Use the \"pc\" machine instead";
>  }
>  
>  DEFINE_PC_MACHINE(isapc, "isapc", pc_init_isa,
> 
