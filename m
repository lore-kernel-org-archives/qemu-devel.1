Received: from eggs.gnu.org ([2001:4830:134:3::10]:58837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dPeZX-0001IS-Ow
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 20:41:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dPeZU-0002Dn-NE
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 20:41:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60722)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dPeZU-0002DP-Go
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 20:41:36 -0400
From: "Eduardo Habkost" <ehabkost@redhat.com>
Date: Mon, 26 Jun 2017 21:41:31 -0300
Message-ID: <20170627004131.GH12152@localhost.localdomain>
References: <20170621052935.20715-1-boqun.feng@gmail.com>
	<20170623133814.GE11773@localhost.localdomain>
	<20170626012144.3ucwsxfcchyba3wv@tardis>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170626012144.3ucwsxfcchyba3wv@tardis>
Subject: Re: [Qemu-devel] [PATCH] target-i386: add Skylake-Server cpu model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Mon, Jun 26, 2017 at 09:23:00AM +0800, Boqun Feng wrote:
> On Fri, Jun 23, 2017 at 10:38:14AM -0300, Eduardo Habkost wrote:
> > On Wed, Jun 21, 2017 at 01:29:34PM +0800, Boqun Feng (Intel) wrote:
> > > Introduce Skylake-Server cpu mode which inherits the features from
> > > Skylake-Client and supports some additional features that are: AVX512,
> > > CWLB and PGPE1GB.
> > 
> > I will fix this to "CLWB" when applying the patch.
> > 
> 
> Oops.. thank you for pointing this out.
> 
[...]
> > 
> > I believe we should add the same comment about XSAVES from
> > Skylake-Cliente here, for consistency:
> > 
> >         /* Missing: XSAVES (not supported by some Linux versions,
> >          * including v4.1 to v4.6).
> >          * KVM doesn't yet expose any XSAVES state save component,
> >          * and the only one defined in Skylake (processor tracing)
> >          * probably will block migration anyway.
> >          */
> > 
> 
> Make sense.
> 
> > I can add it when applying the patch.
> > 
> 
> Please do, thanks! Or you prefer that I send out a V2 with typo fixed
> and comment added?

No need to send v2.  I have already queued the patch + fixes on my
x86-next queue.  Thanks.

-- 
Eduardo
