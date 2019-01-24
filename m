Received: from eggs.gnu.org ([209.51.188.92]:45664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmaZR-0001bv-EE
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 03:41:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmaQ6-0000aD-92
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 03:31:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37921)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gmaQ6-0000Zk-1x
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 03:31:30 -0500
Date: Thu, 24 Jan 2019 09:31:24 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190124083124.iz3vkyhw5j5vjwkl@sirius.home.kraxel.org>
References: <153994006052.15678.15962440455123359491.malonedeb@gac.canonical.com>
	<CAFEAcA9vczSpf+xd+3so1YKAW-d4RKY7iVEtMvJrgSNbRjQ+Zg@mail.gmail.com>
	<jpgd0ooc1f0.fsf@linux.bootlegged.copy>
	<jpg8szcc1ar.fsf_-_@linux.bootlegged.copy>
	<20190124080137.2upct7emowdj7n2r@sirius.home.kraxel.org>
	<jpg4l9yzcw8.fsf@linux.bootlegged.copy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jpg4l9yzcw8.fsf@linux.bootlegged.copy>
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
Cc: Bug 1798780 <1798780@bugs.launchpad.net>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, Jan 24, 2019 at 03:19:03AM -0500, Bandan Das wrote:
> Gerd Hoffmann <kraxel@redhat.com> writes:
> 
> > On Tue, Jan 22, 2019 at 07:41:16AM -0500, Bandan Das wrote:
> >> 
> >> qemu_write_full takes care of partial blocking writes,
> >> as in cases of larger file sizes
> >> 
> >> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> >> Signed-off-by: Bandan <bsd@redhat.com>
> >
> > Hmm, doesn't apply, and git fails to do a 3way merge too due to unknown
> > sha1.
> 
> Oops, sorry, I realize now this is on top of the write buffer breakup patches.

Hmm, they are queued up already, so that should have worked.

> Should I resend a v2 on top of master and send a v3 for the write buffer breakup
> patches ?

Can you just send a single series with both this fix and the breakup
patches, against latest master?

thanks,
  Gerd
