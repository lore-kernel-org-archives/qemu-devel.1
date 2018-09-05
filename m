Received: from eggs.gnu.org ([2001:4830:134:3::10]:34391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fxYj9-0006Kt-0k
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 10:24:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fxYj4-0007Bf-1q
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 10:24:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54184 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fxYj3-0007A4-Pt
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 10:24:09 -0400
Date: Wed, 5 Sep 2018 16:24:04 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180905142404.ztwfcjxznjv6ben6@sirius.home.kraxel.org>
References: <20180824012126.22721-1-famz@redhat.com>
	<8d039be4-486e-e017-88ca-5cb6ebd89519@comstyle.com>
	<20180827090551.4lhug2yvghirb3si@sirius.home.kraxel.org>
	<ca37c453-e198-9ea7-2bed-9b38a17e5170@comstyle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca37c453-e198-9ea7-2bed-9b38a17e5170@comstyle.com>
Subject: Re: [Qemu-devel] [PATCH] tests: vm: auto_install OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brad Smith <brad@comstyle.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

On Wed, Sep 05, 2018 at 08:54:39AM -0400, Brad Smith wrote:
> On 8/27/2018 5:05 AM, Gerd Hoffmann wrote:
> 
> > On Fri, Aug 24, 2018 at 10:36:30AM -0400, Brad Smith wrote:
> > > I very much appreciate the effort to bump up to 6.3 as I was going
> > > to suggest doing that at some point. But bumping up to 6.3 at the
> > > moment will fail with the configure script. We've switched from GCC 4.2
> > > to Clang. The TLS check will fail with Clang's emulated TLS. We've
> > > had a local patch for awhile to fix the test but I don't think it is
> > > appropriate to upstream as is.
> > Hmm, /me looks a bit surprised.
> > Seems to work fine for me ...
> 
> I am quite surprised as well. Something has changed since we first brought
> in Clang
> and this patch no longer seems to be necessary. I just removed it from our
> ports tree.

Cool.  Fam, what is the status here?  There was a slirp patch on the
list, and I guess you also have a updated auto-install patch using that?

cheers,
  Gerd
