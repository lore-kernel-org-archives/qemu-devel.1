Received: from eggs.gnu.org ([2001:4830:134:3::10]:54582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gHDx4-000200-8Q
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 16:15:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gHDx3-00061O-Ia
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 16:15:54 -0400
MIME-Version: 1.0
References: <20181029194519.15628-1-stefanha@redhat.com>
In-Reply-To: <20181029194519.15628-1-stefanha@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 29 Oct 2018 20:15:39 +0000
Message-ID: <CAJSP0QX9oLmpFzZ48Xj5fJ_jy=Upbf3xiGLYw1Ptw9K5C3FS0w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] microbit: do not rely on -kernel option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <qemu.ml@steffen-goertz.de>, qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>, Julia Suvorova <jusual@mail.ru>

On Mon, Oct 29, 2018 at 7:46 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
> @@ -39,8 +47,12 @@ static void microbit_init(MachineState *machine)
>                               &error_fatal);
>      object_property_set_bool(soc, true, "realized", &error_fatal);
>
> -    armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
> -                       NRF51_SOC(soc)->flash_size);
> +    if (machine->kernel_filename) {
> +        error_report("-device loader,file=<filename> must be used instead of -kernel");
> +        exit(1);
> +    }

NACK

Julia pointed out this breaks boot-serial-test.

Stefan
