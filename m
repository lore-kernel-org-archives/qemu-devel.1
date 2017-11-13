Received: from eggs.gnu.org ([2001:4830:134:3::10]:59679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eECxL-0003kv-NB
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 06:31:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eECxK-0000Av-FE
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 06:31:11 -0500
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:48783)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eECxK-0000AM-8P
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 06:31:10 -0500
Received: by mail-wr0-x229.google.com with SMTP id 15so14108926wrb.5
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 03:31:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171113062658.9697-1-ppandit@redhat.com>
References: <20171113062658.9697-1-ppandit@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Nov 2017 11:30:48 +0000
Message-ID: <CAFEAcA-kTyadHKYTAuMOLi+AJyxVd9aWSowj=knU6vWdsaOqaA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] highbank: validate register offset
 before access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Moguofang <moguofang@huawei.com>, qemu-arm <qemu-arm@nongnu.org>, Shawn Guo <shawn.guo@linaro.org>, Rob Herring <robh@kernel.org>, Prasad J Pandit <pjp@fedoraproject.org>

On 13 November 2017 at 06:26, P J P <ppandit@redhat.com> wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> An 'offset' parameter sent to highbank register r/w functions
> could be greater than number(NUM_REGS=0x200) of hb registers,
> leading to an OOB access issue. Add check to avoid it.
>
> Reported-by: Moguofang (Dennis mo) <moguofang@huawei.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/arm/highbank.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> Update: use HWADDR_PRIx to print offset
>   -> https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg02116.html



Applied to target-arm.next, thanks.

-- PMM
