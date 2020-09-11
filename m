Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157A8C43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 16:44:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6027E221EB
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 16:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TLZ0uSte"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6027E221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGmAD-0005d7-BB
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 12:44:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35072)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kGm9b-0005AS-Mg
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 12:44:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37989
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kGm9Z-0002iK-DP
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 12:44:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599842640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VEEK6IBJk451kOcGH0pGjHNGTcEnQ+dnBKQuuhd8gKQ=;
 b=TLZ0uStemyTks4uPSEVBFP2xgga9rdIeIw68LV9h0OLASDI/LkHAfP8dx8kmlMDxWHeQUO
 RxAxRaRT1/CFjArq+yztXu+BnTG9e4nrGZco7mYMY9LEfvaYinvIlZdqabRt3w2sf19UyG
 7a20+Nfetk0wZQ1VqXSPwYTYkjQUbzM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-kJRNCs49P8SgbwRjsQQamA-1; Fri, 11 Sep 2020 12:43:56 -0400
X-MC-Unique: kJRNCs49P8SgbwRjsQQamA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33D321009447;
 Fri, 11 Sep 2020 16:43:55 +0000 (UTC)
Received: from work-vm (ovpn-113-52.ams2.redhat.com [10.36.113.52])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D16575125;
 Fri, 11 Sep 2020 16:43:41 +0000 (UTC)
Date: Fri, 11 Sep 2020 17:43:38 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH V1 03/32] savevm: QMP command for cprsave
Message-ID: <20200911164338.GK3310@work-vm>
References: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
 <1596122076-341293-4-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
In-Reply-To: <1596122076-341293-4-git-send-email-steven.sistare@oracle.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0.004
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 03:28:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Steve Sistare (steven.sistare@oracle.com) wrote:
> To enable live reboot, provide the cprsave QMP command and the VMS_REBOOT
> vmstate-saving operation, which saves the state of the virtual machine in a
> simple file.
> 
> Syntax:
>   {'command':'cprsave', 'data':{'file':'str', 'mode':'str'}}
> 
>   The mode argument must be 'reboot'.  Additional modes will be defined in
>   the future.
> 
> Unlike the savevm command, cprsave supports any type of guest image and
> block device.  cprsave stops the VM so that guest ram and block devices are
> not modified after state is saved.  Guest ram must be mapped to a persistent
> memory file such as /dev/dax0.0.  The ram object vmstate handler and block
> device handler do not apply to VMS_REBOOT, so restrict them to VMS_MIGRATE
> or VMS_SNAPSHOT.  After cprsave completes successfully, qemu exits.
> 
> After issuing cprsave, the caller may update qemu, update the host kernel,
> reboot, start qemu using the same arguments as the original process, and
> issue the cprload command to restore the guest.  cprload is added by
> subsequent patches.
> 
> If the caller suspends the guest instead of stopping the VM, such as by
> issuing guest-suspend-ram to the qemu guest agent, then cprsave and cprload
> support guests with vfio devices.  The guest drivers suspend methods flush
> outstanding requests and re-initialize the devices, and thus there is no
> device state to save and restore.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Signed-off-by: Maran Wilson <maran.wilson@oracle.com>

Going back a step; could you.....

