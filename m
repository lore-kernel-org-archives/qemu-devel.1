Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93A2C43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 15:08:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57AB020855
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 15:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AJu6XHpa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57AB020855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGkel-0001W3-6N
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 11:08:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37782)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kGkbj-0006mr-7X
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 11:04:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33003)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kGkbf-000200-U2
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 11:04:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599836694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Oc4Uch8ZqNOOm3/lhP7cN+3AqzrZd9U/veR1JNamV/Y=;
 b=AJu6XHpausvJSQLplQXVSQFx61ice39ZE2/hBbdUv3ihq4KNAVAtA1AOg+18hzgF/2MT0E
 3e9y8OBkTHcjAsozezZSyFvUOYmVbkBlzIbcV9HhBFBtnGEWK/V6ZUYP83hIzZuCvixb1O
 Vo1l3Ng1wEOqdt4BX6Ynk1ASHg0Hkwc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-AgupYHGGNwaU_eiyi_--wA-1; Fri, 11 Sep 2020 11:04:52 -0400
X-MC-Unique: AgupYHGGNwaU_eiyi_--wA-1
Received: by mail-wr1-f72.google.com with SMTP id i10so3594036wrq.5
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 08:04:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Oc4Uch8ZqNOOm3/lhP7cN+3AqzrZd9U/veR1JNamV/Y=;
 b=JFLG2f6g7z/wbxID29JqziwcbaZlyzecgYvnYgR/Ec7Mbk2Y021sE4T1Cy1vddT71d
 1v372780c8sZK3yi9qAE1JjIBo598CSuDANLDAnawgNbZdzFLQlXRBmlKowN5UpyPbIw
 JB2lJlwtoCxSe4U7UHrphz7x1EIrReTMLV78DDpQFftnGbV/wKqxqgPeNBwnuknIOKXY
 Q0jgrndagoJm//V2r+16LUlNof2hTDClaiPi62MBPgRvqdKI3fnHwXAVQ5izgnV4s+ZI
 lpNuVGvPZ2KV+ACusWZTBCpCibvzPNJeaIx937D08PUjDkJQf12HSYCfuNMsFmMKmMnR
 SnHg==
X-Gm-Message-State: AOAM530icbnTgpKKM3vueO3pYGM4s+m25OV4pHQqa4zSLQ+ntS4Ffz2e
 esiskoJXPGtzZSwqyV8nZNunWHEiwFtd5uKU9siSxOMU/Tr5IsyA/g07tKS8ng4x9clSZnC04YA
 4ZpJWJYsadhBe9lA=
X-Received: by 2002:adf:cd0e:: with SMTP id w14mr2735876wrm.0.1599836691227;
 Fri, 11 Sep 2020 08:04:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyDsP9Sm7EYoAMMQhzCVismdOZaDBD6YpD+YIxqp7VfU8CDtby/uaW1pi7tB1oRz1ZCXIbJmA==
X-Received: by 2002:adf:cd0e:: with SMTP id w14mr2735841wrm.0.1599836690931;
 Fri, 11 Sep 2020 08:04:50 -0700 (PDT)
Received: from redhat.com ([176.230.64.162])
 by smtp.gmail.com with ESMTPSA id t22sm6015334wmt.1.2020.09.11.08.04.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2020 08:04:50 -0700 (PDT)
Date: Fri, 11 Sep 2020 11:04:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH] smp: drop support for deprecated (invalid topologies)
Message-ID: <20200911110407-mutt-send-email-mst@kernel.org>
References: <20200911133202.938754-1-imammedo@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200911133202.938754-1-imammedo@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 23:26:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: libvir-list@redhat.com, pbonzini@redhat.com, rth@twiddle.net,
 qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 11, 2020 at 09:32:02AM -0400, Igor Mammedov wrote:
> it's was deprecated since 3.1
> 
> Support for invalid topologies is removed, the user must ensure
> that topologies described with -smp include all possible cpus,
> i.e. (sockets * cores * threads) == maxcpus or QEMU will
> exit with error.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Acked-by: 

memory tree I guess?

