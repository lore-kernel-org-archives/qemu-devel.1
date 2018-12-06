Received: from eggs.gnu.org ([2001:4830:134:3::10]:57735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gUrjx-0004gE-OW
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 06:22:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gUrjt-0002jb-Bz
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 06:22:45 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:44431)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gUrjt-0002jN-73
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 06:22:41 -0500
Received: by mail-ot1-x342.google.com with SMTP id f18so45537otl.11
	for <qemu-devel@nongnu.org>; Thu, 06 Dec 2018 03:22:41 -0800 (PST)
MIME-Version: 1.0
References: <20181206084816.30485-1-ppandit@redhat.com>
	<20181206105830.43eb1d05@redhat.com>
	<nycvar.YSQ.7.76.1812061637070.2113@xnncv>
	<CAFEAcA90U=8s=f-pcFS+8VF3GZby__GnwXy_van=FxiE7fK7gQ@mail.gmail.com>
In-Reply-To: <CAFEAcA90U=8s=f-pcFS+8VF3GZby__GnwXy_van=FxiE7fK7gQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Dec 2018 11:22:29 +0000
Message-ID: <CAFEAcA9N9sqi4fSp1epPdCV7PkqXpZK4kyoHErvfx3hwcN3kag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] i2c: pm_smbus: check smb_index before
 block transfer write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, public@hansmi.ch, QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>

On Thu, 6 Dec 2018 at 11:19, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Thu, 6 Dec 2018 at 11:10, P J P <ppandit@redhat.com> wrote:
> >
> > +-- On Thu, 6 Dec 2018, Igor Mammedov wrote --+
> > | > From: Prasad J Pandit <pjp@fedoraproject.org>
> > | >
> > | > While performing block transfer write in smb_ioport_writeb(),
> > | > 'smb_index' is incremented and used to index smb_data[] array.
> > | > Check 'smb_index' value to avoid OOB access.
> > | >
> > | > Reported-by: Michael Hanselmann <public@hansmi.ch>
> > | > Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> > | pls squash in:
> > |
> > | Fixes: 38ad4fae43 i2c: pm_smbus: Add block transfer capability
> >
> > Do we need patch v2, or it can be done while merging it?
>
> I can add in the Fixes line when I apply the patch to master.

Oh, I think we should also add to the commit message something
along the lines of:

"Note that this bug is exploitable by a guest to escape
from the virtual machine. However the commit which
introduced the bug was only made after the 3.0 release,
and so it is not present in any released QEMU version."

to clarify that this is a serious bug but also that it's
not one that will be affecting anybody's production systems.

thanks
-- PMM
