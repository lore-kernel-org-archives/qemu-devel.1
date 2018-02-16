Received: from eggs.gnu.org ([2001:4830:134:3::10]:52731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1emc8C-0005oD-SD
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 04:16:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1emc8B-0004RD-KT
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 04:16:36 -0500
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:40096)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1emc8B-0004Qn-E7
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 04:16:35 -0500
Received: by mail-oi0-x242.google.com with SMTP id 8so1829706oix.7
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 01:16:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180216070201.4271-1-penberg@iki.fi>
References: <20180216070201.4271-1-penberg@iki.fi>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Feb 2018 09:16:14 +0000
Message-ID: <CAFEAcA9ERfuxmfucTfEujrxGL-rpCvDYpAV9jKoBwVGccj6BCA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/3] Raspberry Pi 3 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pekka Enberg <penberg@iki.fi>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 16 February 2018 at 07:01, Pekka Enberg <penberg@iki.fi> wrote:
> This patch series adds support for Raspberry Pi 3 as a new machine model
> "raspi3", which is an extension of the "raspi2" model with the following
> differences:
>
>   - Default CPU type is "cortex-a53"
>   - Firmware is at address 0x80000
>   - Board ID is 0xc44 and board revision is 0xa02082
>
> The patches were written by me but I used Zolt=C3=A1n Baldaszti's previou=
s
> work as a reference (with permission from the author):
>
>   https://github.com/bztsrc/qemu-raspi3
>
> Also available from:
>
>   git@github.com:penberg/qemu.git raspi3/v2
>
> Changes from v1 to v2:
>
> - Wrap Raspberry Pi 3 machine definition with TARGET_AARCH64 (Peter
>   Maydell)

Hi. Patches 1 and 2 for this are already in master, and I have
patch 3 queued -- it's just dependent on a bugfix (patch posted)
that's needed for big-endian host systems.

thanks
-- PMM
