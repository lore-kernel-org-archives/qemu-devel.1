Received: from eggs.gnu.org ([2001:4830:134:3::10]:53997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=44560dde8=Ian.Jackson@citrix.com>)
	id 1e0TYK-00015W-Pe
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 10:24:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=44560dde8=Ian.Jackson@citrix.com>)
	id 1e0TYG-00008k-RN
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 10:24:36 -0400
Received: from smtp.citrix.com ([66.165.176.89]:46369)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=44560dde8=Ian.Jackson@citrix.com>)
	id 1e0TYG-00007o-KO
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 10:24:32 -0400
From: Ian Jackson <ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-ID: <22999.37405.481769.589894@mariner.uk.xensource.com>
Date: Fri, 6 Oct 2017 15:24:29 +0100
In-Reply-To: <5e5b3443-eb6f-de15-2cd6-35b5c9cf084a@citrix.com>
References: <1507133891-26013-1-git-send-email-ian.jackson@eu.citrix.com>
	<1507133891-26013-8-git-send-email-ian.jackson@eu.citrix.com>
	<5e5b3443-eb6f-de15-2cd6-35b5c9cf084a@citrix.com>
Subject: Re: [Qemu-devel] [PATCH 7/8] os-posix: Provide new -runasid option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ross Lagerwall <ross.lagerwall@citrix.com>
Cc: qemu-devel@nongnu.org, Anthony PERARD <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>, Stefano
	Stabellini <sstabellini@kernel.org>, xen-devel@nongnu.org

Ross Lagerwall writes ("Re: [PATCH 7/8] os-posix: Provide new -runasid option"):
> On 10/04/2017 05:18 PM, Ian Jackson wrote:
> > -        if (setuid(user_pwd->pw_uid) < 0) {
> > +        if (setuid(user_pwd ? user_pwd->pw_uid : user_gid) < 0) {
> >               fprintf(stderr, "Failed to setuid(%d)\n", user_pwd->pw_uid);
> >               exit(1);
> >           }
> 
> This last one should be user_uid, not user_gid.

Thanks, fixed.

Ian.
