Received: from eggs.gnu.org ([209.51.188.92]:42493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ggv6F-0003rO-SL
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 12:23:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ggv6D-0006eE-OY
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 12:23:35 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:32842)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ggv69-0005rb-64
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 12:23:31 -0500
Received: by mail-wm1-x343.google.com with SMTP id r24so8945634wmh.0
	for <qemu-devel@nongnu.org>; Tue, 08 Jan 2019 09:23:13 -0800 (PST)
References: <20190108162154.22259-1-alex.bennee@linaro.org>
	<20190108162154.22259-4-alex.bennee@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190108162154.22259-4-alex.bennee@linaro.org>
Date: Tue, 08 Jan 2019 17:23:10 +0000
Message-ID: <87h8ejukqp.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 3/6] softfloat: enforce softfloat if the
 host's FMA is broken
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> From: "Emilio G. Cota" <cota@braap.org>
>
> The added branch to the FMA ops is marked as unlikely and therefore
> its impact on performance (measured with fp-bench) is within noise range
> when measured on an Intel(R) Xeon(R) Gold 6142 CPU @ 2.60GHz.

Ahh I missed v2:

  Subject: [PATCH v2] softfloat: enforce softfloat if the host's FMA is bro=
ken
  Date: Tue, 25 Dec 2018 02:03:05 -0500
  Message-Id: <20181225070305.18221-1-cota@braap.org>

I'll roll that into the next iteration.

--
Alex Benn=C3=A9e
