Received: from eggs.gnu.org ([209.51.188.92]:48276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1grozz-0006Ir-VY
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 14:06:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1grozy-0002yU-U8
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 14:06:11 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:33872)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1grozy-0002rN-NP
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 14:06:10 -0500
Received: by mail-ot1-x32b.google.com with SMTP id t5so1754063otk.1
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 11:06:00 -0800 (PST)
MIME-Version: 1.0
References: <20190114162605.5330-1-eblake@redhat.com>
	<20190114162605.5330-20-eblake@redhat.com>
	<CAFEAcA83L0jFLVDK8ebF2pxtAqoM+YsTU2vYUx2y7-PbSuEW9g@mail.gmail.com>
	<60feac5a-d45e-bfd0-b0c8-45e16aa95e6b@redhat.com>
In-Reply-To: <60feac5a-d45e-bfd0-b0c8-45e16aa95e6b@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Feb 2019 19:05:44 +0000
Message-ID: <CAFEAcA93i079grGNsNurdme8Et-Up_hg+_R0txXAXUYdLCxpFg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 19/20] nbd: Merge nbd_export_bitmap into
 nbd_export_new
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

On Thu, 7 Feb 2019 at 19:00, Eric Blake <eblake@redhat.com> wrote:
> (Someday, it would be
> nice to turn -Wshadow on, to catch stuff like this sooner)

Yes; unfortunately -Wshadow currently generates a ton of
warnings in existing code which we'd need to fix to get
the noise level down...

thanks
-- PMM
