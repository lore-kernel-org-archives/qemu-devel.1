Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24719CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 14:11:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA5E420659
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 14:11:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA5E420659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLSy4-0005aU-3r
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 10:11:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57331)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iLSpa-0002F1-Kx
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:02:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iLSpX-0002nW-Sr
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:02:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57984)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1iLSpU-0002kN-U1; Fri, 18 Oct 2019 10:02:09 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F089030738B5;
 Fri, 18 Oct 2019 14:02:07 +0000 (UTC)
Received: from [10.3.116.168] (ovpn-116-168.phx2.redhat.com [10.3.116.168])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 37AB460925;
 Fri, 18 Oct 2019 14:02:07 +0000 (UTC)
Subject: Re: [PATCH v8 2/3] docs: define padding for qcow2 header
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20191018094758.7124-1-vsementsov@virtuozzo.com>
 <20191018094758.7124-3-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <019c2493-25c1-9e54-1f5d-84bb003e98b1@redhat.com>
Date: Fri, 18 Oct 2019 09:02:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191018094758.7124-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Fri, 18 Oct 2019 14:02:08 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
 dplotnikov@virtuozzo.com, den@openvz.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/18/19 4:47 AM, Vladimir Sementsov-Ogievskiy wrote:
> Header extensions ends are already defined to be multiply of 8. Let's
> gently ask for header length to be a multiply of 8 too, when we have
> some additional fields. Requiring this may be considered as an
> incompatible change, so the padding is optional. Actually, padding is
> allowed before this patch (due to definition of additional fields),
> the only actual change is "SHOULD" word.

Too weak. I've already argued that this should be mandatory, and that we 
are not breaking backwards compatibility, but merely clarifying what has 
already been implicit by the fact that header extensions are required to 
be 8-byte size multiple (which makes no sense unless they are also 
8-byte aligned).

> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   docs/interop/qcow2.txt | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
> index 4709f3bb30..b971e59b1a 100644
> --- a/docs/interop/qcow2.txt
> +++ b/docs/interop/qcow2.txt
> @@ -185,6 +185,11 @@ which is covered by @header_length must be zeroed.
>   
>           < ... No additional fields in the header currently ... >
>   
> +Header padding
> +        If @header_length is larger than 104, software SHOULD make it a
> +        multiply of 8, adding zero-padding after additional fields. Still the
> +        padding is optional and may be absent in the image.
> +
>   Directly after the image header, optional sections called header extensions can
>   be stored. Each extension has a structure like the following:
>   
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org

