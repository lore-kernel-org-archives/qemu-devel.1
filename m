Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8537BC83000
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 14:25:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FB5E208DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 14:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L/FffBRA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FB5E208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUA8D-0002lb-Eh
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 10:25:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59788)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jUA5F-00062k-Hw
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 10:22:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jUA5F-0005eg-3z
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 10:22:37 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42644
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jUA5E-0005eR-NY
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 10:22:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588256555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xNXViI9Pe7gq59dmd2X/aYw3cHs0SP/FfbaLQT2xuTo=;
 b=L/FffBRA3z5r9j8w9HPXaFWjCJwI0vAETNaIqpLdpdrmtYZDU0gk09+2A3MMaECY6dbKcV
 5ZLypCnAzSc1VxX8W53fLV7/wX1fHiSgyxltz7KH9FngAzGPwllM890wGJVVBPLCZSf5VZ
 Zze0+f53RxE++YSBBPBuULX503G28j0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-RQ5lxHXmPmeprGLbykEUyQ-1; Thu, 30 Apr 2020 10:22:31 -0400
X-MC-Unique: RQ5lxHXmPmeprGLbykEUyQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03AADA0C02;
 Thu, 30 Apr 2020 14:22:31 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E6CA60C84;
 Thu, 30 Apr 2020 14:22:29 +0000 (UTC)
Subject: Re: [PATCH 6/6] iotests: vmdk: Enable zeroed_grained=on by default
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200430133007.170335-1-kwolf@redhat.com>
 <20200430133007.170335-7-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <c11c2633-34a3-22b1-aa3a-3ff8189672cd@redhat.com>
Date: Thu, 30 Apr 2020 09:22:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430133007.170335-7-kwolf@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:04:40
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
Cc: qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/30/20 8:30 AM, Kevin Wolf wrote:
> In order to avoid bitrot in the zero cluster code in VMDK, enable
> zero_grained=on by default for the tests.

Here, you spell it zero_grained=on,

> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   tests/qemu-iotests/059   | 6 +++---
>   tests/qemu-iotests/check | 3 +++
>   2 files changed, 6 insertions(+), 3 deletions(-)

So you're changing the default for better coverage and speed, but 
ensuring that 59 still covers the (slower) zero_grained=off.  Seems 
reasonable.

Reviewed-by: Eric Blake <eblake@redhat.com>

> +++ b/tests/qemu-iotests/check
> @@ -546,6 +546,9 @@ fi
>   if [ "$IMGFMT" == "luks" ] && ! (echo "$IMGOPTS" | grep "iter-time=" > /dev/null); then
>       IMGOPTS=$(_optstr_add "$IMGOPTS" "iter-time=10")
>   fi
> +if [ "$IMGFMT" == "vmdk" ] && ! (echo "$IMGOPTS" | grep "zeroed_grain=" > /dev/null); then

Here, zeroed_grain=.  Which is it?

> +    IMGOPTS=$(_optstr_add "$IMGOPTS" "zeroed_grain=on")

As a native speaker, my inclination is zero_grained; but I don't know 
the VMDK spec well enough to know if this is something in the spec, or 
just a term that qemu invented.  And since we already have existing 
usage of one spelling, switching the spelling now would require a 
deprecation period and is separate from this patch.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


