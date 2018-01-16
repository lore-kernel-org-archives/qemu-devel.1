Received: from eggs.gnu.org ([2001:4830:134:3::10]:33781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ebScM-00078r-Ht
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:53:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ebScI-00075W-OJ
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:53:38 -0500
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:38384)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ebScI-00074v-Jq
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:53:34 -0500
Received: by mail-ot0-x243.google.com with SMTP id v5so3478004oth.5
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 06:53:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180116013709.13830-14-andrew.smirnov@gmail.com>
References: <20180116013709.13830-1-andrew.smirnov@gmail.com>
	<20180116013709.13830-14-andrew.smirnov@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jan 2018 14:53:13 +0000
Message-ID: <CAFEAcA9fSDjPs0bAcKY7wGDJkhv6sXPWwzNo9DUMBjZic8Y9Xw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 13/14] hw/arm: Move virt's PSCI DT fixup
 code to arm/boot.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>

On 16 January 2018 at 01:37, Andrey Smirnov <andrew.smirnov@gmail.com> wrot=
e:
> Move virt's PSCI DT fixup code to arm/boot.c and set this fixup to
> happen automatically for every board that doesn't mark "psci-conduit"
> as disabled. This way emulated boards other than "virt" that rely on
> PSIC for SMP could benefit from that code.
>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Cc: qemu-devel@nongnu.org
> Cc: qemu-arm@nongnu.org
> Cc: yurovsky@gmail.com
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  hw/arm/boot.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  hw/arm/virt.c | 61 -----------------------------------------------------=
--
>  2 files changed, 65 insertions(+), 61 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
