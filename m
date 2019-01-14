Received: from eggs.gnu.org ([209.51.188.92]:43101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjBb1-0005Af-6P
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 18:24:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjBb0-0006Sd-FY
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 18:24:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38810)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gjBb0-0006S4-9v
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 18:24:42 -0500
Date: Mon, 14 Jan 2019 18:24:36 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190114182425-mutt-send-email-mst@kernel.org>
References: <20181215120353.82786-1-liq3ea@163.com>
	<20181215120353.82786-4-liq3ea@163.com>
	<ed598a9a-ea9d-044e-1677-679a658676b0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed598a9a-ea9d-044e-1677-679a658676b0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] util: check the return value of
 fcntl in qemu_set_{block, nonblock}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Li Qiang <liq3ea@163.com>, lvivier@redhat.com, peter.maydell@linaro.org, jasowang@redhat.com, liq3ea@gmail.com, qemu-devel@nongnu.org, marcandre.lureau@redhat.com, pbonzini@redhat.com

On Wed, Jan 02, 2019 at 03:07:24PM +0100, Thomas Huth wrote:
> On 2018-12-15 13:03, Li Qiang wrote:
> > Assert that the return value is not an error. This is like commit
> > 7e6478e7d4f for qemu_set_cloexec.
> > 
> > Signed-off-by: Li Qiang <liq3ea@163.com>
> > ---
> >  util/oslib-posix.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> > index c1bee2a581..4ce1ba9ca4 100644
> > --- a/util/oslib-posix.c
> > +++ b/util/oslib-posix.c
> > @@ -233,14 +233,18 @@ void qemu_set_block(int fd)
> >  {
> >      int f;
> >      f = fcntl(fd, F_GETFL);
> > -    fcntl(fd, F_SETFL, f & ~O_NONBLOCK);
> > +    assert(f != -1);
> > +    f = fcntl(fd, F_SETFL, f & ~O_NONBLOCK);
> > +    assert(f != -1);
> >  }
> >  
> >  void qemu_set_nonblock(int fd)
> >  {
> >      int f;
> >      f = fcntl(fd, F_GETFL);
> > -    fcntl(fd, F_SETFL, f | O_NONBLOCK);
> > +    assert(f != -1);
> > +    f = fcntl(fd, F_SETFL, f | O_NONBLOCK);
> > +    assert(f != -1);
> >  }
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 
> Michael, could you take this patch series through your vhost tree? Or
> shall I pick them up for the qtests tree? In the latter case, please
> provide an ACK for the second patch.

Did not see it merged so I merged it.
