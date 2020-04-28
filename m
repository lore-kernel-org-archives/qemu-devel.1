Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79846C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 18:03:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46EC2206A1
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 18:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ulcsg7tD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46EC2206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTUa9-0001wl-Cj
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 14:03:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47208)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTUYd-0000GX-As
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 14:02:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTUWw-0004XX-2P
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 14:02:10 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23889
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jTUWv-0004W6-Ed
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 14:00:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588096823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tCHpTYho1y90eeihUyaCPBbBHEOT2C7lgN3ElyEhsKE=;
 b=Ulcsg7tD3RtXogKiEMBvTtgZuChFUgaswgrWFOvf5NTuh2vBumx3CNJ9fK2u/KGCt+8M3h
 5EzSRiK8nZ9DMXcX0FumfkpoM7oTxGnQhFQ1DK+Z8at+1mMo/AIN0dFySsbc+Ic2lELVh+
 +HagmJMsXInJ3+WjbwtI0GrrpABK+o4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-vRd64YMONJWFD9cUrjRl-Q-1; Tue, 28 Apr 2020 14:00:15 -0400
X-MC-Unique: vRd64YMONJWFD9cUrjRl-Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB051100CD03
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 18:00:14 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A801A579A9;
 Tue, 28 Apr 2020 18:00:13 +0000 (UTC)
Subject: Re: [PATCH 06/17] qom: Drop object_property_set_description()
 parameter @errp
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200428163419.4483-1-armbru@redhat.com>
 <20200428163419.4483-7-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <828c31a6-f1d7-1629-cded-ef7097dd02b5@redhat.com>
Date: Tue, 28 Apr 2020 13:00:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428163419.4483-7-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 04:11:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/28/20 11:34 AM, Markus Armbruster wrote:
> object_property_set_description() and
> object_class_property_set_description() fail only when property @name
> is not found.
> 
> There are 85 calls of object_property_set_description() and
> object_class_property_set_description().  None of them can fail:
> 
> * 84 immediately follow the creation of the property.
> 
> * The one in spapr_rng_instance_init() refers to a property created in
>    spapr_rng_class_init(), from spapr_rng_properties[].
> 

I don't envy how you counted those.  But on sheer numbers, this patch 
has to be at least 85 changed lines in length...

> Every one of them still gets to decide what to pass for @errp.
> 
> 51 calls pass &error_abort, 32 calls pass NULL, one receives the error
> and propagates it to &error_abort, and one propagates it to
> &error_fatal.  I'm actually surprised none of them violates the Error
> API.
> 
> What are we gaining by letting callers handle the "property not found"
> error?  Use when the property is not known to exist is simpler: you
> don't have to guard the call with a check.  We haven't found such a
> use in 5+ years.  Until we do, let's make life a bit simpler and drop
> the @errp parameter.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

>   30 files changed, 91 insertions(+), 143 deletions(-)

...which it is. And the compiler would choke if you missed anything. 
The bulk of this is mechanical, with no way to split it smaller.

After hunting, I found the core of the patch:

> +++ b/qom/object.c
> @@ -2835,38 +2835,27 @@ object_property_add_alias(Object *obj, const char *name,
>       }
>   
>       object_property_set_description(obj, op->name,
> -                                    target_prop->description,
> -                                    &error_abort);
> +                                    target_prop->description);
>       return op;
>   }
>   
>   void object_property_set_description(Object *obj, const char *name,
> -                                     const char *description, Error **errp)
> +                                     const char *description)
>   {
>       ObjectProperty *op;
>   
> -    op = object_property_find(obj, name, errp);
> -    if (!op) {
> -        return;
> -    }
> -
> +    op = object_property_find(obj, name, &error_abort);
>       g_free(op->description);
>       op->description = g_strdup(description);
>   }
>   
>   void object_class_property_set_description(ObjectClass *klass,
>                                              const char *name,
> -                                           const char *description,
> -                                           Error **errp)
> +                                           const char *description)
>   {
>       ObjectProperty *op;
>   
>       op = g_hash_table_lookup(klass->properties, name);
> -    if (!op) {
> -        error_setg(errp, "Property '.%s' not found", name);
> -        return;
> -    }
> -

and it is sensible.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


