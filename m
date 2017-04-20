Received: from eggs.gnu.org ([2001:4830:134:3::10]:34313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d1DDq-0001QE-2M
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 10:38:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d1DDp-0001Jp-8r
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 10:38:14 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:36227)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d1DDp-0001JP-2A
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 10:38:13 -0400
Received: by mail-wm0-x22c.google.com with SMTP id o81so105448102wmb.1
	for <qemu-devel@nongnu.org>; Thu, 20 Apr 2017 07:38:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170418150133.22436-1-famz@redhat.com>
References: <20170418150133.22436-1-famz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Apr 2017 15:37:51 +0100
Message-ID: <CAFEAcA9G=o4wBCMTuxOudL6bUzceLu+f78dxv5HjpWydAP6JBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/2] Block patches for 2.9-rc5
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 18 April 2017 at 16:01, Fam Zheng <famz@redhat.com> wrote:
> The following changes since commit 9c6b899f7a46893ab3b671e341a2234e9c0c060e:
>
>   9pfs: local: set the path of the export root to "." (2017-04-18 14:01:43 +0100)
>
> are available in the git repository at:
>
>   git://github.com/famz/qemu.git tags/block-pull-request
>
> for you to fetch changes up to 91af091f92358c2ff828fa1def1a7bea9b701cdf:
>
>   block: Drain BH in bdrv_drained_begin (2017-04-18 22:56:28 +0800)
>
> ----------------------------------------------------------------
>
> Hi Peter,
>
> This fixes the system_reset hanging issue when a block job is running reported
> by Jeff Cody.
>
> ----------------------------------------------------------------
>
> Fam Zheng (2):
>   block: Walk bs->children carefully in bdrv_drain_recurse
>   block: Drain BH in bdrv_drained_begin

Applied to master on Tuesday, but I forgot to say so...

thanks
-- PMM
