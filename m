Received: from eggs.gnu.org ([2001:4830:134:3::10]:54908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSUjk-0008DR-Gu
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 17:52:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSUjg-0007sA-Kl
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 17:52:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38790)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fSUjg-0007rx-F0
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 17:52:24 -0400
Date: Mon, 11 Jun 2018 18:52:17 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180611215217.GD7451@localhost.localdomain>
References: <20180608205830.308627-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180608205830.308627-1-mst@redhat.com>
Subject: Re: [Qemu-devel] [RFC untested PATCH] i386/cpu: make -cpu host
 support monitor/mwait
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Fri, Jun 08, 2018 at 11:59:19PM +0300, Michael S. Tsirkin wrote:
> When guest CPU PM is enabled, and with -cpu host, expose the host CPU
> MWAIT leaf to guest so guest can make good PM decisions.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> 
> This builds but is untested. Is this a reasonable way to go about it?

Looks good to me.

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
