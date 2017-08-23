Received: from eggs.gnu.org ([2001:4830:134:3::10]:50074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dkTkb-0007wk-EC
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 07:23:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dkTka-0004E0-Hl
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 07:23:09 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:34789)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dkTka-0004D2-Bd
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 07:23:08 -0400
Received: by mail-wr0-x231.google.com with SMTP id p14so4625468wrg.1
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 04:23:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170823003217.6769-1-david@gibson.dropbear.id.au>
References: <20170823003217.6769-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 23 Aug 2017 12:22:45 +0100
Message-ID: <CAFEAcA-9K5GdFYGavgVvnv62T_K8AvwbzQPTUFrAvenCShqzLQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/7] ppc-for-2.10 queue 20170823
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>

On 23 August 2017 at 01:32, David Gibson <david@gibson.dropbear.id.au> wrote:
> The following changes since commit 1f296733876434118fd766cfef5eb6f29ecab6a8:
>
>   Update version for v2.10.0-rc3 release (2017-08-15 18:53:31 +0100)
>
> are available in the git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-2.10-20170823
>
> for you to fetch changes up to 1f98e55385d11da1dc0de6440e66f19d191d2a1b:
>
>   hw/ppc/spapr_iommu: Fix crash when removing the "spapr-tce-table" device (2017-08-22 21:26:46 +1000)
>
> ----------------------------------------------------------------
> ppc patch queue 2017-08-23
>
> This is identical to the pull request from yesterday (20180822),
> except that a bug in one patch is fixed so that it doesn't break TCG
> on a ppc host.
>
> Last minute ppc related fixes for qemu-2.10.  I'm not sure if these
> are critical enough to prompt another rc, but I'm submitting them for
> consideration.
>
> First, is Cornelia's fix for 480bc11e6 which meant "make check" would
> always fail on a ppc host.  Tracking that down delayed submission of
> the rest of these patches, sorry.
>
> The rest are all fairly important bugfixes for qemu crashes or guest
> behaviour regression on ppc.  Patches 2-4 specifically are fixes for
> regressions from qemu-2.9, caused by the compatibility mode and
> hotplug handling cleanups for the pseries machine type.
>

Applied, thanks.

-- PMM
