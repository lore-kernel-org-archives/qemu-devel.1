Received: from eggs.gnu.org ([209.51.188.92]:43252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goS14-0003re-FU
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 06:57:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goS13-0000Xr-UA
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 06:57:22 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:37017)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1goS13-0000Wi-9A
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 06:57:21 -0500
Received: by mail-oi1-x242.google.com with SMTP id y23so15899933oia.4
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 03:57:17 -0800 (PST)
MIME-Version: 1.0
References: <20190129113921.21599-1-berrange@redhat.com>
	<20190129113921.21599-6-berrange@redhat.com>
In-Reply-To: <20190129113921.21599-6-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Jan 2019 11:57:05 +0000
Message-ID: <CAFEAcA-Lk7yMhWBHtk6Wd_ZG2CDOwPSwv4E7xfVgbLqyDBHpAA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 5/5] configure: stop trying to link
 non-existant bmp file from bios dir
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Adam Baxter <voltagex@voltagex.org>, Stefan Weil <sw@weilnetz.de>

On Tue, 29 Jan 2019 at 11:39, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
> Inability to find icons during startup when not having run a
> "make install" is harmless, as frontends just continue without
> error. So it is not worth trying to add code hacks to find icons
> in non-installed directories.

I'm not hugely happy about this -- I think running from the
build directory should work the same as running installed
(it is how QEMU is often run as a developer and how it runs
when running tests).

thanks
-- PMM
