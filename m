Received: from eggs.gnu.org ([209.51.188.92]:37516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLaNc-0000Vs-Tg
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 17:33:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLaNb-00015B-RI
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 17:33:36 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46864)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hLaNb-00012j-Fk
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 17:33:35 -0400
Received: by mail-wr1-x441.google.com with SMTP id r7so2934873wrr.13
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 14:33:35 -0700 (PDT)
References: <20190424103747.10173-1-thuth@redhat.com>
	<20190424103747.10173-4-thuth@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190424103747.10173-4-thuth@redhat.com>
Date: Tue, 30 Apr 2019 22:33:33 +0100
Message-ID: <87ftpz6uvm.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/6] tests/qemu-iotests: Do not hard-code
 the path to bash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org, Ed Maste <emaste@freebsd.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>


Thomas Huth <thuth@redhat.com> writes:

> bash is installed in a different directory on non-Linux systems like
> FreeBSD. Do not hard-code /bin/bash here so that the tests can run
> there, too.
>
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
