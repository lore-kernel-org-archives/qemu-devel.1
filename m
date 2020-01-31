Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 835D6C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 17:57:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53532214D8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 17:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q+wxMkrA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53532214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixaYA-0006Vv-Gf
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 12:57:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43716)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1ixaQC-0001xk-Ik
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 12:49:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1ixaQB-0007AG-FL
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 12:49:36 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43540
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ixaQB-00079Y-Bq
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 12:49:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580492975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dsw6pBSLwBg1pYBF0vKbRL+qFONy3A1L8a3cqaUx8lo=;
 b=Q+wxMkrASeGfezFAB5LU+TWnO8/JNXmPYyDcGIV8ld9ekC0tk+G0rHiH0AGf1JIFVVrjVo
 Fq34ZMrvZHp66seFabitgA2gnj0ONPIMj69a7/DBdYN6tbkWfKeCtYYbxXpDnQC41F87R8
 SebLPLUBLt+IdS1RvbiPckHjBFVeqrY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-4uvGhy4XMpWQayLCHi5tKg-1; Fri, 31 Jan 2020 12:49:28 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0396F800D48;
 Fri, 31 Jan 2020 17:49:27 +0000 (UTC)
Received: from [10.3.116.181] (ovpn-116-181.phx2.redhat.com [10.3.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 584595C241;
 Fri, 31 Jan 2020 17:49:26 +0000 (UTC)
Subject: Re: [PATCH v11 2/2] docs: qcow2: introduce compression type feature
To: Alberto Garcia <berto@igalia.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200131142219.3264-1-vsementsov@virtuozzo.com>
 <20200131142219.3264-3-vsementsov@virtuozzo.com>
 <ee6b018a-be33-ed77-c4b9-4894c685d30a@redhat.com>
 <w51mua3zg16.fsf@maestria.local.igalia.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <18578060-2c1f-6c63-31e1-dee51387210a@redhat.com>
Date: Fri, 31 Jan 2020 11:49:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <w51mua3zg16.fsf@maestria.local.igalia.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 4uvGhy4XMpWQayLCHi5tKg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 mreitz@redhat.com, dplotnikov@virtuozzo.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/31/20 11:34 AM, Alberto Garcia wrote:
> On Fri 31 Jan 2020 03:46:12 PM CET, Eric Blake wrote:
>>> +                    If the incompatible bit "Compression type" is set: the field
>>> +                    must be present and non-zero (which means non-zlib
>>> +                    compression type). Otherwise, this field must not be present
>>> +                    or must be zero (which means zlib).
>>
>>              If the incompatible bit "Compression type" is set: the field
>>              must be present. Otherwise, this field must not be present
>>              or must be zero (which means zlib).
> 
> But "not being present" and "being zero" is equivalent (as described in
> the previous commit).
> 
> And if the incompatible bit is not present then the field can be safely
> ignored (i.e. whether it is zero or not is irrelevant).
> 
> Let's try again:
> 
>     Defines the compression method used for compressed clusters. All
>     compressed clusters in an image use the same type.
> 
>     The value of this field should only be used when the incompatible bit
>     "Compression type" is set. If that bit is unset then this field is
>     not used and the compression method is zlib.

I like that wording.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


