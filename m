Received: from eggs.gnu.org ([2001:4830:134:3::10]:55336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=44954d255=Ian.Jackson@citrix.com>)
	id 1e23O7-0005W7-1w
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 18:52:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=44954d255=Ian.Jackson@citrix.com>)
	id 1e23O3-0004kU-Si
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 18:52:35 -0400
Received: from smtp.citrix.com ([66.165.176.89]:21360)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=44954d255=Ian.Jackson@citrix.com>)
	id 1e23O3-0004k6-JW
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 18:52:31 -0400
From: Ian Jackson <ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-ID: <23004.65334.590683.3590@mariner.uk.xensource.com>
Date: Tue, 10 Oct 2017 18:11:18 +0100
In-Reply-To: <878tgjla6b.fsf@dusky.pond.sub.org>
References: <1507133891-26013-1-git-send-email-ian.jackson@eu.citrix.com>
	<1507133891-26013-8-git-send-email-ian.jackson@eu.citrix.com>
	<877ew4ub3u.fsf@dusky.pond.sub.org>
	<23003.36902.664875.346194@mariner.uk.xensource.com>
	<878tgjla6b.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH 7/8] os-posix: Provide new -runasid option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org, Ross Lagerwall <ross.lagerwall@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org, xen-devel@nongnu.org

Markus Armbruster writes ("Re: [Qemu-devel] [PATCH 7/8] os-posix: Provide new -runasid option"):
> Actually, a numeric UID without group name or ID could be made to work
> just fine as long as it maps to a user name.  The use case may not be
> worth the bother, though.

In libxl's use case, it wouldn't map to a name.

> Using '.' to separate user and group is suboptimal, because POSIX
> portable user and group names may contain it:
...
> Coreutils uses ':'.  Let's follow its lead.

I'm happy to change it to use `:'.

Can you confirm that this command line interface is then OK ?
We would like to stablise the corresponding code in libxl...

Ian.
