Received: from eggs.gnu.org ([2001:4830:134:3::10]:33128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ewN0f-00077Y-Ey
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 03:09:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ewN0e-00010j-Hu
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 03:09:09 -0400
Date: Thu, 15 Mar 2018 15:08:59 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180315070859.GF2733@lemon.usersys.redhat.com>
References: <20180314143841.775212-1-eblake@redhat.com>
	<1c173f5f-3307-7d40-f8b2-58d4be3af615@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c173f5f-3307-7d40-f8b2-58d4be3af615@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for 2.12] iotests: Avoid realpath
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Wed, 03/14 09:47, Eric Blake wrote:
> > The remaining use was using realpath to convert a possibly
> > relative filename into an absolute one before calling diff,
> > but diff works just fine on the relative name.
> 
> Hmm, this last change reverts commit 93e53fb6 that added realpath on purpose
> for ease of diagnosing failed tests.  Maybe it's worth a v2 that tests
> whether realpath exists, and if so uses it, but does a safe fallback to just
> using the filename as-is.

Yes, thanks for spotting that. I am used to do out-of-tree builds/tests and
modifying XXX.out files by copying from .out.bad. Having realpath saves some
typing so..

Your fallback idea sounds good to me.

Fam
