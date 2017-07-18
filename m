Received: from eggs.gnu.org ([2001:4830:134:3::10]:43755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dXKZb-0005pf-IS
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 00:57:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dXKZY-00054e-IN
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 00:57:27 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:52633)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dXKZY-00054M-DF
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 00:57:24 -0400
Date: Tue, 18 Jul 2017 00:57:23 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170718045723.GC12960@flamenco>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
	<1500235468-15341-41-git-send-email-cota@braap.org>
	<2db6160f-7eea-5819-7d6d-61831468830e@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2db6160f-7eea-5819-7d6d-61831468830e@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v2 40/45] osdep: introduce
 qemu_mprotect_rwx/none
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org

On Mon, Jul 17, 2017 at 18:26:09 -1000, Richard Henderson wrote:
> On 07/16/2017 10:04 AM, Emilio G. Cota wrote:
> >+static int qemu_mprotect__osdep(void *addr, size_t size, int prot)
> >+{
> >+    void *start = QEMU_ALIGN_PTR_DOWN(addr, qemu_real_host_page_size);
> >+    void *end = QEMU_ALIGN_PTR_UP(addr + size, qemu_real_host_page_size);
> 
> I'm not keen on this.  Any good reason for it as opposed to asserting that
> the inputs are already page aligned?

No particular reason other than "kept the same behaviour we had".

Let's go with asserts, I like that approach much better actually.

		E.
