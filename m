Received: from eggs.gnu.org ([2001:4830:134:3::10]:60499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dXGNL-00073j-Ms
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:28:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dXGNH-0002AS-Lz
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:28:31 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:45071)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dXGNH-0002A8-H9
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:28:27 -0400
Date: Mon, 17 Jul 2017 20:28:26 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170718002826.GB7414@flamenco>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
	<1500235468-15341-12-git-send-email-cota@braap.org>
	<02c5e9bd-d2da-fc12-d0bf-b9812a327af0@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02c5e9bd-d2da-fc12-d0bf-b9812a327af0@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v2 11/45] exec-all: bring tb->invalid into
 tb->cflags
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

On Mon, Jul 17, 2017 at 13:07:53 -1000, Richard Henderson wrote:
> On 07/16/2017 10:03 AM, Emilio G. Cota wrote:
> >-    tb->invalid = true;
> >+    tb->cflags |= CF_INVALID;
> 
> Modulo the store_release comment for the last patch,

same thing: note tb_lock is always held when checking the flag, and also
on removal.

		E.
