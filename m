Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4E8C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 16:24:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86DAB2053B
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 16:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KNN/rzAF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86DAB2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgseu-0002cV-PE
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 12:24:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jgsdh-0001DN-Uo
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 12:22:45 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45314
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jgsdf-0007fd-SG
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 12:22:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591287762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bkaBPgmzr0lMeHWUMJ62vNGfJWQwC8Xb5vQegkVuEtw=;
 b=KNN/rzAFTD86yGJR8ubIsYWlZcKcPPv8SUQBeQvsSzLy0Op2zpl7IFdDjKnIpHUWaI2CQQ
 N4wMWwCvDaDVRqk6cpiGg08QT97CeQfyMhj7LMgpGgonIb0oCW3Qma4JtoVwMMC6OpGvYh
 EPdOr3aE26B7s3cLgICNR5AkTRQO3P8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-CTZPl-nEOxycqWmNfUDJDg-1; Thu, 04 Jun 2020 12:22:35 -0400
X-MC-Unique: CTZPl-nEOxycqWmNfUDJDg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC3A51005510;
 Thu,  4 Jun 2020 16:22:29 +0000 (UTC)
Received: from [10.3.113.22] (ovpn-113-22.phx2.redhat.com [10.3.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3D27C60C47;
 Thu,  4 Jun 2020 16:22:29 +0000 (UTC)
Subject: Re: [PATCH 1/2] lockable: use QLNULL for a null lockable
To: Joe Slater <joe.slater@windriver.com>, qemu-devel@nongnu.org
References: <20200603224903.26268-1-joe.slater@windriver.com>
 <20200603224903.26268-2-joe.slater@windriver.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <dba303d1-5e24-d9e6-7e61-dacbb486c7c0@redhat.com>
Date: Thu, 4 Jun 2020 11:22:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200603224903.26268-2-joe.slater@windriver.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 01:08:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/3/20 5:49 PM, Joe Slater wrote:
> Allows us to build with -Og and optimizations that
> do not clean up dead-code.
> 
> Signed-off-by: Joe Slater <joe.slater@windriver.com>
> 
> to be squished
> 
> Signed-off-by: Joe Slater <joe.slater@windriver.com>

These last two lines can be elided (looks like a rebase mishap).

> ---
>   block/block-backend.c          | 4 ++--
>   block/block-copy.c             | 2 +-
>   block/mirror.c                 | 5 +++--
>   fsdev/qemu-fsdev-throttle.c    | 6 +++---
>   hw/9pfs/9p.c                   | 2 +-
>   include/qemu/lockable.h        | 3 +++
>   util/qemu-co-shared-resource.c | 2 +-
>   7 files changed, 14 insertions(+), 10 deletions(-)
> 

If you use scripts/git.orderfile, your diff would show with the .h 
changes first, which are arguably the meat of this patch.

> +++ b/block/mirror.c
> @@ -28,6 +28,7 @@
>   #define MAX_IO_BYTES (1 << 20) /* 1 Mb */
>   #define DEFAULT_MIRROR_BUF_SIZE (MAX_IN_FLIGHT * MAX_IO_BYTES)
>   
> +
>   /* The mirroring buffer is a list of granularity-sized chunks.
>    * Free chunks are organized in a list.
>    */

This hunk looks spurious.


> +++ b/include/qemu/lockable.h
> @@ -24,6 +24,9 @@ struct QemuLockable {
>       QemuLockUnlockFunc *unlock;
>   };
>   
> +#define QLNULL ((QemuLockable *)0)

Why not ((QemuLocakable *)NULL) ?
Why no comments why this type-safe NULL is useful?

> +
> +
>   /* This function gives an error if an invalid, non-NULL pointer type is passed
>    * to QEMU_MAKE_LOCKABLE.  For optimized builds, we can rely on dead-code elimination
>    * from the compiler, and give the errors already at link time.
> diff --git a/util/qemu-co-shared-resource.c b/util/qemu-co-shared-resource.c
> index 1c83cd9..7423ea4 100644
> --- a/util/qemu-co-shared-resource.c
> +++ b/util/qemu-co-shared-resource.c
> @@ -64,7 +64,7 @@ void coroutine_fn co_get_from_shres(SharedResource *s, uint64_t n)
>   {
>       assert(n <= s->total);
>       while (!co_try_get_from_shres(s, n)) {
> -        qemu_co_queue_wait(&s->queue, NULL);
> +        qemu_co_queue_wait(&s->queue, QLNULL);

It looks like your macro is added to give the compiler some type-safety, 
but it is not obvious how it matters from just the commit message, 
without also looking at patch 2/2.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


