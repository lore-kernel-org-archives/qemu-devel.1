Received: from eggs.gnu.org ([2001:4830:134:3::10]:55054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cTxhq-00076G-M4
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 16:23:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cTxhn-0001jZ-9N
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 16:23:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42822)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cTxhn-0001iM-3u
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 16:23:43 -0500
Date: Wed, 18 Jan 2017 23:23:40 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170118232247-mutt-send-email-mst@kernel.org>
References: <1484772931-16272-1-git-send-email-mst@redhat.com>
	<1484772931-16272-3-git-send-email-mst@redhat.com>
	<CAFEAcA_92_OZbPQGZ17-bOWwnchN14Y9yKxk362G7-c65-6Q4A@mail.gmail.com>
	<20170118231450-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170118231450-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH v2 2/4] compiler: drop ; after BUILD_BUG_ON
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Richard Henderson <rth@twiddle.net>

On Wed, Jan 18, 2017 at 11:16:07PM +0200, Michael S. Tsirkin wrote:
> On Wed, Jan 18, 2017 at 09:04:03PM +0000, Peter Maydell wrote:
> > On 18 January 2017 at 20:55, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > All users include the trailing ;, let's require that
> > > so that uses such as if (a) QEMU_BUILD_BUG_ON(); do not
> > > produce unexpected results.
> > 
> > When would it ever make sense for a build-time
> > assert to be the only thing inside a runtime
> > conditional anyway?
> > 
> > thanks
> > -- PMM
> 
> What do I know? Do you want to keep the trailing ; in there?
> I can drop this patch.

Maybe a better justification:


QEMU_BUILD_BUG_ON(0)

QEMU_BUILD_BUG_ON(0)

looks ugly but is allowed by the current implementation.
Let's drop the trailing ; within the macro to make sure all
users include the ';'.


> -- 
> MST
