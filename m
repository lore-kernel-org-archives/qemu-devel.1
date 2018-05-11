Received: from eggs.gnu.org ([2001:4830:134:3::10]:54528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fH8wA-00015S-Q3
	for qemu-devel@nongnu.org; Fri, 11 May 2018 10:22:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fH8wA-0007Vq-2Y
	for qemu-devel@nongnu.org; Fri, 11 May 2018 10:22:22 -0400
Received: from mail-oi0-x230.google.com ([2607:f8b0:4003:c06::230]:36178)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fH8w9-0007VS-U5
	for qemu-devel@nongnu.org; Fri, 11 May 2018 10:22:22 -0400
Received: by mail-oi0-x230.google.com with SMTP id v2-v6so4860763oif.3
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 07:22:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180511142023.GD2720@work-vm>
References: <20180509112406.6183-1-quintela@redhat.com>
	<CAFEAcA9+qqcVO1gq7PiLqCdKiHkrE81KroEdz7+iPanQ50zJRQ@mail.gmail.com>
	<20180511142023.GD2720@work-vm>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 11 May 2018 15:22:00 +0100
Message-ID: <CAFEAcA99JTLXKVjtSzKO8L5K4bAPd8jS93EEkUBMPug+WAc5wA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/41] Migration queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>

On 11 May 2018 at 15:20, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
> I'd be tempted to drop 03/41 xbzrle test  and see what happens;
> it's a heavy CPU eater so might be making things worse when in parallel.
> I suspect that aarch64 case is the same one we occasionally hit
> due to the page flag dirtying being wrong in TCG.
>
> Can you do that without another pull?

I can't, no. It has to be a signed tag.

thanks
-- PMM
