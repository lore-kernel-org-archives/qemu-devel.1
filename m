Received: from eggs.gnu.org ([2001:4830:134:3::10]:42576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cybMn-00077l-E2
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 05:48:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cybMm-0002bJ-Fb
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 05:48:41 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:33502)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cybMm-0002b3-8Y
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 05:48:40 -0400
Received: by mail-wm0-x22a.google.com with SMTP id y18so2916793wmh.0
	for <qemu-devel@nongnu.org>; Thu, 13 Apr 2017 02:48:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170412235420.GB8607@lemon>
References: <20170412204641.GA15762@localhost.localdomain>
	<f5bf12f4-e4fd-87c7-a714-e412cee63e36@redhat.com>
	<20170412222251.GB15762@localhost.localdomain>
	<20170412235420.GB8607@lemon>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Apr 2017 10:48:18 +0100
Message-ID: <CAFEAcA9yt49a61JLN-Sv=dFSz6rGC30hxb9=oHDqRnvpyjZXQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Regression from 2.8: stuck in bdrv_drain()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Jeff Cody <jcody@redhat.com>, John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 13 April 2017 at 00:54, Fam Zheng <famz@redhat.com> wrote:
> John and I confirmed that this can be fixed by this pending patch:
>
> [PATCH for-2.9 4/5] block: Drain BH in bdrv_drained_begin
>
> https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg01018.html
>
> It didn't make it into 2.9-rc4 because of limited time. :(
>
> Looks like there is no -rc5, we'll have to document this as a known issue.

Well, we *hope* there is no -rc5, but if the bug is genuinely
a "we can't release like this" bug we will obviously have to
do another rc. Basically you all as the block maintainers should
make the call about whether it's release-critical or not.

thanks
-- PMM
