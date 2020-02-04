Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A80C35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:30:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 356632082E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R2FOONBi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 356632082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz22H-0003gh-BR
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 12:30:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37805)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iz21C-0001n3-IF
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:29:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iz21B-0004AR-BM
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:29:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60220
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iz21B-00046n-7J
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:29:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580837384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZubadfosTDTxtVOt8kLgLQxnfRxFqkndMKY7Cd0SmAg=;
 b=R2FOONBi4koGJtRyXEBS6DRhfdXhHIHjIPfeoIE8uBKmtmkr5jc7yin3WGJPNWDm1zVvyB
 yP6NJmUWv+gaHHwlEUjEAg7nmyvYPTq6uaKcIO0UW6R9p1w3JIGhuMDhBGjCgLygvIWMG2
 6vDt3pS2cmkf+vpEKgqkzGFGKQmYarY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-q4hrFqsINmytQmvZ7bLEaA-1; Tue, 04 Feb 2020 12:29:32 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E2A81005F6E;
 Tue,  4 Feb 2020 17:29:31 +0000 (UTC)
Received: from [10.3.116.181] (ovpn-116-181.phx2.redhat.com [10.3.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5260F7FB79;
 Tue,  4 Feb 2020 17:29:28 +0000 (UTC)
Subject: Re: [PATCH] qemu-options: replace constant 1 with HAS_ARG
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200204165638.25051-1-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <aac4e7cc-50e0-6e36-1995-fee3f9f1747a@redhat.com>
Date: Tue, 4 Feb 2020 11:29:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200204165638.25051-1-jsnow@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: q4hrFqsINmytQmvZ7bLEaA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: qemu-trivial@nongnu.org, thuth@redhat.com, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/4/20 10:56 AM, John Snow wrote:
> This is the only instance of a non-zero constant not using a symbolic
> constant.
> ---
>   qemu-options.hx | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

> diff --git a/qemu-options.hx b/qemu-options.hx
> index 224a8e8712..ff3e806977 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -1955,7 +1955,7 @@ STEXI
>   Start in full screen.
>   ETEXI
>   
> -DEF("g", 1, QEMU_OPTION_g ,
> +DEF("g", HAS_ARG, QEMU_OPTION_g ,
>       "-g WxH[xDEPTH]  Set the initial graphical resolution and depth\n",
>       QEMU_ARCH_PPC | QEMU_ARCH_SPARC | QEMU_ARCH_M68K)
>   STEXI
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


