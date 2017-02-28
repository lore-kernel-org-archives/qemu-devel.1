Received: from eggs.gnu.org ([2001:4830:134:3::10]:60163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ciiPH-0001ny-Sk
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 09:05:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ciiPC-000322-Ed
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 09:05:35 -0500
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:35616)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ciiPC-00031o-9X
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 09:05:30 -0500
Received: by mail-wm0-x235.google.com with SMTP id v186so86312922wmd.0
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 06:05:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87lgsq2zd5.fsf@linaro.org>
References: <1487604965-23220-1-git-send-email-peter.maydell@linaro.org>
	<1487604965-23220-4-git-send-email-peter.maydell@linaro.org>
	<87lgsq2zd5.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Feb 2017 14:05:08 +0000
Message-ID: <CAFEAcA9ErvjYLgQK+UfM0xpHx9NrU_5qMwn=vZUh=5JMDxifVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 03/11] armv7m: QOMify the armv7m container
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Alistair Francis <alistair23@gmail.com>, Michael Davidsaver <mdavidsaver@gmail.com>

On 28 February 2017 at 13:56, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>> +static void armv7m_realize(DeviceState *dev, Error **errp)
>> +{
>> +    /* here realize our children */
>
> This comment is a little zen-like. Does this mean the child devices are
> realised at this point when the armv7m realise code is run?

Yeah, it just means "we init child devices in init, and realize
them in realize", but it's a bit cryptic. I have a feeling it
was a placeholder comment I put in when I was writing this
as a "put this code here" note. I'll delete it.

thanks
-- PMM
