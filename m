Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43ADC54FD0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 17:35:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A10F520736
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 17:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g44+YV8I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A10F520736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRfl7-0004kD-Gf
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 13:35:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50724)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jRfkD-0003NR-W0
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 13:34:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jRfkC-0008AZ-Vk
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 13:34:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57329
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jRfkC-00089T-IS
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 13:34:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587663275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3I+HPB4mD/cfDAf3sf7r/LhA25t+7hm8RkenpqbTVtM=;
 b=g44+YV8IxCAwyQLTI+1caW3byflB0WLE2jNaBpVO7LvXKK7pFtdbPiefxxpiRuT07b7CtU
 z84J7VEtnz6yhjYfUvqfdZVi8bk13rMwTHGaMcB+l3MP4TNMKtY8+m0e9hEaC+4t+yH+qr
 o7+Vns0qBEECPmbZV+3HHjkqA7eY7JM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-ceDPYmVhOdSiU3P99sO1tQ-1; Thu, 23 Apr 2020 13:34:33 -0400
X-MC-Unique: ceDPYmVhOdSiU3P99sO1tQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 654111800D51;
 Thu, 23 Apr 2020 17:34:32 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CCDA760C18;
 Thu, 23 Apr 2020 17:34:31 +0000 (UTC)
Subject: Re: [PATCH 03/13] qapi: Fix typo in visit_start_list()'s contract
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200423160036.7048-1-armbru@redhat.com>
 <20200423160036.7048-4-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <efc7d081-a264-574c-366a-808049ac375d@redhat.com>
Date: Thu, 23 Apr 2020 12:34:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200423160036.7048-4-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 05:42:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/23/20 11:00 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   include/qapi/visitor.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Too much copy-and-paste in the original ;)

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/include/qapi/visitor.h b/include/qapi/visitor.h
> index 7f63e4c381..c5d0ce9184 100644
> --- a/include/qapi/visitor.h
> +++ b/include/qapi/visitor.h
> @@ -345,9 +345,9 @@ void visit_end_struct(Visitor *v, void **obj);
>    * input visitors set *@list to NULL.
>    *
>    * After visit_start_list() succeeds, the caller may visit its members
> - * one after the other.  A real visit (where @obj is non-NULL) uses
> + * one after the other.  A real visit (where @list is non-NULL) uses
>    * visit_next_list() for traversing the linked list, while a virtual
> - * visit (where @obj is NULL) uses other means.  For each list
> + * visit (where @list is NULL) uses other means.  For each list
>    * element, call the appropriate visit_type_FOO() with name set to
>    * NULL and obj set to the address of the value member of the list
>    * element.  Finally, visit_end_list() needs to be called with the
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


