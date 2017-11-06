Received: from eggs.gnu.org ([2001:4830:134:3::10]:53833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eBkMs-0003xv-V9
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 11:35:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eBkMr-00012S-Vo
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 11:35:22 -0500
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:52354)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eBkMr-00011i-IX
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 11:35:21 -0500
Received: by mail-wm0-x22f.google.com with SMTP id t139so15528974wmt.1
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 08:35:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <871slbs7iv.fsf@linaro.org>
References: <1509732813-22957-1-git-send-email-peter.maydell@linaro.org>
	<871slbs7iv.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Nov 2017 16:34:59 +0000
Message-ID: <CAFEAcA-02WxVWayj=ZZS9Wq+6herJm2=jdKbfDAV1iYMvLUTBA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH] nvic: Fix ARMv7M MPU_RBAR reads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 6 November 2017 at 16:20, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
>> Fix an incorrect mask expression in the handling of v7M MPU_RBAR
>> reads that meant that we would always report the ADDR field as zero.
>
> nit: you could extend that to: "..as zero because we mask it when
> written".

The ADDR field is bits [31:5], so it's true even if we don't
mask on writes.

thanks
-- PMM
