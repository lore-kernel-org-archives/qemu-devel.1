Received: from eggs.gnu.org ([2001:4830:134:3::10]:50949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wouter@grep.be>) id 1cGm3B-0001rd-6w
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 07:19:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wouter@grep.be>) id 1cGm3A-0000vf-CM
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 07:19:17 -0500
Date: Tue, 13 Dec 2016 13:18:56 +0100
From: Wouter Verhelst <w@uter.be>
Message-ID: <20161213121856.b7fmjwjfkoeufz4g@grep.be>
References: <20161205234235.5728-1-eblake@redhat.com>
	<20161212181237.3aymdmenxeu2kwjj@grep.be>
	<20161213073812.GA4443@noname.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161213073812.GA4443@noname.str.redhat.com>
Subject: Re: [Qemu-devel] [Nbd] [Qemu-block] [PATCH] doc: Propose
 NBD_FLAG_INIT_ZEROES extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: nbd-general@lists.sourceforge.net, xieyingtai@huawei.com, subo7@huawei.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com

On Tue, Dec 13, 2016 at 08:38:12AM +0100, Kevin Wolf wrote:
> Am 12.12.2016 um 19:12 hat Wouter Verhelst geschrieben:
> > I'm not opposed to this proposal, per se, but there seems to be some
> > disagreement (by Kevin, for instance) on whether this extension is at
> > all useful.
> 
> FWIW, I'm not opposed to adding the flag. I don't think it can hurt, but
> I wanted to ask the question so that we don't end up adding a feature
> that noone actually uses. Ultimately it's your call as a maintainer
> anyway how conservative you want to be with spec additions.

I'm not opposed either, but I do agree with you that we shouldn't add
such a feature if it doesn't end up getting used. Especially so if it
burns a flag in the (16-bit) "transmission flags" field, where space is
at a premium.

-- 
< ron> I mean, the main *practical* problem with C++, is there's like a dozen
       people in the world who think they really understand all of its rules,
       and pretty much all of them are just lying to themselves too.
 -- #debian-devel, OFTC, 2016-02-12
