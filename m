Received: from eggs.gnu.org ([2001:4830:134:3::10]:49115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eJJLy-0002DU-3j
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 08:21:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eJJLu-0001Y9-2C
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 08:21:42 -0500
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:42854)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eJJLt-0001Xq-Td
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 08:21:37 -0500
Received: by mail-oi0-x244.google.com with SMTP id p23so16233038oie.9
	for <qemu-devel@nongnu.org>; Mon, 27 Nov 2017 05:21:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171127043003.15034-1-david@gibson.dropbear.id.au>
References: <20171127043003.15034-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Nov 2017 14:21:16 +0100
Message-ID: <CAFEAcA9sJqYh=9S+iRSyG9sEsWVrE6gXVecF7DKqFVS+2h69PQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] ppc-for-2.11 queue 20171127
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: surajjs@au1.ibm.com, Alexander Graf <agraf@suse.de>, Greg Kurz <groug@kaod.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 27 November 2017 at 05:30, David Gibson <david@gibson.dropbear.id.au> wrote:
> The following changes since commit e7b47c22e2df14d55e3e4426688c929bf8e3f7fb:
>
>   osdep.h: Make TIME_MAX handle different time_t types (2017-11-24 13:23:36 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-2.11-20171127
>
> for you to fetch changes up to e07cc1929515cfb808b5c2fcc60c079e6be110cf:
>
>   target/ppc: Fix setting of cpu->compat_pvr on incoming migration (2017-11-27 12:20:11 +1100)
>
> ----------------------------------------------------------------
> ppc patch queue 2017-11-27
>
> This series contains a couple of migration fixes for hash guests on
> POWER9 radix MMU hosts.
>
> ----------------------------------------------------------------
> Suraj Jitindar Singh (2):
>       target/ppc: Move setting of patb_entry on hash table init
>       target/ppc: Fix setting of cpu->compat_pvr on incoming migration
>
>  hw/ppc/spapr.c       | 4 ++--
>  target/ppc/machine.c | 4 +++-
>  2 files changed, 5 insertions(+), 3 deletions(-)

Applied, thanks.

-- PMM
