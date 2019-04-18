Received: from eggs.gnu.org ([209.51.188.92]:33201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hGyco-0007fR-W2
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 00:26:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hGyce-0004Cy-M5
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 00:26:10 -0400
References: <20190417220147.67648-1-stephen.checkoway@oberlin.edu>
	<20190417220147.67648-6-stephen.checkoway@oberlin.edu>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9e1b8e19-a40a-5070-0815-9e783435d542@redhat.com>
Date: Thu, 18 Apr 2019 06:25:29 +0200
MIME-Version: 1.0
In-Reply-To: <20190417220147.67648-6-stephen.checkoway@oberlin.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 05/10] block/pflash_cfi02: Implement
 nonuniform sector sizes
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
> Some flash chips support sectors of different sizes. For example, the
> AMD AM29LV160DT has 31 64 kB sectors, one 32 kB sector, two 8 kB
> sectors, and a 16 kB sector, in that order. The AM29LV160DB has those in
> the reverse order.
> 
> The `num-blocks` and `sector-length` properties work exactly as they did
> before: a flash device with uniform sector lengths. To get non-uniform
> sector lengths for up to four regions, the following properties may be
> set
> - region 0. `num-blocks0` and `sector-length0`;
> - region 1. `num-blocks1` and `sector-length1`;
> - region 2. `num-blocks2` and `sector-length2`; and
> - region 3. `num-blocks3` and `sector-length3`.
> 
> If the uniform and nonuniform properties are set, then both must specify
> a flash device with the same total size. It would be better to disallow
> both being set, or make `num-blocks0` and `sector-length0` alias
> `num-blocks` and `sector-length`, but that would make testing currently
> impossible.
> 
> Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
> ---
>  hw/block/pflash_cfi02.c   | 177 +++++++++++++++++++++++++-----------
>  tests/pflash-cfi02-test.c | 185 ++++++++++++++++++++++++++++----------
>  2 files changed, 265 insertions(+), 97 deletions(-)

Acked-by: Thomas Huth <thuth@redhat.com>
