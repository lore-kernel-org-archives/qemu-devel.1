Received: from eggs.gnu.org ([2001:4830:134:3::10]:34307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjWue-00065s-2t
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 15:01:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjWud-0006yM-Fj
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 15:01:20 -0500
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:35908)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cjWud-0006xb-9e
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 15:01:19 -0500
Received: by mail-wr0-x229.google.com with SMTP id u108so60333522wrb.3
	for <qemu-devel@nongnu.org>; Thu, 02 Mar 2017 12:01:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <db1b69270ca4d2335e6fb2455ee56552373757fc.1488068248.git.balaton@eik.bme.hu>
References: <cover.1488068248.git.balaton@eik.bme.hu>
	<db1b69270ca4d2335e6fb2455ee56552373757fc.1488068248.git.balaton@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Mar 2017 20:00:57 +0000
Message-ID: <CAFEAcA_kzNEfkg56CFE=x-GqQTV-fpXjGXxvwoPoZS1HNVTnww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 12/14] sm501: Implement reading 2D
 engine registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On 25 February 2017 at 21:47, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> Clients normally only write to these registers, nothing is known to
> ever read them but they are documented as read/write so allow clients
> to also read the values.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  hw/display/sm501.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)

Oh, the read code is in a separate patch? Please put all the handling
for a particular register in the same patch. If you think the
resulting patch is too long you can split it into several patches
each of which handles a group of registers if you like (but it
probably isn't necessary).

thanks
-- PMM
