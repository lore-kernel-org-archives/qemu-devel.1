Received: from eggs.gnu.org ([2001:4830:134:3::10]:49187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fAYvg-00045q-LB
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 06:42:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fAYvb-0008M6-T1
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 06:42:40 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:37359)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fAYvb-0008LO-Nf
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 06:42:35 -0400
Received: by mail-ot0-x241.google.com with SMTP id 77-v6so10545675otd.4
	for <qemu-devel@nongnu.org>; Mon, 23 Apr 2018 03:42:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAAYMZQsP2UCa-4hbD9Mjryo5Ac=ZosQdEoDfcPoGA2r=kp5KVA@mail.gmail.com>
References: <1524119244-1240-1-git-send-email-saipava@xilinx.com>
	<CAAYMZQsP2UCa-4hbD9Mjryo5Ac=ZosQdEoDfcPoGA2r=kp5KVA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Apr 2018 11:42:14 +0100
Message-ID: <CAFEAcA_PqmdCWg5Qsm3OBZhZ-F-eWbe9ZPtvbBe3KRF+DyrXHA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3] xilinx_spips: Correct SNOOP_NONE state
 when flushing the txfifo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: francisco iglesias <frasse.iglesias@gmail.com>
Cc: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>, Alistair Francis <alistair@alistair23.me>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Edde <edgar.iglesias@gmail.com>, Sai Pavan Boddu <saipava@xilinx.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On 20 April 2018 at 18:26, francisco iglesias <frasse.iglesias@gmail.com> wrote:
>
>
> On 19 April 2018 at 08:27, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> wrote:
>>
>> SNOOP_NONE state handle is moved above in the if ladder, as it's same
>> as SNOOP_STRIPPING during data cycles.
>>
>> Signed-off-by: Sai Pavan Boddu <saipava@xilinx.com>
>
>
> Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
>
>>



Applied to target-arm.next, thanks.

-- PMM
