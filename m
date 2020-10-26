Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3453C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:50:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20056223AB
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BbcbSOsy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20056223AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX059-0000z5-3b
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 06:50:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kWzpD-0004OI-8M
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:34:03 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:37381)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kWzp6-0007tF-G0
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:34:02 -0400
Received: by mail-ed1-x543.google.com with SMTP id o18so8686124edq.4
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 03:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7Mm4x16uIFdNktSl8j2nIjCFnj7EVbFGZVxFYJWF4Kw=;
 b=BbcbSOsyWHP4F8n3XbdznMOm0JfvinNMiH+5rgMqZv2SSrYy5YM2PtdA3BSHHH8g15
 WJD1pFW45akdge7yGocvpiTeeW+1RfB53kka4W2Pdp3cvPj9D6GLsheFdqHijqasr94w
 WGm0COnosXzwz8lHrqcD+ea94Mh7sUt17F/8xLanQzey9Rcm7uBHnDaSKMeS8EjZhOCh
 Vb2a9fbmpLQS+ZrAvJgQFzNZ83IkZBIvqEA66mN6gWFwN7OSsF/Q94vFbIGZBveJSWUv
 N7B7SR4LRI+YcMGJr77KPanyz39IbbzDrOd7Py4Zm0GhRsakitqmkNEANQd+CguhT5ev
 MpeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7Mm4x16uIFdNktSl8j2nIjCFnj7EVbFGZVxFYJWF4Kw=;
 b=eA7eoAv8fYkZ3JegBpZL4agmqxmqxDwYYh5lfAgu7y8GrU1ofZVRwXwSNl5zxR9+qD
 UJhiQ71xmdiP+KOBpBJhFChk0i9sk6Njnu7mCuIko8+koZGAs9mdxUbpwLbsACJ4Fdti
 6hlQgXFdWMFMVfkteQs2yFWRiRnZwmY/1vL6eFm0b/px7yhvwnCRH6PM2FHlN2SgPHas
 nNocLjA+OA1ZTVjizO3yrcAZYn/+wehmkvJ6WxukFwgs6fzR9u4+CXDa5CBhJYXVw7AW
 Vh/8LeZlI2aIp7H44VsnChyK4OCF4mme9q8Gi5W7g+e0hyi0JM4yC4L78ofJNfSACH07
 bKsg==
X-Gm-Message-State: AOAM530Hr6NKyCrkaa2Wz6LESKUzCRM+gHiZk6AX6isIfAWDAyty7nQO
 DBqVYA0mPCRFKN6yyxmhMMCCpt5AHZ4/+wII4hryTw==
X-Google-Smtp-Source: ABdhPJzaQrTv7QN9lNXID4qIYtP9R9k2HRw6/Ab/+ZldgMj0CbKLQEQc9ydZTglWXnbteaUxR2iH/V045Fg1vkkevg8=
X-Received: by 2002:a50:9ea6:: with SMTP id a35mr15501844edf.52.1603708434155; 
 Mon, 26 Oct 2020 03:33:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603452058.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1603452058.git.qemu_oss@crudebyte.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Oct 2020 10:33:42 +0000
Message-ID: <CAFEAcA_Pd2PQd097tSHABR=jFK-Rq6odkZXEC2V2DBHrh8pSXg@mail.gmail.com>
Subject: Re: [PULL 00/13] 9p queue 2020-10-23
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x543.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 23 Oct 2020 at 12:46, Christian Schoenebeck
<qemu_oss@crudebyte.com> wrote:
>
> The following changes since commit 4c5b97bfd0dd54dc27717ae8d1cd10e14eef1430:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/modules-20201022-pull-request' into staging (2020-10-22 12:33:21 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/cschoenebeck/qemu.git tags/pull-9p-20201023
>
> for you to fetch changes up to ee01926a11b1f9bffcd6cdec0961dd9d1882da71:
>
>   tests/9pfs: add local Tunlinkat hard link test (2020-10-22 20:26:33 +0200)
>
> ----------------------------------------------------------------
> 9pfs: more tests using local fs driver
>
> Only 9pfs test case changes this time:
>
> * Refactor: Rename functions to make top-level test functions fs_*()
>   easily distinguishable from utility test functions do_*().
>
> * Refactor: Drop unnecessary function arguments in utility test
>   functions.
>
> * More test cases using the 9pfs 'local' filesystem driver backend,
>   namely for the following 9p requests: Tunlinkat, Tlcreate, Tsymlink
>   and Tlink.
>
> ----------------------------------------------------------------

I get a 'make check' failure on x86-64 Linux host:

PASS 54 qtest-x86_64: qos-test
/x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-9p-pci/virtio-9p/virtio-9p-tests/local/config
PASS 55 qtest-x86_64: qos-test
/x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-9p-pci/virtio-9p/virtio-9p-tests/local/create_dir
PASS 56 qtest-x86_64: qos-test
/x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-9p-pci/virtio-9p/virtio-9p-tests/local/unlinkat_dir
PASS 57 qtest-x86_64: qos-test
/x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-9p-pci/virtio-9p/virtio-9p-tests/local/create_file
PASS 58 qtest-x86_64: qos-test
/x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-9p-pci/virtio-9p/virtio-9p-tests/local/unlinkat_file
PASS 59 qtest-x86_64: qos-test
/x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-9p-pci/virtio-9p/virtio-9p-tests/local/symlink_file
Received response 7 (RLERROR) instead of 73 (RMKDIR)
Rlerror has errno 2 (No such file or directory)
**
ERROR:../../tests/qtest/virtio-9p-test.c:300:v9fs_req_recv: assertion
failed (hdr.id == id): (7 == 73)
ERROR qtest-x86_64: qos-test - Bail out!
ERROR:../../tests/qtest/virtio-9ptest.c:300:v9fs_req_recv: assertion
failed (hdr.id == id): (7 == 73)
Makefile.mtest:3953: recipe for target 'run-test-492' failed


thanks
-- PMM

