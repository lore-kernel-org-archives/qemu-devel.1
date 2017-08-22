Received: from eggs.gnu.org ([2001:4830:134:3::10]:59324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dk5al-0003rG-Ql
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 05:35:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dk5af-0002YQ-Jn
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 05:35:21 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:35170)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dk5af-0002Xp-CF
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 05:35:17 -0400
Received: by mail-wr0-x236.google.com with SMTP id k46so45374724wre.2
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 02:35:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170822042416.26758-1-david@gibson.dropbear.id.au>
References: <20170822042416.26758-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Aug 2017 10:34:55 +0100
Message-ID: <CAFEAcA-iuizr9eh3=ZkPPT+YxfWzvUFzbWB-aA_Mo5BiDkrzQQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/7] ppc-for-2.10 queue 20170822
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

On 22 August 2017 at 05:24, David Gibson <david@gibson.dropbear.id.au> wrote:
> The following changes since commit 1f296733876434118fd766cfef5eb6f29ecab6a8:
>
>   Update version for v2.10.0-rc3 release (2017-08-15 18:53:31 +0100)
>
> are available in the git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-2.10-20170822
>
> for you to fetch changes up to d3234e2851f1630c695c681beac1e87ac0881260:
>
>   hw/ppc/spapr_iommu: Fix crash when removing the "spapr-tce-table" device (2017-08-22 11:11:30 +1000)
>
> ----------------------------------------------------------------
> ppc patch queue 2017-08-22
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
> ----------------------------------------------------------------

I get a make check failure on ppc64 Linux:

TEST: tests/postcopy-test... (pid=12468)
  /ppc64/postcopy:
Broken pipe
qemu-system-ppc64: RP: Received invalid message 0x0000 length 0x0000
FAIL
GTester: last random seed: R02Se5468e06f561627824306d95b0566d2b
(pid=13011)
FAIL: tests/postcopy-test

thanks
-- PMM
