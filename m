Received: from eggs.gnu.org ([2001:4830:134:3::10]:56081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duLNB-0000TA-La
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:27:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duLN8-0000HT-4v
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:27:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40998)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1duLN7-0000Fd-TZ
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:27:42 -0400
Date: Tue, 19 Sep 2017 18:27:32 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170919182732.23990a9c.cohuck@redhat.com>
In-Reply-To: <CAFEAcA9WKUzGZgPJ01bBtkES=cj+=eyMM40DN+5UGmFgcYd2cA@mail.gmail.com>
References: <20170919145636.9389-1-cohuck@redhat.com>
	<CAFEAcA9WKUzGZgPJ01bBtkES=cj+=eyMM40DN+5UGmFgcYd2cA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/38] various s390x patches (+some fixes)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>

On Tue, 19 Sep 2017 17:13:21 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On 19 September 2017 at 15:55, Cornelia Huck <cohuck@redhat.com> wrote:
> > The following changes since commit 11e06ce1ed28fd0ffcbc1e2436b72f3412b4ecc8:
> >
> >   Merge remote-tracking branch 'remotes/jnsnow/tags/ide-pull-request' into staging (2017-09-19 10:13:51 +0100)
> >
> > are available in the git repository at:
> >
> >   git://github.com/cohuck/qemu tags/s390x-20170919
> >
> > for you to fetch changes up to 4f195287a30f1d58e4aee911aed310883bb819db:
> >
> >   MAINTAINERS/s390x: add terminal3270.c (2017-09-19 15:32:26 +0200)
> >
> > ----------------------------------------------------------------
> > Assorted s390x patches:
> > - introduce virtio-gpu-ccw, with virtio-gpu endian fixes
> > - lots of cleanup in the s390x code
> > - make device_add work for s390x cpus
> > - enable seccomp on s390x
> > - an ivshmem endian fix
> > - set the reserved DHCP client architecture id for netboot
> > - fixes in the css and pci support
> >
> > ----------------------------------------------------------------  
> 
> Hi -- this doesn't apply because it deletes hw/s390x/s390-virtio.c
> which has been modified in master. Can I ask you to fix this up
> and resend, please?

Mid-air collision with the warning message cleanup. Will rebase.
