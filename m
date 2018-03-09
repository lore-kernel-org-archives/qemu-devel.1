Received: from eggs.gnu.org ([2001:4830:134:3::10]:41439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1euO6K-00039E-34
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 14:54:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1euO6F-0000Qj-77
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 14:54:48 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:36433)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1euO6E-0000QK-T5
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 14:54:43 -0500
References: <20180308144733.25615-1-peter.maydell@linaro.org>
	<20180308144733.25615-3-peter.maydell@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <ae2c32d8-3929-4721-3305-0cdc007e5757@vivier.eu>
Date: Fri, 9 Mar 2018 20:54:27 +0100
MIME-Version: 1.0
In-Reply-To: <20180308144733.25615-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/2] linux-user: Remove the unused "not
 implemented" signal handling stubs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>, Riku Voipio <riku.voipio@iki.fi>, patches@linaro.org

Le 08/03/2018 à 15:47, Peter Maydell a écrit :
> Now we've dropped unicore32, all of the architectures we support
> for linux-user implement the signal handling routines. The
> dummy "just print a message" versions are unimplemented, so we
> can drop them entirely.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> IMHO signal handling support is too important to allow a
> hypothetical new architecture target to silently get away
> without implementing it. For initial development it's easy
> enough to stub out the per-architecture functions, and then
> we will have a clear view of which targets (if any) don't
> have the signal handling implemented yet, and the missing
> feature will show up in code review.
> ---
>  linux-user/signal.c | 27 +--------------------------
>  1 file changed, 1 insertion(+), 26 deletions(-)

Applied to my 'linux-user-for-2.12' branch.

Thanks,
Laurent
