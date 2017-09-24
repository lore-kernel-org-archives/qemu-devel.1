Received: from eggs.gnu.org ([2001:4830:134:3::10]:40649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dwE9w-0004ND-P1
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 17:09:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dwE9s-0007i9-P8
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 17:09:52 -0400
References: <1505293637-10450-1-git-send-email-thuth@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <bf1d186c-0489-caa8-7da0-f91c8c20b08b@msgid.tls.msk.ru>
Date: Mon, 25 Sep 2017 00:09:47 +0300
MIME-Version: 1.0
In-Reply-To: <1505293637-10450-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/isa/pc87312: Mark the device with
 user_creatable = false
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, qemu-ppc@nongnu.org
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

13.09.2017 12:07, Thomas Huth wrote:
> QEMU currently aborts if you try to use the device at the command
> line:
> 
> $ ppc64-softmmu/qemu-system-ppc64 -S -machine prep -device pc87312
> Unexpected error in qemu_chr_fe_init() at chardev/char-fe.c:222:
> qemu-system-ppc64: -device pc87312: Device 'parallel0' is in use
> Aborted (core dumped)
> 
> It uses parallel_hds in its realize function, so I can not be
> instantiated by the user again.
> 

Applied to -trivial, thanks!

/mjt
