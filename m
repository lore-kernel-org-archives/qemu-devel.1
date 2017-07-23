Received: from eggs.gnu.org ([2001:4830:134:3::10]:44136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1dZALO-0008Fi-FG
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 02:26:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1dZALL-0004Ie-AM
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 02:26:22 -0400
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242]:36990)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1dZALL-0004Hn-1o
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 02:26:19 -0400
Received: by mail-io0-x242.google.com with SMTP id p5so2413195ioo.4
	for <qemu-devel@nongnu.org>; Sat, 22 Jul 2017 23:26:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170705075411.6556-1-sameeh@daynix.com>
References: <20170705075411.6556-1-sameeh@daynix.com>
From: Sameeh Jubran <sameeh@daynix.com>
Date: Sun, 23 Jul 2017 09:26:15 +0300
Message-ID: <CAKPgXcF1GDQeKo+yf5V8C80r1CPWpTp+mN9X-Ufi1mbMRRj33g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/5] Fix qemu-ga's behaviour on Windows
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

On Wed, Jul 5, 2017 at 10:54 AM, Sameeh Jubran <sameeh@daynix.com> wrote:

> From: Sameeh Jubran <sjubran@redhat.com>
>
> This patch series fixes qemu-ga's main service behaviour on Windows
> by listening to the virtio-serial device's events.
>
> For more info on why this series is needed checkout the commit message
> of the third patch and the following bugzilla:
> https://bugzilla.redhat.com/show_bug.cgi?id=990629.
>
> Sameeh Jubran (5):
>   Makefile: clean: Clean exe files
>   qga-win: service-win32: Add start_service and stop_service functions
>   qga-win: Add serial listener service
>   qga-win: Add qga-serial-listener to msi installer
>   qga-win: service-win32: Use get_service function
>
>  Makefile                            |  12 ++-
>  Makefile.objs                       |   1 +
>  qga/Makefile.objs                   |   2 +
>  qga/channel.h                       |   9 ++
>  qga/installer/qemu-ga.wxs           |  24 +++++
>  qga/main.c                          |  23 +++--
>  qga/serial-listener-service-win32.c | 181 ++++++++++++++++++++++++++++++
> ++++++
>  qga/serial-listener-service-win32.h |  29 ++++++
>  qga/service-win32.c                 | 142 +++++++++++++++++++++++-----
>  qga/service-win32.h                 |   5 +
>  10 files changed, 395 insertions(+), 33 deletions(-)
>  create mode 100644 qga/serial-listener-service-win32.c
>  create mode 100644 qga/serial-listener-service-win32.h
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
