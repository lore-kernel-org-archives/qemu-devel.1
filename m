Received: from eggs.gnu.org ([2001:4830:134:3::10]:42281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dVE5H-0005WQ-Dm
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 05:37:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dVE5C-0000fu-Hu
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 05:37:27 -0400
Date: Wed, 12 Jul 2017 17:37:15 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170712093715.GJ29326@pxdev.xzpeter.org>
References: <CAOE=1Z3ve+zQJbjqqfNA1iB_mNgFkoTTXRxyBikSiJ5_AZwpiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOE=1Z3ve+zQJbjqqfNA1iB_mNgFkoTTXRxyBikSiJ5_AZwpiA@mail.gmail.com>
Subject: Re: [Qemu-devel] How to stop `qemu-system-x86_64 ...` instead of
 `kill -9`?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sam <batmanustc@gmail.com>
Cc: qemu-discuss@nongnu.org, qemu-devel@nongnu.org

On Wed, Jul 12, 2017 at 05:24:40PM +0800, Sam wrote:
> hi all,
> 
> I'm running `qemu-system-x86_64 ...` to start a guest vm. Now I want to
> stop and destroy this vm, I found there is no `qemu-stop` related command,
> so I have to `kill -9` this process.
> 
> How could I stop `qemu-system-x86_64` instead of `kill -9`? Use `virsh`
> command or something?

"virsh destroy $name"? Or "quit" in qemu QMP/HMP?

(I'd say I use kill a lot, especially when I'm using -nographic)

-- 
Peter Xu
