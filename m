Received: from eggs.gnu.org ([2001:4830:134:3::10]:56285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gP6ac-0000iR-2H
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 09:01:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gP6ab-0003Vn-3B
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 09:01:17 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:43796)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gP6aa-0003Uv-Ka
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 09:01:16 -0500
Received: by mail-oi1-x243.google.com with SMTP id u18so1530469oie.10
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 06:01:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181113165247.4806-8-sameo@linux.intel.com>
References: <20181113165247.4806-1-sameo@linux.intel.com>
	<20181113165247.4806-8-sameo@linux.intel.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Nov 2018 14:00:55 +0000
Message-ID: <CAFEAcA9yGRH5sFeS2WWzfUpo4MoMio4O=O95PRSebq6PZ9wrjw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 07/13] target: arm: Remove the LDST headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, qemu-arm <qemu-arm@nongnu.org>

On 13 November 2018 at 16:52, Samuel Ortiz <sameo@linux.intel.com> wrote:
> They are no longer needed.

...because a previous patch moved the code using them out
to excp_helper.c.

> Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Robert Bradford <robert.bradford@intel.com>
> ---
>  target/arm/helper.c | 1 -
>  1 file changed, 1 deletion(-)

thanks
-- PMM
