Received: from eggs.gnu.org ([2001:4830:134:3::10]:58627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dMyb9-0004ce-S0
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 11:28:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dMyb9-0002g2-7W
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 11:28:15 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:37429)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dMyb9-0002fY-0w
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 11:28:15 -0400
Received: by mail-wm0-x22c.google.com with SMTP id d73so73762587wma.0
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 08:28:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170619144932.GI2640@redhat.com>
References: <20170616160658.32290-1-famz@redhat.com>
	<20170619144932.GI2640@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Jun 2017 16:27:53 +0100
Message-ID: <CAFEAcA8sFcma8nspaGE7Sx-72VUGGo491JKp+We2XwgDmGX18A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] migration: Fix race of image locking
 between src and dst
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>

On 19 June 2017 at 15:49, Daniel P. Berrange <berrange@redhat.com> wrote:
> IIUC as well as fixing the race condition, you're also improving
> error reporting by using qemu_file_set_error() which was not done
> previously. Would be nice to mention that in the commit message
> too if you respin for any other reason, but that's just a nit-pick

I've added
    N.B. This commit includes a minor improvement to the error handling
    by using qemu_file_set_error().

to the commit message -- is that OK or do you want to suggest a
different wording?

thanks
-- PMM
