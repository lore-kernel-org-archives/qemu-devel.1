Received: from eggs.gnu.org ([2001:4830:134:3::10]:48468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQ9aV-0006Iq-3P
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 06:53:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQ9aT-0007cy-Pw
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 06:53:15 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:33532)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fQ9aT-0007cW-Iy
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 06:53:13 -0400
Received: by mail-oi0-x243.google.com with SMTP id c6-v6so504796oiy.0
	for <qemu-devel@nongnu.org>; Tue, 05 Jun 2018 03:53:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <149da730-950c-a527-2373-9cb0433543b1@linaro.org>
References: <20180531224911.23725-1-richard.henderson@linaro.org>
	<20180531224911.23725-7-richard.henderson@linaro.org>
	<788ee514-a026-d415-73ce-67cc996e6259@vivier.eu>
	<149da730-950c-a527-2373-9cb0433543b1@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Jun 2018 11:52:52 +0100
Message-ID: <CAFEAcA-h7Ef5yfOS3V_kR5_fCmhr-N6okHY9=N87M9Ld+8MVdA@mail.gmail.com>
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

On 5 June 2018 at 06:27, Richard Henderson <richard.henderson@linaro.org> wrote:
> On Fedora 28, one can no longer build a static qemu.  We depend on libraries
> for which Fedora no longer ships static versions.

Do you mean you can't build the system binaries statically (that's
never really been very supported), or that you can't do a build
with configure --disable-system --disable-tools --static ?

The latter would be more concerning.

thanks
-- PMM
