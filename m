Received: from eggs.gnu.org ([2001:4830:134:3::10]:34535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e4fac-000571-RN
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 00:04:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e4faZ-0004ft-My
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 00:04:18 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:41297)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1e4faZ-0004eX-HA
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 00:04:15 -0400
Date: Wed, 18 Oct 2017 00:04:12 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20171018040412.GA13959@flamenco>
References: <20171016172609.23422-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171016172609.23422-1-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v6 00/50] tcg tb_lock removal
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

On Mon, Oct 16, 2017 at 10:25:19 -0700, Richard Henderson wrote:
>    Thus, an extra 20 patches in the patch set rearranging how temps
>    are referenced within the TCG backend.  Some of them have appeared
>    on the list before, but it would have been last November.

I remember seeing these on the list before -- in June'17:
  https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg04596.html

FWIW with these 20 patches we no longer get a code reduction:

   text    data     bss     dec     hex filename
6850654 2144032 4420896 13415582         ccb49e alpha-softmmu/qemu-system-alpha (before)
6874086 2144032 4437248 13455366         cd5006 alpha-softmmu/qemu-system-alpha (after)

but we've got to keep in mind that the patches aren't exactly the same.

		E.
