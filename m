Received: from eggs.gnu.org ([2001:4830:134:3::10]:53431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSjJn-0007bN-4G
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 08:22:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSjJk-0007Ff-0F
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 08:22:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34908)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dSjJj-0007FR-Pr
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 08:22:03 -0400
Date: Wed, 5 Jul 2017 20:22:00 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170705122200.GH29382@lemon.lan>
References: <1499237876.3041.4.camel@linux.intel.com>
	<20170705110431.GE22008@redhat.com>
	<20170705114411.GE29382@lemon.lan>
	<c1f43fc3-7db8-50af-ee8c-331895721bd6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1f43fc3-7db8-50af-ee8c-331895721bd6@redhat.com>
Subject: Re: [Qemu-devel] change x86 default machine type to Q35?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, qemu-devel@nongnu.org

On Wed, 07/05 13:58, Thomas Huth wrote:
> On 05.07.2017 13:44, Fam Zheng wrote:
> > On Wed, 07/05 12:04, Daniel P. Berrange wrote:
> >> While you can say people should just add '-M pc' that isn't a nice
> >> user experiance, because it makes the assumption that people actually
> >> understand what caused their breakage. When the incompatibilities
> >> arise the error messages are unlikely to give any hint to users that
> >> the problems are caused by the machine type change. So unless someone
> >> is very familiar with debugging QEMU, they're not going to realize
> >> that '-M pc' will fix their problem.
> > 
> > While we change the default, can we start to print a message like 'machine type
> > ("-M" option) not specified, default to Q35. If you find compatibility issues,
> > try "-M pc"'?
> 
> Or we could simply remove the default machine type completely for a
> couple of releases? That would force people to update their script with
> "-M pc" ... and once this has been established, we can finally make q35
> the default?

I wouldn't do that.. Defaults are for those who don't care about setting it, or
want something that just works, by default. It's fine not to provide a default
machine type if we decide there isn't a clear win, just like arm, but IMHO
removing it just to restore it later in order to educate people makes a very
poor experience.

Fam
