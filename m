Received: from eggs.gnu.org ([2001:4830:134:3::10]:51909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ff53a-0002NG-EL
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 11:04:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ff53X-00039g-Av
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 11:04:58 -0400
Received: from mail-pl0-x22a.google.com ([2607:f8b0:400e:c01::22a]:39435)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ff53X-00039H-2h
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 11:04:55 -0400
Received: by mail-pl0-x22a.google.com with SMTP id p23-v6so4119724plo.6
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 08:04:54 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <BN7PR08MB4868F5BE2EBF580CE8F1C244C65D0@BN7PR08MB4868.namprd08.prod.outlook.com>
	<5368d20b-2b39-2fee-8851-f749f97071f8@vivier.eu>
	<BN7PR08MB4868A93EDEAA419282D376D9C65D0@BN7PR08MB4868.namprd08.prod.outlook.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <d8eaa91a-f204-2283-e66d-b3650f584056@twiddle.net>
Date: Mon, 16 Jul 2018 08:04:50 -0700
MIME-Version: 1.0
In-Reply-To: <BN7PR08MB4868A93EDEAA419282D376D9C65D0@BN7PR08MB4868.namprd08.prod.outlook.com>
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

On 07/16/2018 04:36 AM, Aleksandar Markovic wrote:
> The problem is, this means there will be separate executables for QEMU for MIPS
> and QEMU for nanoMIPS. Would that be acceptable from overall QEMU design point
> of view? Peter, Richard?

I really don't imagine how you would *not* have different executables.

NanoMIPS and MIPS III cannot be run on the same machine, surely?


r~
