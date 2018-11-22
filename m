Received: from eggs.gnu.org ([2001:4830:134:3::10]:35381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1gPs9e-0007YV-IL
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 11:48:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1gPs9a-0004Xi-MO
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 11:48:38 -0500
Received: from mail-wm1-f43.google.com ([209.85.128.43]:50750)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1gPs9a-0004Uw-Dk
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 11:48:34 -0500
Received: by mail-wm1-f43.google.com with SMTP id 125so9648124wmh.0
	for <qemu-devel@nongnu.org>; Thu, 22 Nov 2018 08:48:33 -0800 (PST)
MIME-Version: 1.0
References: <20181122133507.30950-1-peter.maydell@linaro.org>
In-Reply-To: <20181122133507.30950-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Thu, 22 Nov 2018 17:48:20 +0100
Message-ID: <CAP+75-UQhpz3kXvGN3vP69QqyiPg0PpGLAuj+EFXsfzhoAU2CQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 0/2] Rename
 cpu_physical_memory_write_rom() to address_space_write_rom()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, patches@linaro.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Paolo Bonzini <pbonzini@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>

Le jeu. 22 nov. 2018 14:36, Peter Maydell <peter.maydell@linaro.org> a
=C3=A9crit :

> The API of cpu_physical_memory_write_rom() is odd, because it
> takes an AddressSpace, unlike all the other cpu_physical_memory_*
> access functions. We note this oddity as a TODO in the
> docs/devel/loads-stores.rst documentation.
>
> Rename cpu_physical_memory_write_rom() to address_space_write_rom(),
> and give it an API that matches address_space_write().
> We also adjest the cpu_physical_memory_write_rom_internal()
> function which is local to exec.c similarly.
>
> thanks
> -- PMM
>
> Peter Maydell (2):
>   exec.c: Rename cpu_physical_memory_write_rom_internal()
>   Rename cpu_physical_memory_write_rom() to address_space_write_rom()
>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
