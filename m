Received: from eggs.gnu.org ([2001:4830:134:3::10]:54226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ej7bn-000798-7m
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 13:04:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ej7bk-0001Tk-3X
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 13:04:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53018)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1ej7bj-0001TG-V4
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 13:04:40 -0500
Date: Tue, 6 Feb 2018 11:04:33 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20180206110433.7a17c46e@w520.home>
In-Reply-To: <CAFEAcA9HMpzXTOHH7sQxQfi9pR9WdJfpfqida6-vnv2yZzqXUA@mail.gmail.com>
References: <20180205185416.14391.5739.stgit@gimli.home>
	<CAFEAcA9HMpzXTOHH7sQxQfi9pR9WdJfpfqida6-vnv2yZzqXUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/11] VFIO updates 2018-02-05
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, aik@ozlabs.ru

On Tue, 6 Feb 2018 17:34:25 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On 5 February 2018 at 18:56, Alex Williamson <alex.williamson@redhat.com> wrote:
> > The following changes since commit f24ee107a07f093bd7ed475dd48d7ba57ea3d8fe:
> >
> >   Merge remote-tracking branch 'remotes/kraxel/tags/ui-20180202-pull-request' into staging (2018-02-02 18:54:11 +0000)
> >
> > are available in the Git repository at:
> >
> >   git://github.com/awilliam/qemu-vfio.git tags/vfio-update-20180205.0
> >
> > for you to fetch changes up to 98cc546baeedd43373ecd44c2392bbe9f0bc484c:
> >
> >   vfio/pci: Add option to disable GeForce quirks (2018-02-05 11:27:15 -0700)
> >
> > ----------------------------------------------------------------
> > VFIO updates 2018-02-05
> >
> >  - SPAPR in-kernel TCE accleration (Alexey Kardashevskiy)
> >
> >  - MSI-X relocation (Alex Williamson)
> >
> >  - Add missing platform mutex init (Eric Auger)
> >
> >  - Redundant variable cleanup (Alexey Kardashevskiy)
> >
> >  - Option to disable GeForce quirks (Alex Williamson)
> >
> > ----------------------------------------------------------------  
> 
> Hi. This fails to build for Windows:
> 
> hw/ppc/spapr_iommu.c:20:23: fatal error: sys/ioctl.h: No such file or directory

Ugh, sorry for that.  Additionally the include looks like cruft from
previous versions of the patch, we're not adding any ioctl calls here.
I'll remove the include and send a new request.  Thanks,

Alex
