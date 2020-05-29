Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BCEC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 22:06:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5870420776
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 22:06:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5870420776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jen93-0003Nm-ET
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 18:06:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jen88-0002uT-Ax
 for qemu-devel@nongnu.org; Fri, 29 May 2020 18:05:32 -0400
Received: from relay68.bu.edu ([128.197.228.73]:60716)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jen86-0004yu-Ub
 for qemu-devel@nongnu.org; Fri, 29 May 2020 18:05:31 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay68.bu.edu (8.14.3/8.14.3) with ESMTP id 04TM4loo011561
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 29 May 2020 18:04:51 -0400
Date: Fri, 29 May 2020 18:04:47 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 1/2] fuzz: skip QTest serialization
Message-ID: <20200529220447.6jd4l3mk5pncn5hm@mozz.bu.edu>
References: <20200529180210.28120-1-alxndr@bu.edu>
 <20200529180210.28120-2-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200529180210.28120-2-alxndr@bu.edu>
User-Agent: NeoMutt/20180716
Received-SPF: pass client-ip=128.197.228.73; envelope-from=alxndr@bu.edu;
 helo=relay68.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 18:05:29
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 f4bug@amsat.org, darren.kenny@oracle.com, bsd@redhat.com, stefanha@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is missing the actual wrapper functions... Sending v3

On 200529 1402, Alexander Bulekov wrote:
> The QTest server usually parses ASCII commands from clients. Since we
> fuzz within the QEMU process, skip the QTest serialization and server
> for most QTest commands. Leave the option to use the ASCII protocol, to
> generate readable traces for crash reproducers.
> 
> Inspired-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
>  tests/qtest/fuzz/Makefile.include | 21 +++++++++++++++++++++
>  tests/qtest/fuzz/fuzz.c           | 14 +++++++++++++-
>  tests/qtest/fuzz/fuzz.h           |  3 +++
>  3 files changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/fuzz/Makefile.include b/tests/qtest/fuzz/Makefile.include
> index f259d866c9..5bde793bf2 100644
> --- a/tests/qtest/fuzz/Makefile.include
> +++ b/tests/qtest/fuzz/Makefile.include
> @@ -5,6 +5,7 @@ fuzz-obj-y += $(libqos-obj-y)
>  fuzz-obj-y += tests/qtest/fuzz/fuzz.o # Fuzzer skeleton
>  fuzz-obj-y += tests/qtest/fuzz/fork_fuzz.o
>  fuzz-obj-y += tests/qtest/fuzz/qos_fuzz.o
> +fuzz-obj-y += tests/qtest/fuzz/qtest_wrappers.o
>  
>  # Targets
>  fuzz-obj-$(CONFIG_PCI_I440FX) += tests/qtest/fuzz/i440fx_fuzz.o
> @@ -16,3 +17,23 @@ FUZZ_CFLAGS += -I$(SRC_PATH)/tests -I$(SRC_PATH)/tests/qtest
>  # Linker Script to force coverage-counters into known regions which we can mark
>  # shared
>  FUZZ_LDFLAGS += -Xlinker -T$(SRC_PATH)/tests/qtest/fuzz/fork_fuzz.ld
> +
> +FUZZ_LDFLAGS += -Wl,-wrap,qtest_inb
> +FUZZ_LDFLAGS += -Wl,-wrap,qtest_inw
> +FUZZ_LDFLAGS += -Wl,-wrap,qtest_inl
> +FUZZ_LDFLAGS += -Wl,-wrap,qtest_outb
> +FUZZ_LDFLAGS += -Wl,-wrap,qtest_outw
> +FUZZ_LDFLAGS += -Wl,-wrap,qtest_outl
> +FUZZ_LDFLAGS += -Wl,-wrap,qtest_readb
> +FUZZ_LDFLAGS += -Wl,-wrap,qtest_readw
> +FUZZ_LDFLAGS += -Wl,-wrap,qtest_readl
> +FUZZ_LDFLAGS += -Wl,-wrap,qtest_readq
> +FUZZ_LDFLAGS += -Wl,-wrap,qtest_writeb
> +FUZZ_LDFLAGS += -Wl,-wrap,qtest_writew
> +FUZZ_LDFLAGS += -Wl,-wrap,qtest_writel
> +FUZZ_LDFLAGS += -Wl,-wrap,qtest_writeq
> +FUZZ_LDFLAGS += -Wl,-wrap,qtest_memread
> +FUZZ_LDFLAGS += -Wl,-wrap,qtest_bufread
> +FUZZ_LDFLAGS += -Wl,-wrap,qtest_memwrite
> +FUZZ_LDFLAGS += -Wl,-wrap,qtest_bufwrite
> +FUZZ_LDFLAGS += -Wl,-wrap,qtest_memset
> diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
> index f5c923852e..cf76a6636f 100644
> --- a/tests/qtest/fuzz/fuzz.c
> +++ b/tests/qtest/fuzz/fuzz.c
> @@ -91,7 +91,10 @@ static void usage(char *path)
>          printf(" * %s  : %s\n", tmp->target->name,
>                  tmp->target->description);
>      }
> -    printf("Alternatively, add -target-FUZZ_TARGET to the executable name\n");
> +    printf("Alternatively, add -target-FUZZ_TARGET to the executable name\n\n"
> +           "Set the environment variable FUZZ_SERIALIZE_QTEST=1 to serialize\n"
> +           "QTest commands into an ASCII protocol. Useful for building crash\n"
> +           "reproducers, but slows down execution.\n");
>      exit(0);
>  }
>  
> @@ -137,6 +140,8 @@ int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
>  {
>  
>      char *target_name;
> +    char *dir;
> +    bool serialize = false;
>  
>      /* Initialize qgraph and modules */
>      qos_graph_init();
> @@ -157,6 +162,13 @@ int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
>          usage(**argv);
>      }
>  
> +    /* Should we always serialize qtest commands? */
> +    if (getenv("FUZZ_SERIALIZE_QTEST")) {
> +        serialize = true;
> +    }
> +
> +    fuzz_qtest_set_serialize(serialize);
> +
>      /* Identify the fuzz target */
>      fuzz_target = fuzz_get_target(target_name);
>      if (!fuzz_target) {
> diff --git a/tests/qtest/fuzz/fuzz.h b/tests/qtest/fuzz/fuzz.h
> index 03901d414e..72d5710f6c 100644
> --- a/tests/qtest/fuzz/fuzz.h
> +++ b/tests/qtest/fuzz/fuzz.h
> @@ -82,6 +82,9 @@ typedef struct FuzzTarget {
>  void flush_events(QTestState *);
>  void reboot(QTestState *);
>  
> +/* Use the QTest ASCII protocol or call address_space API directly?*/
> +void fuzz_qtest_set_serialize(bool option);
> +
>  /*
>   * makes a copy of *target and adds it to the target-list.
>   * i.e. fine to set up target on the caller's stack
> -- 
> 2.26.2
> 

