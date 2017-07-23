Received: from eggs.gnu.org ([2001:4830:134:3::10]:57032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dZN6x-0005vr-PB
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 16:04:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dZN6w-0007nd-UP
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 16:04:19 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:38719)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dZN6w-0007n8-N2
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 16:04:18 -0400
Received: by mail-wm0-x234.google.com with SMTP id m85so2755736wma.1
	for <qemu-devel@nongnu.org>; Sun, 23 Jul 2017 13:04:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170705075411.6556-2-sameeh@daynix.com>
References: <20170705075411.6556-1-sameeh@daynix.com>
	<20170705075411.6556-2-sameeh@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 23 Jul 2017 21:03:56 +0100
Message-ID: <CAFEAcA_tLBx---taBCugWXeRuiJAyUxHdo0d5w9v782zmwOtGQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/5] Makefile: clean: Clean exe files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sameeh Jubran <sameeh@daynix.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Yan Vugenfirer <yan@daynix.com>

On 5 July 2017 at 08:54, Sameeh Jubran <sameeh@daynix.com> wrote:
> From: Sameeh Jubran <sjubran@redhat.com>
>
> Clean exe files such as qemu-ga.exe
>
> Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
> ---
>  Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Makefile b/Makefile
> index 16a0430..22d29d6 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -487,6 +487,7 @@ clean:
>         rm -f config.mak op-i386.h opc-i386.h gen-op-i386.h op-arm.h opc-arm.h gen-op-arm.h
>         rm -f qemu-options.def
>         rm -f *.msi
> +       rm -f *${EXESUF}

On every host OS except Windows, ${EXESUF} is defined
to be the empty string, which means that this will be
"rm -f *", which is probably not what we want...

thanks
-- PMM
