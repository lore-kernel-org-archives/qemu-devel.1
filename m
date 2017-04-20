Received: from eggs.gnu.org ([2001:4830:134:3::10]:39692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d12lN-0000c3-Jn
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 23:28:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d12lM-0007Ac-OR
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 23:28:09 -0400
Date: Thu, 20 Apr 2017 11:27:56 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170420032756.GA24486@lemon.lan>
References: <20170314023933.12118-1-famz@redhat.com>
	<20170314023933.12118-3-famz@redhat.com>
	<0f1ecad6-9e85-39a2-6d52-5481f7e309cb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f1ecad6-9e85-39a2-6d52-5481f7e309cb@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC 2/3] qemu-img: Add --unsafe-read option
 to subcommands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Tue, 04/18 08:20, Eric Blake wrote:
> bool, please.  (Just because existing code is lousy with using an int
> for a bool doesn't mean we should perpetuate it)

OK, will fix.

> 
> 
> > @@ -3033,6 +3085,9 @@ static int img_rebase(int argc, char **argv)
> >          case OPTION_IMAGE_OPTS:
> >              image_opts = true;
> >              break;
> > +        case 'U':
> > +            unsafe_read = 1;
> 
> s/1/true/
> 
> Good patch, but missing documentation updates to --help/man page.  So,
> as encouragement to add that when you drop the RFC, I'll withhold my R-b
> until then. ;)

Yes, I'll add another patch for ease of review.

Fam
