Received: from eggs.gnu.org ([208.118.235.92]:37642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ge3Th-00061p-2s
	for qemu-devel@nongnu.org; Mon, 31 Dec 2018 14:43:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ge3Tb-0007Ch-KH
	for qemu-devel@nongnu.org; Mon, 31 Dec 2018 14:43:57 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38665)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ge3Tb-0007BT-DG
	for qemu-devel@nongnu.org; Mon, 31 Dec 2018 14:43:51 -0500
Received: by mail-wr1-x441.google.com with SMTP id v13so27121851wrw.5
	for <qemu-devel@nongnu.org>; Mon, 31 Dec 2018 11:43:51 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1545916380-12816-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1545916380-12816-2-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2d5cf023-9f74-b592-c4b5-7e210e4d50f5@amsat.org>
Date: Mon, 31 Dec 2018 20:43:47 +0100
MIME-Version: 1.0
In-Reply-To: <1545916380-12816-2-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] tests: tcg: mips: Move source files to
 new location
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: noring@nocrew.org, smarkovic@wavecomp.com, arikalo@wavecomp.com, amarkovic@wavecomp.com, alex.bennee@linaro.org, aurelien@aurel32.net

On 12/27/18 2:12 PM, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> New directory organization is as follows:
> 
> tests
>   tcg
>     mips
>       user
>         isa
>           r5900
>         ase
>           dsp
>       system
>         ase
>           dsp
> 
> New file names are unique within tests/tcg/mips directory, to
> avoid potential name colision problems.
> 
> There will be new subdirectories in near future, for example:
> 
> tests/tcg/mips/user/isa/nanomips
> tests/tcg/mips/user/ase/msa
> tests/tcg/mips/user/ase/mxu
> 
> etc.
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>

Finally this patch arrived!

X-Mailman-Approved-At: Sun, 30 Dec 2018 01:01:12 -0500

Received: from eggs.gnu.org by lists.gnu.org; Sat, 29 Dec 2018 23:43:06
-0500

Received: from mx2.rt-rk.com by eggs.gnu.org; Thu, 27 Dec 2018 14:13:25
+0100 (CET)

Received: from rtrkw774-lin.domain.local by mail.rt-rk.com; Thu, 27 Dec
2018 14:13:22 +0100 (CET)

Culprit to hold it seems eggs.gnu.org ...
