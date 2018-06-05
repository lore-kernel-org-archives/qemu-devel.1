Received: from eggs.gnu.org ([2001:4830:134:3::10]:39739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQCjb-0002OF-3e
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:14:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQCja-0000qL-5u
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:14:51 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:33053)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fQCjZ-0000qC-VJ
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:14:50 -0400
Received: by mail-ot0-x242.google.com with SMTP id h6-v6so2996879otj.0
	for <qemu-devel@nongnu.org>; Tue, 05 Jun 2018 07:14:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <55f8f5d0-4372-9d6a-99c9-6736ded191f9@linaro.org>
References: <20180531224911.23725-1-richard.henderson@linaro.org>
	<20180531224911.23725-7-richard.henderson@linaro.org>
	<788ee514-a026-d415-73ce-67cc996e6259@vivier.eu>
	<149da730-950c-a527-2373-9cb0433543b1@linaro.org>
	<CAFEAcA-h7Ef5yfOS3V_kR5_fCmhr-N6okHY9=N87M9Ld+8MVdA@mail.gmail.com>
	<55f8f5d0-4372-9d6a-99c9-6736ded191f9@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Jun 2018 15:14:28 +0100
Message-ID: <CAFEAcA9fEcUC6By3Zy9LXEhoqmfbTXp=fP=v5DgWK-KOGWJdtg@mail.gmail.com>
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
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Laurent Vivier <laurent@vivier.eu>, QEMU Developers <qemu-devel@nongnu.org>, Evan Green <evgreen@chromium.org>

On 5 June 2018 at 14:45, Richard Henderson <richard.henderson@linaro.org> wrote:
> I'm annoyed that "pkg-config --exists --static foo" does not really do what it
> implies (to me at least), since Fedora does not ship the static library.

Personally I would like to consider that a bug in the distro's
pkg-config files, though I think last time I suggested that
there was a contrary view.

thanks
-- PMM
