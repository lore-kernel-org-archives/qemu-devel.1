Return-Path: <SRS0=Dm/C=EH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFF8C2D0A3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 11:38:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62DF62084C
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 11:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="MbraUk0L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62DF62084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZBh3-0003FP-4v
	for qemu-devel@archiver.kernel.org; Sun, 01 Nov 2020 06:38:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kZBgU-0002px-S3
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 06:38:06 -0500
Received: from lizzy.crudebyte.com ([91.194.90.13]:42537)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kZBgS-0004wp-EP
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 06:38:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=/RtsjjAmQ4CtG7d5WjdFakwkbjOVMiyHSo2LwZHmNNo=; b=MbraUk0LFEvGD5s4jInEl+aWz+
 6/7H/TDvNfGS/HoSH/JKXj7zK2irtKccFSbw9m8MSa88lnJI4/A7ASwSKgyC1AAxyn95fs+ukeD9n
 t/WttBhNxHj6A3oskuFd9DxB7upHU/c2lwVYEjSYKZ/yBEz0qnP+J9BURx9bXCjRzzQmAmPlzh0+G
 2L/0DNkQ/Kym7ZyuF4wuDEGPkr8tz2tFbdVCTtuwKRp8ZCcEtd8HCYgwKGNVqYO4hzz8pyXtL+i2s
 fgPfZrtwsB9x4S+ZtKseRbL2RdH4I6nJKnGNcbbvzrLcT1YAdbKXeovpyYM1+q35xw4muCT8y7wE6
 2mXx9vew==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>
Subject: Re: [PULL v2 01/16] tests/9pfs: fix test dir for parallel tests
Date: Sun, 01 Nov 2020 12:37:59 +0100
Message-ID: <1886506.6T3G6YSIUY@silver>
In-Reply-To: <5877759.JlKFulrene@silver>
References: <cover.1604067568.git.qemu_oss@crudebyte.com>
 <fd3237f7b005b1b73c954ccd5c6011e8228e19a3.1604067568.git.qemu_oss@crudebyte.com>
 <5877759.JlKFulrene@silver>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/01 05:17:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Samstag, 31. Oktober 2020 14:20:27 CET Christian Schoenebeck wrote:
> On Freitag, 30. Oktober 2020 13:07:03 CET Christian Schoenebeck wrote:
> > Use mkdtemp() to generate a unique directory for the 9p 'local' tests.
> > 
> > This fixes occasional 9p test failures when running 'make check -jN' if
> > QEMU was compiled for multiple target architectures, because the
> > individual
> > architecture's test suites would run in parallel and interfere with each
> > other's data as the test directory was previously hard coded and hence the
> > same directory was used by all of them simultaniously.
> > 
> > This also requires a change how the test directory is created and deleted:
> > As the test path is now randomized and virtio_9p_register_nodes() being
> > called in a somewhat undeterministic way, that's no longer an appropriate
> > place to create and remove the test directory. Use a constructor and
> > destructor function for creating and removing the test directory instead.
> > Unfortunately libqos currently does not support setup/teardown callbacks
> > to handle this more cleanly.
> 
> Peter, please ignore this PR. This patch needs rework:
> 
> ERROR:../tests/qtest/test-x86-cpuid-compat.c:208:test_plus_minus: stdout of
> child process (/x86/cpuid/parsing-plus-minus/subprocess [34856]) failed to
> match:
> 
> stdout was:
> 
> # mkdir('/home/travis/build/cschoenebeck/qemu/build/qtest-9p-local-PwY2nQ')
> failed: File exists
> 
> ERROR qtest-x86_64/test-x86-cpuid-compat - Bail out! ERROR:../tests/qtest/
> test-x86-cpuid-compat.c:208:test_plus_minus: stdout of child process (/x86/
> cpuid/parsing-plus-minus/subprocess [34856]) failed to match:
> 
> make: *** [Makefile.mtest:1793: run-test-222] Error 1
> 
> https://travis-ci.org/github/cschoenebeck/qemu/jobs/740199494

Ok, I found a solution: by moving constructor & destructor functions from 
virtio-9p.c to virtio-9p-test.c:
https://github.com/cschoenebeck/qemu/commit/b4c72149f087d5a

The problem was that the constructor function was executed when libqos was 
loaded, which included completely unrelated test suites that just link to 
libqos.

In conjunction with Peter Xu's two migration patches (fixing occasional 
lockups of migration tests) overall situation appears to be smooth now:
https://lore.kernel.org/qemu-devel/20201030135350.GA588069@xz-x1/

There is now only one test failure left concerning macOS Xcode builds, but 
that seems to be completely unrelated to our 9pfs patches:
https://github.com/cschoenebeck/qemu/runs/1338011297

missing object type 'vhost-user-gpu'
Broken pipe
../tests/qtest/libqtest.c:176: kill_qemu() detected QEMU death from signal 6 
(Abort trap: 6)
ERROR qtest-aarch64/device-introspect-test - too few tests run (expected 6, 
got 5)
gmake: *** [Makefile.mtest:905: run-test-111] Error 1

I prepare updated patches for review.

Best regards,
Christian Schoenebeck