> ---
>  docs/system/deprecated.rst | 26 +++++++++++++-------------
>  hw/core/machine.c          | 16 ++++------------
>  hw/i386/pc.c               | 16 ++++------------
>  3 files changed, 21 insertions(+), 37 deletions(-)
> 
> diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
> index 122717cfee..d737728fab 100644
> --- a/docs/system/deprecated.rst
> +++ b/docs/system/deprecated.rst
> @@ -47,19 +47,6 @@ The 'file' driver for drives is no longer appropriate for character or host
>  devices and will only accept regular files (S_IFREG). The correct driver
>  for these file types is 'host_cdrom' or 'host_device' as appropriate.
>  
> -``-smp`` (invalid topologies) (since 3.1)
> -'''''''''''''''''''''''''''''''''''''''''
> -
> -CPU topology properties should describe whole machine topology including
> -possible CPUs.
> -
> -However, historically it was possible to start QEMU with an incorrect topology
> -where *n* <= *sockets* * *cores* * *threads* < *maxcpus*,
> -which could lead to an incorrect topology enumeration by the guest.
> -Support for invalid topologies will be removed, the user must ensure
> -topologies described with -smp include all possible cpus, i.e.
> -*sockets* * *cores* * *threads* = *maxcpus*.
> -
>  ``-vnc acl`` (since 4.0.0)
>  ''''''''''''''''''''''''''
>  
> @@ -618,6 +605,19 @@ New machine versions (since 5.1) will not accept the option but it will still
>  work with old machine types. User can check the QAPI schema to see if the legacy
>  option is supported by looking at MachineInfo::numa-mem-supported property.
>  
> +``-smp`` (invalid topologies) (removed 5.2)
> +'''''''''''''''''''''''''''''''''''''''''''
> +
> +CPU topology properties should describe whole machine topology including
> +possible CPUs.
> +
> +However, historically it was possible to start QEMU with an incorrect topology
> +where *n* <= *sockets* * *cores* * *threads* < *maxcpus*,
> +which could lead to an incorrect topology enumeration by the guest.
> +Support for invalid topologies is removed, the user must ensure
> +topologies described with -smp include all possible cpus, i.e.
> +*sockets* * *cores* * *threads* = *maxcpus*.
> +
>  Block devices
>  -------------
>  
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index ea26d61237..09aee4ea52 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -754,23 +754,15 @@ static void smp_parse(MachineState *ms, QemuOpts *opts)
>              exit(1);
>          }
>  
> -        if (sockets * cores * threads > ms->smp.max_cpus) {
> -            error_report("cpu topology: "
> -                         "sockets (%u) * cores (%u) * threads (%u) > "
> -                         "maxcpus (%u)",
> +        if (sockets * cores * threads != ms->smp.max_cpus) {
> +            error_report("Invalid CPU topology: "
> +                         "sockets (%u) * cores (%u) * threads (%u) "
> +                         "!= maxcpus (%u)",
>                           sockets, cores, threads,
>                           ms->smp.max_cpus);
>              exit(1);
>          }
>  
> -        if (sockets * cores * threads != ms->smp.max_cpus) {
> -            warn_report("Invalid CPU topology deprecated: "
> -                        "sockets (%u) * cores (%u) * threads (%u) "
> -                        "!= maxcpus (%u)",
> -                        sockets, cores, threads,
> -                        ms->smp.max_cpus);
> -        }
> -
>          ms->smp.cpus = cpus;
>          ms->smp.cores = cores;
>          ms->smp.threads = threads;
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index d071da787b..fbde6b04e6 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -746,23 +746,15 @@ void pc_smp_parse(MachineState *ms, QemuOpts *opts)
>              exit(1);
>          }
>  
> -        if (sockets * dies * cores * threads > ms->smp.max_cpus) {
> -            error_report("cpu topology: "
> -                         "sockets (%u) * dies (%u) * cores (%u) * threads (%u) > "
> -                         "maxcpus (%u)",
> +        if (sockets * dies * cores * threads != ms->smp.max_cpus) {
> +            error_report("Invalid CPU topology deprecated: "
> +                         "sockets (%u) * dies (%u) * cores (%u) * threads (%u) "
> +                         "!= maxcpus (%u)",
>                           sockets, dies, cores, threads,
>                           ms->smp.max_cpus);
>              exit(1);
>          }
>  
> -        if (sockets * dies * cores * threads != ms->smp.max_cpus) {
> -            warn_report("Invalid CPU topology deprecated: "
> -                        "sockets (%u) * dies (%u) * cores (%u) * threads (%u) "
> -                        "!= maxcpus (%u)",
> -                        sockets, dies, cores, threads,
> -                        ms->smp.max_cpus);
> -        }
> -
>          ms->smp.cpus = cpus;
>          ms->smp.cores = cores;
>          ms->smp.threads = threads;
> -- 
> 2.27.0


