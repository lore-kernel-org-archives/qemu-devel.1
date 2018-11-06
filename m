Received: from eggs.gnu.org ([2001:4830:134:3::10]:34237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gKARb-00034f-QC
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 18:07:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gKARX-00036Z-Pb
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 18:07:35 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:38400)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gKARX-0002yX-4K
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 18:07:31 -0500
Date: Wed, 7 Nov 2018 00:07:27 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20181106230727.vyqnwt6xsgtjg5gm@function>
References: <20181106151323.16154-1-peter.maydell@linaro.org>
	<20181106151323.16154-3-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106151323.16154-3-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH for-3.1 2/4] slirp: Use g_new() to allocate
 sockets in socreate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Jan Kiszka <jan.kiszka@siemens.com>, patches@linaro.org

Peter Maydell, le mar. 06 nov. 2018 15:13:21 +0000, a ecrit:
> The slirp socreate() function can only fail if the attempt
> to malloc() the struct socket fails. Switch to using
> g_new() instead, which will allow us to remove the
> error-handling code from its callers.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> We already use g_new/g_malloc in slirp, including for
> mbuf buffers which are larger than these socket structs.
> The motivation here is that we can render moot a Coverity
> complaint about an issue in an error-handling path.
> 
> As usual, indenting in slirp code is a bit of a mess;
> I've opted for "keep checkpatch happy".

Applied, thanks!

Samuel
