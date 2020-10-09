Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62863C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 12:11:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C32822284
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 12:11:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C32822284
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQrFJ-0004TV-C9
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 08:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1kQrDy-0003ZS-RH; Fri, 09 Oct 2020 08:10:14 -0400
Received: from mail.ispras.ru ([83.149.199.84]:49940)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1kQrDx-0006ls-0g; Fri, 09 Oct 2020 08:10:14 -0400
Received: from [192.168.0.183] (unknown [62.118.151.149])
 by mail.ispras.ru (Postfix) with ESMTPSA id 6898C40A1DCD;
 Fri,  9 Oct 2020 12:10:10 +0000 (UTC)
Subject: Re: [PATCH 3/3] migration: stop returning errno from load_snapshot()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20201008174803.2696619-1-philmd@redhat.com>
 <20201008174803.2696619-4-philmd@redhat.com>
From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
Message-ID: <d717257b-e86a-827c-5423-b0bde20c46b1@ispras.ru>
Date: Fri, 9 Oct 2020 15:10:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201008174803.2696619-4-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=83.149.199.84;
 envelope-from=pavel.dovgalyuk@ispras.ru; helo=mail.ispras.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 06:35:55
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.208,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08.10.2020 20:48, Philippe Mathieu-Daudé wrote:
> From: Daniel P. Berrangé <berrange@redhat.com>
> 
> None of the callers care about the errno value since there is a full
> Error object populated. This gives consistency with save_snapshot()
> which already just returns a boolean value.
> 
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> [PMD: Return false/true instead of -1/0, document function]
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Acked-by: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>

> ---
>   include/migration/snapshot.h |  9 ++++++++-
>   migration/savevm.c           | 19 +++++++++----------
>   monitor/hmp-cmds.c           |  2 +-
>   replay/replay-snapshot.c     |  2 +-
>   softmmu/vl.c                 |  2 +-
>   5 files changed, 20 insertions(+), 14 deletions(-)
> 
> diff --git a/include/migration/snapshot.h b/include/migration/snapshot.h
> index a40c34307b..9bc989a6b4 100644
> --- a/include/migration/snapshot.h
> +++ b/include/migration/snapshot.h
> @@ -23,6 +23,13 @@
>    * On failure, store an error through @errp and return %false.
>    */
>   bool save_snapshot(const char *name, Error **errp);
> -int load_snapshot(const char *name, Error **errp);
> +/**
> + * save_snapshot: Load a snapshot.
> + * @name: path to snapshot
> + * @errp: pointer to error object
> + * On success, return %true.
> + * On failure, store an error through @errp and return %false.
> + */
> +bool load_snapshot(const char *name, Error **errp);
>   
>   #endif
> diff --git a/migration/savevm.c b/migration/savevm.c
> index fd2e5e8b66..531bb2eca1 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2864,7 +2864,7 @@ void qmp_xen_load_devices_state(const char *filename, Error **errp)
>       migration_incoming_state_destroy();
>   }
>   
> -int load_snapshot(const char *name, Error **errp)
> +bool load_snapshot(const char *name, Error **errp)
>   {
>       BlockDriverState *bs_vm_state;
>       QEMUSnapshotInfo sn;
> @@ -2874,16 +2874,16 @@ int load_snapshot(const char *name, Error **errp)
>       MigrationIncomingState *mis = migration_incoming_get_current();
>   
>       if (!bdrv_all_can_snapshot(errp)) {
> -        return -ENOTSUP;
> +        return false;
>       }
>       ret = bdrv_all_find_snapshot(name, errp);
>       if (ret < 0) {
> -        return ret;
> +        return false;
>       }
>   
>       bs_vm_state = bdrv_all_find_vmstate_bs(errp);
>       if (!bs_vm_state) {
> -        return -ENOTSUP;
> +        return false;
>       }
>       aio_context = bdrv_get_aio_context(bs_vm_state);
>   
> @@ -2892,11 +2892,11 @@ int load_snapshot(const char *name, Error **errp)
>       ret = bdrv_snapshot_find(bs_vm_state, &sn, name);
>       aio_context_release(aio_context);
>       if (ret < 0) {
> -        return ret;
> +        return false;
>       } else if (sn.vm_state_size == 0) {
>           error_setg(errp, "This is a disk-only snapshot. Revert to it "
>                      " offline using qemu-img");
> -        return -EINVAL;
> +        return false;
>       }
>   
>       /*
> @@ -2917,7 +2917,6 @@ int load_snapshot(const char *name, Error **errp)
>       f = qemu_fopen_bdrv(bs_vm_state, 0);
>       if (!f) {
>           error_setg(errp, "Could not open VM state file");
> -        ret = -EINVAL;
>           goto err_drain;
>       }
>   
> @@ -2933,14 +2932,14 @@ int load_snapshot(const char *name, Error **errp)
>   
>       if (ret < 0) {
>           error_setg(errp, "Error %d while loading VM state", ret);
> -        return ret;
> +        return false;
>       }
>   
> -    return 0;
> +    return true;
>   
>   err_drain:
>       bdrv_drain_all_end();
> -    return ret;
> +    return false;
>   }
>   
>   void vmstate_register_ram(MemoryRegion *mr, DeviceState *dev)
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index 14848a3381..ff0e3df8a3 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -1123,7 +1123,7 @@ void hmp_loadvm(Monitor *mon, const QDict *qdict)
>   
>       vm_stop(RUN_STATE_RESTORE_VM);
>   
> -    if (load_snapshot(name, &err) == 0 && saved_vm_running) {
> +    if (!load_snapshot(name, &err) && saved_vm_running) {
>           vm_start();
>       }
>       hmp_handle_error(mon, err);
> diff --git a/replay/replay-snapshot.c b/replay/replay-snapshot.c
> index 4f2560d156..b289365937 100644
> --- a/replay/replay-snapshot.c
> +++ b/replay/replay-snapshot.c
> @@ -83,7 +83,7 @@ void replay_vmstate_init(void)
>                   exit(1);
>               }
>           } else if (replay_mode == REPLAY_MODE_PLAY) {
> -            if (load_snapshot(replay_snapshot, &err) != 0) {
> +            if (!load_snapshot(replay_snapshot, &err)) {
>                   error_report_err(err);
>                   error_report("Could not load snapshot for icount replay");
>                   exit(1);
> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index 5a11a62f78..6eaa6b3a09 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -4478,7 +4478,7 @@ void qemu_init(int argc, char **argv, char **envp)
>       register_global_state();
>       if (loadvm) {
>           Error *local_err = NULL;
> -        if (load_snapshot(loadvm, &local_err) < 0) {
> +        if (!load_snapshot(loadvm, &local_err)) {
>               error_report_err(local_err);
>               autostart = 0;
>               exit(1);
> 


