Received: from eggs.gnu.org ([2001:4830:134:3::10]:33943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ebNzZ-0007d1-Kh
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 04:57:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ebNzY-00006h-Ra
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 04:57:17 -0500
Received: from mail-ot0-x22a.google.com ([2607:f8b0:4003:c0f::22a]:45759)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ebNzY-00006L-Mc
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 04:57:16 -0500
Received: by mail-ot0-x22a.google.com with SMTP id r4so9269496oti.12
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 01:57:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <8bc803bf-c062-6ee0-d7c2-74262ffe12dc@amsat.org>
References: <20171214151934.3647-1-andrew.smirnov@gmail.com>
	<CAKmqyKOV7kYBTDmjLaFTtKAF7KyZQ56F2LiwE5D+Hzzh9nvmxA@mail.gmail.com>
	<CAHQ1cqFhHRVNOT4Fo+AbF9CXYn77Npy2g6hzWJ+Lh90aRxT=0A@mail.gmail.com>
	<8bc803bf-c062-6ee0-d7c2-74262ffe12dc@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jan 2018 09:56:55 +0000
Message-ID: <CAFEAcA-MaS_y-kroAZuX48-bh6YrN8-ULoQUqJD_cM2K7jmonw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH] hw/misc: Add code to emulate
 Xilinx Slave Serial port
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Alistair Francis <alistair.francis@xilinx.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>

On 16 January 2018 at 05:04, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
> If devices have qtests for code coverage, I think we should accept them
> upstream, even if they are not yet plugged into a board.
>
> The other way, there are motivated contributors who start sending
> patches but then never finish due to changes in life and reduced spare
> time, or lack of motivation due to the high quality asked by some
> maintainer or daily paid reviewers, which is a shame IMHO.

The other side of this argument is that every new board and
device we accept upstream is increased maintenance workload
for us as upstream maintainers. If there's no board model
that uses the device then it is completely useless to us and
to our users, and so it's all downside.

thanks
-- PMM
