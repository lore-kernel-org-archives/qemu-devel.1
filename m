Received: from eggs.gnu.org ([2001:4830:134:3::10]:37109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=4484f2008=Ian.Jackson@citrix.com>)
	id 1e1Zck-0005pU-MD
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 11:05:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=4484f2008=Ian.Jackson@citrix.com>)
	id 1e1Zce-0006n5-Ta
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 11:05:42 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:22797)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=4484f2008=Ian.Jackson@citrix.com>)
	id 1e1Zce-0006iI-Nc
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 11:05:36 -0400
From: Ian Jackson <ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-ID: <23003.36902.664875.346194@mariner.uk.xensource.com>
Date: Mon, 9 Oct 2017 16:05:10 +0100
In-Reply-To: <877ew4ub3u.fsf@dusky.pond.sub.org>
References: <1507133891-26013-1-git-send-email-ian.jackson@eu.citrix.com>
	<1507133891-26013-8-git-send-email-ian.jackson@eu.citrix.com>
	<877ew4ub3u.fsf@dusky.pond.sub.org>
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
Cc: qemu-devel@nongnu.org, Juergen Gross <jgross@suse.com>, Stefano
	Stabellini <sstabellini@kernel.org>, Ross Lagerwall <ross.lagerwall@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org, xen-devel@nongnu.org

Markus Armbruster writes ("Re: [Qemu-devel] [PATCH 7/8] os-posix: Provide new -runasid option"):
> The last thing the QEMU command line needs is more exotic options.  Are
> you sure we need a new one here?  Can we make existing -runas serve?
> Precedence: Coreutils[*].  Pseudo-code:
> 
>     if argument is a decimal number starting with '+':
>         user ID
>     else if argument is a valid user name:
>         user name
>     else if argument is a valid user ID:
>         user ID
>     else:
>         error

I can do this.  So -runas <uid>.<gid> then.  I don't think it makes
sense to try to -runas <uid> because: you wouldn't have a username
to pass to initgroups: not calling initgroups would be a bear trap;
and otherwise we wouldn't know what gid to use.

Ian.
