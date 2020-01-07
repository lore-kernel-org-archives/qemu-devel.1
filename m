Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3AEC33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 11:45:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8A7E2070E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 11:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cLfYVF8+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8A7E2070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ionIk-00039L-1o
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 06:45:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33398)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iomaY-0004o2-Sc
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:59:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iomaX-0001Mh-4r
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:59:54 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37924
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iomaX-0001MT-0W
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:59:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578394792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=1KFr9OuGcJR2mzO5jrlO/rNIcg1HcaGI7rziaK4QNrk=;
 b=cLfYVF8+V6rT3F39vQ1txyjtVkM8o0t1jlCOqUF66ZV3Rj8qspYqhrb1wJHDimkviBHGc5
 WEwGn+7/PZAHdCK2HJ5vXHvF6kWHqv0+O86KLaXj6t+hyYnK8sIYtUo4ZmVZOiDTlJlxu/
 JtCTPYdUs8tG2bVRbRZwtCAYTYY6QbE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-qdcei4M4Pja88MIppmSVbQ-1; Tue, 07 Jan 2020 05:59:49 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0BA6B8024FC;
 Tue,  7 Jan 2020 10:59:48 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-116.ams2.redhat.com [10.36.116.116])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8EB878208E;
 Tue,  7 Jan 2020 10:59:46 +0000 (UTC)
Subject: Re: [PATCH 2/2] target/mips: Correct data on deprecated r4k machine
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1576764920-24514-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1576764920-24514-3-git-send-email-aleksandar.markovic@rt-rk.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <e94ef3f3-0126-90e0-3fd0-039302010b81@redhat.com>
Date: Tue, 7 Jan 2020 11:59:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1576764920-24514-3-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: qdcei4M4Pja88MIppmSVbQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: aleksandar.rikalo@rt-rk.com, aurelien@aurel32.net,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/12/2019 15.15, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> Change the release since r4k machine is deprecated from 4.2 to 5.0.
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  qemu-deprecated.texi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> index 62680f7..f71c740 100644
> --- a/qemu-deprecated.texi
> +++ b/qemu-deprecated.texi
> @@ -254,7 +254,7 @@ The 'scsi-disk' device is deprecated. Users should use 'scsi-hd' or
>  
>  @section System emulator machines
>  
> -@subsection mips r4k platform (since 4.2)
> +@subsection mips r4k platform (since 5.0)
>  
>  This machine type is very old and unmaintained. Users should use the 'malta'
>  machine type instead.
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>


