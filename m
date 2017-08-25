Received: from eggs.gnu.org ([2001:4830:134:3::10]:35632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dlFj3-0000uN-QP
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 10:36:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dlFj2-0002SV-KC
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 10:36:45 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:35233)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dlFj2-0002S4-Cw
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 10:36:44 -0400
Received: by mail-wm0-x22c.google.com with SMTP id y71so91971wmd.0
	for <qemu-devel@nongnu.org>; Fri, 25 Aug 2017 07:36:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1503493480-21691-3-git-send-email-chugh.ishani@research.iiit.ac.in>
References: <1503493480-21691-1-git-send-email-chugh.ishani@research.iiit.ac.in>
	<1503493480-21691-3-git-send-email-chugh.ishani@research.iiit.ac.in>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Aug 2017 15:36:22 +0100
Message-ID: <CAFEAcA_K8XK_pWsy_KUDgJt8gqfAKJsHfDA6MeW651nqGz82CQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 2/3] Test for full Backup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
Cc: QEMU Developers <qemu-devel@nongnu.org>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 23 August 2017 at 14:04, Ishani Chugh
<chugh.ishani@research.iiit.ac.in> wrote:
> This patch is the test for full backup implementation in Backup tool.
> The test employs two basic substests:
> 1) Backing up an empty guest and comparing it with base image.
> 2) Writing a pattern to the guest, creating backup and comparing
>    with the base image.
>
> Signed-off-by: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
> ---
>  tests/qemu-iotests/191     | 78 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/191.out | 33 ++++++++++++++++++++
>  tests/qemu-iotests/group   |  1 +
>  3 files changed, 112 insertions(+)
>  create mode 100755 tests/qemu-iotests/191
>  create mode 100644 tests/qemu-iotests/191.out
>
> diff --git a/tests/qemu-iotests/191 b/tests/qemu-iotests/191
> new file mode 100755
> index 0000000..fb4cde9
> --- /dev/null
> +++ b/tests/qemu-iotests/191
> @@ -0,0 +1,78 @@
> +#!/bin/bash
> +#
> +# Test full backup functionality of qemu-backup tool
> +#
> +# Copyright (C) 2009 Red Hat, Inc.

Should this perhaps have a different copyright owner and date?

thanks
-- PMM
