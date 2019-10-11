Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC3EC47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 10:13:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F4672190F
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 10:13:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F4672190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIruz-00087w-68
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 06:13:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33171)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iIruD-0007i5-W8
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 06:12:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iIruC-0003ch-LE
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 06:12:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38402)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iIruC-0003cS-FO
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 06:12:16 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6EAA710C0932;
 Fri, 11 Oct 2019 10:12:15 +0000 (UTC)
Received: from work-vm (ovpn-117-210.ams2.redhat.com [10.36.117.210])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A0E4A196B2;
 Fri, 11 Oct 2019 10:12:11 +0000 (UTC)
Date: Fri, 11 Oct 2019 11:12:09 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: [PATCH v2 2/2] migration/postcopy: check PostcopyState before
 setting to POSTCOPY_INCOMING_RUNNING
Message-ID: <20191011101209.GM3354@work-vm>
References: <20191010011316.31363-1-richardw.yang@linux.intel.com>
 <20191010011316.31363-3-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010011316.31363-3-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Fri, 11 Oct 2019 10:12:15 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: qemu-devel@nongnu.org, peterx@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Wei Yang (richardw.yang@linux.intel.com) wrote:
> Currently, we set PostcopyState blindly to RUNNING, even we found the
> previous state is not LISTENING. This will lead to a corner case.
> 
> First let's look at the code flow:
> 
> qemu_loadvm_state_main()
>     ret = loadvm_process_command()
>         loadvm_postcopy_handle_run()
>             return -1;
>     if (ret < 0) {
>         if (postcopy_state_get() == POSTCOPY_INCOMING_RUNNING)
>             ...
>     }
> 
> >From above snippet, the corner case is loadvm_postcopy_handle_run()
> always sets state to RUNNING. And then it checks the previous state. If
> the previous state is not LISTENING, it will return -1. But at this
> moment, PostcopyState is already been set to RUNNING.
> 
> Then ret is checked in qemu_loadvm_state_main(), when it is -1
> PostcopyState is checked. Current logic would pause postcopy and retry
> if PostcopyState is RUNNING. This is not what we expect, because
> postcopy is not active yet.
> 
> This patch makes sure state is set to RUNNING only previous state is
> LISTENING by checking the state first.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> Suggested by: Peter Xu <peterx@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/savevm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 78c2965ca4..b9f30a7090 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1934,7 +1934,7 @@ static void loadvm_postcopy_handle_run_bh(void *opaque)
>  /* After all discards we can start running and asking for pages */
>  static int loadvm_postcopy_handle_run(MigrationIncomingState *mis)
>  {
> -    PostcopyState ps = postcopy_state_set(POSTCOPY_INCOMING_RUNNING);
> +    PostcopyState ps = postcopy_state_get();
>  
>      trace_loadvm_postcopy_handle_run();
>      if (ps != POSTCOPY_INCOMING_LISTENING) {
> @@ -1942,6 +1942,7 @@ static int loadvm_postcopy_handle_run(MigrationIncomingState *mis)
>          return -1;
>      }
>  
> +    postcopy_state_set(POSTCOPY_INCOMING_RUNNING);
>      mis->bh = qemu_bh_new(loadvm_postcopy_handle_run_bh, mis);
>      qemu_bh_schedule(mis->bh);
>  
> -- 
> 2.17.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

