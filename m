Received: from eggs.gnu.org ([209.51.188.92]:53165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gw108-000590-DU
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 03:43:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gw107-0006Lc-BP
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 03:43:40 -0500
MIME-Version: 1.0
References: <20190218125615.18970-1-armbru@redhat.com>
	<20190218125615.18970-11-armbru@redhat.com>
In-Reply-To: <20190218125615.18970-11-armbru@redhat.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 19 Feb 2019 00:43:26 -0800
Message-ID: <CAMo8BfKk1kPwtqHhfNnP9g6WqwfJ=RPdZgrKsKw7zgbOhc8utQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 10/10] hw/arm hw/xtensa: De-duplicate
 pflash creation code some
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Max Reitz <mreitz@redhat.com>, qemu-ppc <qemu-ppc@nongnu.org>, lersek@redhat.com

On Mon, Feb 18, 2019 at 5:07 AM Markus Armbruster <armbru@redhat.com> wrote:
>
> pflash_cfi01_register() creates a TYPE_CFI_PFLASH01 device, sets
> properties, realizes, and wires up.
>
> We have three modified copies of it, because their users need to set
> additional properties, or have the wiring done differently.
>
> Factor out their common part into pflash_cfi01_create().
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/arm/vexpress.c        | 22 +++++-----------------
>  hw/arm/virt.c            | 26 +++++++++-----------------
>  hw/block/pflash_cfi01.c  | 39 +++++++++++++++++++++++++++------------
>  hw/xtensa/xtfpga.c       | 18 +++++++-----------

I was told that it's better this way when I did that initially:
  http://lists.gnu.org/archive/html/qemu-devel/2015-09/msg06927.html

Has the idea of "better" changed since then?
I'm fine with the code either way, just curious.

-- 
Thanks.
-- Max
