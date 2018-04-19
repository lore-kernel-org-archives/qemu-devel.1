Received: from eggs.gnu.org ([2001:4830:134:3::10]:41461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f9ILo-0000Ib-Uf
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 18:48:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f9ILl-00011x-SX
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 18:48:25 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:49801)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1f9ILl-00010Y-Mo
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 18:48:21 -0400
Date: Thu, 19 Apr 2018 18:48:20 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180419224820.GA21323@flamenco>
References: <20180418090622.20073-1-peterx@redhat.com>
	<20180419015631.GE29462@lemon.usersys.redhat.com>
	<20180419031335.GH14841@xz-mi> <20180419194301.GA22127@flamenco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180419194301.GA22127@flamenco>
Subject: Re: [Qemu-devel] [PATCH v2] QemuMutex: support --enable-debug-mutex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

On Thu, Apr 19, 2018 at 15:43:01 -0400, Emilio G. Cota wrote:
> BTW you might also want to add the file/line pair to
> qemu-thread-win32.c, or hide the configure option to Windows
> users.

A few other call sites are missing as well, e.g. when returning from
pthread_cond_wait or with _trylock.

If you grep for trace_qemu_mutex_locked you'll find all the
places where the file/line update should occur.

		Emilio
