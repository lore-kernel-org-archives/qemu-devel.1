Received: from eggs.gnu.org ([2001:4830:134:3::10]:50755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cen5a-0000OR-RK
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 13:17:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cen5Z-0003Bd-Uz
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 13:17:02 -0500
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:38377)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cen5Z-0003BE-OJ
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 13:17:01 -0500
Received: by mail-wm0-x234.google.com with SMTP id r141so16058350wmg.1
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 10:17:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1487354284-7587-1-git-send-email-nreilly@blackberry.com>
References: <1487354284-7587-1-git-send-email-nreilly@blackberry.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Feb 2017 18:16:40 +0000
Message-ID: <CAFEAcA-JOsT_oKzJ=-0EGx7nnG4ck9AkehAK8bjpeTPMJW42fw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] Add missing fp_access_check() to aarch64
 crypto instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nick Reilly <nreilly@blackberry.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 17 February 2017 at 17:58, Nick Reilly <nreilly@blackberry.com> wrote:
> The aarch64 crypto instructions for AES and SHA are missing the
> check for if the FPU is enabled.
>
> Signed-off-by: Nick Reilly <nreilly@blackberry.com>

Oops, nice catch. Applied to target-arm.next, thanks.

-- PMM
