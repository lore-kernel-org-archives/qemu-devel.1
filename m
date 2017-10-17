Received: from eggs.gnu.org ([2001:4830:134:3::10]:34129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e4Oiv-0002pe-8W
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 06:03:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e4Oip-0007TF-O6
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 06:03:45 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171017001209.32276-1-f4bug@amsat.org>
	<20171017001209.32276-38-f4bug@amsat.org>
	<0f7d83c7-b814-0e07-a043-f4cd957136c6@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7f55b220-d80b-2f0d-b77d-be9bafea6734@amsat.org>
Date: Tue, 17 Oct 2017 07:03:27 -0300
MIME-Version: 1.0
In-Reply-To: <0f7d83c7-b814-0e07-a043-f4cd957136c6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 37/39] i386/pc: extract port92 from pc.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

> Why are you doing this? I really fail to see the rationale here. Please
> add proper patch descriptions!

Oops sorry :/

Mostly because while moving things around I read this comment laying
around since commit 4b78a802ffa:

    /* port 92 stuff: could be split off */

No further rational (except it eases static analysis) so I won't change
this code and drop this patch.

Regards,

Phil.
