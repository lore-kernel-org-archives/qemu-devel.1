Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E5E3C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 19:54:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 440E7207D8
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 19:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="INadt/vS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 440E7207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbUnH-0004xx-Cs
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 15:54:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39732)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jbUmS-0004IB-D0
 for qemu-devel@nongnu.org; Wed, 20 May 2020 15:53:32 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40971
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jbUmR-0006Dc-QP
 for qemu-devel@nongnu.org; Wed, 20 May 2020 15:53:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590004411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=Lqh8ejTwSMFyK0v73WsEFYZbBIrDx2HeGyfBMLYTZ8w=;
 b=INadt/vS8x09Aw+OZDuboxjafShYm9Mke1GpekQJwdQaPHAEY1qk0ohtpc+1EqFkpf0gyi
 7cmAy5gSA9YvQ6wn180rtWRqNoZGWTV3xb7CwYjIDnydmVd5Qs00vGSL6a9QWNuBZRxQzn
 vP3p/n8aeJn8EJeOGbfyd5effL+LZqk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-LPFv75oGMXSifhLGGx3pLw-1; Wed, 20 May 2020 15:53:27 -0400
X-MC-Unique: LPFv75oGMXSifhLGGx3pLw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4189A464;
 Wed, 20 May 2020 19:53:26 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-114.ams2.redhat.com [10.36.112.114])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 87442106427B;
 Wed, 20 May 2020 19:53:21 +0000 (UTC)
Subject: Re: [PATCH v2 2/9] pc-bios: s390x: Consolidate timing functions into
 time.h
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <20200514123729.156283-1-frankja@linux.ibm.com>
 <20200514123729.156283-3-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <21da6890-0951-5488-feaa-74a9a2afe918@redhat.com>
Date: Wed, 20 May 2020 21:53:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200514123729.156283-3-frankja@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 15:03:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14/05/2020 14.37, Janosch Frank wrote:
> Let's consolidate timing related functions into one header.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/menu.c        |  1 +
>  pc-bios/s390-ccw/netmain.c     | 15 +++----------
>  pc-bios/s390-ccw/s390-ccw.h    | 18 ----------------
>  pc-bios/s390-ccw/time.h        | 39 ++++++++++++++++++++++++++++++++++
>  pc-bios/s390-ccw/virtio-net.c  |  1 +
>  pc-bios/s390-ccw/virtio-scsi.c |  1 +
>  pc-bios/s390-ccw/virtio.c      | 18 +++-------------
>  7 files changed, 48 insertions(+), 45 deletions(-)
>  create mode 100644 pc-bios/s390-ccw/time.h
> 
> diff --git a/pc-bios/s390-ccw/menu.c b/pc-bios/s390-ccw/menu.c
> index ce3815b201..7925c33248 100644
> --- a/pc-bios/s390-ccw/menu.c
> +++ b/pc-bios/s390-ccw/menu.c
> @@ -12,6 +12,7 @@
>  #include "libc.h"
>  #include "s390-ccw.h"
>  #include "sclp.h"
> +#include "time.h"
>  
>  #define KEYCODE_NO_INP '\0'
>  #define KEYCODE_ESCAPE '\033'
> diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
> index 309ffa30d9..73def8de4f 100644
> --- a/pc-bios/s390-ccw/netmain.c
> +++ b/pc-bios/s390-ccw/netmain.c
> @@ -35,6 +35,7 @@
>  #include "s390-ccw.h"
>  #include "cio.h"
>  #include "virtio.h"
> +#include "time.h"

netmain.c already contains a #include <time.h> which pulls in the header
with the same name from libnet in SLOF ... so I wonder why you don't run
into trouble here, I'd expect that your local time.h now rather gets
included twice. Did you rebuild s390-netboot.img without problems?
Anyway, time.h is maybe not the best name for a new header here...

 Thomas



