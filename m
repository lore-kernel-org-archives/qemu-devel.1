Received: from eggs.gnu.org ([2001:4830:134:3::10]:60411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eowHr-0001sz-Ug
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 14:12:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eowHq-0007HM-JU
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 14:12:11 -0500
Received: from mail-ot0-x22f.google.com ([2607:f8b0:4003:c0f::22f]:37682)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eowHq-0007Gp-FL
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 14:12:10 -0500
Received: by mail-ot0-x22f.google.com with SMTP id e64so5607185ote.4
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 11:12:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <151932620203.726.14470172414364772802@bdbb90650ae5>
References: <20180220180325.29818-1-peter.maydell@linaro.org>
	<151932620203.726.14470172414364772802@bdbb90650ae5>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2018 19:11:49 +0000
Message-ID: <CAFEAcA90bTkHb+AF2W7Jv3GMENo0Ni3rK6GnzNVtk+RF89VuCg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 00/19] Add Cortex-M33 and mps2-an505 board
 model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Fam Zheng <famz@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 22 February 2018 at 19:03,  <no-reply@patchew.org> wrote:

> WARNING: line over 80 characters
> #530: FILE: include/hw/misc/iotkit-secctl.h:14:
> + * http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ecm0601256/index.html

> WARNING: line over 80 characters
> #660: FILE: include/hw/arm/iotkit.h:13:
> + * http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ecm0601256/index.html

> ERROR: line over 90 characters
> #54: FILE: hw/arm/mps2-tz.c:21:
> + * https://developer.arm.com/products/system-design/development-boards/fpga-prototyping-boards/mps2
>
> ERROR: line over 90 characters
> #57: FILE: hw/arm/mps2-tz.c:24:
> + * http://infocenter.arm.com/help/topic/com.arm.doc.100112_0200_06_en/versatile_express_cortex_m_prototyping_systems_v2m_mps2_and_v2m_mps2plus_technical_reference_100112_0200_06_en.pdf
>
> WARNING: line over 80 characters
> #63: FILE: hw/arm/mps2-tz.c:30:
> + *   http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ecm0601256/index.html

Does anybody better with perl and more familiar with checkpatch's
internals feel like tweaking it to suppress the over-long-line
complaint for URLs ?

thanks
-- PMM
