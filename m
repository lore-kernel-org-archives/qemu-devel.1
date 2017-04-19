Received: from eggs.gnu.org ([2001:4830:134:3::10]:33840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d0mYb-0001yC-U2
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 06:09:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d0mYb-0004fR-2Q
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 06:09:53 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:38141)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d0mYa-0004eg-RJ
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 06:09:52 -0400
Received: by mail-wm0-x236.google.com with SMTP id r190so18039009wme.1
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 03:09:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJy91CaB3kA0vNRGs52S=OweSfSXnkO71AHOa2XpUYNJTnZHDQ@mail.gmail.com>
References: <CAJy91CZpAiZ6adPmbAESrYqDgtK37CEgw4SAk97jCNduADy6Tw@mail.gmail.com>
	<CAFEAcA-V3BNcrhhnap+Hn8spfZPd0=Dv2v0P5myGwqU2e5t0Eg@mail.gmail.com>
	<CAJy91Ca2FTvBzd2OqQZyEJBtCAxxosdcAFP1RMgGCQe2PJXEJA@mail.gmail.com>
	<CAFEAcA-f1P4OW+DwLRn1AZQCzoiWNX_8Rhq0oduppMOSLWo9Ww@mail.gmail.com>
	<CAJy91CY=s2H0VYYuDUrs=HYTEKjKZHpU1MXrhStxGxxWg=hfEg@mail.gmail.com>
	<CAFEAcA9mfnUF-ZtU+kGpSj2LqVxPi=0GLB4Jk9zLnhhfq_Su4A@mail.gmail.com>
	<CAJy91CaB3kA0vNRGs52S=OweSfSXnkO71AHOa2XpUYNJTnZHDQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 19 Apr 2017 11:09:31 +0100
Message-ID: <CAFEAcA81o245N_zoSUtJ0SVupZyRE9cnfr15hmu+ReMuDj9iyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Hight Processor time of Socket communciation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jiahuan Zhang <jiahuanzhang90@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 19 April 2017 at 11:04, Jiahuan Zhang <jiahuanzhang90@gmail.com> wrote:
> Okay. Thank you for pointing this out.
> I would like to make a new serial device based on pl011,
> but containing a buffer for guest-to-host data transfer.

As I've said, the PL011 is inherently byte at a time.
If you want better than that, I recommend you use virtio-serial,
because it already exists for this purpose.

thanks
-- PMM
