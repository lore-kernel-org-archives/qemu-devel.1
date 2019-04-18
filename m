Received: from eggs.gnu.org ([209.51.188.92]:60752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hGyZM-0005sc-4l
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 00:22:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hGyZJ-0002WL-Su
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 00:22:39 -0400
References: <20190417220147.67648-1-stephen.checkoway@oberlin.edu>
	<20190417220147.67648-4-stephen.checkoway@oberlin.edu>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d6aedf1f-0928-8385-4c8b-4e20fc21f2b4@redhat.com>
Date: Thu, 18 Apr 2019 06:22:08 +0200
MIME-Version: 1.0
In-Reply-To: <20190417220147.67648-4-stephen.checkoway@oberlin.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 03/10] block/pflash_cfi02: Fix command
 address comparison
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
> Most AMD commands only examine 11 bits of the address. This masks the
> addresses used in the comparison to 11 bits. The exceptions are word or
> sector addresses which use offset directly rather than the shifted
> offset, boff.
> 
> Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
> ---
>  hw/block/pflash_cfi02.c   |  8 +++++++-
>  tests/pflash-cfi02-test.c | 12 ++++++++++--
>  2 files changed, 17 insertions(+), 3 deletions(-)

Acked-by: Thomas Huth <thuth@redhat.com>
