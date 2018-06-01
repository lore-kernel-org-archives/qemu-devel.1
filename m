Received: from eggs.gnu.org ([2001:4830:134:3::10]:49649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fOfuH-0006oX-Kj
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 04:59:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fOfuG-0006pc-Vv
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 04:59:33 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:37997)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fOfuG-0006oK-QR
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 04:59:32 -0400
Received: by mail-ot0-x242.google.com with SMTP id n3-v6so28474875ota.5
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 01:59:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180531224911.23725-2-richard.henderson@linaro.org>
References: <20180531224911.23725-1-richard.henderson@linaro.org>
	<20180531224911.23725-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Jun 2018 09:59:11 +0100
Message-ID: <CAFEAcA-EVGk=E=0z=DJyv0eCCvstV_jV3uoxAztvmhY4p76AzQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/6] gdbstub: Return the fd from
 gdbserver_start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>, Evan Green <evgreen@chromium.org>

On 31 May 2018 at 23:49, Richard Henderson <richard.henderson@linaro.org> wrote:
> This will allow us to protect gdbserver_fd from the guest.

Ha, I hadn't realised we already had an internal-to-QEMU filedescriptor :-)

thanks
-- PMM
