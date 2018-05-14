Received: from eggs.gnu.org ([2001:4830:134:3::10]:55462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fIDD9-0001Rj-Ob
	for qemu-devel@nongnu.org; Mon, 14 May 2018 09:08:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fIDD8-0007Tx-Up
	for qemu-devel@nongnu.org; Mon, 14 May 2018 09:08:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38350 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fIDD8-0007Tf-Ot
	for qemu-devel@nongnu.org; Mon, 14 May 2018 09:08:18 -0400
Date: Mon, 14 May 2018 16:08:17 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180514160802-mutt-send-email-mst@kernel.org>
References: <1526074301-211877-1-git-send-email-mst@redhat.com>
	<CAFEAcA-WWAy_0Ovc34fpnx=yTXk-ieDqoP4JikeeZfRBxRX3bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-WWAy_0Ovc34fpnx=yTXk-ieDqoP4JikeeZfRBxRX3bw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v5 0/3] linux-headers: arch fixups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, James Hogan <jhogan@kernel.org>

On Mon, May 14, 2018 at 11:17:14AM +0100, Peter Maydell wrote:
> On 11 May 2018 at 22:32, Michael S. Tsirkin <mst@redhat.com> wrote:
> > It turns out that we have unistd.h and kvm headers for some
> > architectures but not others.  We are thus unable to use e.g. usefaultfd
> > on these systems unless system headers have been updated.
> >
> > Fix up update-linux-headers.sh to make sure we auto-updates
> > all architectures which have linux-headers/
> > (unfortunately this still does not mean "all linux systems").
> >
> > Tested on x86 only.
> >
> > Pls consider merging this through the ARM tree.
> >
> > changes from v4:
> >     dropped s390 chunks - already upstream
> >
> > Michael S. Tsirkin (3):
> >   update-linux-headers.sh: unistd.h, kvm consistency
> >   linux-headers: add unistd.h on all arches
> >   linux-headers: add kvm header for mips
> 
> Hi. Patch 1 doesn't seem to apply to current master -- could you
> rebase and resend, please?
> 
> thanks
> -- PMM

Done, v6 posted.
