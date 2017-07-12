Received: from eggs.gnu.org ([2001:4830:134:3::10]:55188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dVEvk-0001TI-E0
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 06:31:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dVEvf-0006qH-CW
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 06:31:40 -0400
Date: Wed, 12 Jul 2017 18:31:31 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170712103131.GA11040@lemon>
References: <CAOE=1Z3ve+zQJbjqqfNA1iB_mNgFkoTTXRxyBikSiJ5_AZwpiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOE=1Z3ve+zQJbjqqfNA1iB_mNgFkoTTXRxyBikSiJ5_AZwpiA@mail.gmail.com>
Subject: Re: [Qemu-devel] [Qemu-discuss] How to stop `qemu-system-x86_64
 ...` instead of `kill -9`?
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

On Wed, 07/12 17:24, Sam wrote:
> hi all,
> 
> I'm running `qemu-system-x86_64 ...` to start a guest vm. Now I want to
> stop and destroy this vm, I found there is no `qemu-stop` related command,
> so I have to `kill -9` this process.

If you have a "monitor", send "quit" command is the right way. The simplest type
of monitor (HMP on your console) is with the option "-monitor stdio".

Even without monitors, SIGKILL is likely overkill. QEMU responds to SIGTERM and
SIGINT more gracefully.

Fam
