Received: from eggs.gnu.org ([209.51.188.92]:46100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hKOe6-0001Bb-HQ
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 10:49:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hKOe5-0006sI-MV
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 10:49:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37178)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hKOe5-0006rT-E3
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 10:49:41 -0400
References: <20190427141905.20393-1-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2f8710be-0005-a8dc-ac28-c572e55f2d20@redhat.com>
Date: Sat, 27 Apr 2019 16:49:33 +0200
MIME-Version: 1.0
In-Reply-To: <20190427141905.20393-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/i386: The i440fx is not a machine,
 remove it from the machine list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

On 27/04/2019 16.19, Philippe Mathieu-Daud=C3=A9 wrote:
> When building with CONFIG_ISAPC=3Dn and CONFIG_I440FX=3Dy we get:
>=20
>   $ make subdir-x86_64-softmmu
>   [...]
>   /usr/bin/ld: hw/i386/pc_piix.o: in function `pc_init1':
>   /source/qemu/hw/i386/pc_piix.c:261: undefined reference to `isa_ide_i=
nit'
>   /usr/bin/ld: /source/qemu/hw/i386/pc_piix.c:261: undefined reference =
to `isa_ide_init'
>   collect2: error: ld returned 1 exit status
>   make[1]: *** [Makefile:204: qemu-system-x86_64] Error 1
>=20
> This is because the I440FX device is a North Bridge, not a machine.

Really? I thought CONFIG_I440FX was there to configure the
"pc-i440fx-x.y" machine types?

 Thomas
