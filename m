Received: from eggs.gnu.org ([2001:4830:134:3::10]:37447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dsTYm-0004Rp-Ot
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 08:48:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dsTYl-0004Vi-UY
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 08:48:00 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:44338)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dsTYl-0004Uo-Of
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 08:47:59 -0400
Received: by mail-wm0-x22d.google.com with SMTP id 189so5668738wmh.1
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 05:47:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKmqyKMdfNLtVTnDGVytJKaaoWMkxt+G3+U6Ph5Vm8U2ZGzRaA@mail.gmail.com>
References: <20170908163859.29820-1-richard.henderson@linaro.org>
	<CAKmqyKMdfNLtVTnDGVytJKaaoWMkxt+G3+U6Ph5Vm8U2ZGzRaA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Sep 2017 13:47:38 +0100
Message-ID: <CAFEAcA8mdXdnbFQ0auivBNr2StWqSZhO2W-ZAr477rDqtxif2Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] target/arm: Avoid an extra temporary for
 store_exclusive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Patch Tracking <patches@linaro.org>

On 8 September 2017 at 18:46, Alistair Francis <alistair23@gmail.com> wrote:
> On Fri, Sep 8, 2017 at 9:38 AM, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> Instead of copying addr to a local temp, reuse the value (which we
>> have just compared as equal) already saved in cpu_exclusive_addr.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>
> Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
>



Applied to target-arm.next, thanks.

-- PMM
