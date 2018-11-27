Received: from eggs.gnu.org ([2001:4830:134:3::10]:40266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gRanQ-0006nG-8y
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 05:40:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gRanP-0001QF-Ez
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 05:40:48 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:45652)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gRanP-0001Ph-7a
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 05:40:47 -0500
Received: by mail-oi1-x244.google.com with SMTP id b141so18807080oii.12
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 02:40:47 -0800 (PST)
MIME-Version: 1.0
References: <20181126191454.9455-1-ricardo.perez_blanco@nokia.com>
	<CAFEAcA8MZD1nBPqtPEX91v97si5_MgjXUCPOiJd-tzBg5KvF8g@mail.gmail.com>
	<AM6PR07MB536866E0CCDADD411210C7EBB3D00@AM6PR07MB5368.eurprd07.prod.outlook.com>
In-Reply-To: <AM6PR07MB536866E0CCDADD411210C7EBB3D00@AM6PR07MB5368.eurprd07.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Nov 2018 10:40:34 +0000
Message-ID: <CAFEAcA-mB-4Hib2CKYshpggCCSM-wT5fB8H_1LPzOhxoMjNayA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] [PATCH] Allow AArch64 processors to boot
 from a kernel placed over 4GB.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ricardo.perez_blanco@nokia.com
Cc: ricardoperezblanco@gmail.com, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Tue, 27 Nov 2018 at 08:43, Perez Blanco, Ricardo (Nokia -
BE/Antwerp) <ricardo.perez_blanco@nokia.com> wrote:
>
> Hi Peter,
>
> AFAIK, there is no board in QEMU that has its memory over 4GiB, however, we are working in some prototypes and proof of concepts of boards with memory over 4GiB.

OK, thanks. It's a reasonable missing feature to fix, but
since it doesn't affect any current boards we can defer
it to the next (4.0) release. I'll send some code
review comments in a moment.

thanks
-- PMM
