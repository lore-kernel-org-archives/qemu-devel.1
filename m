Received: from eggs.gnu.org ([2001:4830:134:3::10]:34470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f889d-0005Ex-7H
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 13:43:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f889Z-0004do-AV
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 13:43:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44794)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f889Z-0004dI-3R
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 13:42:57 -0400
Date: Mon, 16 Apr 2018 14:42:52 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180416174252.GA23840@localhost.localdomain>
References: <20180416163953.31188-1-ehabkost@redhat.com>
	<CAFEAcA9jQsRK4WW+Ov7j1rewCgtVHoWFkkDF7wfoWgdP0SeTgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9jQsRK4WW+Ov7j1rewCgtVHoWFkkDF7wfoWgdP0SeTgA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 0/1] i386: Don't automatically enable
 FEAT_KVM_HINTS bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

On Mon, Apr 16, 2018 at 05:57:35PM +0100, Peter Maydell wrote:
> On 16 April 2018 at 17:39, Eduardo Habkost <ehabkost@redhat.com> wrote:
> > Last remaining fix for -rc4.
> >
> > The following changes since commit 042f6a31af3d38eefc6ec995cce1d762c41d4515:
> >
> >   Merge remote-tracking branch 'remotes/maxreitz/tags/pull-block-2018-04-16' into staging (2018-04-16 15:30:54 +0100)
> >
> > are available in the Git repository at:
> >
> >   git://github.com/ehabkost/qemu.git tags/x86-next-pull-request
> >
> > for you to fetch changes up to 0d914f39a77954bf5472b16130aeefe573a068f5:
> >
> >   i386: Don't automatically enable FEAT_KVM_HINTS bits (2018-04-16 13:36:52 -0300)
> >
> > ----------------------------------------------------------------
> > i386: Don't automatically enable FEAT_KVM_HINTS bits
> >
> > Bug fix for "-cpu host" with newer kernels.
> >
> > ----------------------------------------------------------------
> 
> Is this a regression since 2.11 ?

Yes.

-- 
Eduardo
