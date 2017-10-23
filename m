Received: from eggs.gnu.org ([2001:4830:134:3::10]:53436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e6gHN-0007O4-FD
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 13:12:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e6gHL-0001FF-IN
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 13:12:45 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:35999)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1e6gHL-0001F7-E9
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 13:12:43 -0400
Date: Mon, 23 Oct 2017 13:12:42 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20171023171242.GD6901@flamenco>
References: <20171020232023.15010-1-richard.henderson@linaro.org>
	<20171020232023.15010-19-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171020232023.15010-19-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v7 18/52] tcg: Remove GET_TCGV_* and
 MAKE_TCGV_*
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

On Fri, Oct 20, 2017 at 16:19:49 -0700, Richard Henderson wrote:
> The GET and MAKE functions weren't really specific enough.
> We now have a full compliment of functions that convert exactly

s/compliment/complement/

> between temporaries, arguments, tcgv pointers, and indices.
> 
> The target/sparc change is also a bug fix, which would have affected
> a host that defines TCG_TARGET_HAS_extr[lh]_i64_i32, i.e. MIPS64.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Emilio G. Cota <cota@braap.org>

		E.
