Received: from eggs.gnu.org ([2001:4830:134:3::10]:44442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cUIME-00070Y-RB
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 14:26:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cUIMD-0002Fo-T0
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 14:26:50 -0500
Received: from mail-vk0-x230.google.com ([2607:f8b0:400c:c05::230]:34157)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cUIMD-0002FC-F9
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 14:26:49 -0500
Received: by mail-vk0-x230.google.com with SMTP id r136so37446158vke.1
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 11:26:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1483979087-32663-8-git-send-email-clg@kaod.org>
References: <1483979087-32663-1-git-send-email-clg@kaod.org>
	<1483979087-32663-8-git-send-email-clg@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Jan 2017 19:26:28 +0000
Message-ID: <CAFEAcA_tLcVQj_kJh3iY7ZOEechPrk=9+Hj3_QcOE+pmPoWCYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 07/11] aspeed/smc: handle SPI flash
 Command mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Marcin Krzeminski <marcin.krzeminski@nokia.com>

On 9 January 2017 at 16:24, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> The Aspeed SMC controllers have a mode (Command mode) in which
> accesses to the flash content are no different than doing MMIOs. The
> controller generates all the necessary commands to load (or store)
> data in memory.
>
> However, accesses are restricted to the segment window assigned the
> the flash module by the controller. This window is defined by the
> Segment Address Register.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
> ---
>  hw/ssi/aspeed_smc.c         | 152 ++++++++++++++++++++++++++++++++++++++=
------
>  include/hw/ssi/aspeed_smc.h |   2 +-
>  2 files changed, 132 insertions(+), 22 deletions(-)

This deleted the only call to aspeed_smc_is_usermode() but not
its definition, which makes clang complain:
/Users/pm215/src/qemu-for-merges/hw/ssi/aspeed_smc.c:409:20: error:
unused function 'aspeed_smc_is_usermode' [-Werror,-Wunused-function]

Presumably the function itself should be deleted?

thanks
-- PMM
