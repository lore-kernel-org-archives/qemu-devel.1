Received: from eggs.gnu.org ([2001:4830:134:3::10]:53948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e4vlx-0006gv-9h
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 17:21:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e4vlu-0008KO-4h
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 17:21:05 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:40539)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1e4vlt-0008JW-T2
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 17:21:02 -0400
Date: Wed, 18 Oct 2017 17:20:59 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20171018212059.GA9118@flamenco>
References: <20171017121714.24714-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171017121714.24714-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] watch_mem_write: implement 8-byte accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Andrew.Baumann@microsoft.com, rth@twiddle.net

On Tue, Oct 17, 2017 at 14:17:14 +0200, Paolo Bonzini wrote:
> Aligned 8-byte memory writes by a 64-bit target on a 64-bit host should
> always turn into atomic 8-byte writes on the host, however a write
> write watchpoint would end up tearing the 8-byte write into two 4-byte

s/write\nwrite/write/

> writes in access_with_adjusted_size().
> 
> Reported-by: Andrew Baumann <Andrew.Baumann@microsoft.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Emilio G. Cota <cota@braap.org>

		E.
