Received: from eggs.gnu.org ([2001:4830:134:3::10]:49304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e4TcD-0005EG-Il
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 11:17:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e4Tc9-0002Xb-Fl
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 11:17:09 -0400
Date: Tue, 17 Oct 2017 17:16:29 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171017171629.1b2aa212.cohuck@redhat.com>
In-Reply-To: <3651bc50-e8f4-8aa3-fff4-462ac7a7ff05@redhat.com>
References: <20171017144051.8452-1-lprosek@redhat.com>
	<3651bc50-e8f4-8aa3-fff4-462ac7a7ff05@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH trivial] Remove empty statements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Ladi Prosek <lprosek@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>, Christian Borntraeger <borntraeger@de.ibm.com>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

On Tue, 17 Oct 2017 16:50:41 +0200
Laszlo Ersek <lersek@redhat.com> wrote:

> On 10/17/17 16:40, Ladi Prosek wrote:
> > Thanks to Laszlo Ersek for spotting the double semicolon in target/i386/kvm.c
> > 
> > I have trivially grepped the tree for ';;' in C files.
> > 
> > Suggested-by: Laszlo Ersek <lersek@redhat.com>
> > Signed-off-by: Ladi Prosek <lprosek@redhat.com>
> > ---
> >  hw/misc/imx6_ccm.c     | 2 +-
> >  hw/s390x/virtio-ccw.c  | 2 +-
> >  linux-user/signal.c    | 2 +-
> >  migration/block.c      | 2 +-
> >  target/i386/cpu.c      | 2 +-
> >  target/i386/kvm.c      | 2 +-
> >  target/sh4/translate.c | 2 +-
> >  7 files changed, 7 insertions(+), 7 deletions(-)  
> 
> I've run "get_maintainer.pl" on the above files, and added some CCs.
> 
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Trivial ;) enough, but

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
