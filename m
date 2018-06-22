Received: from eggs.gnu.org ([2001:4830:134:3::10]:50342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fWPTW-0006dp-JL
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 13:03:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fWPTS-0006po-M2
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 13:03:54 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:40059)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fWPTS-0006pg-FO
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 13:03:50 -0400
Date: Fri, 22 Jun 2018 13:03:49 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180622170349.GA13208@flamenco>
References: <CAFEAcA_gYh6RTZb30pzritv-RP3uHc+JjBkb_AsipcmcL7=d5A@mail.gmail.com>
	<1529684183-17385-1-git-send-email-cota@braap.org>
	<CAFEAcA8t7xJQCANL9OLbujuVp0MFX+Z0-_xsQ8iH4YQh2+SNpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8t7xJQCANL9OLbujuVp0MFX+Z0-_xsQ8iH4YQh2+SNpA@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>

On Fri, Jun 22, 2018 at 17:24:33 +0100, Peter Maydell wrote:
> On 22 June 2018 at 17:16, Emilio G. Cota <cota@braap.org> wrote:
> It's probably the --enable-debug that makes the difference:
> for instance cpu_reloading_memory_map() is referenced from
> tcg_commit(), which is only called from within an "if (tcg_enabled())"
> guard; with debug disabled the compiler probably figures out that
> tcg_commit() is unreachable and doesn't put it in the .o file.

Yes, I get the same errors with both --enable-debug and --disable-tcg.

> Possibly this has always been broken and wasn't a regression?
> If so I guess we should apply your patch and then fix this
> separately...

v2.12.0 doesn't build either with the options above, so the
regression is fixed with the patch.

I'll send a v2 patch as a separate thread with an updated commit
message to reflect the above.

Thanks,

		Emilio
