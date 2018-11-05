Received: from eggs.gnu.org ([2001:4830:134:3::10]:42208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gJgBg-0002Z8-4T
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 09:49:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gJgBf-0007Uz-Bk
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 09:49:07 -0500
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234]:46339)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gJgBf-0007Tk-63
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 09:49:07 -0500
Received: by mail-oi1-x234.google.com with SMTP id k64-v6so7613729oia.13
	for <qemu-devel@nongnu.org>; Mon, 05 Nov 2018 06:49:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <d3a69de8bd0a6e821a3539f85da80699@walle.cc>
References: <20181030170032.1844-1-peter.maydell@linaro.org>
	<d3a69de8bd0a6e821a3539f85da80699@walle.cc>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Nov 2018 14:48:46 +0000
Message-ID: <CAFEAcA_JG1_6GcNLJuO=1vD4kd_=NQGTWFqKEsYO9p17jWDV=Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-3.1] milkymist: Check for failure
 trying to load BIOS image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Walle <michael@walle.cc>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 31 October 2018 at 08:20, Michael Walle <michael@walle.cc> wrote:
> Am 2018-10-30 18:00, schrieb Peter Maydell:
>>
>> Check the return value from load_image_targphys(), which tells us
>> whether our attempt to load the BIOS image into RAM failed.
>> (Spotted by Coverity, CID 1190305.)
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
>
> Acked-by: Michael Walle <michael@walle.cc>
>
> Will you put it in your queue, Peter?

Sure, I have an arm pullreq I'm putting together anyway.

thanks
-- PMM
