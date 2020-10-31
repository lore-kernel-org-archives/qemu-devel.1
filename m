Return-Path: <SRS0=iivN=EG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A72EC388F7
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2020 13:21:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF9812068D
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2020 13:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="mbRlCyYz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF9812068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYqp9-0004xW-He
	for qemu-devel@archiver.kernel.org; Sat, 31 Oct 2020 09:21:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kYqo7-0004Me-Fy
 for qemu-devel@nongnu.org; Sat, 31 Oct 2020 09:20:35 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:42789)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kYqo5-0008SH-3t
 for qemu-devel@nongnu.org; Sat, 31 Oct 2020 09:20:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=WbDiM3VKjfxUeUJk4F43pQgNUSEHhs7ZBqOAkj8C8sI=; b=mbRlCyYzJV0f5qGJ8l7fVn4hte
 hRU+UOAzGoVw2ZP5GgcGC0kq3t/xLcJj7fV4GDCWq1Hn55nS84fhEZ26kge573bws/X/GjPuSgmrK
 nLN/CXH1j3FPd0+1u/felpZ7++OnvqFdYWpxroaoezyhoS/xrZKhKzcvCrzQwFUtRuzlXkZWUrc5V
 W++KX97q6QiyQLf4eFQ0b/Ab8npEUQhoT5KrkVGivj6gbTXAHsNyu6KRQxl0ivuoVLfzYCaZHB7P0
 pXIkTin9Xht2F7yuZBPumCnNwLsP+lk7s62c/yoBJ65kXmrevslmwsXCxCsuqWpCWkygohU9RhzEc
 7IP+GJ2Q==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>
Subject: Re: [PULL v2 01/16] tests/9pfs: fix test dir for parallel tests
Date: Sat, 31 Oct 2020 14:20:27 +0100
Message-ID: <5877759.JlKFulrene@silver>
In-Reply-To: <fd3237f7b005b1b73c954ccd5c6011e8228e19a3.1604067568.git.qemu_oss@crudebyte.com>
References: <cover.1604067568.git.qemu_oss@crudebyte.com>
 <fd3237f7b005b1b73c954ccd5c6011e8228e19a3.1604067568.git.qemu_oss@crudebyte.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/31 09:20:29
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

On Freitag, 30. Oktober 2020 13:07:03 CET Christian Schoenebeck wrote:
> Use mkdtemp() to generate a unique directory for the 9p 'local' tests.
> 
> This fixes occasional 9p test failures when running 'make check -jN' if
> QEMU was compiled for multiple target architectures, because the individual
> architecture's test suites would run in parallel and interfere with each
> other's data as the test directory was previously hard coded and hence the
> same directory was used by all of them simultaniously.
> 
> This also requires a change how the test directory is created and deleted:
> As the test path is now randomized and virtio_9p_register_nodes() being
> called in a somewhat undeterministic way, that's no longer an appropriate
> place to create and remove the test directory. Use a constructor and
> destructor function for creating and removing the test directory instead.
> Unfortunately libqos currently does not support setup/teardown callbacks
> to handle this more cleanly.

Peter, please ignore this PR. This patch needs rework:

ERROR:../tests/qtest/test-x86-cpuid-compat.c:208:test_plus_minus: stdout of
child process (/x86/cpuid/parsing-plus-minus/subprocess [34856]) failed to
match: 

stdout was:

# mkdir('/home/travis/build/cschoenebeck/qemu/build/qtest-9p-local-PwY2nQ')
failed: File exists

ERROR qtest-x86_64/test-x86-cpuid-compat - Bail out! ERROR:../tests/qtest/
test-x86-cpuid-compat.c:208:test_plus_minus: stdout of child process (/x86/
cpuid/parsing-plus-minus/subprocess [34856]) failed to match:

make: *** [Makefile.mtest:1793: run-test-222] Error 1

https://travis-ci.org/github/cschoenebeck/qemu/jobs/740199494

> 
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> Tested-by: Greg Kurz <groug@kaod.org>
> Reviewed-by: Greg Kurz <groug@kaod.org>
> Message-Id:
> <a37fbc713614f7615b11d0a3cb8d9adc3b8fba4b.1604061839.git.qemu_oss@crudebyte
> .com> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---
>  tests/qtest/libqos/virtio-9p.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/qtest/libqos/virtio-9p.c b/tests/qtest/libqos/virtio-9p.c
> index d43647b3b7..6b22fa0e9a 100644
> --- a/tests/qtest/libqos/virtio-9p.c
> +++ b/tests/qtest/libqos/virtio-9p.c
> @@ -35,7 +35,12 @@ static char *concat_path(const char* a, const char* b)
>  static void init_local_test_path(void)
>  {
>      char *pwd = g_get_current_dir();
> -    local_test_path = concat_path(pwd, "qtest-9p-local");
> +    char *template = concat_path(pwd, "qtest-9p-local-XXXXXX");
> +    local_test_path = mkdtemp(template);
> +    if (!local_test_path) {
> +        g_test_message("mkdtemp('%s') failed: %s", template,
> strerror(errno)); +    }
> +    g_assert(local_test_path);
>      g_free(pwd);
>  }
> 
> @@ -246,11 +251,6 @@ static void virtio_9p_register_nodes(void)
>      const char *str_simple = "fsdev=fsdev0,mount_tag=" MOUNT_TAG;
>      const char *str_addr = "fsdev=fsdev0,addr=04.0,mount_tag=" MOUNT_TAG;
> 
> -    /* make sure test dir for the 'local' tests exists and is clean */
> -    init_local_test_path();
> -    remove_local_test_dir();
> -    create_local_test_dir();
> -
>      QPCIAddress addr = {
>          .devfn = QPCI_DEVFN(4, 0),
>      };
> @@ -278,3 +278,16 @@ static void virtio_9p_register_nodes(void)
>  }
> 
>  libqos_init(virtio_9p_register_nodes);
> +
> +static void __attribute__((constructor)) construct_virtio_9p(void)
> +{
> +    /* make sure test dir for the 'local' tests exists */
> +    init_local_test_path();
> +    create_local_test_dir();
> +}

I'm not sure yet what happens there exactly. One problem that I can see is 
that this constructor function is executed before main() is entered, it 
generates a random test path as global variable, creates that test directory, 
then main() is entered and qost-test.c might now call g_test_trap_subprocess() 
(depending on the config) which would fork the process for the individual test 
cases, probably ending up with a shared test dir path unintentionally. So this 
constructor solution is probably wrong anyway.

But that does not explain what I'm seeing in above's CI error: that error 
message suggests that create_local_test_dir() was called in parallel with the 
same test path. A GCC constructor function being called again on fork() is not 
an expected behaviour to me, but assuming it does on some system, the address 
space should have deviated at this point and hence each subprocess should end 
up with overwriting the global test path variable with their own test 
directory path in this case.

It's too late for touching libqos for this, so I hope we can find a temporary 
workaround for this problem for 5.2 release. For instance by using a TLS 
(__thread) variable instead of a regular global variable for the test path, 
but I would still like to understand the precise (mis)behaviour observed 
there.

> +
> +static void __attribute__((destructor)) destruct_virtio_9p(void)
> +{
> +    /* remove previously created test dir when test suite completed */
> +    remove_local_test_dir();
> +}