> ---
>  include/migration/vmstate.h |  1 +
>  include/sysemu/sysemu.h     |  2 ++
>  migration/block.c           |  1 +
>  migration/ram.c             |  1 +
>  migration/savevm.c          | 59 +++++++++++++++++++++++++++++++++++++++++++++
>  monitor/qmp-cmds.c          |  6 +++++
>  qapi/migration.json         | 14 +++++++++++
>  7 files changed, 84 insertions(+)
> 
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index fa575f9..c58551a 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -161,6 +161,7 @@ typedef enum {
>  typedef enum {
>      VMS_MIGRATE  = (1U << 1),
>      VMS_SNAPSHOT = (1U << 2),
> +    VMS_REBOOT   = (1U << 3),
>      VMS_MODE_ALL = ~0U
>  } VMStateMode;
>  
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index 4b6a5c4..6fe86e6 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -24,6 +24,8 @@ extern bool machine_init_done;
>  void qemu_add_machine_init_done_notifier(Notifier *notify);
>  void qemu_remove_machine_init_done_notifier(Notifier *notify);
>  
> +void save_cpr_snapshot(const char *file, const char *mode, Error **errp);
> +
>  extern int autostart;
>  
>  typedef enum {
> diff --git a/migration/block.c b/migration/block.c
> index 737b649..a69accb 100644
> --- a/migration/block.c
> +++ b/migration/block.c
> @@ -1023,6 +1023,7 @@ static SaveVMHandlers savevm_block_handlers = {
>      .load_state = block_load,
>      .save_cleanup = block_migration_cleanup,
>      .is_active = block_is_active,
> +    .mode_mask = VMS_MIGRATE | VMS_SNAPSHOT,
>  };
>  
>  void blk_mig_init(void)
> diff --git a/migration/ram.c b/migration/ram.c
> index 76d4fee..f0d5d9f 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -3795,6 +3795,7 @@ static SaveVMHandlers savevm_ram_handlers = {
>      .load_setup = ram_load_setup,
>      .load_cleanup = ram_load_cleanup,
>      .resume_prepare = ram_resume_prepare,
> +    .mode_mask = VMS_MIGRATE | VMS_SNAPSHOT,
>  };
>  
>  void ram_mig_init(void)
> diff --git a/migration/savevm.c b/migration/savevm.c
> index ce02b6b..ff1a46e 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2680,6 +2680,65 @@ int qemu_load_device_state(QEMUFile *f)
>      return 0;
>  }
>  
> +static QEMUFile *qf_file_open(const char *filename, int flags, int mode,
> +                              Error **errp)
> +{
> +    QIOChannel *ioc;
> +    int fd = qemu_open(filename, flags, mode);
> +
> +    if (fd < 0) {
> +        error_setg_errno(errp, errno, "%s(%s)", __func__, filename);
> +        return NULL;
> +    }
> +
> +    ioc = QIO_CHANNEL(qio_channel_file_new_fd(fd));
> +
> +    if (flags & O_WRONLY) {
> +        return qemu_fopen_channel_output(ioc);
> +    }
> +
> +    return qemu_fopen_channel_input(ioc);
> +}
> +
> +void save_cpr_snapshot(const char *file, const char *mode, Error **errp)
> +{
> +    int ret = 0;
> +    QEMUFile *f;
> +    VMStateMode op;
> +
> +    if (!strcmp(mode, "reboot")) {
> +        op = VMS_REBOOT;
> +    } else {
> +        error_setg(errp, "cprsave: bad mode %s", mode);
> +        return;
> +    }
> +
> +    f = qf_file_open(file, O_CREAT | O_WRONLY | O_TRUNC, 0600, errp);
> +    if (!f) {
> +        return;
> +    }
> +
> +    ret = global_state_store();
> +    if (ret) {
> +        error_setg(errp, "Error saving global state");
> +        qemu_fclose(f);
> +        return;
> +    }
> +
> +    vm_stop(RUN_STATE_SAVE_VM);
> +
> +    ret = qemu_savevm_state(f, op, errp);
> +    if ((ret < 0) && !*errp) {
> +        error_setg(errp, "qemu_savevm_state failed");
> +    }

just call qemu_save_device_state(f) there rather than introducing the
modes?
What you're doing is VERY similar to qmp_xen_save_devices_state and also
COLO's device state saving.

(and also very similar to migration with the x-ignore-shared flag set).

Dave

> +    qemu_fclose(f);
> +
> +    if (op == VMS_REBOOT) {
> +        no_shutdown = 0;
> +        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
> +    }
> +}
> +
>  int save_snapshot(const char *name, Error **errp)
>  {
>      BlockDriverState *bs, *bs1;
> diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
> index 864cbfa..9ec7b88 100644
> --- a/monitor/qmp-cmds.c
> +++ b/monitor/qmp-cmds.c
> @@ -35,6 +35,7 @@
>  #include "qapi/qapi-commands-machine.h"
>  #include "qapi/qapi-commands-misc.h"
>  #include "qapi/qapi-commands-ui.h"
> +#include "qapi/qapi-commands-migration.h"
>  #include "qapi/qmp/qerror.h"
>  #include "hw/mem/memory-device.h"
>  #include "hw/acpi/acpi_dev_interface.h"
> @@ -161,6 +162,11 @@ void qmp_cont(Error **errp)
>      }
>  }
>  
> +void qmp_cprsave(const char *file, const char *mode, Error **errp)
> +{
> +    save_cpr_snapshot(file, mode, errp);
> +}
> +
>  void qmp_system_wakeup(Error **errp)
>  {
>      if (!qemu_wakeup_suspend_enabled()) {
> diff --git a/qapi/migration.json b/qapi/migration.json
> index d500055..b61df1d 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1621,3 +1621,17 @@
>  ##
>  { 'event': 'UNPLUG_PRIMARY',
>    'data': { 'device-id': 'str' } }
> +
> +##
> +# @cprsave:
> +#
> +# Create a checkpoint of the virtual machine device state in @file.
> +# Guest RAM and guest block device blocks are not saved.
> +#
> +# @file: name of checkpoint file
> +# @mode: 'reboot' : checkpoint can be cprload'ed after a host kexec reboot.
> +#
> +# Since 5.0
> +##
> +{ 'command': 'cprsave', 'data': { 'file': 'str', 'mode': 'str' } }
> +
> -- 
> 1.8.3.1
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


