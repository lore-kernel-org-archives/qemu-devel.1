Received: from eggs.gnu.org ([2001:4830:134:3::10]:41608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ckq5b-00058W-FP
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 05:42:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ckq5a-0002t6-O4
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 05:42:03 -0500
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:33853)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ckq5a-0002st-Hj
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 05:42:02 -0500
Received: by mail-wr0-x22b.google.com with SMTP id l37so113396491wrc.1
	for <qemu-devel@nongnu.org>; Mon, 06 Mar 2017 02:42:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <7b7fb9380fb7189f1aeb1f6264a4451d066a7afe.1488665935.git.balaton@eik.bme.hu>
References: <cover.1488665935.git.balaton@eik.bme.hu>
	<7b7fb9380fb7189f1aeb1f6264a4451d066a7afe.1488665935.git.balaton@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Mar 2017 10:41:41 +0000
Message-ID: <CAFEAcA8+dVxeFNYU00PJna+fyAPwSdjKfwPSx769J+Bv6FOxpA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v4 08/13] sm501: Fix hardware cursor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, David Gibson <david@gibson.dropbear.id.au>

On 4 December 2016 at 18:01, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> Rework HWC handling to simplify it and fix cursor not updating on
> screen as needed. Previously cursor was not updated because checking
> for changes in a line overrode the update flag set for the cursor but
> fixing this is not enough because the cursor should also be updated if
> its shape or location changes. Introduce hwc_invalidate() function to
> handle that similar to other display controller models.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
