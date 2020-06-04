Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CABC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 08:44:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDFF720738
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 08:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AdHA0FZD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDFF720738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jglU3-000398-W9
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 04:44:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jglTW-0002hw-Gn
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 04:43:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60026
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jglTU-0008Bl-OH
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 04:43:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591260223;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=nwrLxNpgtcUzKmaKLV2ZZwRVkV2T9CtIZutZAP8mSYI=;
 b=AdHA0FZDG+nrytLX6bzmQN/ozgEKhNfN0Mhusvgf7Deqj8s0yVL/nua3/zYMhXbAGUwDyv
 EbN+BGUMoaqd5LEcCrWUlMBbdV5hXI0RU9FP5Q0irGB9sVGB/a/l9lLcTjK2jBs3HvMydt
 y9XZAK8EWeR7VsZupVVWvlGJkLS/7PU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-hN2BkNh9O6SGnZR9262l-w-1; Thu, 04 Jun 2020 04:43:31 -0400
X-MC-Unique: hN2BkNh9O6SGnZR9262l-w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D1B29800C78;
 Thu,  4 Jun 2020 08:43:29 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.64])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9799C6111F;
 Thu,  4 Jun 2020 08:43:21 +0000 (UTC)
Date: Thu, 4 Jun 2020 09:43:18 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: P J P <ppandit@redhat.com>
Subject: Re: [PATCH v2 1/2] ait-vga: check address before reading
 configuration bytes
Message-ID: <20200604084318.GA3050580@redhat.com>
References: <20200603202251.1199170-1-ppandit@redhat.com>
 <20200603202251.1199170-2-ppandit@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200603202251.1199170-2-ppandit@redhat.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 01:12:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_EXCESS_BASE64=0.979, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Prasad J Pandit <pjp@fedoraproject.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Yi Ren <c4tren@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Ren Ding <rding@gatech.edu>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Hanqing Zhao <hanqing@gatech.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Typo: s/ait/ati/

On Thu, Jun 04, 2020 at 01:52:50AM +0530, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> While reading PCI configuration bytes, a guest may send an
> address towards the end of the configuration space. It may lead
> to an OOB access issue. Add check to ensure 'address + size' is
> within PCI configuration space.

Please include a CVE number for this security flaw if there is
one.

> 
> Reported-by: Ren Ding <rding@gatech.edu>
> Reported-by: Hanqing Zhao <hanqing@gatech.edu>
> Reported-by: Yi Ren <c4tren@gmail.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/display/ati.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> Update v2: add check to avoid OOB PCI configuration space access
>   -> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg00711.html
> 
> diff --git a/hw/display/ati.c b/hw/display/ati.c
> index bda4a2d816..6671959e5d 100644
> --- a/hw/display/ati.c
> +++ b/hw/display/ati.c
> @@ -384,7 +384,10 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
>          val = s->regs.crtc_pitch;
>          break;
>      case 0xf00 ... 0xfff:
> -        val = pci_default_read_config(&s->dev, addr - 0xf00, size);
> +        addr = addr - 0xf00;
> +        if (addr + size <= 0xff) {
> +            val = pci_default_read_config(&s->dev, addr, size);
> +        }
>          break;
>      case CUR_OFFSET:
>          val = s->regs.cur_offset;
> -- 
> 2.26.2
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


