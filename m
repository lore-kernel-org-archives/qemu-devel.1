Received: from eggs.gnu.org ([2001:4830:134:3::10]:52334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1d89QV-0006QZ-SB
	for qemu-devel@nongnu.org; Tue, 09 May 2017 14:00:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1d89QR-0007hC-56
	for qemu-devel@nongnu.org; Tue, 09 May 2017 13:59:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43960)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcody@redhat.com>) id 1d89QQ-0007gr-V8
	for qemu-devel@nongnu.org; Tue, 09 May 2017 13:59:55 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A984F85376
	for <qemu-devel@nongnu.org>; Tue,  9 May 2017 17:59:52 +0000 (UTC)
Date: Tue, 9 May 2017 13:59:49 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170509175949.GG16494@localhost.localdomain>
References: <1487770954.4687.2.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1487770954.4687.2.camel@redhat.com>
Subject: Re: [Qemu-devel] ipxe for qemu maintainance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Ladi Prosek <lprosek@redhat.com>, Laszlo Ersek <lersek@redhat.com>

On Wed, Feb 22, 2017 at 02:42:34PM +0100, Gerd Hoffmann wrote:
>   Hi folks,
> 
> I'd like to start maintaining qemu-specific branches in our ipxe.git
> repo.  The reason for this are some problems with the upstream ipxe
> maintainance:
> 
>  * The ipxe maintainer apparently is pretty busy.  Often (but not
>    always) it takes weeks or even months to get patches merged upstream,
>    which is bad in case we need a fix included quickly due to freeze
>    deadline approaching ...
>  * There is no release management whatsoever.  No stable branches,
>    no release tags.  Picking up a fix upstream means rebasing to
>    a snapshot which includes the fix.
> 
> So I'd like to improve that downstream with qemu branches, where we can
> commit not-yet merged patches, revert broken patches and cherry-pick
> bugfixes.
> 
> This is *NOT* meant to be a replacement for working with upstream to get
> patches merged and bugs fixed.  But it will allow us to handle things in
> a timely manner without having to depend on the upstream maintainer.
> And we can be more selective about the ipxe patches we accept during
> freeze.
> 
> I plan to also add qemu release tags to the repo, so you can easily
> figure what is included in each qemu release.
> 
> Laszlo created a wiki page for this, naming conventions for branches and
> tags are listed there too:
>         http://wiki.qemu-project.org/IpxeDownstreamForQemu
> 
> Comments?
>

It looks like there were no objections, so I've gone ahead and put you and
Ladi Prosek in the ipxe.git committers.   Let me know if you have any
issues.

Thanks,
Jeff
 
