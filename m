Received: from eggs.gnu.org ([2001:4830:134:3::10]:52785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fSCPz-0006gJ-Te
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 22:18:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fSCPu-0004Lo-Vr
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 22:18:51 -0400
Date: Mon, 11 Jun 2018 05:18:43 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180611051748-mutt-send-email-mst@kernel.org>
References: <20180611011501.10235-1-f4bug@amsat.org>
	<20180611011501.10235-34-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180611011501.10235-34-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 33/40] hw/i386: Use the IEC binary
 prefix definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Thomas Huth <thuth@redhat.com>, Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

On Sun, Jun 10, 2018 at 10:14:54PM -0300, Philippe Mathieu-Daud=E9 wrote:
> @@ -1392,11 +1393,11 @@ void pc_memory_init(PCMachineState *pcms,
>          }
> =20
>          machine->device_memory->base =3D
> -            ROUND_UP(0x100000000ULL + pcms->above_4g_mem_size, 1ULL <<=
 30);
> +            ROUND_UP(0x100000000ULL + pcms->above_4g_mem_size, GiB);
> =20


For some reason, GiB got special treatment. Why not 1* GiB?
