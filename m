Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFB0C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 12:44:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BB6A2073B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 12:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z8VFjpjC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BB6A2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jACLH-0007hb-JE
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 07:44:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39030)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jACKc-0006q9-0h
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 07:43:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jACKb-0001Zj-20
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 07:43:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25109
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jACKa-0001W0-UI
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 07:43:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583498636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H/txHChYAsFlVrUHZBgmVdcxpU3iJMCzrGbMnmiY4G8=;
 b=Z8VFjpjClyTB9D3prTqUlE278DHeEiQn3L5yWtY86/0y8KFNuuDgV6vrMnZYmrXmyjDOPe
 AfE0SNfR3OjsgB2GaGuoaxnkgtpjoFH6ewgm2JykcLJeYKwT5/QmNmvzCHm/pwikzfPBy7
 bP6bcutGYCKM520/aK/qkROg7vKsGN0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-nkUAVqrpNFydeiZfafpZ-g-1; Fri, 06 Mar 2020 07:43:54 -0500
X-MC-Unique: nkUAVqrpNFydeiZfafpZ-g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A9BD107ACC9;
 Fri,  6 Mar 2020 12:43:52 +0000 (UTC)
Received: from [10.3.117.177] (ovpn-117-177.phx2.redhat.com [10.3.117.177])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E054746;
 Fri,  6 Mar 2020 12:43:43 +0000 (UTC)
Subject: Re: [PATCH v8 02/10] scripts: add coccinelle script to use auto
 propagated errp
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200306051536.27803-1-vsementsov@virtuozzo.com>
 <20200306051536.27803-3-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <8b4ef7d1-f1dd-91f3-0c34-787818cbecd1@redhat.com>
Date: Fri, 6 Mar 2020 06:43:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200306051536.27803-3-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Paul Durrant <paul@xen.org>, Laszlo Ersek <lersek@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 armbru@redhat.com, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/5/20 11:15 PM, Vladimir Sementsov-Ogievskiy wrote:
> Script adds ERRP_AUTO_PROPAGATE macro invocation where appropriate and
> does corresponding changes in code (look for details in
> include/qapi/error.h)
> 
> Usage example:
> spatch --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
>   --macro-file scripts/cocci-macro-file.h --in-place --no-show-diff \
>   blockdev-nbd.c qemu-nbd.c {block/nbd*,nbd/*,include/block/nbd*}.[hc]
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
> 

I'll let Markus do the final review of this, but my personal take is 
that if the subsequent patches created by using this script are 
reasonable, then this script was good enough.

> +// Always use the same patter for checking error

pattern

> +@@
> +identifier rule1.fn;
> +symbol errp;
> +@@
> +
> + fn(...)
> + {
> +     <...
> +-    *errp != NULL
> ++    *errp
> +     ...>
> + }
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


