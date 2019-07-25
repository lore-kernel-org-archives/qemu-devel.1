Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8034DC76194
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 17:53:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5245B22BE8
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 17:53:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5245B22BE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqhvw-0005Nb-Ka
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 13:53:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34404)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hqhvg-0004bi-9l
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 13:53:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hqhve-0002NW-E9
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 13:53:24 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45586)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hqhve-0002LS-3U
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 13:53:22 -0400
Received: by mail-wr1-f65.google.com with SMTP id f9so51661132wre.12
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 10:53:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=z2RBga7NTTGJi7PiffDvM9zu9aqDYFVL5k+fMQ84fGQ=;
 b=a8WgKt2BSQsDUEmExttNK6WHTHWPrk2GTv9UHvRaIMuify6blZ7y1rS10wusexcbWB
 J4+fe/1TIJ+fJEZaZvQWMfUOfFQ05xW0OVTBCdEbkaCGhTO3RXWjw8e/pHfjpz6TLU0M
 periqKXfnkM5QsSHr3RtMQW2mxTx5pMUYnmxr3gHWq5fx5J+HurSrZuoNLK2PbHQWRhl
 YeC1/VoUD78zqZib0h0zow7GOHnm/QelCzS5nYdTUcSMme3HoeZMshby8uwcJHJs8I+C
 m0aurqmyHxZIXLMTKWdSm30ClCPa4w6L9VMyrX8tjxBSGVsNEj1sSYDmSSQZWwMgmtJt
 4tbA==
X-Gm-Message-State: APjAAAWGhkYCEdhVzQsXkJJ4Qo3LDbtLWqRDxRlz7EycsceYDJWiDiwN
 LNqqZ+Rap+crcxWWe2/3QAF46w==
X-Google-Smtp-Source: APXvYqzZREc1ZH4/Uc0BXYAlinNvSTL5NLfuT99s+OjsLrjva1ujJmMkZgsx3e8N/B2CzFIr/0QYMw==
X-Received: by 2002:a05:6000:1203:: with SMTP id
 e3mr19553603wrx.300.1564077200784; 
 Thu, 25 Jul 2019 10:53:20 -0700 (PDT)
Received: from [192.168.1.38] (190.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.190])
 by smtp.gmail.com with ESMTPSA id j6sm75403435wrx.46.2019.07.25.10.53.19
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 25 Jul 2019 10:53:20 -0700 (PDT)
To: "Oleinik, Alexander" <alxndr@bu.edu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20190725032321.12721-1-alxndr@bu.edu>
 <20190725032321.12721-17-alxndr@bu.edu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <139e1ca9-0da3-277b-baa6-94aa5372baac@redhat.com>
Date: Thu, 25 Jul 2019 19:53:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190725032321.12721-17-alxndr@bu.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [RFC 16/19] fuzz: add general fuzzer entrypoints
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "superirishdonkey@gmail.com" <superirishdonkey@gmail.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Aleksander,

