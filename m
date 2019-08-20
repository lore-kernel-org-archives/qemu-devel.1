Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4DBC3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 13:32:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4049B214DA
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 13:32:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4049B214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i04FG-00071b-EU
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 09:32:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45190)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1i04EN-0006ZT-KH
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 09:31:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1i04EL-0006Nv-51
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 09:31:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34538)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1i04EK-0006NJ-Vh
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 09:31:21 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EEC5D12AC9;
 Tue, 20 Aug 2019 13:31:18 +0000 (UTC)
Received: from dhcp-17-173.bos.redhat.com (dhcp-17-173.bos.redhat.com
 [10.18.17.173])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4395C5C205;
 Tue, 20 Aug 2019 13:31:15 +0000 (UTC)
Date: Tue, 20 Aug 2019 09:31:13 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190820133113.GA4422@dhcp-17-173.bos.redhat.com>
References: <20190818231827.27573-1-philmd@redhat.com>
 <20190818231827.27573-4-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190818231827.27573-4-philmd@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Tue, 20 Aug 2019 13:31:19 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/4] tests/docker: Add test-acceptance
 runner
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 19, 2019 at 01:18:26AM +0200, Philippe Mathieu-Daud=E9 wrote:
> Add a runner script to be able to run acceptance tests within
> Docker images. We can now reproduce Travis CI builds locally (and
> debug  them!).
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  tests/docker/test-acceptance | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100755 tests/docker/test-acceptance
>=20
> diff --git a/tests/docker/test-acceptance b/tests/docker/test-acceptanc=
e
> new file mode 100755
> index 0000000000..84edaa676c
> --- /dev/null
> +++ b/tests/docker/test-acceptance
> @@ -0,0 +1,21 @@
> +#!/bin/bash -e
> +#
> +# Compile default Travis-CI target and run Avocado acceptance tests
> +#
> +# Copyright (c) 2019 Red Hat Inc.
> +#
> +# Authors:
> +#  Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2
> +# or (at your option) any later version. See the COPYING file in
> +# the top-level directory.
> +
> +. common.rc
> +
> +cd "$BUILD_DIR"
> +
> +DEF_TARGET_LIST=3D"x86_64-softmmu,mips-softmmu,mips64el-softmmu,aarch6=
4-softmmu,arm-softmmu,s390x-softmmu,alpha-softmmu"
> +TARGET_LIST=3D${TARGET_LIST:-$DEF_TARGET_LIST} \
> +build_qemu
> +check_qemu check-acceptance
> --=20
> 2.20.1
>=20
>=20

I'm currently seeing test errors when running in a container:

  MKDIR   /tmp/qemu-test/build/tests/results
  AVOCADO tests/acceptance
JOB ID     : fe56cc0b2d1adbc0b5bb5828902e113d596edccf
JOB LOG    : /tmp/qemu-test/build/tests/results/job-2019-08-19T22.13-fe56=
cc0/job.log
 (01/27) /tmp/qemu-test/src/tests/acceptance/boot_linux_console.py:BootLi=
nuxConsole.test_x86_64_pc:  ERROR: join() argument must be str or bytes, =
not 'NoneType' (0.05 s)
Interrupting job (failfast).
RESULTS    : PASS 0 | ERROR 1 | FAIL 0 | SKIP 26 | WARN 0 | INTERRUPT 0 |=
 CANCEL 0
JOB TIME   : 0.26 s
/tmp/qemu-test/src/tests/Makefile.include:1158: recipe for target 'check-=
acceptance' failed
make: *** [check-acceptance] Error 9

That being said, I'm not running it under docker, but under podman,
although I'm not convinced yet that is the defining issue.  I'll try
to identify what's going here.

Cheers,
- Cleber.

