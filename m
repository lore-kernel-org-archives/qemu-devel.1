Received: from eggs.gnu.org ([2001:4830:134:3::10]:45303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1bT9-0007PW-5F
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:03:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1bT8-0000f6-Gd
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:03:55 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:45339)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e1bT8-0000eR-Al
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:03:54 -0400
Received: by mail-wm0-x232.google.com with SMTP id q124so24418100wmb.0
	for <qemu-devel@nongnu.org>; Mon, 09 Oct 2017 10:03:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHQ1cqEQpgr1Qgwr9rUnpiUXs_=jKSnzpJFQ=Q6GK+5vpT-x6A@mail.gmail.com>
References: <20170918195100.17593-1-andrew.smirnov@gmail.com>
	<20170918195100.17593-3-andrew.smirnov@gmail.com>
	<CAFEAcA9M9ZpcAHB4eZ2zh9jA6YSWpLoEPiAznnL2-SSdJoW+Mw@mail.gmail.com>
	<CAHQ1cqEQpgr1Qgwr9rUnpiUXs_=jKSnzpJFQ=Q6GK+5vpT-x6A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Oct 2017 18:03:32 +0100
Message-ID: <CAFEAcA8eLWXNDiLEYQez-rknah86sdduGxUZy__UtDWS+VyGSQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 02/17] imx_fec: Do not calculate FEC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>

On 9 October 2017 at 15:47, Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
> On Fri, Oct 6, 2017 at 6:48 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
>> This looks a bit odd. Doesn't the hardware calculate the CRC here?
>>
>
> It does, it just seemed to me that since the hardware also has a "CRC
> error" bit in its status register, there would be few if any users of
> the actual calculated CRC value. Given how eTSEC emulation layer gets
> away without calculating CRC I thought that it might be possible to
> have this optimization here as well.

As a general rule QEMU should just emulate what the hardware does
(even if the usual guest software doesn't happen to care about
that corner of the specification).

thanks
-- PMM
