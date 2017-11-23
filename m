Received: from eggs.gnu.org ([2001:4830:134:3::10]:59703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eHrtJ-000186-AE
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:50:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eHrtI-0007BK-Gx
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:50:09 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:37404)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eHrtI-0007AL-Cg
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:50:08 -0500
Received: by mail-ot0-x244.google.com with SMTP id s4so16368255ote.4
	for <qemu-devel@nongnu.org>; Thu, 23 Nov 2017 05:50:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171122044814.3001-1-david@gibson.dropbear.id.au>
References: <20171122044814.3001-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Nov 2017 13:49:47 +0000
Message-ID: <CAFEAcA8eGWknRWXdpyV3tQgZAd+-5W11RjOWRKh_N50L7St1sw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/3] ppc-for-2.11 queue 20171122
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, Greg Kurz <groug@kaod.org>, Laurent Vivier <lvivier@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>

On 22 November 2017 at 04:48, David Gibson <david@gibson.dropbear.id.au> wrote:
> The following changes since commit a15d835f00dce270fd3194e83d9910f4b5b44ac0:
>
>   Update version for v2.11.0-rc2 release (2017-11-21 17:50:36 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-2.11-20171122
>
> for you to fetch changes up to 6dd836f5d32b989e18c6dda655a26f4d73a52f6a:
>
>   ppc: fix VTB migration (2017-11-22 15:28:37 +1100)
>
> ----------------------------------------------------------------
> ppc patch queue 2017-11-22
>
> Several more fixes to merge for qemu-2.11.
>
> ----------------------------------------------------------------
> David Gibson (1):
>       spapr: Implement bug in spapr-vty device to be compatible with PowerVM
>
> Laurent Vivier (1):
>       ppc: fix VTB migration
>
> Thomas Huth (1):
>       hw/ppc/spapr: Fix virtio-scsi bootindex handling for LUNs >= 256
>
>  hw/char/spapr_vty.c         | 18 ++++++++++++++++++
>  hw/ppc/spapr.c              |  4 ++++
>  target/ppc/translate_init.c |  4 ++--
>  3 files changed, 24 insertions(+), 2 deletions(-)


Applied, thanks.

-- PMM
