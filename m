Received: from eggs.gnu.org ([2001:4830:134:3::10]:45427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e6hFH-00070v-Iy
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 14:14:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e6hFC-0007iw-CT
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 14:14:39 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:52069)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1e6hFC-0007hv-7b
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 14:14:34 -0400
Date: Mon, 23 Oct 2017 14:14:32 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20171023181432.GL6901@flamenco>
References: <20171020232023.15010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171020232023.15010-1-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v7 00/52] tcg queued patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, f4bug@amsat.org, pbonzini@redhat.com

On Fri, Oct 20, 2017 at 16:19:31 -0700, Richard Henderson wrote:
> A bit silly to keep calling this "tb_lock removal", since it
> doesn't quite, and it has accumulated several additional patches.

Thanks for doing all this work!

I think I went through all of the patches. I also did some testing
(tested the final result plus some intermediate commits that I
thought might be tricky). Looks good (and now we have a booting
icount+MTTCG, although I'm not sure of its usefulness).

Cheers,

		Emilio
