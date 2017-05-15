Received: from eggs.gnu.org ([2001:4830:134:3::10]:39753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dAC31-0002vq-QB
	for qemu-devel@nongnu.org; Mon, 15 May 2017 05:12:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dAC30-0000LN-Sp
	for qemu-devel@nongnu.org; Mon, 15 May 2017 05:12:11 -0400
Date: Mon, 15 May 2017 17:12:00 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170515091200.GB23262@lemon.lan>
References: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
	<1494513181-7900-6-git-send-email-kwolf@redhat.com>
	<a4c0213e-7a34-1abe-55bb-89ca7660ef3a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4c0213e-7a34-1abe-55bb-89ca7660ef3a@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PULL 05/58] qemu-img: Update
 documentation for -U
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org

On Fri, 05/12 19:37, Max Reitz wrote:
> On 2017-05-11 16:32, Kevin Wolf wrote:
> > From: Fam Zheng <famz@redhat.com>
> > 
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  qemu-img-cmds.hx | 36 ++++++++++++++++++------------------
> >  1 file changed, 18 insertions(+), 18 deletions(-)
> > 
> > diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
> > index bf4ce59..e5bc28f 100644
> > --- a/qemu-img-cmds.hx
> > +++ b/qemu-img-cmds.hx
> 
> [...]
> 
> >  DEF("convert", img_convert,
> > -    "convert [--object objectdef] [--image-opts] [-c] [-p] [-q] [-n] [-f fmt] [-t cache] [-T src_cache] [-O output_fmt] [-B backing_file] [-o options] [-s snapshot_id_or_name] [-l snapshot_param] [-S sparse_size] [-m num_coroutines] [-W] filename [filename2 [...]] output_filename")
> > +    "convert [--object objectdef] [--image-opts] [-U] [-c] [-p] [-q] [-n] [-f fmt] [-t cache] [-T src_cache] [-O output_fmt] [-o options] [-s snapshot_id_or_name] [-l snapshot_param] [-S sparse_size] [-m num_coroutines] [-W] filename [filename2 [...]] output_filename")
> >  STEXI
> > -@item convert [--object @var{objectdef}] [--image-opts] [-c] [-p] [-q] [-n] [-f @var{fmt}] [-t @var{cache}] [-T @var{src_cache}] [-O @var{output_fmt}] [-B @var{backing_file}] [-o @var{options}] [-s @var{snapshot_id_or_name}] [-l @var{snapshot_param}] [-S @var{sparse_size}] [-m @var{num_coroutines}] [-W] @var{filename} [@var{filename2} [...]] @var{output_filename}
> > +@item convert [--object @var{objectdef}] [--image-opts] [-U] [-c] [-p] [-q] [-n] [-f @var{fmt}] [-t @var{cache}] [-T @var{src_cache}] [-O @var{output_fmt}] [-o @var{options}] [-s @var{snapshot_id_or_name}] [-l @var{snapshot_param}] [-S @var{sparse_size}] [-m @var{num_coroutines}] [-W] @var{filename} [@var{filename2} [...]] @var{output_filename}
> 
> Soo... Who gets to add the -B documentation back?
> 

Oops, lost during a rebase, must be.

I'll send a patch! Thanks for catching this.

Fam
