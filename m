Received: from eggs.gnu.org ([2001:4830:134:3::10]:47049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cjHil-0004r1-1Z
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 22:48:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cjHik-0004wq-4D
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 22:48:03 -0500
Date: Wed, 1 Mar 2017 22:47:57 -0500
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170302034757.GA16314@localhost.localdomain>
References: <20170228163436.31357-1-jcody@redhat.com>
	<CAFEAcA_WQWnSTz8_oJ1qwGsVKKJtoQpyQXLYLEQFPNMEHp8ueg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_WQWnSTz8_oJ1qwGsVKKJtoQpyQXLYLEQFPNMEHp8ueg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL v2 0/5] Block patches for 2.9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Wed, Mar 01, 2017 at 04:30:55PM +0000, Peter Maydell wrote:
> On 28 February 2017 at 16:34, Jeff Cody <jcody@redhat.com> wrote:
> > The following changes since commit c8c0a1a784cdf70ecea50e93213137c6c89337a7:
> >
> >   Merge remote-tracking branch 'remotes/cody/tags/block-pull-request' into staging (2017-02-28 13:41:03 +0000)
> >
> > are available in the git repository at:
> >
> >   git@github.com:codyprime/qemu-kvm-jtc.git tags/block-pull-request
> >
> > for you to fetch changes up to 7a4bdbdd818fba3fb6c79d23baa3c7cb928be661:
> >
> >   block/rbd: add support for 'mon_host', 'auth_supported' via QAPI (2017-02-28 11:32:46 -0500)
> >
> > ----------------------------------------------------------------
> > Block patches for 2.9 - rbd blockdev-add.  Added s-o-b's.
> > ----------------------------------------------------------------
> 
> Doesn't build on some compilers:
> 
> /home/petmay01/qemu/block/rbd.c: In function 'qemu_rbd_array_opts':
> /home/petmay01/qemu/block/rbd.c:605:5: error: 'for' loop initial
> declarations are only allowed in C99 or C11 mode
>      for (int i = 0; i < num_entries; i++) {
>      ^
> /home/petmay01/qemu/block/rbd.c:605:5: note: use option -std=c99,
> -std=gnu99, -std=c11 or -std=gnu11 to compile your code
> 
> Variable declaration has to go at the top of a block,
> not inside a for().


I just sent a v3.  I'm traveling, and have limited connectivity, so I could
only do a quick sanity compile check for the pull req.  But the diff is only
2 lines, to move the int i declaration up.


-Jeff
