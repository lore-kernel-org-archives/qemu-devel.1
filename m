Received: from eggs.gnu.org ([2001:4830:134:3::10]:51098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e4ajM-0002jY-F1
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 18:53:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e4ajH-0000hE-O3
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 18:53:00 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:44665)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1e4ajH-0000gn-GQ
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 18:52:55 -0400
Date: Tue, 17 Oct 2017 18:52:53 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20171017225253.GQ1345@flamenco>
References: <20171016172609.23422-1-richard.henderson@linaro.org>
	<20171016172609.23422-18-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171016172609.23422-18-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v6 17/50] tcg: Introduce index_arg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org

On Mon, Oct 16, 2017 at 10:25:36 -0700, Richard Henderson wrote:
> For multi-threaded tcg we have one TCGContext per thread.  With that,
> plus static cpu_* variables, we need the translators to handle indicies.

s/indicies/indices/


> We transform those to "arguments" at opcode generating time.
> 
> For now, that transformation is a no-op.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Emilio G. Cota <cota@braap.org>

		E.
