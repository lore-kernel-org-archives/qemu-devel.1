Received: from eggs.gnu.org ([2001:4830:134:3::10]:42899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fWOqE-0000Zd-HH
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 12:23:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fWOqB-0000QR-DZ
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 12:23:18 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:56359)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fWOqB-0000Pw-8T
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 12:23:15 -0400
Date: Fri, 22 Jun 2018 12:23:14 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180622162314.GA17489@flamenco>
References: <20180621143715.27176-1-richard.henderson@linaro.org>
	<CAFEAcA9dGUOLhxHr+AYHCfTvStM+M7DLVBiHEmnDzpX38aggBw@mail.gmail.com>
	<CAFEAcA8jUTAZmYrkvrS60PSqiiWc2sw20GvQnY+-bbXjvvMz7A@mail.gmail.com>
	<CAFEAcA_gYh6RTZb30pzritv-RP3uHc+JjBkb_AsipcmcL7=d5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_gYh6RTZb30pzritv-RP3uHc+JjBkb_AsipcmcL7=d5A@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL v2.5 00/19] tcg queued patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Fri, Jun 22, 2018 at 15:40:33 +0100, Peter Maydell wrote:
(snip)
> /home/petmay01/linaro/qemu-from-laptop/qemu/cpus.c:1637: undefined
> reference to `tcg_register_thread'
> /home/petmay01/linaro/qemu-from-laptop/qemu/cpus.c:1673: undefined
> reference to `cpu_exec_step_atomic'
> cpus.o: In function `qemu_tcg_init_vcpu':
> /home/petmay01/linaro/qemu-from-laptop/qemu/cpus.c:1865: undefined
> reference to `tcg_region_init'
> /home/petmay01/linaro/qemu-from-laptop/qemu/cpus.c:1875: undefined
> reference to `parallel_cpus'
> 
> Some of those are probably best handled with stub functions
> (eg tcg_register_thread()), but some of them might be better
> off handled by guarding functions with #ifndef CONFIG_TCG
> or moving them to source files in accel/tcg ?
> 
> This is probably best fixed by somebody familiar with the
> commits in question...

Just sent a patch that fixes the --disable-tcg build for me,
tested for x86_64-softmmu and i386-softmmu targets.

However, I'm puzzled by the fact that I cannot replicate all
of the link errors you report above. My build (tried with gcc
5.4.0 and 8.1.0) completes even though I don't see how
some symbols are resolved (I don't see them in the final
binary), e.g. tcg_register_thread().
Is the compiler somehow determining that it doesn't need those?

Thanks,

		Emilio
