Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C369C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 19:32:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB7B32467E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 19:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aop8P1M8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB7B32467E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwA7T-0003OH-5b
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 14:32:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55940)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iwA6c-0002rb-RH
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 14:31:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iwA6b-0005D6-Cj
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 14:31:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52698
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iwA6b-0005CH-8M
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 14:31:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580153488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AG0N+1ROQUgMrc6UZxUzW632vZeX3ujGXUwEqs1w2lI=;
 b=aop8P1M8sU16zFu44+vPYisJ8cGXtljHWuzHzyZVTh3AzMVNPiUMf8Ittp4ACuwXkaXxUR
 M4C3OfCsRtNDH4xEKIwXLp7b57eKJznRkXyP5lxgaHZnGIj6jf2q6oqRp0zHxSAwsiQGaB
 xT9UFqhloAGf5LMzgtVqkxhw6v9baPc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-vffQKKJSOiaus1ES0WKXvA-1; Mon, 27 Jan 2020 14:31:21 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89567189F763;
 Mon, 27 Jan 2020 19:31:20 +0000 (UTC)
Received: from [10.3.117.16] (ovpn-117-16.phx2.redhat.com [10.3.117.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 338D45D9CD;
 Mon, 27 Jan 2020 19:31:20 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] doc: Use @code rather than @var for options
To: David Edmondson <david.edmondson@oracle.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20200124103458.1525982-1-david.edmondson@oracle.com>
 <20200124103458.1525982-3-david.edmondson@oracle.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <8412b6bf-3819-9042-4ade-d42f36fd3a97@redhat.com>
Date: Mon, 27 Jan 2020 13:31:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200124103458.1525982-3-david.edmondson@oracle.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: vffQKKJSOiaus1ES0WKXvA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/24/20 4:34 AM, David Edmondson wrote:
> Texinfo defines @var for metasyntactic variables and such terms are
> shown in upper-case or italics in the output of makeinfo. When
> considering an option to a command, such as "-n", upper-casing is
> undesirable as it may confuse the reader or be in conflict with the
> equivalent upper-case option.
> 
> Replace the use of @var for options with @code to avoid this.
> 
> Signed-off-by: David Edmondson <david.edmondson@oracle.com>
> ---
>   qemu-img.texi | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)

Is this patch still needed given Peter's recent push to move to rST 
documentation?

> 
> diff --git a/qemu-img.texi b/qemu-img.texi
> index 3b6dfd8682..6b4a1ac961 100644
> --- a/qemu-img.texi
> +++ b/qemu-img.texi
> @@ -74,13 +74,13 @@ keys.
>   @item --image-opts
>   Indicates that the source @var{filename} parameter is to be interpreted as a
>   full option string, not a plain filename. This parameter is mutually
> -exclusive with the @var{-f} parameter.
> +exclusive with the @code{-f} parameter.
>   


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


