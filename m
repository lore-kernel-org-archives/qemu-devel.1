Received: from eggs.gnu.org ([2001:4830:134:3::10]:53213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dX9BG-0003Xz-Qy
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 12:47:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dX9BG-0005kc-35
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 12:47:34 -0400
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <20170714100029.26288-1-ppandit@redhat.com>
References: <20170714100029.26288-1-ppandit@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 17 Jul 2017 13:47:32 -0300
Message-ID: <CAAdtpL5S=bvyRBmJD-+MLsJU-HoUQjRi-_ngw-+TJ3eSRn_5Qg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] ide: check BlockBackend object in
 ide_cancel_dma_sync
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, John Snow <jsnow@redhat.com>, Chensongnian <chensongnian@huawei.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Prasad J Pandit <pjp@fedoraproject.org>

On Fri, Jul 14, 2017 at 7:00 AM, P J P <ppandit@redhat.com> wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> -        blk_drain(s->blk);
> -        assert(s->bus->dma->aiocb == NULL);

This assert looks weird

> +        if (s->blk) {
> +            blk_drain(s->blk);
> +            assert(s->bus->dma->aiocb == NULL);
> +        }
