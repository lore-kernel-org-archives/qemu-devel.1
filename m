Received: from eggs.gnu.org ([2001:4830:134:3::10]:45642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ecZd5-00062N-BG
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 11:35:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ecZd4-0006qC-LE
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 11:34:59 -0500
Received: from mail-ot0-x232.google.com ([2607:f8b0:4003:c0f::232]:42790)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ecZd4-0006py-F8
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 11:34:58 -0500
Received: by mail-ot0-x232.google.com with SMTP id s3so1865302otc.9
	for <qemu-devel@nongnu.org>; Fri, 19 Jan 2018 08:34:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <d746e2e8-3690-c27e-f816-9892b36d8a1c@amsat.org>
References: <20180115115309.23982-1-quintela@redhat.com>
	<CAFEAcA-SxiJyKa84UwG8CESpkTXEM9AG5HqEgpPrzSFwrTPzYg@mail.gmail.com>
	<d746e2e8-3690-c27e-f816-9892b36d8a1c@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jan 2018 16:34:37 +0000
Message-ID: <CAFEAcA9dYzqTQTseZQfa0bm+H8tjCdhjuJOSgCx-KB14jBWDUA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/27] Migration pull
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Laurent Vivier <lvivier@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 19 January 2018 at 16:27, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
> We have armel/armhf/powerpc hosts failing since this pull due to commit
> 3be98be4e9f.
>
> Those target are currently tested on Shippable CI, eventually adding an
> IRC bot we could notice.
>
> I know companies using QEMU system in embedded armel/armhf hosts, I
> don't know about the ppc32 hosts.
> This is however unlikely the migration features are used there.

I have ppc64 and armhf in my test set, so clearly they don't all
fail all the time. What are the failure symptoms ?

thanks
-- PMM
