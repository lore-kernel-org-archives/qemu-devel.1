Received: from eggs.gnu.org ([2001:4830:134:3::10]:35170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dqKia-0008CL-Lv
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:57:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dqKia-0001T7-14
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:57:16 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:38826)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dqKiZ-0001RI-R3
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:57:15 -0400
Received: by mail-wr0-x22f.google.com with SMTP id 108so5140066wra.5
	for <qemu-devel@nongnu.org>; Fri, 08 Sep 2017 07:57:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170905021201.25684-4-famz@redhat.com>
References: <20170905021201.25684-1-famz@redhat.com>
	<20170905021201.25684-4-famz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Sep 2017 15:56:54 +0100
Message-ID: <CAFEAcA9mFqWntuM3=vGQKv-rLjRpRnBLhXomJNTHH9U6+zhTLQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v6 03/12] scripts: Add archive-source.sh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Daniel P. Berrange" <berrange@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>, Eric Blake <eblake@redhat.com>, Kamil Rytarowski <kamil@netbsd.org>

On 5 September 2017 at 03:11, Fam Zheng <famz@redhat.com> wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  scripts/archive-source.sh | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100755 scripts/archive-source.sh
>
> diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
> new file mode 100755
> index 0000000000..3cae7f34d3
> --- /dev/null
> +++ b/scripts/archive-source.sh
> @@ -0,0 +1,31 @@
> +#!/bin/sh
> +#
> +# Author: Fam Zheng <famz@redhat.com>
> +#
> +# Create archive of source tree, including submodules
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2.
> +# See the COPYING file in the top-level directory.

Why GPL-2-only? We generally prefer GPL-2-or-later for new
files, or something more permissive.

thanks
-- PMM
