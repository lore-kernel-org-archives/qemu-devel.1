Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38198C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 15:56:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8366F22258
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 15:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ihk0rCzV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8366F22258
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZcCX-00020V-KM
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 10:56:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33582)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kZcAx-0001Nf-1V
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 10:55:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52554)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kZcAt-0003xR-Fo
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 10:55:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604332513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VarGrj9Rs54J4Ib5xBIWPlERoM116/qAYpeM9NVgSbQ=;
 b=ihk0rCzV8w00f47BxhaFmIlVVJtKQIyXun8lZegEKB2/i0stzIfreOU1SWZ4DUnwIBueML
 aMm/fCqkyTMJT7Nlku1b+pcBcMHoTI5dkQP8q3mD/dTyDqXohOX8XGH1s5tBFqzu61vbE6
 Uv+kOr77qvF+LDlBb/mD+oU9muSiCKM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-XttFul7rNJiLTrm6z0s9LA-1; Mon, 02 Nov 2020 10:55:12 -0500
X-MC-Unique: XttFul7rNJiLTrm6z0s9LA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 193E2809DD6
 for <qemu-devel@nongnu.org>; Mon,  2 Nov 2020 15:55:11 +0000 (UTC)
Received: from localhost (unknown [10.40.208.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2699C5B4D4;
 Mon,  2 Nov 2020 15:55:09 +0000 (UTC)
Date: Mon, 2 Nov 2020 16:55:08 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 07/29] vl: extract qemu_init_subsystems
Message-ID: <20201102165508.7ff0e71d@redhat.com>
In-Reply-To: <20201027182144.3315885-8-pbonzini@redhat.com>
References: <20201027182144.3315885-1-pbonzini@redhat.com>
 <20201027182144.3315885-8-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 01:33:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 27 Oct 2020 14:21:22 -0400
Paolo Bonzini <pbonzini@redhat.com> wrote:

> Group a bunch of subsystem initializations that can be done right
> after command line parsing.  Remove initializations that can be done
> simply as global variable initializers.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  softmmu/vl.c | 94 ++++++++++++++++++++++++----------------------------
>  1 file changed, 43 insertions(+), 51 deletions(-)
> 
> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index b05340802a..a086cd7066 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -128,7 +128,7 @@ bool enable_mlock = false;
>  bool enable_cpu_pm = false;
>  int nb_nics;
>  NICInfo nd_table[MAX_NICS];
> -int autostart;
> +int autostart = 1;
>  static enum {
>      RTC_BASE_UTC,
>      RTC_BASE_LOCALTIME,
> @@ -1228,7 +1228,8 @@ struct VMChangeStateEntry {
>      int priority;
>  };
>  
> -static QTAILQ_HEAD(, VMChangeStateEntry) vm_change_state_head;
> +static QTAILQ_HEAD(, VMChangeStateEntry) vm_change_state_head =
> +    QTAILQ_HEAD_INITIALIZER(vm_change_state_head);
>  
>  /**
>   * qemu_add_vm_change_state_handler_prio:
> @@ -2965,11 +2966,45 @@ static void qemu_maybe_daemonize(const char *pid_file)
>      qemu_add_exit_notifier(&qemu_unlink_pidfile_notifier);
>  }
>  
> +static void qemu_init_subsystems(void)
> +{
> +    Error *err;
> +
> +    os_set_line_buffering();
> +
> +    module_call_init(MODULE_INIT_TRACE);
> +
> +    qemu_init_cpu_list();
> +    qemu_init_cpu_loop();
> +    qemu_mutex_lock_iothread();
> +
> +    atexit(qemu_run_exit_notifiers);
> +
> +    module_call_init(MODULE_INIT_QOM);
> +    module_call_init(MODULE_INIT_MIGRATION);
> +
> +    runstate_init();
> +    precopy_infrastructure_init();
> +    postcopy_infrastructure_init();
> +    monitor_init_globals();
> +
> +    if (qcrypto_init(&err) < 0) {
> +        error_reportf_err(err, "cannot initialize crypto: ");
> +        exit(1);
> +    }
> +
> +    os_setup_early_signal_handling();
> +
> +    bdrv_init_with_whitelist();
> +    page_size_init();
> +    socket_init();
> +}
>  
>  void qemu_init(int argc, char **argv, char **envp)
>  {
>      int i;
> -    int snapshot, linux_boot;
> +    int snapshot = 0;
> +    int linux_boot;
>      const char *initrd_filename;
>      const char *kernel_filename, *kernel_cmdline;
>      const char *boot_order = NULL;
> @@ -2990,7 +3025,6 @@ void qemu_init(int argc, char **argv, char **envp)
>      ram_addr_t maxram_size;
>      uint64_t ram_slots = 0;
>      FILE *vmstate_dump_file = NULL;
> -    Error *main_loop_err = NULL;
>      Error *err = NULL;
>      const char *mem_path = NULL;
>      bool have_custom_ram_size;
> @@ -2998,22 +3032,6 @@ void qemu_init(int argc, char **argv, char **envp)
>      QemuPluginList plugin_list = QTAILQ_HEAD_INITIALIZER(plugin_list);
>      int mem_prealloc = 0; /* force preallocation of physical target memory */
>  
> -    os_set_line_buffering();
> -
> -    error_init(argv[0]);
> -    module_call_init(MODULE_INIT_TRACE);
> -
> -    qemu_init_cpu_list();
> -    qemu_init_cpu_loop();
> -
> -    qemu_mutex_lock_iothread();
> -
> -    atexit(qemu_run_exit_notifiers);
> -    qemu_init_exec_dir(argv[0]);
> -
> -    module_call_init(MODULE_INIT_QOM);
> -    module_call_init(MODULE_INIT_MIGRATION);
> -
>      qemu_add_opts(&qemu_drive_opts);
>      qemu_add_drive_opts(&qemu_legacy_drive_opts);
>      qemu_add_drive_opts(&qemu_common_drive_opts);
> @@ -3048,27 +3066,10 @@ void qemu_init(int argc, char **argv, char **envp)
>      qemu_add_opts(&qemu_fw_cfg_opts);
>      module_call_init(MODULE_INIT_OPTS);
>  
> -    runstate_init();
> -    precopy_infrastructure_init();
> -    postcopy_infrastructure_init();
> -    monitor_init_globals();
> -
> -    if (qcrypto_init(&err) < 0) {
> -        error_reportf_err(err, "cannot initialize crypto: ");
> -        exit(1);
> -    }
> -
> -    QTAILQ_INIT(&vm_change_state_head);
> -    os_setup_early_signal_handling();
> -
> -    cpu_option = NULL;
> -    snapshot = 0;
> -
> -    nb_nics = 0;
> -
> -    bdrv_init_with_whitelist();
> +    error_init(argv[0]);
> +    qemu_init_exec_dir(argv[0]);
>  
> -    autostart = 1;
> +    qemu_init_subsystems();
>  
>      /* first pass of option parsing */
>      optind = 1;
> @@ -3947,13 +3948,10 @@ void qemu_init(int argc, char **argv, char **envp)
>      qemu_process_help_options();
>      qemu_maybe_daemonize(pid_file);
>  
> -    if (qemu_init_main_loop(&main_loop_err)) {
> -        error_report_err(main_loop_err);
> -        exit(1);
> -    }
> +    qemu_init_main_loop(&error_fatal);
> +    cpu_timers_init();
>  
>      user_register_global_props();
> -
>      replay_configure(icount_opts);
>  
>      if (incoming && !preconfig_exit_requested) {
> @@ -4132,9 +4130,6 @@ void qemu_init(int argc, char **argv, char **envp)
>          exit(1);
>      }
>  
> -    page_size_init();
> -    socket_init();
> -
>      qemu_opts_foreach(qemu_find_opts("object"),
>                        user_creatable_add_opts_foreach,
>                        object_create_initial, &error_fatal);
> @@ -4251,9 +4246,6 @@ void qemu_init(int argc, char **argv, char **envp)
>          semihosting_arg_fallback(kernel_filename, kernel_cmdline);
>      }
>  
> -    /* initialize cpu timers and VCPU throttle modules */
> -    cpu_timers_init();
> -
>      if (default_net) {
>          QemuOptsList *net = qemu_find_opts("net");
>          qemu_opts_set(net, NULL, "type", "nic", &error_abort);


