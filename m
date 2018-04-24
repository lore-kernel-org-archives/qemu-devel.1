Received: from eggs.gnu.org ([2001:4830:134:3::10]:55091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fB0AK-0000Ni-AT
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:47:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fB0AF-00037x-FT
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:47:36 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:33451)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fB0AF-00037e-As
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:47:31 -0400
Date: Tue, 24 Apr 2018 11:47:30 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180424154730.GB22209@flamenco>
References: <20180424045112.12963-1-peterx@redhat.com>
	<20180424045112.12963-4-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424045112.12963-4-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 3/4] QemuMutex: support
 --enable-debug-mutex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Tue, Apr 24, 2018 at 12:51:11 +0800, Peter Xu wrote:
> We have had some tracing tools for mutex but it's not easy to use them
> for e.g. dead locks.  Let's provide "--enable-debug-mutex" parameter
> when configure to allow QemuMutex to store the last owner that took
> specific lock.  It will be easy to use this tool to debug deadlocks
> since we can directly know who took the lock then as long as we can have
> a debugger attached to the process.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Emilio G. Cota <cota@braap.org>

		E.
