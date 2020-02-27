Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD327C4BA35
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 01:58:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A959320838
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 01:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UQsymhY0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A959320838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j78Rf-0001Rd-Tt
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 20:58:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37972)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j78R0-0000Yd-Cy
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 20:57:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j78Qz-0000lY-Gf
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 20:57:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54571
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j78Qz-0000kD-Bz
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 20:57:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582768673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=inBcSck0Ovqsi0dpBZi7WHEW6qxHfYDL4KzepaM2Pjc=;
 b=UQsymhY0Gc2dOXhzIk3u3fUVHqA/Mbh+PuoKMOaNlBCNwoDbH7UIf1qSLKOForFQ/vGRgz
 Wum+Yta89FZzthxc7OJMuh4sZpaBO2HlIt9AQ2CjKhNtw+6C/jLoTPCQnmk1EEWFBOjqSX
 AudW725B1eipnSFT/m6IR0g5OrCyrhk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-Fy6nzlbDN7WkUmCz0s4PIg-1; Wed, 26 Feb 2020 20:57:47 -0500
X-MC-Unique: Fy6nzlbDN7WkUmCz0s4PIg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 534C3800EBB;
 Thu, 27 Feb 2020 01:57:46 +0000 (UTC)
Received: from [10.3.116.57] (ovpn-116-57.phx2.redhat.com [10.3.116.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DCFB51001B34;
 Thu, 27 Feb 2020 01:57:45 +0000 (UTC)
Subject: Re: [PATCH v6 9/9] iotests: add pylintrc file
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200227000639.9644-1-jsnow@redhat.com>
 <20200227000639.9644-10-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <b37712c8-ea12-e3e0-5a34-31e5c96f30fc@redhat.com>
Date: Wed, 26 Feb 2020 19:57:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200227000639.9644-10-jsnow@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/26/20 6:06 PM, John Snow wrote:
> Repeatable results. run `pylint iotests.py` and you should get a pass.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   tests/qemu-iotests/pylintrc | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
>   create mode 100644 tests/qemu-iotests/pylintrc

> +        too-many-branches,
> +        too-many-public-methods,
> \ No newline at end of file

Intentional?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


