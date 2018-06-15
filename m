Received: from eggs.gnu.org ([2001:4830:134:3::10]:42341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTkgG-0000tD-Tv
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 05:06:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTkgD-0004PQ-3K
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 05:06:04 -0400
Received: from mail-oi0-x22e.google.com ([2607:f8b0:4003:c06::22e]:39481)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fTkgC-0004Ox-U2
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 05:06:01 -0400
Received: by mail-oi0-x22e.google.com with SMTP id t22-v6so8206199oih.6
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 02:06:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <12713e19-d67f-2196-7fed-5552d2aa95d5@redhat.com>
References: <20180604152941.20374-1-peter.maydell@linaro.org>
	<20180604152941.20374-7-peter.maydell@linaro.org>
	<12713e19-d67f-2196-7fed-5552d2aa95d5@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Jun 2018 10:05:39 +0100
Message-ID: <CAFEAcA8ZPAWD8JuvOZYpMC5xBBqJqY_KtytXBkO-_tzoLtkKUA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 06/13] hw/misc/tz-mpc.c: Implement
 registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>

On 15 June 2018 at 08:23, Auger Eric <eric.auger@redhat.com> wrote:
> Hi Peter,
>
> On 06/04/2018 05:29 PM, Peter Maydell wrote:
>> Implement the missing registers for the TZ MPC.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

>> +    case A_BLK_LUT:
>> +        r = s->blk_lut[s->blk_idx];
>> +        if (size == 4) {
> don't you need to test CTRL[8] before doing the auto-increment?
>
> spec says:
> "A full word write or read to this register
> automatically increments the BLK_IDX by one if
> enabled by CTRL[8]."

Oops, yes, definitely.

thanks
-- PMM
