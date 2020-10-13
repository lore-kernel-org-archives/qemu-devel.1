Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00EA1C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 10:43:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 458CE20E65
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 10:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YB8ITyLs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 458CE20E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSHlj-0006vf-9M
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 06:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kSHkJ-0005VI-Kl
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 06:41:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57247)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kSHkH-0004hs-8E
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 06:41:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602585686;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vuoG5AQ8E6jDkAiHa5PKsdi9zHw37GJmh1Y94C8NBIo=;
 b=YB8ITyLsH96Dmgukz09YrABZ+DQT//9PTiNfI1hiU1gPan2zKTTs3tPjKH4UKDEUCqUcSo
 Wd9QBlzEtv+7wE2Ajh3/esxRM5auqemU+dfCRWeO0vF48FwQ9XDCpoY6Wt7yE72yn1m1jT
 OBj68+OUkVxAZZ3FGCHM69L/sBK3q3s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-116-IsUix0j7N2CrKHkG9edo4w-1; Tue, 13 Oct 2020 06:41:25 -0400
X-MC-Unique: IsUix0j7N2CrKHkG9edo4w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 762631084C84
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 10:41:24 +0000 (UTC)
Received: from redhat.com (ovpn-114-78.ams2.redhat.com [10.36.114.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6297D10013C1;
 Tue, 13 Oct 2020 10:41:20 +0000 (UTC)
Date: Tue, 13 Oct 2020 11:41:17 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] qemu-edid: drop cast
Message-ID: <20201013104117.GK70612@redhat.com>
References: <20201013091615.14166-1-kraxel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201013091615.14166-1-kraxel@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 03:04:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 13, 2020 at 11:16:15AM +0200, Gerd Hoffmann wrote:
> Not needed and makes some compilers error out with:
> 
> qemu-edid.c:15:1: error: initializer element is not constant
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  qemu-edid.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/qemu-edid.c b/qemu-edid.c
> index 1db3372b982c..1cd6a9517238 100644
> --- a/qemu-edid.c
> +++ b/qemu-edid.c
> @@ -9,7 +9,7 @@
>  #include "qemu/cutils.h"
>  #include "hw/display/edid.h"
>  
> -static qemu_edid_info info = (qemu_edid_info) {
> +static qemu_edid_info info = {
>      .prefx = 1024,
>      .prefy = 768,
>  };

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


