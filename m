Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C299AC35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 11:03:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FD4020674
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 11:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DwqO8dSt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FD4020674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izISr-0003fJ-MY
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 06:03:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44476)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1izIRm-0003CS-Iz
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:02:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1izIRl-0005f5-GA
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:02:18 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55798
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1izIRl-0005bX-Ba
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:02:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580900534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=1hM7rcymZlUWYa2TMQzerhk4h9zJeNXgJTdJ2wWFUgg=;
 b=DwqO8dStXThRw3zf5mr/vprozXHLZ+tUmHxDctPpQIFl14eZnvkAX1C3hnR17FMXN98EeU
 yFAzkFCl22kA0xou6alA5EqCM7EVHpf14KXlrt3zd09vJQwGsuRuZDN7UBFJoq9kXMl7+A
 SFALm+bAmh67ae6yfdq9PvkNY1GreVw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-fp1uUQwzPBm2LbSyfvVPjQ-1; Wed, 05 Feb 2020 06:02:12 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E92A104FB66;
 Wed,  5 Feb 2020 11:02:11 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-132.ams2.redhat.com [10.36.116.132])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3947C100194E;
 Wed,  5 Feb 2020 11:02:09 +0000 (UTC)
Subject: Re: [PATCH RFC 1/2] docs: rstfy s390 dasd ipl documentation
To: Cornelia Huck <cohuck@redhat.com>, Tony Krowiak <akrowiak@linux.ibm.com>, 
 "Jason J . Herne" <jjherne@linux.ibm.com>
References: <20200128180142.15132-1-cohuck@redhat.com>
 <20200128180142.15132-2-cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <d1465241-ceda-e47a-7077-e6037c13931f@redhat.com>
Date: Wed, 5 Feb 2020 12:02:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200128180142.15132-2-cohuck@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: fp1uUQwzPBm2LbSyfvVPjQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Pierre Morel <pmorel@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/01/2020 19.01, Cornelia Huck wrote:
> While at it, also fix the numbering in 'What QEMU does'.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  MAINTAINERS                                   |  2 +-
>  docs/devel/index.rst                          |  1 +
>  .../{s390-dasd-ipl.txt => s390-dasd-ipl.rst}  | 65 ++++++++++---------
>  3 files changed, 37 insertions(+), 31 deletions(-)
>  rename docs/devel/{s390-dasd-ipl.txt => s390-dasd-ipl.rst} (77%)

Looks sane to me.

Reviewed-by: Thomas Huth <thuth@redhat.com>


