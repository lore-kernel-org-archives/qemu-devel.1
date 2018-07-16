Received: from eggs.gnu.org ([2001:4830:134:3::10]:50936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <krinkin.m.u@gmail.com>) id 1ff8a6-0004mq-9O
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 14:50:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <krinkin.m.u@gmail.com>) id 1ff8a5-0000CP-9X
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 14:50:46 -0400
MIME-Version: 1.0
References: <20180716174146.19845-1-krinkin.m.u@gmail.com>
	<20180716184752.GA30657@redhat.com>
In-Reply-To: <20180716184752.GA30657@redhat.com>
From: Mike Krinkin <krinkin.m.u@gmail.com>
Date: Mon, 16 Jul 2018 19:50:32 +0100
Message-ID: <CACpa5=-1prNeg7DNibyoiADnXVSmXB-5AVBDHQM7MAgXn1CbOw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] opts: fix NULL pointer derefernce in
 get_opt_value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: berrange@redhat.com
Cc: qemu-devel@nongnu.org, armbru@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, qemu-trivial@nongnu.org

On Mon, Jul 16, 2018 at 7:47 PM Daniel P. Berrange <berrange@redhat.com>
wrote:

> On Mon, Jul 16, 2018 at 06:41:46PM +0100, Mike Krinkin wrote:
> > The value argument can be NULL, for example, in hw/i386/multiboot.c
> > in the load_multiboot function get_opt_value is explicitly called
> > with NULL as the second argument.
> >
> > The problem was introduced in commit 950c4e6c94b1 ("opts: don't
> > silently truncate long option values"). This change fixes the
> > problem by adding a check whether the value is NULL or not.
> >
> > Signed-off-by: Mike Krinkin <krinkin.m.u@gmail.com>
> > ---
> >  util/qemu-option.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
>
> This problem is fixed in this:
>
>   https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg01490.html
>
> but it is still waiting for i386 maintainers to respond....
>

Thanks for the update, I searched through the archive briefly but didn't
find this fix, sorry for the noise and please ignore this path.


>
> Regards,
> Daniel
> --
> |: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/
> :|
> |: http://libvirt.org              -o-             http://virt-manager.org
> :|
> |: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/
> :|
>
