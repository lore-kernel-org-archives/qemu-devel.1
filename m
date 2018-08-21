Received: from eggs.gnu.org ([2001:4830:134:3::10]:43086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1frzOL-0005Tq-DT
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 01:39:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1frzOF-0000fk-IX
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 01:39:45 -0400
Date: Tue, 21 Aug 2018 07:39:32 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180821053932.atekhme4w7waw2oh@sirius.home.kraxel.org>
References: <20180807221830.3844-1-peter@lekensteyn.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807221830.3844-1-peter@lekensteyn.nl>
Subject: Re: [Qemu-devel] [PATCH] vnc: fix memleak of the
 "vnc-worker-output" name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Wu <peter@lekensteyn.nl>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org

On Wed, Aug 08, 2018 at 12:18:30AM +0200, Peter Wu wrote:
> Fixes repeated memory leaks of 18 bytes when using VNC:
> 
>     Direct leak of 831024 byte(s) in 46168 object(s) allocated from:
>         ...
>         #4 0x7f6d2f919bdd in g_strdup_vprintf glib/gstrfuncs.c:514
>         #5 0x56085cdcf660 in buffer_init util/buffer.c:59
>         #6 0x56085ca6a7ec in vnc_async_encoding_start ui/vnc-jobs.c:177
>         #7 0x56085ca6b815 in vnc_worker_thread_loop ui/vnc-jobs.c:240
> 
> Fixes: 543b95801f98 ("vnc: attach names to buffers")
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> CC: qemu-stable@nongnu.org
> Signed-off-by: Peter Wu <peter@lekensteyn.nl>

Added to ui queue.

thanks,
  Gerd
