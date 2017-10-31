Received: from eggs.gnu.org ([2001:4830:134:3::10]:58482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e9Xu7-0008Fy-Cn
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 10:52:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e9Xu6-00054a-NT
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 10:52:35 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:43496)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e9Xu6-00054C-GV
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 10:52:34 -0400
Received: by mail-wm0-x243.google.com with SMTP id m72so14496584wmc.0
	for <qemu-devel@nongnu.org>; Tue, 31 Oct 2017 07:52:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_dhMWxRpz8hZ-Ljw+dwWha_NCUZQiaq96V=b0LNvqq2g@mail.gmail.com>
References: <20171005145557.5746-1-programmingkidx@gmail.com>
	<20171005145557.5746-3-programmingkidx@gmail.com>
	<CAFEAcA_dhMWxRpz8hZ-Ljw+dwWha_NCUZQiaq96V=b0LNvqq2g@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Oct 2017 14:52:12 +0000
Message-ID: <CAFEAcA-Ts6a5V+w9KRaB8U6Wz_ZoHGp+Wac=2sY=dpzoe_rOsg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 2/2] ui/cocoa.m: send ctrl-alt key
 combinations to guest if not used by QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Arbuckle <programmingkidx@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 31 October 2017 at 14:38, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 5 October 2017 at 15:55, John Arbuckle <programmingkidx@gmail.com> wrote:
>> Send control-alt key combinations to the guest if not used by the user interface.
>>
>> ---
>> v2 changes:
>> - changed logic to use existing if case
>>
>
> This patch is missing your signed-off-by line, can you provide
> it, please?

...actually, don't worry -- I wrote an equivalent of this patch
that does the same thing but doesn't need to get rid of the
switch() statement.

thanks
-- PMM
