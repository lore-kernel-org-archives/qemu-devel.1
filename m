Received: from eggs.gnu.org ([2001:4830:134:3::10]:48020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gZaje-0007VL-6C
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 07:13:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gZaja-0004TQ-51
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 07:13:58 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:46394)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gZajY-0004S0-Lm
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 07:13:52 -0500
Received: by mail-wr1-x431.google.com with SMTP id l9so19233359wrt.13
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 04:13:52 -0800 (PST)
Received: from zen.linaro.local ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	l37sm9597495wre.69.2018.12.19.04.13.50 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 19 Dec 2018 04:13:50 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
	by zen.linaro.local (Postfix) with ESMTPS id D2D063E0380
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 12:13:49 +0000 (GMT)
References: <7955f937.ccda.167c58f21b1.Coremail.13824125580@163.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <7955f937.ccda.167c58f21b1.Coremail.13824125580@163.com>
Date: Wed, 19 Dec 2018 12:13:49 +0000
Message-ID: <87k1k5af42.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] how to get the "intermediate tcg" string output to
 debug qemu?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org


tugouxp <13824125580@163.com> writes:

> hi folks:
>   i want to get the translated tcg operations printed on my test
>   pattern, so is there any way to get this for convenient?

$QEMU -d help

You can use something like

$QEMU -d in_asm,op,op_opt,out_asm

If you want lots of output.

>
>
> thanks for your kindley help.


--
Alex Benn=C3=A9e
