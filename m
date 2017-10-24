Received: from eggs.gnu.org ([2001:4830:134:3::10]:48202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=463142844=Ian.Jackson@citrix.com>)
	id 1e73nX-0005ao-7x
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 14:19:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=463142844=Ian.Jackson@citrix.com>)
	id 1e73nS-0004oM-Fe
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 14:19:31 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:16179)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=463142844=Ian.Jackson@citrix.com>)
	id 1e73nS-0004nn-9t
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 14:19:26 -0400
From: Ian Jackson <ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-ID: <23023.33822.864007.643155@mariner.uk.xensource.com>
Date: Tue, 24 Oct 2017 19:19:10 +0100
In-Reply-To: <20171024172911.GH1885@perard.uk.xensource.com>
References: <23017.64539.31230.43449@mariner.uk.xensource.com>
	<1508506702-17704-1-git-send-email-ian.jackson@eu.citrix.com>
	<1508506702-17704-7-git-send-email-ian.jackson@eu.citrix.com>
	<20171024172911.GH1885@perard.uk.xensource.com>
Subject: Re: [Qemu-devel] [PATCH v5.1 7/8] os-posix: Provide new -runas
 <uid>:<gid> facility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony PERARD <anthony.perard@citrix.com>
Cc: qemu-devel@nongnu.org, Ross Lagerwall <ross.lagerwall@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org

Anthony PERARD writes ("Re: [PATCH v5.1 7/8] os-posix: Provide new -runas <uid>:<gid> facility"):
> On Fri, Oct 20, 2017 at 02:38:21PM +0100, Ian Jackson wrote:
> > +static bool os_parse_runas_uid_gid(const char *optarg)
...
> > +    errno = 0;
> > +    lv = strtoul(optarg, &ep, 0); /* can't qemu_strtoul, want *ep==':' */
> 
> Should strtoul base be 10? If that matter.

If someone wants to write uids in hex then I don't see a reason to
stop them...

> > -        if (!user_pwd) {
> > -            fprintf(stderr, "User \"%s\" doesn't exist\n", optarg);
> > +        if (!user_pwd && !os_parse_runas_uid_gid(optarg)) {
> > +            fprintf(stderr,
> > +                    "User \"%s\" doesn't exist (and is not <uid>.<gid>)\n",
> 
> The error message have not been update, I think it should be <uid>:<gid>

Oops.

> With the error message fix:
> Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>

Thanks,
Ian.
