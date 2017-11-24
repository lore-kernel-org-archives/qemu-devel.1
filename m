Received: from eggs.gnu.org ([2001:4830:134:3::10]:51389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eI9af-0001TE-94
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 03:44:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eI9ac-0002oo-KJ
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 03:44:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44878)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eI9ac-0002o3-Er
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 03:44:02 -0500
Date: Fri, 24 Nov 2017 16:43:59 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171124084359.GE3108@lemon>
References: <20171123135906.12852-1-famz@redhat.com>
	<20171123135906.12852-2-famz@redhat.com>
	<e36d9628-ce26-b019-3573-f1c358467d05@univention.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e36d9628-ce26-b019-3573-f1c358467d05@univention.de>
Subject: Re: [Qemu-devel] [PATCH 1/2] docs: Add image locking subsection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philipp Hahn <hahn@univention.de>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com

On Thu, 11/23 17:07, Philipp Hahn wrote:
> Hello,
> 
> Am 23.11.2017 um 14:59 schrieb Fam Zheng:
> > diff --git a/docs/qemu-block-drivers.texi b/docs/qemu-block-drivers.texi
> > index 1cb1e55686..fa2e90d15f 100644
> > --- a/docs/qemu-block-drivers.texi
> > +++ b/docs/qemu-block-drivers.texi
> > @@ -785,6 +785,42 @@ warning: ssh server @code{ssh.example.com:22} does not support fsync
> ...
> > +To check if image locking is active, check the output of "lslocks" command on
> > +host and see if there are locks held by QEMU process on the image file. More
> > +than one bytes could be locked by a QEMU instance, each byte of which reflects
> 
> "one byte", without the 's'?
> 
> > +a perticular permission that are acquired or protected by the running block
> 
> "particular", 'e' -> 'a'
> 

Yes to both. Thanks!

Fam
