Received: from eggs.gnu.org ([2001:4830:134:3::10]:43656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eb4Zr-0002e1-8C
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 08:13:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eb4Zq-0008Qj-Eo
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 08:13:27 -0500
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:38289)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eb4Zq-0008QI-91
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 08:13:26 -0500
Received: by mail-oi0-x244.google.com with SMTP id m65so8232715oig.5
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 05:13:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <94742c6e-9b7c-2d83-fc97-b8813a96b1e8@linaro.org>
References: <20180110063337.21538-1-richard.henderson@linaro.org>
	<CAFEAcA_yQPCNWcv0Mz9mKUObuQH74DcbzyBvo9=UWF6pJ0qPWg@mail.gmail.com>
	<94742c6e-9b7c-2d83-fc97-b8813a96b1e8@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jan 2018 13:13:05 +0000
Message-ID: <CAFEAcA-TWemchenRbxskT+xgmnWu3SGyvBYSmp6F+=ByyM5nTw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/2] target/arm: split out vfp_expand_imm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 12 January 2018 at 19:07, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 01/12/2018 09:22 AM, Peter Maydell wrote:
>>> Richard Henderson (2):
>>>   target/arm: Split out vfp_expand_imm
>>>   target/arm: Add fp16 support to vfp_expand_imm
>>>
>>>  target/arm/translate-a64.c | 49 +++++++++++++++++++++++++++++++---------------
>>>  1 file changed, 33 insertions(+), 16 deletions(-)
>>
>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>>
>> I could put these in target-arm.next now if you like ?
>
> Yes, please.

OK, done.

thanks
-- PMM
