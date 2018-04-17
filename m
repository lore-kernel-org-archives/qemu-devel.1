Received: from eggs.gnu.org ([2001:4830:134:3::10]:40860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1f8T9n-0004QD-NT
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 12:08:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1f8T9m-0006Co-R5
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 12:08:35 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:44092)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1f8T9m-0006C8-H9
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 12:08:34 -0400
Received: by mail-lf0-x244.google.com with SMTP id g203-v6so28141297lfg.11
	for <qemu-devel@nongnu.org>; Tue, 17 Apr 2018 09:08:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKmqyKP-cMmiZmGeZa6PX8LTpYO09fX6y8o_nNT5TwmSsF288Q@mail.gmail.com>
References: <1523974696-1965-1-git-send-email-saipava@xilinx.com>
	<CAKmqyKP-cMmiZmGeZa6PX8LTpYO09fX6y8o_nNT5TwmSsF288Q@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 17 Apr 2018 09:08:02 -0700
Message-ID: <CAKmqyKPTnXeUmW3_QVRavdD8Js9NDLwOBxSoZSh-O7EizjwxaA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 0/1] xilinx_spips dummy bytes fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Cc: Alistair Francis <alistair@alistair23.me>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Edgar Iglesias <edgar.iglesias@gmail.com>, Francisco Iglesias <frasse.iglesias@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Tue, Apr 17, 2018 at 8:47 AM, Alistair Francis <alistair23@gmail.com> wrote:
> On Tue, Apr 17, 2018 at 7:18 AM, Sai Pavan Boddu
> <sai.pavan.boddu@xilinx.com> wrote:
>> For zynq-7000 boards, we saw issues when u-boot/linux accessing the qspi.
>> Issue is due to wrong dummy byte transfers for few of un-handled commands ex: 0x9F, 0x6, 0xe9, 0x4, 0x18, etc
>> There are many unhandled commands which do not require dummy bytes but they can be followed by address cycles.
>>
>> To fix this issue for above commands, the next upcoming tx bytes are not considered dummies rather sent to slave directly.
>>
>> Sai Pavan Boddu (1):
>>   xilinx_spips: send dummy only if cmd requires it
>
> I don't see this patch on the list, I only see the cover letter.
>
> Do other see it?

Never mind, it just came through.

Alistair

>
> Alistair
>
>>
>>  hw/ssi/xilinx_spips.c | 13 ++++++++++---
>>  1 file changed, 10 insertions(+), 3 deletions(-)
>>
>> --
>> 2.7.4
>>
>>
