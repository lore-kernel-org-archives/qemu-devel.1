Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADFBC83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 17:48:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65AAB20757
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 17:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HuSTNw34"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65AAB20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTULR-0000jN-8Q
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 13:48:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44532)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTUIz-0005rE-BV
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 13:46:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTUFF-000817-Lv
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 13:46:01 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48321
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jTUFF-00080u-3E
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 13:42:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588095728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EStuwgWDh4ovNzt8hbgaDjSTxQENeAaRgH/athwGG3Y=;
 b=HuSTNw34RsfZ1QcYyOhrvAJnBAjlIl+lviwxABjFQXxKBZizUX53h65Fy4O5gYSGjg9HND
 gpr7h+1ML3QJJxbqtO1hwL+8PyMaN7SgXCNm+pdeZbPtz6Q32d6sinSIbicdcZUywL9G2A
 1hcKqC0s0wMnZ3wCeCTaE+f3ph6cx6s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-Tp5YzVV5NQidnZOIjx9WfQ-1; Tue, 28 Apr 2020 13:42:06 -0400
X-MC-Unique: Tp5YzVV5NQidnZOIjx9WfQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 718E881E22B
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 17:42:05 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B3E3F196AE;
 Tue, 28 Apr 2020 17:42:01 +0000 (UTC)
Subject: Re: [PATCH 03/17] qom: Drop object_property_del_child()'s unused
 parameter @errp
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200428163419.4483-1-armbru@redhat.com>
 <20200428163419.4483-4-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <08475537-f30c-4f13-8ce0-5758f19c575d@redhat.com>
Date: Tue, 28 Apr 2020 12:42:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428163419.4483-4-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 02:06:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/28/20 11:34 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   qom/object.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/qom/object.c b/qom/object.c
> index 0c9e2052fa..9c74749193 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -614,7 +614,7 @@ static void object_property_del_all(Object *obj)
>       g_hash_table_unref(obj->properties);
>   }
>   
> -static void object_property_del_child(Object *obj, Object *child, Error **errp)
> +static void object_property_del_child(Object *obj, Object *child)
>   {
>       ObjectProperty *prop;
>       GHashTableIter iter;
> @@ -644,7 +644,7 @@ static void object_property_del_child(Object *obj, Object *child, Error **errp)
>   void object_unparent(Object *obj)
>   {
>       if (obj->parent) {
> -        object_property_del_child(obj->parent, obj, NULL);
> +        object_property_del_child(obj->parent, obj);
>       }
>   }
>   
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


