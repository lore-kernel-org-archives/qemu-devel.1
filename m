Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63740C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 19:29:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28E732082E
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 19:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ku8WaGi8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28E732082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixbyX-0007ne-CA
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 14:29:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53222)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1ixbxj-0007Ke-LT
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 14:28:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1ixbxi-0008VL-NL
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 14:28:19 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54643
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ixbxi-0008Ux-KK
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 14:28:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580498898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uuxCDpmv0eZh8uPkd270EqP3QNu1UP8zfYBx4AxG0go=;
 b=Ku8WaGi8xEEUuve+NktCoZPUlPXzsvQ4y35r+vO7S10VLtL+trNQn5AQDE75lEhKd6Sgir
 YcUQXU931oux/wWA/w7P023rfe3NHPw3cSpri2vtgOZ5Hb7cgmfH+JmnfOsE3dqajKKWab
 I3Jg59ZbVZnhv/ul47ogAlTm4aQfLQA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-JLScayvMPXePRE8CgxlO3g-1; Fri, 31 Jan 2020 14:28:14 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ADF47107B7F2;
 Fri, 31 Jan 2020 19:28:12 +0000 (UTC)
Received: from [10.3.116.181] (ovpn-116-181.phx2.redhat.com [10.3.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 437418885F;
 Fri, 31 Jan 2020 19:28:06 +0000 (UTC)
Subject: Re: [PATCH v2 2/5] migretion/block-dirty-bitmap: refactor
 init_dirty_bitmap_migration
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20191219085106.22309-1-vsementsov@virtuozzo.com>
 <20191219085106.22309-3-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <4deacc37-9d13-a9bd-288b-083502446e71@redhat.com>
Date: Fri, 31 Jan 2020 13:28:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20191219085106.22309-3-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: JLScayvMPXePRE8CgxlO3g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: fam@euphon.net, kwolf@redhat.com, quintela@redhat.com,
 qemu-devel@nongnu.org, dgilbert@redhat.com, stefanha@redhat.com,
 den@openvz.org, mreitz@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/19/19 2:51 AM, Vladimir Sementsov-Ogievskiy wrote:

In the subject: s/migretion/migration/

> Split out handling one bs, it is needed for the following commit, which
> will handle BlockBackends in separate.

s/in separate/separately/

> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   migration/block-dirty-bitmap.c | 89 +++++++++++++++++++---------------
>   1 file changed, 49 insertions(+), 40 deletions(-)
> 

> +++ b/migration/block-dirty-bitmap.c
> @@ -268,57 +268,66 @@ static void dirty_bitmap_mig_cleanup(void)

>   
> -    for (bs = bdrv_next_all_states(NULL); bs; bs = bdrv_next_all_states(bs)) {
> -        const char *name = bdrv_get_device_or_node_name(bs);
> +        if (!bs_name || strcmp(bs_name, "") == 0) {
> +            error_report("Found bitmap '%s' in unnamed node %p. It can't "
> +                         "be migrated", bdrv_dirty_bitmap_name(bitmap), bs);

error_report() generally avoids multiple sentences.

> +            return -1;
> +        }
>   
> -        FOR_EACH_DIRTY_BITMAP(bs, bitmap) {
> -            if (!bdrv_dirty_bitmap_name(bitmap)) {
> -                continue;
> -            }
> +        if (bdrv_dirty_bitmap_check(bitmap, BDRV_BITMAP_DEFAULT, &local_err)) {
> +            error_report_err(local_err);
> +            return -1;
> +        }
>   
> -            if (!name || strcmp(name, "") == 0) {
> -                error_report("Found bitmap '%s' in unnamed node %p. It can't "
> -                             "be migrated", bdrv_dirty_bitmap_name(bitmap), bs);

But as this was just code motion,

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


