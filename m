Received: from eggs.gnu.org ([209.51.188.92]:60694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9Uv-0000eF-U1
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:51:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9Uv-00017p-43
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:51:21 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f]:34214)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL9Uu-00017O-SB
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:51:21 -0400
Received: by mail-ot1-x32f.google.com with SMTP id n15so3191211ota.1
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 09:51:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190412165416.7977-1-philmd@redhat.com>
In-Reply-To: <20190412165416.7977-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 17:51:08 +0100
Message-ID: <CAFEAcA90Pv=zEqaonGV=c022T=CYMo11nkqNwBnGgocESnBNmA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v3 00/12] hw: Remove
 "hw/devices.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, Jan Kiszka <jan.kiszka@web.de>, Andrzej Zaborowski <balrogg@gmail.com>

On Fri, 12 Apr 2019 at 17:55, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> Hi,
>
> As his first comment describes itself, the "hw/devices.h" contains
> declarations for "Devices that have nowhere better to go."
> This series remove it, creating new headers for devices covered there.
> MAINTAINERS is updated.
> I also included 2 cleanups while working on this, in "qemu/typedefs.h"
> and "hw/net/ne2000-isa.h" header guard.
>
> v3:
> - rebased
> - added 2 patches suggested by Markus
> - addressed Markus review comments
> - added Markus's R-b

Since these are almost all arm devices I'll take this via the
target-arm tree (I'm going to make a pullreq later today).

thanks
-- PMM
