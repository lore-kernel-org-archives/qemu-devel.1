Received: from eggs.gnu.org ([2001:4830:134:3::10]:46056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1emJgF-000463-5t
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:34:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1emJgB-0004If-2U
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:34:31 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:58383)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1emJgA-0004He-Ov
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:34:26 -0500
References: <20180213132246.26844-1-peter.maydell@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <648461d0-2f4a-7c39-800d-40d286b5364b@vivier.eu>
Date: Thu, 15 Feb 2018 14:34:11 +0100
MIME-Version: 1.0
In-Reply-To: <20180213132246.26844-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: Remove THREAD macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <rth@twiddle.net>, patches@linaro.org

Le 13/02/2018 à 14:22, Peter Maydell a écrit :
> Back when we used to support compiling either with or without
> NPTL threading library support, we used a macro THREAD which would
> expand either to nothing (no thread support) or to __thread (threads
> supported). For a long time now we have required thread support,
> so remove the macro and just use __thread directly as other parts
> of QEMU do.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  linux-user/qemu.h | 4 +---
>  linux-user/main.c | 2 +-
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 

Applied to my 'linux-user-for-2.12' branch.

Thanks,
Laurent
