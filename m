Received: from eggs.gnu.org ([2001:4830:134:3::10]:52724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1dk7CV-0008Tw-Uc
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 07:18:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1dk7CS-0003YY-Pi
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 07:18:27 -0400
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242]:35507)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1dk7CS-0003Xs-IY
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 07:18:24 -0400
Received: by mail-io0-x242.google.com with SMTP id l190so3505020iol.2
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 04:18:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170813155849.11368-1-sameeh@daynix.com>
References: <20170813155849.11368-1-sameeh@daynix.com>
From: Sameeh Jubran <sameeh@daynix.com>
Date: Tue, 22 Aug 2017 14:18:21 +0300
Message-ID: <CAKPgXcHH=H6OzbLKen3q21Rmx9iwdg7C_jzApmqin7NDR6XMxQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/3]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Yan Vugenfirer <yan@daynix.com>

Ping.

On Sun, Aug 13, 2017 at 6:58 PM, Sameeh Jubran <sameeh@daynix.com> wrote:

> From: Sameeh Jubran <sjubran@redhat.com>
>
> This series fixes qemu-ga's behaviour upon facing a missing serial/serial
> driver by listening to the serial device's events.
>
> For more info on why this series is needed checkout the commit message
> of the third patch and the following bugzilla:
> https://bugzilla.redhat.com/show_bug.cgi?id=990629.
>
> Sameeh Jubran (3):
>   qga: Channel: Add functions for checking serial status
>   qga: main: make qga config and socket activation global
>   qga: Prevent qemu-ga exit if serial doesn't exist
>
>  Makefile            |   4 +
>  qga/channel-posix.c |  54 ++++++++++
>  qga/channel-win32.c |  60 +++++++++++
>  qga/channel.h       |   9 ++
>  qga/main.c          | 284 ++++++++++++++++++++++++++++++
> ++++++++++++++++------
>  qga/service-win32.h |   4 +
>  6 files changed, 385 insertions(+), 30 deletions(-)
>
> --
> 2.9.4
>
>


-- 
Respectfully,
*Sameeh Jubran*
*Linkedin <https://il.linkedin.com/pub/sameeh-jubran/87/747/a8a>*
*Software Engineer @ Daynix <http://www.daynix.com>.*
