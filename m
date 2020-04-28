Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE05AC83001
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 17:54:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3EF320757
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 17:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lu0D0O2W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3EF320757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTURN-0002rS-IO
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 13:54:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44858)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTUJn-0007K2-C4
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 13:46:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTUJm-0000gr-Qr
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 13:46:51 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30764
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jTUJm-0000gR-9j
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 13:46:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588096004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=huQsXKh1fDpi+UWk8ioe9jnTLSKT7dIu62o5AEludac=;
 b=Lu0D0O2WJaUqR++KX6fQUC5U8EeTsWu8ShethubfTUtgQ0xpjEz23cieNes4VjCKmP351r
 v7yP/tCQwnfVPdNqpR9TV7F4+t9n9ubf6/pzlga0pAqnEEZJdFFKI5lwo/jDonGj7qbjLU
 xV5HnfgfLAgCVfqGf2tow6qJQvHVFU0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-YluVhvJ2OGCiaqRrl7XWEQ-1; Tue, 28 Apr 2020 13:46:42 -0400
X-MC-Unique: YluVhvJ2OGCiaqRrl7XWEQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE38C1005510
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 17:46:41 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DAE725C1BD;
 Tue, 28 Apr 2020 17:46:40 +0000 (UTC)
Subject: Re: [PATCH 04/17] qom: Change object_property_get_uint16List() to
 match its doc
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200428163419.4483-1-armbru@redhat.com>
 <20200428163419.4483-5-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <1dd34bf3-542f-44ce-05c4-a351edc92cc3@redhat.com>
Date: Tue, 28 Apr 2020 12:46:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428163419.4483-5-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
>   include/qom/object.h       | 4 ++--
>   hw/core/machine-qmp-cmds.c | 6 +++---
>   qom/object.c               | 9 +++++----
>   3 files changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/include/qom/object.h b/include/qom/object.h
> index ccfa82e33d..5d1ed672c3 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -1331,8 +1331,8 @@ int object_property_get_enum(Object *obj, const char *name,

Adding context:

/**
  * object_property_get_uint16List:
  * @obj: the object
  * @name: the name of the property
  * @list: the returned int list
  * @errp: returns an error if this function fails
  *
  * Returns: the value of the property, converted to integers, or

>    * undefined if an error occurs (including when the property value is not
>    * an list of integers).
>    */
> -void object_property_get_uint16List(Object *obj, const char *name,
> -                                    uint16List **list, Error **errp);
> +uint16List *object_property_get_uint16List(Object *obj, const char *name,
> +                                           Error **errp);

Incomplete.  The doc comments need to drop the @list line, as well as 
s/undefined/#NULL/ in the Returns line.

With that fixed,
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


