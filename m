Received: from eggs.gnu.org ([2001:4830:134:3::10]:57237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=644ea31d5=Ian.Jackson@citrix.com>)
	id 1fAf0i-0003Wp-7W
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 13:12:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=644ea31d5=Ian.Jackson@citrix.com>)
	id 1fAf0e-0002m5-Tc
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 13:12:16 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:36581)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=644ea31d5=Ian.Jackson@citrix.com>)
	id 1fAf0e-0002lV-Kl
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 13:12:12 -0400
From: Ian Jackson <ian.jackson@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Message-ID: <23262.5095.477702.668746@mariner.uk.xensource.com>
Date: Mon, 23 Apr 2018 18:12:07 +0100
In-Reply-To: <20180423163809.GR3267@redhat.com>
References: <1524156319-11465-1-git-send-email-ian.jackson@eu.citrix.com>
	<1524156319-11465-17-git-send-email-ian.jackson@eu.citrix.com>
	<20180423162142.GG1980@perard>	<20180423163809.GR3267@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 16/16] configure: do_compiler: Dump some
 extra info under bash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P.=?iso-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>
Cc: Anthony PERARD <anthony.perard@citrix.com>, Juergen Gross <jgross@suse.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Peter Maydell <peter.maydell@linaro.org>, "Kent R. Spillner" <kspillner@acm.org>, qemu-devel@nongnu.org, Ross Lagerwall <ross.lagerwall@citrix.com>, Paolo
	Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org

Daniel P. Berrangé writes ("Re: [Qemu-devel] [PATCH 16/16] configure: do_compiler: Dump some extra info under bash"):
> Personally I'd suggest we add informative messages throughout the
> configure script for each check being run. If people really hate the
> idea of a verbose output from configure, we could leave it silent by
> default and add a '--verbose' option to turn it on.

Doing that would be a lot of work.  I am not opposed to it, but I am
not going to do it.

My suggestion is a very small change which instantly makes configure
much easier to debug, at least if you have bash available (and the bug
you are fixing doesn't go away with bash).

Please don't let the best be the enemy of an improvement.  If
configure is ever improved (without being simply replaced), the
logging code can easily be removed.

Thanks,
Ian.
