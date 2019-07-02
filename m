Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7035C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 16:10:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA18B206A3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 16:10:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA18B206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiLM9-00053A-Ds
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 12:10:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33507)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lvivier@redhat.com>) id 1hiKa9-00021r-JW
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:20:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lvivier@redhat.com>) id 1hiKa8-0006HQ-3X
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:20:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39074)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1hiKa0-0005An-8k
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:20:27 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1C755309265A;
 Tue,  2 Jul 2019 15:19:47 +0000 (UTC)
Received: from [10.36.116.109] (ovpn-116-109.ams2.redhat.com [10.36.116.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DAC5A5C29A;
 Tue,  2 Jul 2019 15:19:44 +0000 (UTC)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20190702150311.20467-1-peter.maydell@linaro.org>
From: Laurent Vivier <lvivier@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=lvivier@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <b0ee3bea-9871-7b98-4956-b5c8d51ca7a8@redhat.com>
Date: Tue, 2 Jul 2019 17:19:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190702150311.20467-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Tue, 02 Jul 2019 15:19:47 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.1] tests/migration-test: Fix read off
 end of aarch64_kernel array
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/07/2019 17:03, Peter Maydell wrote:
> The test aarch64 kernel is in an array defined with
>  unsigned char aarch64_kernel[] = { [...] }
> 
> which means it could be any size; currently it's quite small.
> However we write it to a file using init_bootfile(), which
> writes exactly 512 bytes to the file. This will break if
> we ever end up with a kernel larger than that, and will
> read garbage off the end of the array in the current setup
> where the kernel is smaller.
> 
> Make init_bootfile() take an argument giving the length of
> the data to write. This allows us to use it for all architectures
> (previously s390 had a special-purpose init_bootfile_s390x
> which hardcoded the file to write so it could write the
> correct length). We assert that the x86 bootfile really is
> exactly 512 bytes as it should be (and as we were previously
> just assuming it was).
> 
> This was detected by the clang-7 asan:
> ==15607==ERROR: AddressSanitizer: global-buffer-overflow on address 0x55a796f51d20 at pc 0x55a796b89c2f bp 0x7ffc58e89160 sp 0x7ffc58e88908
> READ of size 512 at 0x55a796f51d20 thread T0
>     #0 0x55a796b89c2e in fwrite (/home/petmay01/linaro/qemu-from-laptop/qemu/build/sanitizers/tests/migration-test+0xb0c2e)
>     #1 0x55a796c46492 in init_bootfile /home/petmay01/linaro/qemu-from-laptop/qemu/tests/migration-test.c:99:5
>     #2 0x55a796c46492 in test_migrate_start /home/petmay01/linaro/qemu-from-laptop/qemu/tests/migration-test.c:593
>     #3 0x55a796c44101 in test_baddest /home/petmay01/linaro/qemu-from-laptop/qemu/tests/migration-test.c:854:9
>     #4 0x7f906ffd3cc9  (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x72cc9)
>     #5 0x7f906ffd3bfa  (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x72bfa)
>     #6 0x7f906ffd3bfa  (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x72bfa)
>     #7 0x7f906ffd3ea1 in g_test_run_suite (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x72ea1)
>     #8 0x7f906ffd3ec0 in g_test_run (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x72ec0)
>     #9 0x55a796c43707 in main /home/petmay01/linaro/qemu-from-laptop/qemu/tests/migration-test.c:1187:11
>     #10 0x7f906e9abb96 in __libc_start_main /build/glibc-OTsEL5/glibc-2.27/csu/../csu/libc-start.c:310
>     #11 0x55a796b6c2d9 in _start (/home/petmay01/linaro/qemu-from-laptop/qemu/build/sanitizers/tests/migration-test+0x932d9)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> patchew's asan build doesn't spot this, so it's presumably
> using an older version of the sanitizers...
> 
> 
>  tests/migration-test.c | 22 +++++++---------------
>  1 file changed, 7 insertions(+), 15 deletions(-)
> 
> diff --git a/tests/migration-test.c b/tests/migration-test.c
> index 0cd014dbe51..b6434628e1c 100644
> --- a/tests/migration-test.c
> +++ b/tests/migration-test.c
> @@ -91,23 +91,13 @@ static const char *tmpfs;
>   */
>  #include "tests/migration/i386/a-b-bootblock.h"
>  #include "tests/migration/aarch64/a-b-kernel.h"
> -
> -static void init_bootfile(const char *bootpath, void *content)
> -{
> -    FILE *bootfile = fopen(bootpath, "wb");
> -
> -    g_assert_cmpint(fwrite(content, 512, 1, bootfile), ==, 1);
> -    fclose(bootfile);
> -}
> -
>  #include "tests/migration/s390x/a-b-bios.h"
>  
> -static void init_bootfile_s390x(const char *bootpath)
> +static void init_bootfile(const char *bootpath, void *content, size_t len)
>  {
>      FILE *bootfile = fopen(bootpath, "wb");
> -    size_t len = sizeof(s390x_elf);
>  
> -    g_assert_cmpint(fwrite(s390x_elf, len, 1, bootfile), ==, 1);
> +    g_assert_cmpint(fwrite(content, len, 1, bootfile), ==, 1);
>      fclose(bootfile);
>  }
>  
> @@ -537,7 +527,9 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>      got_stop = false;
>      bootpath = g_strdup_printf("%s/bootsect", tmpfs);
>      if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
> -        init_bootfile(bootpath, x86_bootsect);
> +        /* the assembled x86 boot sector should be exactly one sector large */
> +        assert(sizeof(x86_bootsect) == 512);
> +        init_bootfile(bootpath, x86_bootsect, sizeof(x86_bootsect));
>          extra_opts = use_shmem ? get_shmem_opts("150M", shmem_path) : NULL;
>          cmd_src = g_strdup_printf("-machine accel=%s -m 150M"
>                                    " -name source,debug-threads=on"
> @@ -555,7 +547,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>          start_address = X86_TEST_MEM_START;
>          end_address = X86_TEST_MEM_END;
>      } else if (g_str_equal(arch, "s390x")) {
> -        init_bootfile_s390x(bootpath);
> +        init_bootfile(bootpath, s390x_elf, sizeof(s390x_elf));
>          extra_opts = use_shmem ? get_shmem_opts("128M", shmem_path) : NULL;
>          cmd_src = g_strdup_printf("-machine accel=%s -m 128M"
>                                    " -name source,debug-threads=on"
> @@ -590,7 +582,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>          start_address = PPC_TEST_MEM_START;
>          end_address = PPC_TEST_MEM_END;
>      } else if (strcmp(arch, "aarch64") == 0) {
> -        init_bootfile(bootpath, aarch64_kernel);
> +        init_bootfile(bootpath, aarch64_kernel, sizeof(aarch64_kernel));
>          extra_opts = use_shmem ? get_shmem_opts("150M", shmem_path) : NULL;
>          cmd_src = g_strdup_printf("-machine virt,accel=%s,gic-version=max "
>                                    "-name vmsource,debug-threads=on -cpu max "
> 

Reviewed-by: Laurent Vivier <lvivier@redhat.com>

