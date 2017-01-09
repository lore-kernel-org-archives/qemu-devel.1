Received: from eggs.gnu.org ([2001:4830:134:3::10]:47607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cQXHK-0001Ab-UM
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 05:34:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cQXHJ-000469-Qn
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 05:34:14 -0500
Received: from mail-ua0-x236.google.com ([2607:f8b0:400c:c08::236]:33020)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cQXHJ-00045U-M8
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 05:34:13 -0500
Received: by mail-ua0-x236.google.com with SMTP id i68so353937889uad.0
	for <qemu-devel@nongnu.org>; Mon, 09 Jan 2017 02:34:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170109100123.5080-1-jinguojie@loongson.cn>
References: <20170109100123.5080-1-jinguojie@loongson.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Jan 2017 10:33:51 +0000
Message-ID: <CAFEAcA_MhVrBtCVWGSs_qSFR5pLgM4nrYXFdCjks77FoikyW8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 0/1] Change default CFLAGS to -O3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jin Guojie <jinguojie@loongson.cn>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On 9 January 2017 at 10:01, Jin Guojie <jinguojie@loongson.cn> wrote:
> * in configure, the default optimization level is changed to O3.
> * Tested successfully on following machines:
>
>   | Host machine | Host OS  | qemu-system | Debian ISO  |
>   |-----------------------------------------------------|
>   |   x86 64     | Fedora25 |    i386     |    i386     |
>   | mips 64 le   | Fedora25 |    i386     |    i386     |
>
> Signed-off-by: Jin Guojie <jinguojie@loongson.cn>
>
> Jin Guojie (1):
>   Change default CFLAGS to -O3
>
>  configure | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

...so what are the measured performance improvements from
this change? As I understand it -O3 is where the "trade off
code size for speed" optimisations kick in, so we need
to benchmark to be sure that the increased icache usage
doesn't outweigh any speed gains. -O3 is not guaranteed
to be strictly better than -O2 (which is why for instance
Debian and Gentoo recommend -O2 as their default).

thanks
-- PMM
