Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1CAC2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 14:09:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B638921D7D
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 14:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aLBUx8Ov"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B638921D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izhqg-000133-VV
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 09:09:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46483)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1izhq1-0000NQ-Dx
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 09:09:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1izhpz-0002Ai-Ba
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 09:09:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56652
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1izhpz-0002AR-3K
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 09:08:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580998138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TjFMyxaopW2iDQqzMnvbCsvu7KhzB9A3d6pu3yk+Vrw=;
 b=aLBUx8OvGKaDif+PIOidTghtghJB1jHk2ZH8Rq6GBXRxYOuT7hCJdBs/oinlJ/+sedFcgH
 4xwD4YwFQ8TZi6zBJ5tXqhIbfVG5mO1pcOG7KMS2oIdmvj7DO+mxqKt0bO4ha7+26qxXVf
 PRfnOFIqkOW2uZr4kdF+S0Am4CcQy3s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-qB89CFgpMe68GsLlOx4ijg-1; Thu, 06 Feb 2020 09:08:54 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46F851857340;
 Thu,  6 Feb 2020 14:08:53 +0000 (UTC)
Received: from [10.3.116.166] (ovpn-116-166.phx2.redhat.com [10.3.116.166])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E5A026E4B;
 Thu,  6 Feb 2020 14:08:52 +0000 (UTC)
Subject: Re: [PATCH v11 2/2] docs: qcow2: introduce compression type feature
To: Max Reitz <mreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
References: <20200131142219.3264-1-vsementsov@virtuozzo.com>
 <20200131142219.3264-3-vsementsov@virtuozzo.com>
 <ee6b018a-be33-ed77-c4b9-4894c685d30a@redhat.com>
 <w51mua3zg16.fsf@maestria.local.igalia.com>
 <18578060-2c1f-6c63-31e1-dee51387210a@redhat.com>
 <aa9050a1-b071-6e08-bb91-8b513de09180@virtuozzo.com>
 <aa11a480-bd79-837b-c79b-722bdb6dc31f@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <d2b7bdc6-4691-3c10-0610-d8443d737abe@redhat.com>
Date: Thu, 6 Feb 2020 08:08:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <aa11a480-bd79-837b-c79b-722bdb6dc31f@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: qB89CFgpMe68GsLlOx4ijg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: kwolf@redhat.com, den@openvz.org, dplotnikov@virtuozzo.com,
 armbru@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/6/20 6:38 AM, Max Reitz wrote:

>> I'm OK with it too, as well as I'm OK with the stricter variant, when we
>> don't allow incompatible images with zlib set. I don't see any serious
>> difference.
>>
>> But I need this to land somehow. Max likes stricter variant and he is
>> maintainer of qcow2..
>>
>> Max, will you merge it as is, or did you change your mind, or should we
>> ask Kevin for his opinion?
>=20
> I=92m currently preparing a pull request (without this series), but after
> that I=92m planning to merge the stricter variant.
>=20
> As far as I=92ve seen, the argument for making it less strict was still
> accompanied by =93Sure, nobody would set this flag for zlib-compressed
> images because that doesn=92t make sense=94.  So if nobody would do that,=
 we
> might as well just forbid it and thus ensure that everyone indeed does
> the sensible thing.

Fair enough; I'm happy to live with your decision as maintainer's=20
prerogative.

I _do_ hope that the actual implementation series gets merged soon,=20
though, and that as part of that series, you remember to tweak the=20
optional 'Feature Name' extension header to name the new incompatible=20
bit introduced in this patch.  And there's the simultaneous patches from=20
my qcow2 autoclear-all-zeroes bit that touch the same files, so we may=20
have some rebasing fun ahead of us...

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


