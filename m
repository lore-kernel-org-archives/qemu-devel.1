Received: from eggs.gnu.org ([2001:4830:134:3::10]:43797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQB9h-0001jS-Pf
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 08:33:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQB9g-0002IP-Ng
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 08:33:41 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:40715)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fQB9g-0002IA-Fn
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 08:33:40 -0400
Received: by mail-ot0-x241.google.com with SMTP id n1-v6so2561942otf.7
	for <qemu-devel@nongnu.org>; Tue, 05 Jun 2018 05:33:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <18231864-96b1-8f6f-5caa-c3d8613ec20e@vivier.eu>
References: <20180531224911.23725-1-richard.henderson@linaro.org>
	<20180531224911.23725-7-richard.henderson@linaro.org>
	<788ee514-a026-d415-73ce-67cc996e6259@vivier.eu>
	<149da730-950c-a527-2373-9cb0433543b1@linaro.org>
	<CAFEAcA-h7Ef5yfOS3V_kR5_fCmhr-N6okHY9=N87M9Ld+8MVdA@mail.gmail.com>
	<54f54010-ad2d-7df0-8838-b2ddc7668875@vivier.eu>
	<CAFEAcA9b==mGZQUAoPDCt1zbqxT3RmTa0XoQZvuPb17L0NYbMg@mail.gmail.com>
	<18231864-96b1-8f6f-5caa-c3d8613ec20e@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Jun 2018 13:33:19 +0100
Message-ID: <CAFEAcA9e1ymU6aiOi=mQJzyXgZmda+mckhk6uKgR=3E_Po5GVQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 6/6] linux-user: Use *at functions to
 implement interp_prefix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Evan Green <evgreen@chromium.org>

On 5 June 2018 at 13:23, Laurent Vivier <laurent@vivier.eu> wrote:
> They are used by tests/qemu-iotests/socket_scm_helper and
> qemu-bridge-helper.
>
> Perhaps we can disable qemu-iotests with linux-user only and to not
> build qemu-bridge-helper when tools are disabled?

Yeah, we shouldn't be building those if you're using --disable-system
--disable-tools...

thanks
-- PMM
