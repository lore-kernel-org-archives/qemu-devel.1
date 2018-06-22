Received: from eggs.gnu.org ([2001:4830:134:3::10]:47170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fWP94-0007oq-VN
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 12:42:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fWP94-0007ff-0n
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 12:42:47 -0400
Received: from mail-ot0-x22c.google.com ([2607:f8b0:4003:c0f::22c]:37148)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fWP93-0007fU-Qv
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 12:42:45 -0400
Received: by mail-ot0-x22c.google.com with SMTP id 101-v6so8183453oth.4
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 09:42:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8t7xJQCANL9OLbujuVp0MFX+Z0-_xsQ8iH4YQh2+SNpA@mail.gmail.com>
References: <CAFEAcA_gYh6RTZb30pzritv-RP3uHc+JjBkb_AsipcmcL7=d5A@mail.gmail.com>
	<1529684183-17385-1-git-send-email-cota@braap.org>
	<CAFEAcA8t7xJQCANL9OLbujuVp0MFX+Z0-_xsQ8iH4YQh2+SNpA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Jun 2018 17:42:24 +0100
Message-ID: <CAFEAcA_ap1eufV0QxEw_xa+JfLdp0haqfArmpV_XQqcpgGpgUA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] tcg: fix --disable-tcg build breakage
 introduced by tb_lock removal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>

On 22 June 2018 at 17:24, Peter Maydell <peter.maydell@linaro.org> wrote:
> Possibly this has always been broken and wasn't a regression?
> If so I guess we should apply your patch and then fix this
> separately...

Yep, before your tb_lock changes on my system I can build
--disable-tcg, but not --disable-tcg --enable-debug. After
your tb_lock changes, both fail, and this patch fixes the
--disable-tcg case again. So I think we could reasonably
apply this (to fix the travis builds) and then look at
the longer-standing "can't build --disable-tcg --enable-debug"
issue separately.

thanks
-- PMM
