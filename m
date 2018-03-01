Received: from eggs.gnu.org ([2001:4830:134:3::10]:53945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erNZT-0002mk-EH
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 07:44:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erNZS-0003sT-Im
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 07:44:27 -0500
Received: from mail-ot0-x230.google.com ([2607:f8b0:4003:c0f::230]:36551)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1erNZS-0003r6-Dn
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 07:44:26 -0500
Received: by mail-ot0-x230.google.com with SMTP id 108so5407627otv.3
	for <qemu-devel@nongnu.org>; Thu, 01 Mar 2018 04:44:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <7b95391b-2ef8-b664-5d23-15db04841e6b@linaro.org>
References: <20180220180325.29818-1-peter.maydell@linaro.org>
	<20180220180325.29818-16-peter.maydell@linaro.org>
	<7b95391b-2ef8-b664-5d23-15db04841e6b@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Mar 2018 12:44:05 +0000
Message-ID: <CAFEAcA_xh+_3Uy1M9Uc8N+O-_MKoGcmn+JqHBgD5rXinV_Vv_w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 15/19] hw/misc/iotkit-secctl: Arm IoT Kit
 security controller initial skeleton
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 27 February 2018 at 21:44, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 02/20/2018 10:03 AM, Peter Maydell wrote:
>> +        r >>= 8 * (addr & 3);
>> +        r &= (1 << (size * 8)) - 1;
>
> extract32(r, (addr & 3) * 8, size * 8) ?

Good idea, that's much clearer.

-- PMM
