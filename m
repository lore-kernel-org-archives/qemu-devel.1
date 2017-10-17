Received: from eggs.gnu.org ([2001:4830:134:3::10]:43796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1e4TJU-000299-Dn
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 10:57:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1e4TJT-0008Rt-NJ
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 10:57:48 -0400
References: <20171017144051.8452-1-lprosek@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <7ac8f033-44e2-8955-9dd7-e11595081356@vivier.eu>
Date: Tue, 17 Oct 2017 16:57:34 +0200
MIME-Version: 1.0
In-Reply-To: <20171017144051.8452-1-lprosek@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH trivial] Remove empty
 statements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ladi Prosek <lprosek@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: lersek@redhat.com

Le 17/10/2017 à 16:40, Ladi Prosek a écrit :
> Thanks to Laszlo Ersek for spotting the double semicolon in target/i386/kvm.c
> 
> I have trivially grepped the tree for ';;' in C files.
> 
> Suggested-by: Laszlo Ersek <lersek@redhat.com>
> Signed-off-by: Ladi Prosek <lprosek@redhat.com>
> ---
>  hw/misc/imx6_ccm.c     | 2 +-
>  hw/s390x/virtio-ccw.c  | 2 +-
>  linux-user/signal.c    | 2 +-
>  migration/block.c      | 2 +-
>  target/i386/cpu.c      | 2 +-
>  target/i386/kvm.c      | 2 +-
>  target/sh4/translate.c | 2 +-
>  7 files changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
