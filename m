Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACFA3C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 19:52:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 788F02082D
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 19:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gJOnkfua"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 788F02082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia3M5-0002J8-RP
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 14:52:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54035)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1ia3K9-0001Dv-TX
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 14:50:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1ia3K8-0003vQ-1u
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 14:50:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52528
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ia3K7-0003us-Re
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 14:50:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574884203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2TM1dq/LZ5zAfvPa4w/qIrWC2rTGZYBUI5lhZGCDEK0=;
 b=gJOnkfuarmYHREUmAZDD4/64Yu+24OWymNsXtEYNmxqLsG8U/vjuedFLvPEr3d4A8AM9DJ
 3xqhdnqcmCc7OKD8ieQtz0lo07fgImHGaxs6So0qwwM2g5BHZsH12wEwql+l0oWQ6sBnOE
 dAWvAdA8o+QGIrvcT/sxWbHQbJsrcUs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-JloblrN1PRqqfHdL-dIBWQ-1; Wed, 27 Nov 2019 14:50:01 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1012107ACE6;
 Wed, 27 Nov 2019 19:50:00 +0000 (UTC)
Received: from [10.3.116.163] (ovpn-116-163.phx2.redhat.com [10.3.116.163])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0DE7719C69;
 Wed, 27 Nov 2019 19:49:58 +0000 (UTC)
Subject: Re: [PATCH v6] nbd: well form nbd_iter_channel_error errp handler
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20191127190840.15773-1-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <949f6fe4-5dde-0cef-84e3-e029787c7b12@redhat.com>
Date: Wed, 27 Nov 2019 13:49:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191127190840.15773-1-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: JloblrN1PRqqfHdL-dIBWQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: kwolf@redhat.com, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[adding Markus]

On 11/27/19 1:08 PM, Vladimir Sementsov-Ogievskiy wrote:
> Make nbd_iter_channel_error errp handler well formed:
> rename local_err to errp_in, as it is IN-parameter here (which is
> unusual for Error**).
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
> 
> v6: fix commit message
>      add Eric's r-b

I'm surprised that you aren't including Markus on a lot of these patches 
- even though you've posted a lot of them as separate threads to make 
them easier for individual maintainers to pick up, it would also be 
possible for Markus to pick up a bunch of them at once through his error 
tree.

At any rate, I'll queue this one through my NBD tree for 5.0 if it does 
not make it through Markus' error tree or the trivial tree sooner.


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


