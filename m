Received: from eggs.gnu.org ([2001:4830:134:3::10]:47265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f3fdc-00045U-Ju
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 06:27:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f3fdY-0003V9-CU
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 06:27:32 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:42041)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f3fdY-0003Uc-5z
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 06:27:28 -0400
Received: by mail-wr0-x236.google.com with SMTP id s18so21739165wrg.9
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 03:27:28 -0700 (PDT)
References: <1519324303-5674-1-git-send-email-aleksandar.markovic@rt-rk.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1519324303-5674-1-git-send-email-aleksandar.markovic@rt-rk.com>
Date: Wed, 04 Apr 2018 11:27:25 +0100
Message-ID: <87o9izclma.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/6] target-mips: support MTTCG feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Fam Zheng <famz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <rth@twiddle.net>, Riku Voipio <riku.voipio@iki.fi>, Yongbok Kim <yongbok.kim@mips.com>, Aleksandar Markovic <aleksandar.markovic@mips.com>, Goran Ferenc <goran.ferenc@mips.com>, Miodrag Dinic <miodrag.dinic@mips.com>, Petar Jovanovic <petar.jovanovic@mips.com>, Raghu Gandham <raghu.gandham@mips.com>


Aleksandar Markovic <aleksandar.markovic@rt-rk.com> writes:

> From: Aleksandar Markovic <aleksandar.markovic@mips.com>
>
> v1->v2:
>
>   - patches #3 and #4 are squashed into one to avoid bisect breaking
>   - improved locking features in patch #5 (formerly #6)
>   - commit messages reviewed and improved
>   - rebased to the latest code
>
>
> This series introduces MTTCG feature for MIPS targets by adding all
> missing bits and pieces, and formally enabling corresponding QEMU
> builds to support such configurations.

You are better able to test the changes than me but I've built the
patches and eyeballed the BQL/async patches and they look good to me.

Sorry it took so long to get around to looking at them.

whole series:

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--
Alex Benn=C3=A9e
