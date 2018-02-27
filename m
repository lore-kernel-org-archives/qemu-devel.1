Received: from eggs.gnu.org ([2001:4830:134:3::10]:50580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqil6-0003N4-IW
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 12:09:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqil5-00043S-KN
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 12:09:44 -0500
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:43104)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eqil5-000438-E3
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 12:09:43 -0500
Received: by mail-oi0-x243.google.com with SMTP id a207so13399229oii.10
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 09:09:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180223232233.31482-1-frasse.iglesias@gmail.com>
References: <20180223232233.31482-1-frasse.iglesias@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Feb 2018 17:09:22 +0000
Message-ID: <CAFEAcA8bKM_Z9skCUE2HaF8zdca7YCAazxOXX-+dF5xC_xvGJw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 0/2] xilinx_spips: Update CS assertion
 when striping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Francisco Iglesias <frasse.iglesias@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Edgar Iglesias <edgari@xilinx.com>, Alistair Francis <alistai@xilinx.com>, Francisco Iglesias <francisco.iglesias@feimtech.se>

On 23 February 2018 at 23:22, Francisco Iglesias
<frasse.iglesias@gmail.com> wrote:
> Hi,
>
> The first patch in this series attempts to correct the slave selection when
> using the striping functionality in the QSPI. The second patch in the series
> updates the QIOR/QIOR4 commands to use 8 dummy cycles in the QSPI for matching
> Micron (Numonyx) flashes (the default target flash type of the QSPI).
>
> Best regards,
> Francisco Iglesias
>
> Changelog:
> v1 -> v2
>   * Attempted to improve readability in the patch 'xilinx_spips: Enable only
>     two slaves when reading/writing with stripe' when selecting chip selects.
>
>
> Francisco Iglesias (2):
>   xilinx_spips: Enable only two slaves when reading/writing with stripe
>   xilinx_spips: Use 8 dummy cycles with the QIOR/QIOR4 commands
>
>  hw/ssi/xilinx_spips.c | 43 ++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 38 insertions(+), 5 deletions(-)



Applied to target-arm.next, thanks.

-- PMM
