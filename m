Received: from eggs.gnu.org ([209.51.188.92]:56938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hCKvJ-0008Bp-Mi
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 05:14:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hCKvI-0001Bq-TN
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 05:14:09 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:33772)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hCKvH-0001AK-S1
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 05:14:08 -0400
Received: by mail-ot1-x343.google.com with SMTP id j10so5032422otq.0
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 02:14:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190404185730.GA22512@ls3530.dellerweb.de>
	<CAFEAcA9xP8CtXEruuzPHCyuDT5EyMMHFGdCJdfFBhX+C2Jr36A@mail.gmail.com>
	<b48c6984-f0fc-a597-53a0-4869c822ce73@gmx.de>
	<20190405082613.GC6105@redhat.com>
	<457ec791-3691-2ebb-e225-bd42a7aee627@gmx.de>
In-Reply-To: <457ec791-3691-2ebb-e225-bd42a7aee627@gmx.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Apr 2019 16:13:55 +0700
Message-ID: <CAFEAcA8uXuQMRapv5ZvvQBFzR0VV++fYnZEm=ePc8Xe1=OCbMA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] configure: Automatically fall back to TCI
 on non-release architectures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Helge Deller <deller@gmx.de>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Fri, 5 Apr 2019 at 16:02, Helge Deller <deller@gmx.de> wrote:
> Sadly such special treatment by projects makes life for me
> as an architecture maintainer much harder :-(

It's kind of inevitable for programs that aren't straightforwardly
architecture agnostic. gcc doesn't work for architectures which
don't have implemented backends either...

thanks
-- PMM
