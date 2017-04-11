Received: from eggs.gnu.org ([2001:4830:134:3::10]:49474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cxy0t-0002uS-5v
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 11:47:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cxy0s-0004ip-Ea
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 11:47:27 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:36237)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cxy0s-0004iH-97
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 11:47:26 -0400
Received: by mail-wm0-x234.google.com with SMTP id o81so66959383wmb.1
	for <qemu-devel@nongnu.org>; Tue, 11 Apr 2017 08:47:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170411145050.31290-1-mreitz@redhat.com>
References: <20170411145050.31290-1-mreitz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Apr 2017 16:47:03 +0100
Message-ID: <CAFEAcA8w=yc69wNAYmV7FZvm0O6mR_ShW1DqL3AgmqEH_=Ajng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH for-2.9?] block/io: Comment out permission
 assertions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Fam Zheng <famz@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On 11 April 2017 at 15:50, Max Reitz <mreitz@redhat.com> wrote:
> In case of block migration, there may be writes to BlockBackends that do
> not have the write permission taken. Before this issue is fixed (which
> is not going to happen in 2.9), we therefore cannot assert that this is
> the case.
>
> Suggested-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Applied, thanks.

-- PMM
