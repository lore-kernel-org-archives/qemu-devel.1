Received: from eggs.gnu.org ([209.51.188.92]:38956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLkav-0007BU-4I
	for qemu-devel@nongnu.org; Wed, 01 May 2019 04:28:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLkar-0007gG-Fl
	for qemu-devel@nongnu.org; Wed, 01 May 2019 04:28:00 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41965)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hLkar-0007eC-A8
	for qemu-devel@nongnu.org; Wed, 01 May 2019 04:27:57 -0400
Received: by mail-wr1-x443.google.com with SMTP id c12so23818884wrt.8
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 01:27:54 -0700 (PDT)
References: <20190428155451.15653-1-thuth@redhat.com>
	<20190428155451.15653-5-thuth@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190428155451.15653-5-thuth@redhat.com>
Date: Wed, 01 May 2019 09:27:52 +0100
Message-ID: <87d0l27f5j.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 4/8] tests/qemu-iotests: Do not
 hard-code the path to bash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Ed Maste <emaste@freebsd.org>, Christophe Fergeau <cfergeau@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Markus Armbruster <armbru@redhat.com>


Thomas Huth <thuth@redhat.com> writes:

> bash is installed in a different directory on non-Linux systems like
> FreeBSD. Do not hard-code /bin/bash here so that the tests can run
> there, too.
>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tests/qemu-iotests/239 | 2 +-
>  tests/qemu-iotests/240 | 2 +-
>  tests/qemu-iotests/241 | 2 +-
>  tests/qemu-iotests/243 | 2 +-
>  tests/qemu-iotests/244 | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/tests/qemu-iotests/239 b/tests/qemu-iotests/239
> index 6f085d573d..b0991ffe59 100755
> --- a/tests/qemu-iotests/239
> +++ b/tests/qemu-iotests/239
> @@ -1,4 +1,4 @@
> -#!/bin/bash
> +#!/usr/bin/env bash
>  #
>  # Test case for dmg
>  #
> diff --git a/tests/qemu-iotests/240 b/tests/qemu-iotests/240
> index 65cc3b39b1..d3e663ed65 100755
> --- a/tests/qemu-iotests/240
> +++ b/tests/qemu-iotests/240
> @@ -1,4 +1,4 @@
> -#!/bin/bash
> +#!/usr/bin/env bash
>  #
>  # Test hot plugging and unplugging with iothreads
>  #
> diff --git a/tests/qemu-iotests/241 b/tests/qemu-iotests/241
> index 017a736aab..58b64ebf41 100755
> --- a/tests/qemu-iotests/241
> +++ b/tests/qemu-iotests/241
> @@ -1,4 +1,4 @@
> -#!/bin/bash
> +#!/usr/bin/env bash
>  #
>  # Test qemu-nbd vs. unaligned images
>  #
> diff --git a/tests/qemu-iotests/243 b/tests/qemu-iotests/243
> index 5838c6e89c..e563761307 100755
> --- a/tests/qemu-iotests/243
> +++ b/tests/qemu-iotests/243
> @@ -1,4 +1,4 @@
> -#!/bin/bash
> +#!/usr/bin/env bash
>  #
>  # Test qcow2 preallocation
>  #
> diff --git a/tests/qemu-iotests/244 b/tests/qemu-iotests/244
> index d8e7122305..13978f93d2 100755
> --- a/tests/qemu-iotests/244
> +++ b/tests/qemu-iotests/244
> @@ -1,4 +1,4 @@
> -#!/bin/bash
> +#!/usr/bin/env bash
>  #
>  # Test qcow2 with external data files
>  #


--
Alex Benn=C3=A9e
