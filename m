Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346DAC1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 20:29:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F33D42051A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 20:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VBnVSTXo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F33D42051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEIpi-0001ps-5t
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 16:29:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43677)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jEIoY-0001Gl-T7
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 16:27:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jEIoX-0005Lx-SZ
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 16:27:50 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:27501)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jEIoX-0005IK-Nn
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 16:27:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584476868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t3mvC+FCMYEdmIkmgAioa0aN4WlLbKf3umQ9Szu0/b8=;
 b=VBnVSTXoWDnwslfJ939lsIZKzcquHy6xrl8epNKL3oOqziCb8RS1jdAt+SNbYsv+bWItpS
 vkH+/s72Y0H5lZMBUMTaPK0XI1Lwg9bMvnve1ZA7q4n0HCh99Ur+gxtY0ayGIGUxJf+Zem
 Owek3hpZyhJh5ZvKYJPR7cyIr64wLyM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-MAQ1O7WcN0aW4Bxv02KA0w-1; Tue, 17 Mar 2020 16:27:44 -0400
X-MC-Unique: MAQ1O7WcN0aW4Bxv02KA0w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A60ED8017CC;
 Tue, 17 Mar 2020 20:27:43 +0000 (UTC)
Received: from [10.3.112.193] (ovpn-112-193.phx2.redhat.com [10.3.112.193])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3BD085D9E2;
 Tue, 17 Mar 2020 20:27:40 +0000 (UTC)
Subject: Re: [PATCH v4 20/34] qapi: Add feature flags to struct members
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200317115459.31821-1-armbru@redhat.com>
 <20200317115459.31821-21-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <39d4cc7c-76b8-9e78-a694-c2ae1d8324f3@redhat.com>
Date: Tue, 17 Mar 2020 15:27:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200317115459.31821-21-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 marcandre.lureau@gmail.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/17/20 6:54 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---

> +++ b/qapi/introspect.json
> @@ -206,11 +206,15 @@
>   #           Future extension: if present and non-null, the parameter
>   #           is optional, and defaults to this value.
>   #
> +# @features: names of features associated with the member, in no
> +#            particular order.  (since 5.0)

We're down to the soft-freeze wire ;)

> +#
>   # Since: 2.5
>   ##
>   { 'struct': 'SchemaInfoObjectMember',
> -  'data': { 'name': 'str', 'type': 'str', '*default': 'any' } }
> +  'data': { 'name': 'str', 'type': 'str', '*default': 'any',
>   # @default's type must be null or match @type
> +            '*features': [ 'str' ] } }

The comment was outside the overall definition, and now occurs=20
mid-object.  I might have listed '*features' first, leaving '*default'=20
last so that the comment can still be outside the overall struct.  But=20
that's aesthetics; the QAPI parser handles things correctly as-is.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


