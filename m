Received: from eggs.gnu.org ([2001:4830:134:3::10]:35495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cWSYj-0004iM-4W
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 13:44:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cWSYg-0001NJ-2h
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 13:44:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39310)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcody@redhat.com>) id 1cWSYf-0001N8-Sw
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 13:44:38 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DF669C001690
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 18:44:37 +0000 (UTC)
Date: Wed, 25 Jan 2017 13:44:35 -0500
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170125184435.GA1868@localhost.localdomain>
References: <9a93d47ddba5f86d36cbdf884d86e2fa6f5542ae.1485364872.git.jcody@redhat.com>
	<343adad0-1e18-5777-ad73-3d6fb7be8424@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <343adad0-1e18-5777-ad73-3d6fb7be8424@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] block: check full backing filename
 when searching protocol filenames
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com

On Wed, Jan 25, 2017 at 07:24:48PM +0100, Max Reitz wrote:
> On 25.01.2017 18:22, Jeff Cody wrote:
> > In bdrv_find_backing_image(), if we are searching an image for a backing
> > file that contains a protocol, we currently only compare unmodified
> > paths.
> > 
> > However, some management software will change the backing filename to be
> > a relative filename in a path.  QEMU is able to handle this fine,
> > because internally it will use path_combine to put together the full
> > protocol URI.
> > 
> > However, this can lead to an inability to match an image during a QAPI
> > command that needs to use bdrv_find_backing_image() to find the image,
> > when it is searched by the full URI.
> > 
> > When searching for a protocol filename, if the straight comparison
> > fails, this patch will also compare against the full backing filename to
> > see if that is a match.
> > 
> > Signed-off-by: Jeff Cody <jcody@redhat.com>
> > ---
> >  block.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> 
> Thanks, applied to my block tree:
> 
> https://github.com/XanClic/qemu/commits/block
>

Thanks!

> 
> How much would you mind writing an iotest?

I don't mind, I can do that.

-Jeff
