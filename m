Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C02C52D2B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 14:04:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D6DB21556
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 14:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FdgC37sy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D6DB21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7JmW-0007eq-Kp
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 09:04:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42175)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j7JlY-0006Ur-WC
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:03:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j7JlT-0002Ry-Vf
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:03:52 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42656
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j7JlT-0002Ro-RD
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:03:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582812227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fCJRkG4PglvnfXCelEZNyYb3OnFp+pyHWRipzkeF1Ns=;
 b=FdgC37syn92GKJo6w2q/ivjH7j7K6hCHzQblgkMraPkJiYW1Xfge+aKpLBJm6bvyboDkf6
 SylH9BQs1fs1XUvRzMmdtEoQP2VD37HNU+ZIUMahQTTaaCjErYOlb/ohNx084zFAMqmZKj
 T0+tMw4ZL5u3Awvr7hm1E1UBHsXsg+w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-Zb0pWH6eO92OSRE3a8ZQaQ-1; Thu, 27 Feb 2020 09:03:43 -0500
X-MC-Unique: Zb0pWH6eO92OSRE3a8ZQaQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 512B08010E8;
 Thu, 27 Feb 2020 14:03:42 +0000 (UTC)
Received: from [10.3.116.57] (ovpn-116-57.phx2.redhat.com [10.3.116.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BA6EC5D9CD;
 Thu, 27 Feb 2020 14:03:41 +0000 (UTC)
Subject: Re: [PATCH v1 4/8] iotests: filter out compression_type
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200227072953.25445-1-dplotnikov@virtuozzo.com>
 <20200227072953.25445-5-dplotnikov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <e3a3a3b1-8cd0-fa26-c5a3-46065c5888fe@redhat.com>
Date: Thu, 27 Feb 2020 08:03:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200227072953.25445-5-dplotnikov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, armbru@redhat.com,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/27/20 1:29 AM, Denis Plotnikov wrote:
> After adding compression type feature to qcow2 format, qemu framework
> commands reporting the image settingd, e.g. "qemu-img create", started

settings

> reporting the compression type for the image which breaks the iotests
> output matching.
> 
> To fix it, add compression_type=zlib to the list of filtered image parameters.
> 
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---
>   tests/qemu-iotests/common.filter | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

This should be squashed in to the patch that caused the breakage (3/8, 
if I'm right).

> 
> diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common.filter
> index 3f8ee3e5f7..c6962d199c 100644
> --- a/tests/qemu-iotests/common.filter
> +++ b/tests/qemu-iotests/common.filter
> @@ -152,7 +152,8 @@ _filter_img_create()
>           -e "s# refcount_bits=[0-9]\\+##g" \
>           -e "s# key-secret=[a-zA-Z0-9]\\+##g" \
>           -e "s# iter-time=[0-9]\\+##g" \
> -        -e "s# force_size=\\(on\\|off\\)##g"
> +        -e "s# force_size=\\(on\\|off\\)##g" \
> +        -e "s# compression_type=zlib##g"

Do you really want to hard-code just zlib, or should this be more 
generic as compression_type=[a-zA-Z0-9]\\+ as done on other lines like 
key-secret?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


