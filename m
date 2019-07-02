Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59562C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 17:09:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF9602082F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 17:09:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF9602082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiMHg-0002LO-3Q
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 13:09:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38973)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hiKtp-0006By-21
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:40:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hiKtj-00023s-Fa
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:40:51 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39021)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hiKth-00021Y-La
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:40:45 -0400
Received: by mail-wr1-f67.google.com with SMTP id x4so18381348wrt.6
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 08:40:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fYeCQi0os7jmPhNB88DbZVjPSXVXb+/v4/XPNo2WZlo=;
 b=fjueIB5hoCqVn+mt9B5SufN9ndK5ixWdjFovHFRb2VH2GG8/0H8jKdleHoYp3AWodh
 lcDyCHRit4DSzdJRNurcNa5mXdOG2VPVVLsVg/rr/YdXCe2nD3f36ksU2B0ZJbRt7oZj
 +gp0e3AmIC2QzY1+vjLwZ7YnbOhZvVzrImzyizwPvNweQvgihsY4Xf/wkDqAymTf5rYD
 /lXqeZUWFZy+ftu264a9l7Ccdi9+jkK5PfYYIFJMtq8TBofqN2v5o+t/GxIoTL1ZX6cw
 AGmt8VCTF2ixlDpXfo/Elaor30L+YtVGsA7pP+c06BiWJoxkzp7JC3K/Awo0XFDGf5BM
 poDQ==
X-Gm-Message-State: APjAAAXiQrCJT53w0feZy0JT8RwRwah3dalDgqEdrb0DROwalX1rkQ9R
 tTP5ctj5oYf6EEyR58sW7cKrKQ==
X-Google-Smtp-Source: APXvYqylWW/P3Mn6odYaVb5dPvSaV15EMLC1OhdMensNd2TOXtbpDh9vstpErJ2cdpyjtrtL3I9fTA==
X-Received: by 2002:a5d:5342:: with SMTP id t2mr17950736wrv.126.1562082044650; 
 Tue, 02 Jul 2019 08:40:44 -0700 (PDT)
Received: from [192.168.1.38] (56.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.56])
 by smtp.gmail.com with ESMTPSA id w6sm13065254wrp.67.2019.07.02.08.40.43
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 02 Jul 2019 08:40:44 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20190702150311.20467-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <944807ae-3977-1782-2356-74dfcec4e98c@redhat.com>
Date: Tue, 2 Jul 2019 17:40:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190702150311.20467-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/2/19 5:03 PM, Peter Maydell wrote:
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

