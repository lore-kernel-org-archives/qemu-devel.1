Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF408C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 16:58:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FACD221E7
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 16:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gt2ARY8S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FACD221E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGmNb-0008ML-43
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 12:58:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kGmMl-0007hT-9X
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 12:57:39 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20706
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kGmMj-0004YI-KI
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 12:57:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599843457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R1WpKWd7y5j+0Gw8kD8awFNw7R/WDyhk6VcRgk467C0=;
 b=gt2ARY8SfvX5cPisVnYatYZzdXrafnllX4FmopI33kLcLHpdavnx4E+m8LNyw0CD5jWYs/
 8rnkzoeF1Swl3CcNMjNTXSCAXq9EzAe6XO4A/XHdeSFi+HrQFraWfQ6TWOp2cEEIiUet3J
 jJg9K9KpiwJWB+QrVkIfxC+FRBy0W7w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-aYY8iHe5MBy4FEWsQcZ7vg-1; Fri, 11 Sep 2020 12:57:35 -0400
X-MC-Unique: aYY8iHe5MBy4FEWsQcZ7vg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2E33801F95;
 Fri, 11 Sep 2020 16:57:33 +0000 (UTC)
Received: from work-vm (ovpn-113-52.ams2.redhat.com [10.36.113.52])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 293267B7A0;
 Fri, 11 Sep 2020 16:57:18 +0000 (UTC)
Date: Fri, 11 Sep 2020 17:57:16 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH V1 04/32] savevm: HMP Command for cprsave
Message-ID: <20200911165716.GL3310@work-vm>
References: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
 <1596122076-341293-5-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
In-Reply-To: <1596122076-341293-5-git-send-email-steven.sistare@oracle.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 00:33:53
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
> Enable HMP access to the cprsave QMP command.
> 
> Usage: cprsave <filename> <mode>
> 
> Signed-off-by: Maran Wilson <maran.wilson@oracle.com>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

I realise that the current mode is currently only 'reboot' - can you
please give us a clue as to why you've got a mode argument that's
currently only got one mode?

Dave

> ---
>  hmp-commands.hx       | 18 ++++++++++++++++++
>  include/monitor/hmp.h |  1 +
>  monitor/hmp-cmds.c    | 10 ++++++++++
>  3 files changed, 29 insertions(+)
> 
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 60f395c..c8defd9 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -354,6 +354,24 @@ SRST
>  ERST
>  
>      {
> +        .name       = "cprsave",
> +        .args_type  = "file:s,mode:s",
> +        .params     = "file 'reboot'",
> +        .help       = "create a checkpoint of the VM in file",
> +        .cmd        = hmp_cprsave,
> +    },
> +
> +SRST
> +``cprsave`` *tag*
> +  Stop VCPUs, create a checkpoint of the whole virtual machine and save it
> +  in *file*.
> +  If *mode* is 'reboot', the checkpoint can be cprload'ed after a host kexec
> +  reboot.
> +  exec() /usr/bin/qemu-exec if it exists, else exec /usr/bin/qemu-system-x86_64,
> +  passing all the original command line arguments.  The VCPUs remain paused.
> +ERST
> +
> +    {
>          .name       = "delvm",
>          .args_type  = "name:s",
>          .params     = "tag",
> diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
> index c986cfd..af8ee23 100644
> --- a/include/monitor/hmp.h
> +++ b/include/monitor/hmp.h
> @@ -59,6 +59,7 @@ void hmp_balloon(Monitor *mon, const QDict *qdict);
>  void hmp_loadvm(Monitor *mon, const QDict *qdict);
>  void hmp_savevm(Monitor *mon, const QDict *qdict);
>  void hmp_delvm(Monitor *mon, const QDict *qdict);
> +void hmp_cprsave(Monitor *mon, const QDict *qdict);
>  void hmp_migrate_cancel(Monitor *mon, const QDict *qdict);
>  void hmp_migrate_continue(Monitor *mon, const QDict *qdict);
>  void hmp_migrate_incoming(Monitor *mon, const QDict *qdict);
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index ae4b6a4..59196ed 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -1139,6 +1139,16 @@ void hmp_announce_self(Monitor *mon, const QDict *qdict)
>      qapi_free_AnnounceParameters(params);
>  }
>  
> +void hmp_cprsave(Monitor *mon, const QDict *qdict)
> +{
> +    Error *err = NULL;
> +
> +    qmp_cprsave(qdict_get_try_str(qdict, "file"),
> +                qdict_get_try_str(qdict, "mode"),
> +                &err);
> +    hmp_handle_error(mon, err);
> +}
> +
>  void hmp_migrate_cancel(Monitor *mon, const QDict *qdict)
>  {
>      qmp_migrate_cancel(NULL);
> -- 
> 1.8.3.1
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


