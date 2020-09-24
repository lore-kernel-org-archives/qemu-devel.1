Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C49A3C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:18:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F12D121D91
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dUmnD0d8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F12D121D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLWl9-0001vX-Sa
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 15:18:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kLWdk-0005Ds-1i
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 15:10:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53490)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kLWdg-0004bB-2V
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 15:10:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600974642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4z0A7EMcviNKUGxP8mlTfQPnRBVv33kdl1gcD44oSc8=;
 b=dUmnD0d8aLPiuHANKrkMwIE4J8HN49itZQ/abMztBYMnorRaCvG8yt0q30SrSMXN8tvZ+9
 CEa8pJa9P/zkDh4x2s+6ZBTiDkaNdiWAvBXyxpfQz8GlvxGcXWNn27LFLhnsBlXj4TMPmY
 VxLDMerqPxlPVtQzRs4WEQUNxSuVhWg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-UM5rInt_M6aY6GY_e783Ng-1; Thu, 24 Sep 2020 15:10:35 -0400
X-MC-Unique: UM5rInt_M6aY6GY_e783Ng-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C9CD807356;
 Thu, 24 Sep 2020 19:10:34 +0000 (UTC)
Received: from [10.3.114.148] (ovpn-114-148.phx2.redhat.com [10.3.114.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CD06B5C1C7;
 Thu, 24 Sep 2020 19:10:30 +0000 (UTC)
Subject: Re: [PATCH v9 4/7] scripts: add block-coroutine-wrapper.py
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200924185414.28642-1-vsementsov@virtuozzo.com>
 <20200924185414.28642-5-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <20235fa1-b269-7f49-0a0b-9f7c6f06eca8@redhat.com>
Date: Thu, 24 Sep 2020 14:10:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200924185414.28642-5-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: fam@euphon.net, kwolf@redhat.com, ehabkost@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com,
 crosa@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/24/20 1:54 PM, Vladimir Sementsov-Ogievskiy wrote:
> We have a very frequent pattern of creating a coroutine from a function
> with several arguments:
> 
>    - create a structure to pack parameters
>    - create _entry function to call original function taking parameters
>      from struct
>    - do different magic to handle completion: set ret to NOT_DONE or
>      EINPROGRESS or use separate bool field
>    - fill the struct and create coroutine from _entry function with this
>      struct as a parameter
>    - do coroutine enter and BDRV_POLL_WHILE loop
> 
> Let's reduce code duplication by generating coroutine wrappers.
> 
> This patch adds scripts/block-coroutine-wrapper.py together with some
> friends, which will generate functions with declared prototypes marked
> by the 'generated_co_wrapper' specifier.
> 
> The usage of new code generation is as follows:
> 
>      1. define the coroutine function somewhere
> 
>          int coroutine_fn bdrv_co_NAME(...) {...}
> 
>      2. declare in some header file
> 
>          int generated_co_wrapper bdrv_NAME(...);
> 
>         with same list of parameters (generated_co_wrapper is
>         defined in "include/block/block.h").
> 
>      3. Make sure the block_gen_c delaration in block/meson.build

declaration

>         mentions the file with your marker function.
> 
> Still, no function is now marked, this work is for the following
> commit.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---

> +++ b/docs/devel/block-coroutine-wrapper.rst
> @@ -0,0 +1,54 @@
> +=======================
> +block-coroutine-wrapper
> +=======================
> +
> +A lot of functions in QEMU block layer (see ``block/*``) can only be
> +called in coroutine context. Such functions are normally marked by the
> +coroutine_fn specifier. Still, sometimes we need to call them from
> +non-coroutine context; for this we need to start a coroutine, run the
> +needed function from it and wait for coroutine finish in

to finish in a

> +BDRV_POLL_WHILE() loop. To run a coroutine we need a function with one
> +void* argument. So for each coroutine_fn function which needs a
> +non-coroutine interface, we should define a structure to pack the
> +parameters, define a separate function to unpack the parameters and
> +call the original function and finally define a new interface function
> +with same list of arguments as original one, which will pack the
> +parameters into a struct, create a coroutine, run it and wait in
> +BDRV_POLL_WHILE() loop. It's boring to create such wrappers by hand,
> +so we have a script to generate them.
> +

> +++ b/scripts/block-coroutine-wrapper.py
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


