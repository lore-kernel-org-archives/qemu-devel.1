Received: from eggs.gnu.org ([2001:4830:134:3::10]:55885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cTAT8-0005Pf-SN
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 11:49:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cTAT8-0005bi-6i
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 11:49:18 -0500
Received: from mail-vk0-x233.google.com ([2607:f8b0:400c:c05::233]:34776)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cTAT8-0005bU-1u
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 11:49:18 -0500
Received: by mail-vk0-x233.google.com with SMTP id r136so76627884vke.1
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 08:49:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170108083854.5006-1-mar.krzeminski@gmail.com>
References: <20170108083854.5006-1-mar.krzeminski@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Jan 2017 16:48:56 +0000
Message-ID: <CAFEAcA_QZ2k=V5MC_=ny++8VebFyq9dFDJsohOGVjjuChVrEyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v3 0/3] block: m25p80: Improve mt25qu01g
 chip model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcin Krzeminski <mar.krzeminski@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Edgar Iglesias <edgar.iglesias@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>

On 8 January 2017 at 08:38, Marcin Krzeminski <mar.krzeminski@gmail.com> wrote:
> This series introduce some improvememnt targeting mt25qu01g and adds
> support for n25q00 device.
>
> v3:
> * Removed debug printf
> v2:
> * Rework die erase command functionality. Since the number of dies
> is constant per chip, new field to flash description structure has
> been added (instead of dynamic code from v1).
> * Add definition for n25q00.

Thanks, applied to target-arm.next (with some tweaks to the patch 2
commit message).

-- PMM