On 7/25/19 5:23 AM, Oleinik, Alexander wrote:
> Defines LLVMFuzzerInitialize and LLVMFuzzerTestOneInput
> 
> Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
> ---
>  tests/fuzz/fuzz.c | 262 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/fuzz/fuzz.h |  96 +++++++++++++++++
>  2 files changed, 358 insertions(+)
>  create mode 100644 tests/fuzz/fuzz.c
>  create mode 100644 tests/fuzz/fuzz.h
> 
> diff --git a/tests/fuzz/fuzz.c b/tests/fuzz/fuzz.c
> new file mode 100644
> index 0000000000..0421b9402c
> --- /dev/null
> +++ b/tests/fuzz/fuzz.c
> @@ -0,0 +1,262 @@
> +#include "tests/fuzz/ramfile.h"
> +#include "migration/qemu-file.h"
> +#include "migration/global_state.h"
> +#include "migration/savevm.h"
> +#include "tests/libqtest.h"
> +#include "exec/memory.h"
> +#include "migration/migration.h"
> +#include "fuzz.h"
> +#include "tests/libqos/qgraph.h"
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <linux/userfaultfd.h>
> +#include <poll.h>
> +#include <pthread.h>
> +#include <sys/syscall.h>
> +#include <sys/types.h>
> +#include <sys/ioctl.h>
> +
> +QTestState *s;
> +
> +QEMUFile *ramfile;
> +QEMUFile *writefile;
> +ram_disk *rd; 
> +typedef QSLIST_HEAD(, FuzzTarget) FuzzTargetList;
> +
> +FuzzTargetList* fuzz_target_list;
> +
> +uint64_t total_mr_size = 0;
> +uint64_t mr_index = 0;
> +
> +const MemoryRegion* mrs[1000];
> +
> +
> +// Save just the VMStateDescriptors
> +void save_device_state(void)
> +{
> +    writefile = qemu_fopen_ram(&rd);
> +    global_state_store();
> +    qemu_save_device_state(writefile);
> +    qemu_fflush(writefile);
> +    ramfile = qemu_fopen_ro_ram(rd);
> +}
> +
> +// Save the entire vm state including RAM
> +void save_vm_state(void) 
> +{
> +    writefile = qemu_fopen_ram(&rd);
> +    vm_stop(RUN_STATE_SAVE_VM);
> +    global_state_store();
> +    qemu_savevm_state(writefile, NULL);
> +    qemu_fflush(writefile);
> +    ramfile = qemu_fopen_ro_ram(rd);
> +}
> +
> +/* Reset state by rebooting */
> +void reboot()
> +{
> +    qemu_system_reset(SHUTDOWN_CAUSE_NONE);
> +}
> +
> +/* Restore device state */
> +void load_device_state()
> +{
> +    qemu_freopen_ro_ram(ramfile);
> +
> +    int ret = qemu_load_device_state(ramfile);
> +    if (ret < 0){
> +        printf("reset error\n");
> +        exit(-1);
> +    }
> +}
> +
> +/* Restore full vm state */
> +void load_vm_state()
> +{
> +    qemu_freopen_ro_ram(ramfile);
> +
> +    vm_stop(RUN_STATE_RESTORE_VM);
> +    /* qemu_system_reset(SHUTDOWN_CAUSE_NONE); */
> +
> +    int ret = qemu_loadvm_state(ramfile);
> +    if (ret < 0){
> +        printf("reset error\n");
> +        exit(-1);
> +    }
> +    migration_incoming_state_destroy();
> +    vm_start();
> +}
> +
> +void qtest_setup()
> +{
> +    s = qtest_init_fuzz(NULL, NULL);
> +    global_qtest = s;
> +}
> +
> +void fuzz_add_target(const char* name,
> +        const char* description,
> +        void(*init_pre_main)(void),
> +        void(*init_pre_save)(void),
> +        void(*save_state)(void),
> +        void(*reset)(void),
> +        void(*pre_fuzz)(void),
> +        void(*fuzz)(const unsigned char*, size_t),
> +        void(*post_fuzz)(void),
> +        int* main_argc,
> +        char*** main_argv)
> +{
> +
> +    FuzzTarget *target;
> +    FuzzTarget *tmp;
> +    if(!fuzz_target_list)
> +        fuzz_target_list = g_new0(FuzzTargetList, 1);
> +
> +    QSLIST_FOREACH(tmp, fuzz_target_list, target_list) {
> +        if (g_strcmp0(tmp->name->str, name) == 0) {
> +            fprintf(stderr, "Error: Fuzz target name %s already in use\n", name);
> +            abort();
> +        }
> +    }
> +    target = g_new0(FuzzTarget, 1);
> +    target->name = g_string_new(name);
> +    target->description = g_string_new(description);
> +    target->init_pre_main = init_pre_main;
> +    target->init_pre_save = init_pre_save;
> +    target->save_state = save_state;
> +    target->reset = reset;
> +    target->pre_fuzz = pre_fuzz;
> +    target->fuzz = fuzz;
> +    target->post_fuzz = post_fuzz;
> +    target->main_argc = main_argc;
> +    target->main_argv = main_argv;
> +    QSLIST_INSERT_HEAD(fuzz_target_list, target, target_list);
> +}
> +
> +
> +FuzzTarget* fuzz_get_target(char* name)
> +{
> +    FuzzTarget* tmp;
> +    if(!fuzz_target_list){
> +        fprintf(stderr, "Fuzz target list not initialized");
> +        abort();
> +    }
> +
> +    QSLIST_FOREACH(tmp, fuzz_target_list, target_list) {
> +        if (g_strcmp0(tmp->name->str, name) == 0) {
> +            break;
> +        }
> +    }
> +    return tmp;
> +}
> +
> +FuzzTarget* fuzz_target;
> +
> +
> +
> +static void usage(void)
> +{
> +    printf("Usage: ./fuzz --FUZZ_TARGET [LIBFUZZER ARGUMENTS]\n");
> +    printf("where --FUZZ_TARGET is one of:\n");
> +    FuzzTarget* tmp;
> +    if(!fuzz_target_list){
> +        fprintf(stderr, "Fuzz target list not initialized");
> +        abort();
> +    }
> +    QSLIST_FOREACH(tmp, fuzz_target_list, target_list) {
> +        QSLIST_FOREACH(tmp, fuzz_target_list, target_list) {
> +            printf(" --%s  : %s\n", tmp->name->str, tmp->description->str);
> +        }
> +        exit(0);
> +    }
> +}
> +
> +// TODO: Replace this with QEMU's built-in linked list
> +static void enum_memory(void)
> +{
> +    mtree_info(true, true, true);
> +    fuzz_memory_region *fmr = g_new0(fuzz_memory_region, 1);
> +
> +    fmr->io = false;
> +    fmr->start = 0x100000;
> +    fmr->length = 0x10000;
> +    fmr->next = fuzz_memory_region_head;
> +    fuzz_memory_region_tail->next = fmr;
> +    fuzz_memory_region_tail = fmr;
> +    fmr = fuzz_memory_region_head;
> +
> +    while(true){
> +        fmr = fmr->next;
> +        if(fmr == fuzz_memory_region_head)
> +            break;
> +    }
> +}
> +
> +/* Executed for each fuzzing-input */
> +int LLVMFuzzerTestOneInput(const unsigned char *Data, size_t Size)
> +{
> +    /* e.g. Device bootstrapping */
> +    if(fuzz_target->pre_fuzz)
> +        fuzz_target->pre_fuzz();
> +
> +    if(fuzz_target->fuzz)
> +        fuzz_target->fuzz(Data, Size);
> +
> +    /* e.g. Copy counter bitmap to shm*/
> +    if(fuzz_target->post_fuzz)
> +        fuzz_target->post_fuzz();
> +
> +    /* e.g. Reboot the machine or vmload */
> +    if(fuzz_target->reset)
> +        fuzz_target->reset();
> +
> +    return 0;
> +}
> +
> +/* Executed once, prior to fuzzing */
> +int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
> +{
> +
> +    char *target_name;
> +
> +    // Initialize qgraph and modules
> +    qos_graph_init();
> +    module_call_init(MODULE_INIT_FUZZ_TARGET);
> +    module_call_init(MODULE_INIT_QOM);
> +    module_call_init(MODULE_INIT_LIBQOS);
> +
> +    if(*argc <= 1)
> +        usage();
> +
> +
> +    /* Identify the fuzz target */
> +    target_name = (*argv)[1];
> +    target_name+=2;
> +    fuzz_target = fuzz_get_target(target_name);
> +
> +    if(!fuzz_target)
> +    {
> +        fprintf(stderr, "Error: Fuzz fuzz_target name %s not found\n", target_name);
> +        usage();
> +    }
> +
> +    if(fuzz_target->init_pre_main)
> +        fuzz_target->init_pre_main();
> +
> +    /* Run QEMU's regular vl.c:main */
> +    real_main(*(fuzz_target->main_argc), *(fuzz_target->main_argv), NULL);
> +
> +
> +    /* Enumerate memory to identify mapped MMIO and I/O regions */
> +    enum_memory();
> +
> +    /* Good place to do any one-time device initialization (such as QOS init) */
> +    if(fuzz_target->init_pre_save)
> +        fuzz_target->init_pre_save();
> +
> +    /* If configured, this is where we save vm or device state to ramdisk */
> +    if(fuzz_target->save_state)
> +        fuzz_target->save_state();
> +
> +    return 0;
> +}
> diff --git a/tests/fuzz/fuzz.h b/tests/fuzz/fuzz.h
> new file mode 100644
> index 0000000000..02f26752eb
> --- /dev/null
> +++ b/tests/fuzz/fuzz.h
> @@ -0,0 +1,96 @@
> +#ifndef FUZZER_H_
> +#define FUZZER_H_
> +
> +#include "qemu/osdep.h"
> +#include "qemu/units.h"
> +#include "qapi/error.h"
> +#include "exec/memory.h"
> +#include "tests/libqtest.h"
> +#include "migration/qemu-file.h"
> +#include "ramfile.h"
> +
> +#include <linux/userfaultfd.h>
> +
> +
> +extern QTestState *s;
> +extern QEMUFile *writefile;
> +extern QEMUFile *ramfile;
> +extern ram_disk *rd;
> +
> +typedef struct FuzzTarget {
> +	GString* name;
> +	GString* description;
> +	void(*init_pre_main)(void);
> +	void(*init_pre_save)(void);
> +	void(*save_state)(void);
> +	void(*reset)(void);
> +	void(*pre_fuzz)(void);
> +	void(*fuzz)(const unsigned char*, size_t);
> +	void(*post_fuzz)(void);
> +	int* main_argc;
> +	char*** main_argv;
> +	QSLIST_ENTRY(FuzzTarget) target_list;
> +
> +} FuzzTarget;
> +
> +extern void* _ZN6fuzzer3TPCE;
> +/* extern uint8_t __sancov_trace_pc_guard_8bit_counters; */
> +/* extern uint8_t __sancov_trace_pc_pcs; */
> +extern void* __prof_nms_sect_data;
> +extern void* __prof_vnodes_sect_data;
> +
> +#define TPC_SIZE 0x0443c00
> +#define PROFILE_SIZE ( &__prof_vnodes_sect_data - &__prof_nms_sect_data)
> +
> +#define NUMPCS (1 << 21)
> +/* #define TPC_SIZE 0x33c00 */
> +
> +extern uint8_t *TPCCopy;
> +extern uint8_t *ARGCopy;
> +
> +void save_device_state(void);
> +void save_vm_state(void);
> +void reboot(void);
> +
> +void load_device_state(void);
> +void load_vm_state(void);
> +
> +
> +void save_device_state(void);
> +void qtest_setup(void);
> +void fuzz_register_mr(const MemoryRegion *mr);
> +
> +FuzzTarget* fuzz_get_target(char* name);
> +
> +extern FuzzTarget* fuzz_target;
> +
> +typedef struct fuzz_memory_region {
> +	bool io;
> +	uint64_t start;
> +	uint64_t length;
> +	struct fuzz_memory_region* next;
> +} fuzz_memory_region;
> +
> +extern fuzz_memory_region *fuzz_memory_region_head;
> +extern fuzz_memory_region *fuzz_memory_region_tail;
> +
> +extern uint64_t total_io_mem;
> +extern uint64_t total_ram_mem;
> +
> +void fuzz_add_target(const char* name,
> +	const char* description,
> +	void(*init_pre_main)(void),
> +	void(*init_pre_save)(void),
> +	void(*save_state)(void),
> +	void(*reset)(void),
> +	void(*pre_fuzz)(void),
> +	void(*fuzz)(const unsigned char*, size_t),
> +	void(*post_fuzz)(void),
> +	int* main_argc,
> +	char*** main_argv);

What about having in tests/fuzz/fuzz.h:

typedef struct FuzzTarget {
	GString* name;
	GString* description;
	void(*init_pre_main)(void);
	void(*init_pre_save)(void);
	void(*save_state)(void);
	void(*reset)(void);
	void(*pre_fuzz)(void);
	void(*fuzz)(const unsigned char*, size_t);
	void(*post_fuzz)(void);
	int* main_argc;
	char*** main_argv;
} FuzzTarget;

void fuzz_add_target(FuzzTarget *target);

And in tests/fuzz/fuzz.c:

typedef struct FuzzTargetState {
	FuzzTarget *target;
	QSLIST_ENTRY(FuzzTarget) target_list;
} FuzzTargetState;

> +
> +int LLVMFuzzerTestOneInput(const unsigned char *Data, size_t Size);
> +int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp);
> +
> +#endif
> +
> 

