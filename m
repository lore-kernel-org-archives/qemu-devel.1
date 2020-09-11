Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65361C43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 18:50:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFF102087C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 18:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="atOZmKmb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFF102087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGo8D-0007Cl-O5
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 14:50:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34502)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kGo7P-0006L0-PN
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 14:49:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42955
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kGo7O-0003NK-5O
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 14:49:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599850193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dKNgVZ0Zf+0Bj4F5BYXWJ2ztH/ltnx/ECH9VZWGY7NE=;
 b=atOZmKmbG2l7h1N93+tGoLxQLR7SZXch9ND8KZMsMq0449GbXPVWLcxJ+7RkkldWjvg5ex
 LVTIgHCqHJ9ovBE/pdfvYe99ZTjf+NGxVogU2t3u+CZTGUDDL3yX8syH6XJ+6zj2TfJufi
 1YJbx0m7xiJ40/xvLbkSmHoTi7XCA2s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-Rpxi7911O4-DOKOh159jTQ-1; Fri, 11 Sep 2020 14:49:49 -0400
X-MC-Unique: Rpxi7911O4-DOKOh159jTQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66AC81007480;
 Fri, 11 Sep 2020 18:49:48 +0000 (UTC)
Received: from work-vm (ovpn-113-52.ams2.redhat.com [10.36.113.52])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D76F610013BD;
 Fri, 11 Sep 2020 18:49:29 +0000 (UTC)
Date: Fri, 11 Sep 2020 19:49:27 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH V1 15/32] vl: QEMU_START_FREEZE env var
Message-ID: <20200911184927.GU3310@work-vm>
References: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
 <1596122076-341293-16-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
In-Reply-To: <1596122076-341293-16-git-send-email-steven.sistare@oracle.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 09:43:46
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
> For qemu upgrade and restart, we will re-exec() qemu with the same argv.
> However, qemu must start in a paused state and wait for the cprload command,
> and the original argv might not contain the -S option.  To avoid modifying
> argv, provide the QEMU_START_FREEZE environment variable.  If
> QEMU_START_FREEZE is set, then set autostart=0, like the -S option.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

What's wrong with modifying the argv?

Note, also the trick -incoming defer uses;  the whole point here is that
we start qemu with   -incoming defer     and then we can issue commands
to modify the QEMU configuration before we actually reload state.

Note, even without CPR there might be reasons that you need to modify
the argv; for example, imagine that since it was originally booted
someone had hotplug added an extra CPU or RAM or a disk; the new QEMU
must be started in a state that reflects the state in which the VM was
at the point when it was saved, not the point at which it was started
long ago.

Dave

> ---
>  softmmu/vl.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index 951994f..7016e39 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -4501,6 +4501,11 @@ void qemu_init(int argc, char **argv, char **envp)
>          exit(0);
>      }
>  
> +    if (getenv("QEMU_START_FREEZE")) {
> +        unsetenv("QEMU_START_FREEZE");
> +        autostart = 0;
> +    }
> +
>      if (incoming) {
>          Error *local_err = NULL;
>          qemu_start_incoming_migration(incoming, &local_err);
> -- 
> 1.8.3.1
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


