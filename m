Received: from eggs.gnu.org ([2001:4830:134:3::10]:39921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d12mZ-0001Ar-Fk
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 23:29:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d12mY-0007MN-Qy
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 23:29:23 -0400
Date: Thu, 20 Apr 2017 11:29:14 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170420032914.GB24486@lemon.lan>
References: <20170314023933.12118-1-famz@redhat.com>
	<20170314023933.12118-4-famz@redhat.com>
	<811911cd-a8c9-90d2-2186-33f4db0a9af1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <811911cd-a8c9-90d2-2186-33f4db0a9af1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC 3/3] qemu-io: Add --unsafe-read option
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

On Tue, 04/18 08:27, Eric Blake wrote:
> On 03/13/2017 09:39 PM, Fam Zheng wrote:
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >  qemu-io.c | 28 +++++++++++++++++++++-------
> >  1 file changed, 21 insertions(+), 7 deletions(-)
> > 
> > @@ -108,6 +112,7 @@ static void open_help(void)
> >  " -r, -- open file read-only\n"
> >  " -s, -- use snapshot file\n"
> >  " -n, -- disable host cache, short for -t none\n"
> > +" -U, -- accept unsafe opening of the image even if it's in use by another process\n"
> 
> Long line (exceeds 80 columns of output); can we shorten it?  Maybe
> 
>  -U, allow unsafe reads when another process is writing
> 
> You did get 'qemu-io -c "help open"' adjusted, but I don't see where you
> adjusted 'qemu-io --help'.  Since both places gained a -U, you still
> need more documentation. But at least there is no man page to worry
> about here.

Sounds good. will fix both issues.

Many thanks for the review!

Fam
