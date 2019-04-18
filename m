Received: from eggs.gnu.org ([209.51.188.92]:37521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hGz2H-0004xb-5i
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 00:52:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hGz2D-0002w6-76
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 00:52:32 -0400
References: <20190417220147.67648-1-stephen.checkoway@oberlin.edu>
	<20190417220147.67648-9-stephen.checkoway@oberlin.edu>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2b6e60dc-9484-ffd4-afb5-6be792ee586d@redhat.com>
Date: Thu, 18 Apr 2019 06:52:16 +0200
MIME-Version: 1.0
In-Reply-To: <20190417220147.67648-9-stephen.checkoway@oberlin.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 08/10] block/pflash_cfi02: Implement
 multi-sector erase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stephen Checkoway <stephen.checkoway@oberlin.edu>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 18/04/2019 00.01, Stephen Checkoway wrote:
> After two unlock cycles and a sector erase command, the AMD flash chips
> start a 50 us erase time out. Any additional sector erase commands add a
> sector to be erased and restart the 50 us timeout. During the timeout,
> status bit DQ3 is cleared. After the time out, DQ3 is asserted during
> erasure.
> 
> Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
> ---
>  hw/block/pflash_cfi02.c   | 94 +++++++++++++++++++++++++++++++--------
>  tests/pflash-cfi02-test.c | 59 ++++++++++++++++++++++--
>  2 files changed, 131 insertions(+), 22 deletions(-)

Acked-by: Thomas Huth <thuth@redhat.com>
