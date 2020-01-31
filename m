Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090FDC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 14:49:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5270206D5
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 14:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C3B0lk9t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5270206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixXbj-0003cb-UF
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 09:49:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53852)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1ixXZV-0001lO-GE
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 09:47:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1ixXZT-0001QC-DC
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 09:47:01 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32285
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ixXZR-0001KJ-Hh
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 09:46:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580482015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LIECwYuI/LdyU5huu2OmcBqdAE2Or9vq9vxvqXvhCqY=;
 b=C3B0lk9tD5Q317xW7oFgKDYT1kAOouyDHhEDvgRtupV4WlrdZYi0BDw2154jnzZTUTres5
 pgLBFE2kPgyKGZ+DzveSJWmfomuMf6PcS0k/MEgqFpUt/kkdcWN8yhUgpDHn3B/pntNmGA
 hgyuXSjCl9IcPElQUFKlLocoQb8F7Xw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-DpFyAiMBMXKjXrzV08CvsA-1; Fri, 31 Jan 2020 09:46:51 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3250800D53;
 Fri, 31 Jan 2020 14:46:49 +0000 (UTC)
Received: from [10.3.116.181] (ovpn-116-181.phx2.redhat.com [10.3.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F4F660BE1;
 Fri, 31 Jan 2020 14:46:49 +0000 (UTC)
Subject: Re: [PATCH v11 1/2] docs: improve qcow2 spec about extending image
 header
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200131142219.3264-1-vsementsov@virtuozzo.com>
 <20200131142219.3264-2-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <acc0be89-de1a-7406-ddfd-e95f154f0aef@redhat.com>
Date: Fri, 31 Jan 2020 08:46:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200131142219.3264-2-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: DpFyAiMBMXKjXrzV08CvsA-1
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
Cc: kwolf@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 dplotnikov@virtuozzo.com, den@openvz.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/31/20 8:22 AM, Vladimir Sementsov-Ogievskiy wrote:
> Make it more obvious how to add new fields to the version 3 header and
> how to interpret them.
> 
> The specification is adjusted so that for new defined optional fields:
> 
> 1. Software may support some of these optional fields and ignore the
>     others, which means that features may be backported to downstream
>     Qemu independently.
> 2. If we want to add incompatible field (or a field, for which some its

s/some/some of/

>     values would be incompatible), it must be accompanied by
>     incompatible feature bit.
> 
> Also the concept of "default is zero" is clarified, as it's strange to
> say that the value of the field is assumed to be zero for the software
> version which don't know about the field at all and don't know how to
> treat it be it zero or not.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>   docs/interop/qcow2.txt | 45 +++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 42 insertions(+), 3 deletions(-)
-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


