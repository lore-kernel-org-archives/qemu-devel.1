Received: from eggs.gnu.org ([2001:4830:134:3::10]:52180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ff54t-00031y-FN
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 11:06:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ff54q-0004Kb-Bt
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 11:06:19 -0400
Received: from mail-pf0-x231.google.com ([2607:f8b0:400e:c00::231]:46743)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ff54q-0004KI-2f
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 11:06:16 -0400
Received: by mail-pf0-x231.google.com with SMTP id l123-v6so26407136pfl.13
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 08:06:16 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <BN7PR08MB4868F5BE2EBF580CE8F1C244C65D0@BN7PR08MB4868.namprd08.prod.outlook.com>
	<5368d20b-2b39-2fee-8851-f749f97071f8@vivier.eu>
	<BN7PR08MB4868A93EDEAA419282D376D9C65D0@BN7PR08MB4868.namprd08.prod.outlook.com>
	<CAFEAcA9muPW8d6QTwzyFc+364fzhy9s0J9ok1FgJEjbP1vQicQ@mail.gmail.com>
	<BN7PR08MB4868051FE8DADE7A1CA8A62AC65D0@BN7PR08MB4868.namprd08.prod.outlook.com>
	<945b2112-83e6-47eb-a70f-190846b4150e@vivier.eu>
	<BN7PR08MB486816E87B50793B872E0E84C65D0@BN7PR08MB4868.namprd08.prod.outlook.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <d166f0fe-0b22-6deb-8c91-505950191b76@twiddle.net>
Date: Mon, 16 Jul 2018 08:06:12 -0700
MIME-Version: 1.0
In-Reply-To: <BN7PR08MB486816E87B50793B872E0E84C65D0@BN7PR08MB4868.namprd08.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] tcg_register_jit_int() interface problem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Petar Jovanovic <pjovanovic@wavecomp.com>, Riku Voipio <riku.voipio@iki.fi>, Stefan Markovic <smarkovic@wavecomp.com>

On 07/16/2018 06:23 AM, Aleksandar Markovic wrote:
> No, EM_NANOMIPS is meant to be run on EM_NANOMIPS only, and EM_MIPS on EM_MIPS
> only.

Exactly.  So why do you imagine a problem with separate binaries.

Recall -- this is not depending on *targeting* QEMU, but *hosting* QEMU.


r~
