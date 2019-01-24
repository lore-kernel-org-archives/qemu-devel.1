Received: from eggs.gnu.org ([209.51.188.92]:40135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmZxL-0002EI-GY
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 03:01:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmZxJ-00042F-Cj
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 03:01:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33952)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gmZxJ-0003xP-60
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 03:01:45 -0500
Date: Thu, 24 Jan 2019 09:01:37 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190124080137.2upct7emowdj7n2r@sirius.home.kraxel.org>
References: <153994006052.15678.15962440455123359491.malonedeb@gac.canonical.com>
	<CAFEAcA9vczSpf+xd+3so1YKAW-d4RKY7iVEtMvJrgSNbRjQ+Zg@mail.gmail.com>
	<jpgd0ooc1f0.fsf@linux.bootlegged.copy>
	<jpg8szcc1ar.fsf_-_@linux.bootlegged.copy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jpg8szcc1ar.fsf_-_@linux.bootlegged.copy>
Subject: Re: [Qemu-devel] [PATCH] usb-mtp: replace the homebrew write with
 qemu_write_full
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bandan Das <bsd@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Bug 1798780 <1798780@bugs.launchpad.net>, QEMU Developers <qemu-devel@nongnu.org>

On Tue, Jan 22, 2019 at 07:41:16AM -0500, Bandan Das wrote:
> 
> qemu_write_full takes care of partial blocking writes,
> as in cases of larger file sizes
> 
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Bandan <bsd@redhat.com>

Hmm, doesn't apply, and git fails to do a 3way merge too due to unknown
sha1.

cheers,
  Gerd
