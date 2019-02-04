Received: from eggs.gnu.org ([209.51.188.92]:45473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gqgk1-0002ML-Q1
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 11:05:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gqgjz-0008B0-I0
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 11:05:01 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:41761)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gqgjx-00086l-Li
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 11:04:59 -0500
Received: by mail-ot1-x341.google.com with SMTP id u16so583191otk.8
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 08:04:57 -0800 (PST)
MIME-Version: 1.0
References: <20190130031427.13129-1-jasowang@redhat.com>
In-Reply-To: <20190130031427.13129-1-jasowang@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Feb 2019 16:04:43 +0000
Message-ID: <CAFEAcA_no_9KX5v4WBWZ2Vu9zGjM5A3MtVzSLSwkure6y1=r8Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH V2] test-filter-mirror: pass UNIX domain
 socket through fd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Li Zhijian <lizhijian@cn.fujitsu.com>, Peter Xu <peterx@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Zhang Chen <zhangckid@gmail.com>, Markus Armbruster <armbru@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>

On Wed, 30 Jan 2019 at 03:14, Jason Wang <jasowang@redhat.com> wrote:
>
> The tests tries to let qemu server mode to process the connection
> which turns out to be racy after commit 8258292e18c3 ("monitor: Remove
> "x-oob", offer capability "oob" unconditionally"). This is because the
> filter may try to mirror the packets before UNIX socket object is
> ready (connected was set to true) from the view of qemu. In this case
> the packet will be dropped silently.
>
> Fixing this by passing pre-connected socket created by socketpair() to
> qemu through fd.

Hi; assuming it passes my merge tests I'm planning to apply
this directly to master since it will make my merge testing
easier. Thanks for tracking down and fixing the bug!

-- PMM
