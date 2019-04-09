Received: from eggs.gnu.org ([209.51.188.92]:40697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDrIM-0001g0-SD
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 10:00:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDrIL-0001MH-Pn
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 10:00:14 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:36855)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hDrIL-0001Kn-1Z
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 10:00:13 -0400
Received: by mail-ot1-x341.google.com with SMTP id o74so15627762ota.3
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 07:00:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190409134536.15548-1-philmd@redhat.com>
In-Reply-To: <20190409134536.15548-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Apr 2019 15:00:00 +0100
Message-ID: <CAFEAcA9pc3Dw_X5b74+av0qq5hM7wB4uixSuh_TLwHAm8eGsqA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v3 0/2] roms: Avoid iPXE/EDK2
 EFIROM variable clash, pass CFLAGS to EDK2 build tools
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Olaf Hering <olaf@aepfle.de>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

On Tue, 9 Apr 2019 at 14:47, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
>
> Hi,
>
> Two trivial fixes to avoid the latest EDK2 testing series to
> cause trouble to downstream distributions (in particular if
> they have PIE enforced).
>
> Since v2:
> - addressed Laszlo's suggestion
> - reworded patch description
>
> v2: https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg01033.html
> v1: https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg01006.html
> error report: https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg00=
992.html
>
> Regards,
>
> Phil.
>
> Philippe Mathieu-Daud=C3=A9 (2):
>   roms: Rename the EFIROM variable to avoid clashing with iPXE
>   roms: Allow passing configure options to the EDK2 build tools
>
>  roms/Makefile | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)

Thanks. This is one of a handful of remaining bugs we
should fix for 4.0, so I would ideally like to get this
in rc3 today (or tomorrow if we have to slip rc3 a day).
If people wanting to review this series could do so
promptly I'd definitely appreciate it.

-- PMM
