Received: from eggs.gnu.org ([2001:4830:134:3::10]:34642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gRNbV-0005OL-6G
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:35:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gRNbU-0007I6-Ht
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:35:37 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:44114)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gRNbU-0007Hw-4k
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:35:36 -0500
Received: by mail-ot1-x344.google.com with SMTP id f18so16368214otl.11
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 12:35:36 -0800 (PST)
MIME-Version: 1.0
References: <20181126191454.9455-1-ricardo.perez_blanco@nokia.com>
In-Reply-To: <20181126191454.9455-1-ricardo.perez_blanco@nokia.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Nov 2018 20:35:24 +0000
Message-ID: <CAFEAcA8MZD1nBPqtPEX91v97si5_MgjXUCPOiJd-tzBg5KvF8g@mail.gmail.com>
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

On Mon, 26 Nov 2018 at 19:15, Perez Blanco, Ricardo (Nokia -
BE/Antwerp) <ricardo.perez_blanco@nokia.com> wrote:
>
> Some machine based on AArch64 can have its main memory over 4GBs. With
> the current path, these machines can support "-kernel" in qemu
>
> Signed-off-by: Ricardo Perez Blanco <ricardo.perez_blanco@nokia.com>

Does this fix an issue with one of the current boards we
have in QEMU? I think they all have RAM below 4GB...

thanks
-- PMM
