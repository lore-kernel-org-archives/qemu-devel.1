Received: from eggs.gnu.org ([2001:4830:134:3::10]:56132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dZx5J-0003D9-Bq
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 06:29:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dZx5I-0001u1-CB
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 06:29:01 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:37265)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dZx5I-0001tf-4B
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 06:29:00 -0400
Received: by mail-wr0-x231.google.com with SMTP id 33so60513813wrz.4
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 03:28:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170725054510.15177-1-david@gibson.dropbear.id.au>
References: <20170725054510.15177-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Jul 2017 11:28:38 +0100
Message-ID: <CAFEAcA-rZ62E_dVULrLjzPSszKN7HTnU-sTXQtmXXWhSdrJHLw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/4] ppc-for-2.10 queue 20170725
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, Alexey Kardashevskiy <aik@ozlabs.ru>, Laurent Vivier <lvivier@redhat.com>, Greg Kurz <groug@kaod.org>, "bharata@linux.vnet.ibm.com" <bharata@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>

On 25 July 2017 at 06:45, David Gibson <david@gibson.dropbear.id.au> wrote:
> The following changes since commit b5a74cd81d76cb467552f38f2b39520d07c65ea2:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20170724' into staging (2017-07-24 18:15:45 +0100)
>
> are available in the git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-2.10-20170725
>
> for you to fetch changes up to 86844c213348a596ea716a44a6f337555e07ad09:
>
>   pseries: Update SLOF firmware image (2017-07-25 14:35:42 +1000)
>
> ----------------------------------------------------------------
> ppc patch queue 2017-07-25
>
> Last pull request for the 2.10 hard freeze, and correspondingly small.
> There are a handful of bugfixes here plus an update for the "pseries"
> guest firmware (SLOF).
>
> This is later than ideal for a guest firmware update.  However, this
> does include a number of fixes in that guest firmware, so I think it's
> worth the risk of squeezing this in just before the hard freeze.
>
> ----------------------------------------------------------------
> Alexey Kardashevskiy (2):
>       spapr_pci: Fix obsolete comment about MSIX encoding in addr/data
>       pseries: Update SLOF firmware image
>
> Bharata B Rao (1):
>       spapr: Fix QEMU abort during memory unplug
>
> Laurent Vivier (1):
>       spapr/htab: fix savevm

Applied, thanks.

-- PMM
