Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96224C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 16:59:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6269524648
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 16:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RH8mpo6n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6269524648
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icuTW-0000ox-JD
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 11:59:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58933)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1icuSS-0000K1-B1
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 11:58:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1icuSP-0003Tp-QF
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 11:58:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43487
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1icuSP-0003OC-JZ
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 11:58:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575565104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a9oVn3wmKsJSk52Uv3PLFD3kiGYbdJTYy3ZPtYtO6WU=;
 b=RH8mpo6nJfh1cKUbcedU0DD5nfbi+YenMfALunZaJi8UY18uQpN4fNBebS6Tssr8i+qeOJ
 sfWuvWNHNfJEuP8cAGBI9YjBsnp97AjLsGyt+qC6eE9hprdzYhdt7wfPOPRgJD3VGAYowy
 73p+2A6GMjNYJ+0kcKtlAwjKFN7HnKI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-CIcgjijkMd-_5olk7Os-xg-1; Thu, 05 Dec 2019 11:58:23 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 203C9104FB63;
 Thu,  5 Dec 2019 16:58:22 +0000 (UTC)
Received: from [10.3.116.171] (ovpn-116-171.phx2.redhat.com [10.3.116.171])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6EF1760919;
 Thu,  5 Dec 2019 16:58:21 +0000 (UTC)
Subject: Re: [PATCH v7 06/21] qdev-monitor: well form error hint helpers
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20191205152019.8454-1-vsementsov@virtuozzo.com>
 <20191205152019.8454-7-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <ab98627d-fdd3-1a01-793c-31bf9c445cd6@redhat.com>
Date: Thu, 5 Dec 2019 10:58:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191205152019.8454-7-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: CIcgjijkMd-_5olk7Os-xg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, armbru@redhat.com,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/5/19 9:20 AM, Vladimir Sementsov-Ogievskiy wrote:
> Make qbus_list_bus and qbus_list_dev hint append helpers well formed:
> rename errp to errp_in, as it is IN-parameter here (which is unusual
> for errp), rename functions to be error_append_*_hint.

Commit message mentions a rename...

> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   qdev-monitor.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/qdev-monitor.c b/qdev-monitor.c
> index 29ed73e56a..3465a1e2d0 100644
> --- a/qdev-monitor.c
> +++ b/qdev-monitor.c
> @@ -328,7 +328,8 @@ static Object *qdev_get_peripheral_anon(void)
>       return dev;
>   }
>   
> -static void qbus_list_bus(DeviceState *dev, Error **errp)
> +static void qbus_error_append_bus_list_hint(DeviceState *dev,
> +                                            Error *const *errp)

...but instead you did a type change with the name left unchanged. 
Commit message needs a fix.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


