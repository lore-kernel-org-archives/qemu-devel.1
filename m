Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00EBCC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 12:46:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C13A52073B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 12:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G4eQuMnO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C13A52073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jACN0-0000Ge-WB
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 07:46:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42126)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jACMD-0008HX-G8
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 07:45:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jACMC-0007eD-1j
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 07:45:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41396
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jACMA-0007a5-Ek
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 07:45:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583498732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=93KZEIQMh+dQ90r0OOOU4q3Y1wqJWDCA80Z2dOF09Rg=;
 b=G4eQuMnOpaJB2Nk7v0RPX5DMovbj7wqUNtgpEe0x2aJ4r6oaUIooMajzU0Ctzc2mjUaedK
 kdhF9lUIpLuQBauqMw/mQYqXoTtecELiTSYP66jB1YeOYsbd3nrNL263W7x1lsUVt4wHOz
 L2KcewbfxC510Lr8E1bMJkAuNvcDbWg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-WwtAUbNZNSqRfA0sSyLvqg-1; Fri, 06 Mar 2020 07:45:31 -0500
X-MC-Unique: WwtAUbNZNSqRfA0sSyLvqg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7CE3107ACCC;
 Fri,  6 Mar 2020 12:45:29 +0000 (UTC)
Received: from [10.3.117.177] (ovpn-117-177.phx2.redhat.com [10.3.117.177])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3261A10016EB;
 Fri,  6 Mar 2020 12:45:29 +0000 (UTC)
Subject: Re: [PATCH v8 09/10] nbd: introduce ERRP_AUTO_PROPAGATE
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200306051536.27803-1-vsementsov@virtuozzo.com>
 <20200306051536.27803-10-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <0a5a6162-1ee0-e9bc-27ac-7a0f4956cc44@redhat.com>
Date: Fri, 6 Mar 2020 06:45:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200306051536.27803-10-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 armbru@redhat.com, qemu-block@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/5/20 11:15 PM, Vladimir Sementsov-Ogievskiy wrote:
> If we want to add some info to errp (by error_prepend() or
> error_append_hint()), we must use the ERRP_AUTO_PROPAGATE macro.
> Otherwise, this info will not be added when errp == &error_fatal
> (the program will exit prior to the error_append_hint() or
> error_prepend() call).  Fix such cases.
> 
> If we want to check error after errp-function call, we need to
> introduce local_err and then propagate it to errp. Instead, use
> ERRP_AUTO_PROPAGATE macro, benefits are:
> 1. No need of explicit error_propagate call
> 2. No need of explicit local_err variable: use errp directly
> 3. ERRP_AUTO_PROPAGATE leaves errp as is if it's not NULL or
>     &error_fatal, this means that we don't break error_abort
>     (we'll abort on error_set, not on error_propagate)
> 
> This commit is generated by command
> 
>      sed -n '/^Network Block Device (NBD)$/,/^$/{s/^F: //p}' \
>          MAINTAINERS | \
>      xargs git ls-files | grep '\.[hc]$' | \
>      xargs spatch \
>          --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
>          --macro-file scripts/cocci-macro-file.h \
>          --in-place --no-show-diff --max-width 80
> 
> Reported-by: Kevin Wolf <kwolf@redhat.com>
> Reported-by: Greg Kurz <groug@kaod.org>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


