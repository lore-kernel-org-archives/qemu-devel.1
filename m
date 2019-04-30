Received: from eggs.gnu.org ([209.51.188.92]:36498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLU9K-0003j8-U6
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 10:54:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLU9K-0006gQ-2v
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 10:54:26 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:43052)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLU9J-0006fe-TX
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 10:54:26 -0400
Received: by mail-ot1-x342.google.com with SMTP id u15so12133949otq.10
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 07:54:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190416091348.26075-1-armbru@redhat.com>
In-Reply-To: <20190416091348.26075-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2019 15:54:12 +0100
Message-ID: <CAFEAcA-9aXpYTarSUw2r49PEeihZ4eyQub7f+DdcwqcJ8GXXGw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/3] hw/arm/virt: Support firmware
 configuration with -blockdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laszlo Ersek <lersek@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Qemu-block <qemu-block@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>

On Tue, 16 Apr 2019 at 10:13, Markus Armbruster <armbru@redhat.com> wrote:
>
> L=C3=A1szl=C3=B3 asked for feature parity with the PC machine types.
>
> v2:
> * PATCH 1: Split off PATCH 2 [L=C3=A1szl=C3=B3]
> * PATCH 2: Factor out the loop body, not the whole loop
> * PATCH 3: Rebase on previous change
>            More detailed commit message [L=C3=A1szl=C3=B3]
>
> Markus Armbruster (3):
>   pc: Rearrange pc_system_firmware_init()'s legacy -drive loop
>   pflash_cfi01: New pflash_cfi01_legacy_drive()
>   hw/arm/virt: Support firmware configuration with -blockdev

I appreciated the commit message on patch 3, it was very helpful.
Applied to target-arm.next, thanks.

-- PMM
