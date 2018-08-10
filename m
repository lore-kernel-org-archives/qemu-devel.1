Received: from eggs.gnu.org ([2001:4830:134:3::10]:41271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fo0De-0005kh-8x
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 01:44:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fo0DZ-0005fp-9K
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 01:44:14 -0400
Received: from mail-ua1-x944.google.com ([2607:f8b0:4864:20::944]:38277)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fo0DZ-0005fW-31
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 01:44:09 -0400
Received: by mail-ua1-x944.google.com with SMTP id o11-v6so715060uak.5
	for <qemu-devel@nongnu.org>; Thu, 09 Aug 2018 22:44:08 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1533574847-19294-1-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5b12b2c3-8476-2862-d686-d406b65fc6cc@amsat.org>
Date: Fri, 10 Aug 2018 02:44:02 -0300
MIME-Version: 1.0
In-Reply-To: <1533574847-19294-1-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 00/80] Add nanoMIPS support to QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com, arikalo@wavecomp.com, thuth@redhat.com, armbru@redhat.com

Hi Aleksandar,

On 08/06/2018 01:59 PM, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
[snip]
> This series of patches implements recently announced nanoMIPS on QEMU.
> nanoMIPS is a variable length ISA containing 16, 32 and 48-bit wide
> instructions. It is designed to be portable at assembly level with
> other MIPS and microMIPS code, but contains a number of changes that
> enhance code density and efficiency. The largest portion of patches
> is nanoMIPS decoding engine.
[snip]

I think you can stage 1-12 for the next MIPS pull request on 3.1 cycle
opens. Then respins of this series will be a bit shorter ;)

Regards,

Phil.
