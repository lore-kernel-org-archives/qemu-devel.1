Received: from eggs.gnu.org ([2001:4830:134:3::10]:37661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dGVfe-0003Ly-GG
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 15:22:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dGVfd-0003mz-K5
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 15:22:10 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:44536)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dGVfd-0003km-Em
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 15:22:09 -0400
Date: Thu, 1 Jun 2017 21:22:06 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170601192206.3z6yki3sji5efrjc@aurel32.net>
References: <87d1ar504h.fsf@dusky.pond.sub.org>
	<13985c6d-d24a-ac50-2708-fc3b9cc64acd@redhat.com>
	<87h902l8qd.fsf@dusky.pond.sub.org>
	<6a6a91cc-7ea1-2b45-a4bd-31aa3cfef917@redhat.com>
	<20170531070346.GE14845@pxdev.xzpeter.org>
	<1633113774.3648008.1496216414543.JavaMail.zimbra@redhat.com>
	<20170531082651.GJ14845@pxdev.xzpeter.org>
	<1013114653.3661277.1496219327691.JavaMail.zimbra@redhat.com>
	<2c763ebf-d11e-f414-a2cf-f7117ea6d4fb@redhat.com>
	<c666d24d-c8fc-ea77-af25-7f528aee0a81@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c666d24d-c8fc-ea77-af25-7f528aee0a81@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] msi: remove return code for msi_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>, Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>, Paul Burton <paul.burton@imgtec.com>

On 2017-06-01 16:23, Paolo Bonzini wrote:
> 
> 
> On 01/06/2017 10:27, Marcel Apfelbaum wrote:
> > On 31/05/2017 11:28, Paolo Bonzini wrote:
> >> No, for now I'd rather just go and remove msi_nonbroken.  When someone
> >> reports a bug, we can add back "msi_broken".
> > 
> > Hi,
> > I agree with the direction, but I am concerned msi_nonbroken is there
> > for a reason.
> > We might break some (obscure/not in use) machine.
> > Maybe we should CC all arch machine maintainers/contributors to give
> > them a chance to object...
> 
> Yeah, Alpha, MIPS and SH are those that support PCI.  Adding Richard and
> Aurelien, do your platforms support MSI on real hardware but not in QEMU?

SH clearly doesn't support MSI.

The oldest MIPS board also do not support MSI, but I guess the Boston
board might support it. I am adding Paul Burton in Cc: who probably
knows about that.

Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
