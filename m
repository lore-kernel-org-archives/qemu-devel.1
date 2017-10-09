Received: from eggs.gnu.org ([2001:4830:134:3::10]:42554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=4484f2008=Ian.Jackson@citrix.com>)
	id 1e1bIH-0002dN-Sr
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 12:52:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=4484f2008=Ian.Jackson@citrix.com>)
	id 1e1bIE-0001Ru-QA
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 12:52:41 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:2916)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=4484f2008=Ian.Jackson@citrix.com>)
	id 1e1bIE-0001R0-Ik
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 12:52:38 -0400
From: Ian Jackson <ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-ID: <23003.43334.500944.219647@mariner.uk.xensource.com>
Date: Mon, 9 Oct 2017 17:52:22 +0100
In-Reply-To: <20171009152457.GO2954@redhat.com>
References: <1507133891-26013-1-git-send-email-ian.jackson@eu.citrix.com>
	<1507133891-26013-8-git-send-email-ian.jackson@eu.citrix.com>
	<877ew4ub3u.fsf@dusky.pond.sub.org>
	<23003.36902.664875.346194@mariner.uk.xensource.com>
	<20171009152457.GO2954@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 7/8] os-posix: Provide new -runasid option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org, Ross
	Lagerwall <ross.lagerwall@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org, xen-devel@nongnu.org

Daniel P. Berrange writes ("Re: [Qemu-devel] [PATCH 7/8] os-posix: Provide new -runasid option"):
> Just use  getpwuid() to get the "struct passwd *", then change_process_uid()
> doesn't need any changes at all AFAICT.

See my comments in the commit message.  There may be multiple passwd
entries referring to a particular uid.  I think in this area it would
be better to expect the caller to be explicit, rather than taking
getpwuid's notion of the first one.

Ian.
