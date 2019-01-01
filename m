Received: from eggs.gnu.org ([208.118.235.92]:60736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1geSOJ-000651-SS
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 17:20:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1geSOG-0002aK-NX
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 17:20:03 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45695)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1geSOG-0002Zy-H7
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 17:20:00 -0500
Received: by mail-wr1-x443.google.com with SMTP id t6so28902194wrr.12
	for <qemu-devel@nongnu.org>; Tue, 01 Jan 2019 14:20:00 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1545916380-12816-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1545916380-12816-2-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <378e08d0-af95-bd2e-fea8-8a1fb542e59f@amsat.org>
Date: Tue, 1 Jan 2019 23:19:56 +0100
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

Hi Aleksandar,

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
[...]

Since you said you are preparing a v2, could you split this huge patch
in smallers? One directory per patch seems an easy way to do it.
This way you can also delete the respective files from your patch 2 at
each step, and let your commits bisectables (else you let Makefile with
rules but no target to use them).

Thanks!

Phil.
