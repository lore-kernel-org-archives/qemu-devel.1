Return-Path: <SRS0=M8gQ=CP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D3CC433E2
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 15:21:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94D4320714
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 15:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZgkJSzQ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94D4320714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEwTm-0002KE-GD
	for qemu-devel@archiver.kernel.org; Sun, 06 Sep 2020 11:21:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kEwSu-0001VW-Vt
 for qemu-devel@nongnu.org; Sun, 06 Sep 2020 11:20:26 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:38215)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kEwSt-0000aw-3h
 for qemu-devel@nongnu.org; Sun, 06 Sep 2020 11:20:24 -0400
Received: by mail-ej1-x642.google.com with SMTP id i22so14629667eja.5
 for <qemu-devel@nongnu.org>; Sun, 06 Sep 2020 08:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GMQ4Cl/+xUmyb9W1iYTJwQKeT5zOAdxAaw1kExISoRU=;
 b=ZgkJSzQ3v0KQo7Bar/geF1kwGXxWQrycmrJvRbHRwIJisglinBRD+jLOkJZdQrbHtS
 6Owp48R+cRBJrtY+bprAHCTd9Gz+fC9+VX8ONXSghL8LhjGtJ5YQiv3eSzLXU8TNvIKH
 ZvkmU4zpcpjzkGXocDx+9oOAvr3UqDX1E1sGqbRcGs1nzUsW3xiHLD21bLqDfexw02bm
 UqffJFZC4OzUJlsJ8mxbwtu6866RjRg8blrEMyx0YQZd7W+jaNtZKckJvvkgQDjpuyRC
 xcl+69J5o3gEWpsWVYQe7Y7+beOoQh6EbzLLKP9pnviRBlvXUPmDRt8AyihUJAnJRybS
 1ucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GMQ4Cl/+xUmyb9W1iYTJwQKeT5zOAdxAaw1kExISoRU=;
 b=FDE+hTS+sakHI9OMUWuiI3IoL5RHoA7tXA6LZydXziRe17MSoZ0Fkk2b/i19EIoQS7
 z8XDDimJMagCsQzyz9jIbbAepBM7pGz2RGttYhqWR5lt8whXhF9B40rKeVB0gD8JnJy1
 8n5evxF4JlGNRumEMlOUJ85SivGbxda7xFucLez7cPgRAmWdevp6iaESXhxw472JRl2Y
 2Fp5UhUtg7RJsbGJDXFqlqeZ7tLNuYLusMKLh2SGxuQPCSGyPc52x7dqhm1sc+nLSgzq
 uuSYiXPI/AQxJlOJwZf49mxfu9doozpAgEKxUdC3XoeD/1k/vW6S94GEy8bb83RGOvAf
 +rqA==
X-Gm-Message-State: AOAM531BS2TRWk/z2wE/fZMIPmddA5ppfYZjkAY/47sffHAFjnGp9mMy
 x1PPnOKOF/1M0m1b3mPTXw5Nia61Rv0I5Z+JXcHp9Q==
X-Google-Smtp-Source: ABdhPJyAXTw3rl6hJO0ptKJM39TAENM7gPZo7/H6kiTbJkNC2Rm7l7UfvNA7dbW/2yo8wMGtFtojvJSWmFzHxo/vJTM=
X-Received: by 2002:a17:906:24d6:: with SMTP id
 f22mr16541039ejb.85.1599405621027; 
 Sun, 06 Sep 2020 08:20:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200904034719.673626-1-david@gibson.dropbear.id.au>
In-Reply-To: <20200904034719.673626-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 6 Sep 2020 16:20:10 +0100
Message-ID: <CAFEAcA8xCpRBcsCaozEXnCuM5SqWr5ZEDrwLjs+8va=316_70Q@mail.gmail.com>
Subject: Re: [PULL 00/30] ppc-for-5.2 queue 20200904
To: David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 4 Sep 2020 at 04:47, David Gibson <david@gibson.dropbear.id.au> wrote:
>
> The following changes since commit 67a7bfe560a1bba59efab085cb3430f45176d382:
>
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2020-09-03' into staging (2020-09-03 16:58:25 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-5.2-20200904
>
> for you to fetch changes up to b172606ecf29a140073f7787251a9d70ecb53b6e:
>
>   spapr_numa: move NVLink2 associativity handling to spapr_numa.c (2020-09-04 13:40:09 +1000)
>
> ----------------------------------------------------------------
> ppc patch queue 2020-09-04
>
> Next pull request for qemu-5.2.  The biggest thing here is the
> generalization of ARM's start-powered-off machine property to all
> targets.  This can fix a number of odd little edge cases where KVM
> could run vcpus before they were properly initialized.  This does
> include changes to a number of files that aren't normally in my
> purview.  There are suitable Acked-by lines and Peter requested this
> come in via my tree, since the most pressing requirement for it is in
> pseries machines with the POWER secure virtual machine facility.
>
> In addition we have:
>  * The start of Daniel Barboza's rework and clean up of pseries
>    machine NUMA handling
>  * Correction to behaviour of the nvdimm= generic machine property on
>    pseries
>  * An optimization to the allocation of XIVE interrupts on KVM
>  * Some fixes for confused behaviour with kernel_irqchip when both
>    XICS and XIVE are in play
>  * Add HIOMAP comamnd to pnv flash
>  * Properly advertise the fact that spapr_vscsi doesn't handle
>    hotplugged disks
>  * Some assorted minor enhancements

Hi -- this fails to build for Windows:

../../hw/ppc/spapr_numa.c: In function 'spapr_numa_fixup_cpu_dt':
../../hw/ppc/spapr_numa.c:77:5: error: unknown type name 'uint'
     uint vcpu_assoc_size = NUMA_ASSOC_SIZE + 1;
     ^

That should probably be using one of the standard C types.

The 'check-tcg' tests for the linux-user static build also
failed on an s390x test:

  CHECK   debian-s390x-cross
  BUILD   s390x-linux-user guest-tests with docker qemu/debian-s390x-cross
  RUN     tests for s390x
  TEST    threadcount on s390x
Unhandled trap: 0x10003
PSW=mask 0000000180000000 addr 00000000010004f0 cc 00
R00=0000000000000000 R01=0000000000000000 R02=0000000000000000
R03=0000000000000000
R04=0000000000000000 R05=0000000000000000 R06=0000000000000000
R07=0000000000000000
R08=0000000000000000 R09=0000000000000000 R10=0000000000000000
R11=0000000000000000
R12=0000000000000000 R13=0000000000000000 R14=0000000000000000
R15=00000040008006c0

../Makefile.target:153: recipe for target 'run-threadcount' failed
make[2]: *** [run-threadcount] Error 1


thanks
-- PMM

