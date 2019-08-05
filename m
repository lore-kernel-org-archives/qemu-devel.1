Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDCDC0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 10:55:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7C922087B
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 10:55:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7C922087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huadz-0004C8-Tm
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 06:55:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49655)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1huadX-0003mN-GM
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 06:54:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1huadW-000718-H3
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 06:54:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:5829)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1huadW-00070a-Bm
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 06:54:42 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 43C6A7F769;
 Mon,  5 Aug 2019 10:54:41 +0000 (UTC)
Received: from work-vm (ovpn-117-168.ams2.redhat.com [10.36.117.168])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 362AF60603;
 Mon,  5 Aug 2019 10:54:34 +0000 (UTC)
Date: Mon, 5 Aug 2019 11:54:32 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Message-ID: <20190805105432.GH13734@work-vm>
References: <20190805071038.32146-1-alxndr@bu.edu>
 <20190805071038.32146-9-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805071038.32146-9-alxndr@bu.edu>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Mon, 05 Aug 2019 10:54:41 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC PATCH v2 08/17] fuzz: Export the
 qemu_savevm_live_state function
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Oleinik, Alexander (alxndr@bu.edu) wrote:
> Skip the header when saving device state, as the header isn't handled by
> qemu_load_device_state
> 
> Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
> ---
>  migration/savevm.c | 9 +++++++--
>  migration/savevm.h | 2 ++
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 79ed44d475..5eac36e6ca 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1405,7 +1405,7 @@ void qemu_savevm_state_cleanup(void)
>      }
>  }
>  
> -static int qemu_savevm_state(QEMUFile *f, Error **errp)
> +int qemu_savevm_state(QEMUFile *f, Error **errp)
>  {
>      int ret;
>      MigrationState *ms = migrate_get_current();
> @@ -1471,11 +1471,16 @@ void qemu_savevm_live_state(QEMUFile *f)
>  int qemu_save_device_state(QEMUFile *f)
>  {
>      SaveStateEntry *se;
> -
> +    /*
> +     * qemu_load_device_state doesn't load the header. Either skip writing the
> +     * header or seek forward in the file, prior to loading device state
> +     */
> +#ifndef CONFIG_FUZZ
>      if (!migration_in_colo_state()) {
>          qemu_put_be32(f, QEMU_VM_FILE_MAGIC);
>          qemu_put_be32(f, QEMU_VM_FILE_VERSION);
>      }
> +#endif

I'd prefer if you just added a ', bool save_header' to the parameters
and then replace the '!migration_in_colo_state()' by 'save_header'

It's only called from two places at the moment,
'qmp_xen_save_devices_state' where I think it's always 'true'
and 'colo_do_checkpoint_transaction' where I think it's always false.

Dave

>      cpu_synchronize_all_states();
>  
>      QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> diff --git a/migration/savevm.h b/migration/savevm.h
> index 51a4b9caa8..5405215cb4 100644
> --- a/migration/savevm.h
> +++ b/migration/savevm.h
> @@ -64,4 +64,6 @@ void qemu_loadvm_state_cleanup(void);
>  int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);
>  int qemu_load_device_state(QEMUFile *f);
>  
> +int qemu_savevm_state(QEMUFile *f, Error **errp);
> +
>  #endif
> -- 
> 2.20.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

