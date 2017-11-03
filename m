Received: from eggs.gnu.org ([2001:4830:134:3::10]:44573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kirill.shutemov@linux.intel.com>) id 1eAeNQ-0002ol-PP
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 11:59:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kirill.shutemov@linux.intel.com>) id 1eAeNM-0002Qz-UP
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 11:59:24 -0400
Received: from mga11.intel.com ([192.55.52.93]:41072)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kirill.shutemov@linux.intel.com>)
	id 1eAeNM-0002Qq-M3
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 11:59:20 -0400
Date: Fri, 3 Nov 2017 18:59:17 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Message-ID: <20171103155917.npedj7ygvi3lw2rz@black.fi.intel.com>
References: <20171103152824.21948-1-marcandre.lureau@redhat.com>
	<20171103152824.21948-2-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171103152824.21948-2-marcandre.lureau@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/2] chardev: fix backend events
 regression with mux chardev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com

On Fri, Nov 03, 2017 at 03:28:23PM +0000, Marc-André Lureau wrote:
> Kirill noticied that on recent versions on QEMU he was not able to
> trigger SysRq to invoke debug capabilites of Linux Kernel.  He tracked
> it down to qemu_chr_be_event() ignoring CHR_EVENT_BREAK due s->be
> being NULL. The bug was introduced in 2.8, commit a4afa548fc6d ("char:
> move front end handlers in CharBackend"). Since the commit, the
> qemu_chr_be_event() failed to deliver CHR_EVENT_BREAK due to
> qemu_chr_fe_init() does not set s->be in case of mux.
> 
> Let's fix this by teaching mux to send an event to the frontend with
> the focus.
> 
> Reported-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Fixes: a4afa548fc6d ("char: move front end handlers in CharBackend")

Works for me.

Tested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
