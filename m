Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AFDC433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 12:10:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A736B22284
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 12:10:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A736B22284
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQrEb-0003mI-B2
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 08:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36208)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1kQrDT-0002uc-7c; Fri, 09 Oct 2020 08:09:43 -0400
Received: from mail.ispras.ru ([83.149.199.84]:49818)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1kQrDQ-0006Zu-Pk; Fri, 09 Oct 2020 08:09:42 -0400
Received: from [192.168.0.183] (unknown [62.118.151.149])
 by mail.ispras.ru (Postfix) with ESMTPSA id 007B940A1DB1;
 Fri,  9 Oct 2020 12:09:35 +0000 (UTC)
Subject: Re: [PATCH 2/3] migration: Make save_snapshot() return bool, not 0/-1
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20201008174803.2696619-1-philmd@redhat.com>
 <20201008174803.2696619-3-philmd@redhat.com>
From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
Message-ID: <6cea7daf-74a5-f866-8631-1c4d3e9bb48f@ispras.ru>
Date: Fri, 9 Oct 2020 15:09:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201008174803.2696619-3-philmd@redhat.com>
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
> Just for consistency, following the example documented since
> commit e3fe3988d7 ("error: Document Error API usage rules").
> Document the function.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Acked-by: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>

> ---
>   include/migration/snapshot.h |  9 ++++++++-
>   migration/savevm.c           | 16 ++++++++--------
>   replay/replay-debugging.c    |  2 +-
>   replay/replay-snapshot.c     |  2 +-
>   4 files changed, 18 insertions(+), 11 deletions(-)
> 
> diff --git a/include/migration/snapshot.h b/include/migration/snapshot.h
> index c85b6ec75b..a40c34307b 100644
> --- a/include/migration/snapshot.h
> +++ b/include/migration/snapshot.h
> @@ -15,7 +15,14 @@
>   #ifndef QEMU_MIGRATION_SNAPSHOT_H
>   #define QEMU_MIGRATION_SNAPSHOT_H
>   
> -int save_snapshot(const char *name, Error **errp);
> +/**
> + * save_snapshot: Save a snapshot.
> + * @name: path to snapshot
> + * @errp: pointer to error object
> + * On success, return %true.
> + * On failure, store an error through @errp and return %false.
> + */
> +bool save_snapshot(const char *name, Error **errp);
>   int load_snapshot(const char *name, Error **errp);
>   
>   #endif
> diff --git a/migration/savevm.c b/migration/savevm.c
> index a52da440f4..fd2e5e8b66 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2658,7 +2658,7 @@ int qemu_load_device_state(QEMUFile *f)
>       return 0;
>   }
>   
> -int save_snapshot(const char *name, Error **errp)
> +bool save_snapshot(const char *name, Error **errp)
>   {
>       BlockDriverState *bs;
>       QEMUSnapshotInfo sn1, *sn = &sn1, old_sn1, *old_sn = &old_sn1;
> @@ -2671,29 +2671,29 @@ int save_snapshot(const char *name, Error **errp)
>       AioContext *aio_context;
>   
>       if (migration_is_blocked(errp)) {
> -        return ret;
> +        return false;
>       }
>   
>       if (!replay_can_snapshot()) {
>           error_setg(errp, "Record/replay does not allow making snapshot "
>                      "right now. Try once more later.");
> -        return ret;
> +        return false;
>       }
>   
>       if (!bdrv_all_can_snapshot(errp)) {
> -        return ret;
> +        return false;
>       }
>   
>       /* Delete old snapshots of the same name */
>       if (name) {
>           if (bdrv_all_delete_snapshot(name, errp) < 0) {
> -            return ret;
> +            return false;
>           }
>       }
>   
>       bs = bdrv_all_find_vmstate_bs(errp);
>       if (bs == NULL) {
> -        return ret;
> +        return false;
>       }
>       aio_context = bdrv_get_aio_context(bs);
>   
> @@ -2702,7 +2702,7 @@ int save_snapshot(const char *name, Error **errp)
>       ret = global_state_store();
>       if (ret) {
>           error_setg(errp, "Error saving global state");
> -        return ret;
> +        return false;
>       }
>       vm_stop(RUN_STATE_SAVE_VM);
>   
> @@ -2779,7 +2779,7 @@ int save_snapshot(const char *name, Error **errp)
>       if (saved_vm_running) {
>           vm_start();
>       }
> -    return ret;
> +    return ret == 0;
>   }
>   
>   void qmp_xen_save_devices_state(const char *filename, bool has_live, bool live,
> diff --git a/replay/replay-debugging.c b/replay/replay-debugging.c
> index 8785489c02..5458a73fce 100644
> --- a/replay/replay-debugging.c
> +++ b/replay/replay-debugging.c
> @@ -327,7 +327,7 @@ void replay_gdb_attached(void)
>        */
>       if (replay_mode == REPLAY_MODE_PLAY
>           && !replay_snapshot) {
> -        if (save_snapshot("start_debugging", NULL) != 0) {
> +        if (!save_snapshot("start_debugging", NULL)) {
>               /* Can't create the snapshot. Continue conventional debugging. */
>           }
>       }
> diff --git a/replay/replay-snapshot.c b/replay/replay-snapshot.c
> index e26fa4c892..4f2560d156 100644
> --- a/replay/replay-snapshot.c
> +++ b/replay/replay-snapshot.c
> @@ -77,7 +77,7 @@ void replay_vmstate_init(void)
>   
>       if (replay_snapshot) {
>           if (replay_mode == REPLAY_MODE_RECORD) {
> -            if (save_snapshot(replay_snapshot, &err) != 0) {
> +            if (!save_snapshot(replay_snapshot, &err)) {
>                   error_report_err(err);
>                   error_report("Could not create snapshot for icount record");
>                   exit(1);
> 


