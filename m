Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA49C18E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:07:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4316D20658
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XQHG4iLb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4316D20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDv5I-0004qJ-E3
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 15:07:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49546)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jDuIK-0005dj-Pn
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:17:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jDuII-0003b6-3Y
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:16:55 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:43826)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jDuIF-0003WG-6M
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:16:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584382608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qYHp8rynnbtG8wxxghAk7dzacjYoNL1Xio3DDGG3ujY=;
 b=XQHG4iLbEjkR2bzKJfMdBCZzHTuwaAPqSjxM6RVnn5z9JF4/QoWeelzYFypEYL3YVhR8be
 Mf5B4e8vVDhq5c5VONELfVYFH8VC0OeJGF1dTbkR4a/rOVzFF4+XTcxf6X/T5EhV0XmOHy
 A85ZFKfnihxyihFYfhKBrz8B8w4qKvE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-1ueIRDpVPRCrssMs6zqA_g-1; Mon, 16 Mar 2020 14:16:44 -0400
X-MC-Unique: 1ueIRDpVPRCrssMs6zqA_g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10EEB116AF69;
 Mon, 16 Mar 2020 17:55:39 +0000 (UTC)
Received: from [10.3.118.63] (ovpn-118-63.phx2.redhat.com [10.3.118.63])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A7DEB5C1B2;
 Mon, 16 Mar 2020 17:55:38 +0000 (UTC)
Subject: Re: [PATCH v3 12/34] qapi: Add feature flags to remaining definitions
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200315144653.22660-1-armbru@redhat.com>
 <20200315144653.22660-13-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <a6b5dcd4-6ac7-adef-d3c0-20a6a9748bd3@redhat.com>
Date: Mon, 16 Mar 2020 12:55:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200315144653.22660-13-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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

On 3/15/20 9:46 AM, Markus Armbruster wrote:
> In v4.1.0, we added feature flags just to struct types (commit
> 6a8c0b5102^..f3ed93d545), to satisfy an immediate need (commit
> c9d4070991 "file-posix: Add dynamic-auto-read-only QAPI feature").  In
> v4.2.0, we added them to commands (commit 23394b4c39 "qapi: Add
> feature flags to commands") to satisfy another immediate need (commit
> d76744e65e "qapi: Allow introspecting fix for savevm's cooperation
> with blockdev").
> 
> Add them to the remaining definitions: enumeration types, union types,
> alternate types, and events.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---


> +++ b/qapi/introspect.json
> @@ -89,12 +89,18 @@
>   #
>   # @meta-type: the entity's meta type, inherited from @base.
>   #
> +# @features: names of features associated with the entity, in no
> +#            particular order.
> +#            (since 4.1 for object types, 4.2 for commands, 5.0 for
> +#            the rest)

Odd versioning hint, but accurate, and I don't see any way to improve it.

> +#
>   # Additional members depend on the value of @meta-type.
>   #
>   # Since: 2.5
>   ##
>   { 'union': 'SchemaInfo',
> -  'base': { 'name': 'str', 'meta-type': 'SchemaMetaType' },
> +  'base': { 'name': 'str', 'meta-type': 'SchemaMetaType',
> +            '*features': [ 'str' ] },
>     'discriminator': 'meta-type',
>     'data': {
>         'builtin': 'SchemaInfoBuiltin',
> @@ -174,9 +180,6 @@
>   #            and may even differ from the order of the values of the
>   #            enum type of the @tag.
>   #
> -# @features: names of features associated with the type, in no particular
> -#            order. (since: 4.1)
> -#
>   # Values of this type are JSON object on the wire.
>   #
>   # Since: 2.5
> @@ -184,8 +187,7 @@
>   { 'struct': 'SchemaInfoObject',
>     'data': { 'members': [ 'SchemaInfoObjectMember' ],
>               '*tag': 'str',
> -            '*variants': [ 'SchemaInfoObjectVariant' ],
> -            '*features': [ 'str' ] } }
> +            '*variants': [ 'SchemaInfoObjectVariant' ] } }

The code motion from use in some of the union branches to now being 
present in the base class of all of the branches is backwards-compatible.

The generator changes also look correct, and have enough testsuite 
coverage to make it easier to be confident about the patch.

Reviewed-by: Eric Blake <eblake@redhat.com>


> +++ b/tests/qapi-schema/doc-good.json
> @@ -53,10 +53,14 @@
>   # @Enum:
>   # @one: The _one_ {and only}
>   #
> +# Features:
> +# @enum-feat: Also _one_ {and only}

All our existing public features are a single word (matching naming 
conventions elsewhere in QAPI).  Are we sure we want to allow feature 
names that include whitespace?  Of course, the fact that our testsuite 
covers it (even if we don't use it publically) means that we are sure 
that our generator can handle it, regardless of whether we decide that a 
separate patch should restrict feature names.  But I don't see it 
holding up this patch.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


