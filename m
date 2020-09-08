Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86970C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 14:12:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 303E622838
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 14:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BxjMqQIo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 303E622838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFeMX-0007px-Bt
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 10:12:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kFeLk-0006ZY-3H
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 10:11:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36652)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kFeLi-0004qr-2N
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 10:11:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599574313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mmSzVecf6gPU4qPiKIRm/BTSNQ/lSsUt4KhSax4mdFA=;
 b=BxjMqQIoc9JufOymrWe/DiYJg53SpIS99q9JSXIeXS5XtdbTX8vBmGOk/MXjpOBaSnpaGM
 3POloBFocsmaGVGCm6WjmEhf/d7krwyZFbahI89YmOawh7hFVOQx8ja1SDzF43O4kE/uez
 R2NjAeqcv+aUZAhaO69HKjTdSTA7j1s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-Pzp_8H5QPzq8BaOCOsaQUA-1; Tue, 08 Sep 2020 10:11:51 -0400
X-MC-Unique: Pzp_8H5QPzq8BaOCOsaQUA-1
Received: by mail-wm1-f69.google.com with SMTP id c198so4787182wme.5
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 07:11:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=mmSzVecf6gPU4qPiKIRm/BTSNQ/lSsUt4KhSax4mdFA=;
 b=HA658Cv3Uua65A0AZnVGbwABN5AtR7jLXo8Zx8Ei8wC4khvRWtY+xPvDu1sC4zAklv
 gk/xuXmZTfVrMd0Z97Ecc064zK+AoxhNJVuIFCl8G1MzKoqdl8d6KdU6TvaxygvhrMJv
 oMbqbo3JnR7xddQkSgpe9cMwKPBxyDfd44xxm9H9ALkf6KPe0koSoPCGTgmMC+zPPy/k
 E+5+yf43+qOPAiz9/fTAgp+pAlAXwb9ncJFge9T0IIF+7mm/wi+txtvno78TR2LQpa9F
 Z8kj6KLxaRlAOrCaT9zUNZnWnPa2B/tXLhAGYMDBVYWjze+lRrOxyZQ2k/4YJ7xxQwtu
 z0uQ==
X-Gm-Message-State: AOAM533+C+jVJmUSJXtrTZLupoWB9PHq8BNzOtHAi1lJJ18dcpiuEe9Z
 6sEQJsJ4ewFj34wkTNzST9JAaWyBeLBIfVNvV+nLJPGkCQHM/3R6U0LsZeN643AoWsmI2TVXnGE
 NxFDTrldDQfWMzxg=
X-Received: by 2002:a5d:61c7:: with SMTP id q7mr27539904wrv.343.1599574310381; 
 Tue, 08 Sep 2020 07:11:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZ2YnqYCdAsq3g02YZj4aKzr469dXu3h4LfESH6XsK6qBVJ66raE9v46qiBOL5/Kic2OMriA==
X-Received: by 2002:a5d:61c7:: with SMTP id q7mr27539879wrv.343.1599574310114; 
 Tue, 08 Sep 2020 07:11:50 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-218-236.inter.net.il. [80.230.218.236])
 by smtp.gmail.com with ESMTPSA id
 k4sm33325141wrx.51.2020.09.08.07.11.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 07:11:49 -0700 (PDT)
Date: Tue, 8 Sep 2020 10:11:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v7 0/2] Remove EPYC mode apicid decode and use generic
 decode
Message-ID: <20200908101129-mutt-send-email-mst@kernel.org>
References: <159897580089.30750.12581669374705391794.stgit@naples-babu.amd.com>
MIME-Version: 1.0
In-Reply-To: <159897580089.30750.12581669374705391794.stgit@naples-babu.amd.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 02:10:54
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
Cc: ehabkost@redhat.com, qemu-devel@nongnu.org, imammedo@redhat.com,
 pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 01, 2020 at 10:57:20AM -0500, Babu Moger wrote:
> To support some of the complex topology, we introduced EPYC mode apicid decode.
> But, EPYC mode decode is running into problems. Also it can become quite a
> maintenance problem in the future. So, it was decided to remove that code and
> use the generic decode which works for majority of the topology. Most of the
> SPECed configuration would work just fine. With some non-SPECed user inputs,
> it will create some sub-optimal configuration.
> 
> Here is the discussion thread.
> https://lore.kernel.org/qemu-devel/c0bcc1a6-1d84-a6e7-e468-d5b437c1b254@amd.com/
> https://lore.kernel.org/qemu-devel/20200826143849.59f6970b@redhat.com/
> 
> This series removes all the EPYC mode specific apicid changes and use the generic
> apicid decode.

PC, x86 changes:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

Feel free to merge.

> ---
> v7:
>  Eduardo has already queued 1-8 from the v6. Sending rest of the patches.
>  Fixed CPUID 800000ld based on Igor's comment and few text changes.
>  
> v6:
>  https://lore.kernel.org/qemu-devel/159889924378.21294.16494070903874534542.stgit@naples-babu.amd.com/
>  Found out that numa configuration is not mandatory for all the EPYC model topology.
>  We can use the generic decode which works pretty well. Also noticed that
>  cpuid does not changes when the numa nodes change(NPS- Nodes per socket).
>  Took care of couple comments from Igor and Eduardo.
>  Thank you Igor, Daniel, David, Eduardo for your feedback.  
> 
> v5:
>  https://lore.kernel.org/qemu-devel/159804762216.39954.15502128500494116468.stgit@naples-babu.amd.com/
>  Revert EPYC specific decode.
>  Simplify CPUID_8000_001E
> 
> v4:
>   https://lore.kernel.org/qemu-devel/159744083536.39197.13827776633866601278.stgit@naples-babu.amd.com/
>   Not much of a change. Just added few text changes.
>   Error out configuration instead of warning if dies are not configured in EPYC.
>   Few other text changes to clarify the removal of node_id, nr_nodes and nodes_per_pkg.
> 
> v3:
>   https://lore.kernel.org/qemu-devel/159681772267.9679.1334429994189974662.stgit@naples-babu.amd.com/#r
>   Added a new check to pass the dies for EPYC numa configuration.
>   Added Simplify CPUID_8000_001E patch with some changes suggested by Igor.
>   Dropped the patch to build the topology from CpuInstanceProperties.
>   TODO: Not sure if we still need the Autonuma changes Igor mentioned.
>   Needs more clarity on that.
> 
> v2:
>   https://lore.kernel.org/qemu-devel/159362436285.36204.986406297373871949.stgit@naples-babu.amd.com/
>   Used the numa information from CpuInstanceProperties for building
>   the apic_id suggested by Igor.
>   Also did some minor code re-aarangement to take care of changes.
>   Dropped the patch "Simplify CPUID_8000_001E" from v1. Will send
>   it later.
> 
> v1:
>  https://lore.kernel.org/qemu-devel/159164739269.20543.3074052993891532749.stgit@naples-babu.amd.com
> 
> Babu Moger (2):
>       i386: Simplify CPUID_8000_001d for AMD
>       i386: Simplify CPUID_8000_001E for AMD
> 
> 
>  target/i386/cpu.c |  226 ++++++++++++++---------------------------------------
>  1 file changed, 61 insertions(+), 165 deletions(-)
> 
> --


