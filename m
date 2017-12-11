Received: from eggs.gnu.org ([2001:4830:134:3::10]:60247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eOMVf-0005SD-5P
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 06:44:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eOMVe-0003KJ-Ga
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 06:44:35 -0500
Date: Mon, 11 Dec 2017 19:44:25 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171211114425.GD3350@lemon>
References: <20171211093314.16974-1-famz@redhat.com>
	<20171211095044.GA7707@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171211095044.GA7707@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH v3] qemu-img: Document --force-share / -U
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, kchamart@redhat.com, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, stefanha@redhat.com

On Mon, 12/11 10:50, Kevin Wolf wrote:
> Am 11.12.2017 um 10:33 hat Fam Zheng geschrieben:
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > 
> > ---
> > 
> > v3: Document that the option is not allowed for read-write. [Stefan]
> > 
> > v2: - "code{qemu-img}". [Kashyap, Eric]
> >     - "etc.." -> "etc.".
> > ---
> >  qemu-img.texi | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/qemu-img.texi b/qemu-img.texi
> > index fdcf120f36..d85ace73f0 100644
> > --- a/qemu-img.texi
> > +++ b/qemu-img.texi
> > @@ -57,6 +57,15 @@ exclusive with the @var{-O} parameters. It is currently required to also use
> >  the @var{-n} parameter to skip image creation. This restriction may be relaxed
> >  in a future release.
> >  
> > +@item --force-share (-U)
> > +
> > +If specified, @code{qemu-img} will open the image with shared permissions,
> > +which makes it less likely to conflict with a running guest's permissions due
> > +to image locking. For example, this can be used to get the image information
> > +(with 'info' subcommand) when the image is used by a running guest. Note that
> > +this could produce inconsistent result because of concurrent metadata changes,
> > +etc. This option is only allowed when opening image in read-only mode.
> 
> I think "an image", "the image" or "images" could all work in this
> context, but just "image" without an article doesn't.

"Images" would be my intent if I proofread it, but you're right, all sound okay
to me. Thanks.

Fam
