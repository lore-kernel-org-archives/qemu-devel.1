Received: from eggs.gnu.org ([2001:4830:134:3::10]:44568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fMbd4-0008Os-4t
	for qemu-devel@nongnu.org; Sat, 26 May 2018 12:01:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fMbd3-0001PV-FB
	for qemu-devel@nongnu.org; Sat, 26 May 2018 12:01:14 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:33305)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <keno@juliacomputing.com>)
	id 1fMbd3-0001PB-8m
	for qemu-devel@nongnu.org; Sat, 26 May 2018 12:01:13 -0400
Received: by mail-pl0-x243.google.com with SMTP id n10-v6so4820653plp.0
	for <qemu-devel@nongnu.org>; Sat, 26 May 2018 09:01:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-dL_6vAWmo8kyVJWHLhH-oChmHO0zpcqz3tfSCiZAW5A@mail.gmail.com>
References: <cover.1527310210.git.keno@alumni.harvard.edu>
	<305501d80a62cc12e0d82a2ffd656819badd0d4d.1527310210.git.keno@alumni.harvard.edu>
	<CAFEAcA-dL_6vAWmo8kyVJWHLhH-oChmHO0zpcqz3tfSCiZAW5A@mail.gmail.com>
From: Keno Fischer <keno@juliacomputing.com>
Date: Sat, 26 May 2018 12:00:30 -0400
Message-ID: <CABV8kRx=qDeC8ZXtxSRbm1_a0hHX13WX8UKL4zNDJcbumyhxag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 09/13] 9p: darwin: Provide a compatibility
 definition for XATTR_SIZE_MAX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Keno Fischer <keno@alumni.harvard.edu>, Greg Kurz <groug@kaod.org>

> > +#if defined(CONFIG_DARWIN) && !defined(XATTR_SIZE_MAX)
> > +/* Darwin doesn't seem to define a maximum xattr size in its user
> > +   user space header, but looking at the kernel source, HFS supports
> > +   up to INT32_MAX, so use that as the maximum.
> > +*/
> > +#define XATTR_SIZE_MAX INT32_MAX
> > +#endif
>
> Do we really need the CONFIG_DARWIN part of this check?

Right now this code only runs on Linux (and Darwin after this series).
On Linux it's always defined,
but I'd rather this code give an error when somebody tries to port it
to a new OS than have it
silently use an incorrect value. The ` !defined(XATTR_SIZE_MAX)` is
just there in case Apple ever
decides to define it in their headers. I can remove that part if you
would prefer.
