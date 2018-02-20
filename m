Received: from eggs.gnu.org ([2001:4830:134:3::10]:34253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eoChX-0007ph-Dz
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 13:31:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eoChW-0003Ep-H1
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 13:31:39 -0500
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:35281)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eoChW-0003EN-BK
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 13:31:38 -0500
Received: by mail-ot0-x243.google.com with SMTP id p8so9462167otf.2
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 10:31:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <cover.1519150239.git.balaton@eik.bme.hu>
References: <cover.1519150239.git.balaton@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Feb 2018 18:31:17 +0000
Message-ID: <CAFEAcA8UnMNoGbpx+Mhh8AT9MfOMuUZvMd139tGQFokTAWqWpA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/2] Firmware blob and git submodule for
 Sam460ex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc@nongnu.org, Francois Revol <revol@free.fr>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>

On 20 February 2018 at 18:10, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> I've created a git repo for the Sam460ex u-boot sources and this adds
> that as a submodule and a separate patch to add the binary built from
> these sources. Feel free to keep this as two patches, squash them into
> one patch or take the git repo and commit the content under the QEMU
> repo and use that as a submodule as you see fit (or let me know if any
> changes are needed for these patches).
>
> BALATON Zoltan (2):
>   roms: Added git submodule for u-boot-sam460 (firmware for sam460ex)
>   pc-bios: Added u-boot-sam460 firmware binary

We already have a submodule for u-boot. Is it not possible to
build this bios blob from those upstream u-boot sources?

thanks
-- PMM
