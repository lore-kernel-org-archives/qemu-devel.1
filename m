Received: from eggs.gnu.org ([209.51.188.92]:55838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCKrV-0004xb-Bv
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 05:10:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCKrU-0003j3-IE
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 05:10:13 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:45838)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hCKrT-0003av-Mu
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 05:10:12 -0400
Received: by mail-wr1-f48.google.com with SMTP id s15so7012789wra.12
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 02:10:11 -0700 (PDT)
References: <20190404185730.GA22512@ls3530.dellerweb.de>
	<CAFEAcA9xP8CtXEruuzPHCyuDT5EyMMHFGdCJdfFBhX+C2Jr36A@mail.gmail.com>
	<b48c6984-f0fc-a597-53a0-4869c822ce73@gmx.de>
	<20190405082613.GC6105@redhat.com>
	<457ec791-3691-2ebb-e225-bd42a7aee627@gmx.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5792aea8-c510-9f18-2d64-49a7f24f90e6@redhat.com>
Date: Fri, 5 Apr 2019 11:10:08 +0200
MIME-Version: 1.0
In-Reply-To: <457ec791-3691-2ebb-e225-bd42a7aee627@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Helge Deller <deller@gmx.de>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

Cc'ing qemu-block.

On 4/5/19 11:02 AM, Helge Deller wrote:
[...]
> As another example, even if I only want to build "qemu-img", I still need
> to manually give the --enable-tcg-interpreter configure option.

You found a bug :)
