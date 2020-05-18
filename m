Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF993C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 09:51:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 845892070A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 09:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SA5J1QRv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 845892070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jacQh-0002P6-Mp
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 05:51:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jacOp-0001D3-5b
 for qemu-devel@nongnu.org; Mon, 18 May 2020 05:49:31 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43019
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jacOn-0000cE-Te
 for qemu-devel@nongnu.org; Mon, 18 May 2020 05:49:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589795368;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=kPXjBK5JlwaNQFHdl8/2gPX7bL42R0POnkn3+E+HaAc=;
 b=SA5J1QRvx4Usxd0y82HSgbqedFTV4o/T3sgYBEaYNIz06U+PXS+OMJz39J96BmYbhHRcMn
 6dl6AvGkY4gKdEkK6HDBl5u1gnGORQbWsgP6hZm0WrAElToyDIS2xhJpd0rvlqYGuHxuk+
 H2lLclRv9Abh2pCl9MMxzSFM8Sr2Sgs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-Aip9q9tyPJyzhYp_itzqmg-1; Mon, 18 May 2020 05:49:24 -0400
X-MC-Unique: Aip9q9tyPJyzhYp_itzqmg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 237D01005512;
 Mon, 18 May 2020 09:49:23 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.61])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E224960BF1;
 Mon, 18 May 2020 09:49:21 +0000 (UTC)
Date: Mon, 18 May 2020 10:49:18 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Victor Lavaud <victor.lavaud@protonmail.com>
Subject: Re: Patch to fix missing Exec field in qemu.desktop
Message-ID: <20200518094918.GE1430944@redhat.com>
References: <zrVSyE1D2Xtxcr723wTf2sJRtM0IPuBRH0S-Gyx2XsvooDqbMYhqrK_aVk3AZM8RkjyOzYKWQH3VrnWDjwVUspDJHYUKXOyLZEZlvAzz6Ww=@protonmail.com>
MIME-Version: 1.0
In-Reply-To: <zrVSyE1D2Xtxcr723wTf2sJRtM0IPuBRH0S-Gyx2XsvooDqbMYhqrK_aVk3AZM8RkjyOzYKWQH3VrnWDjwVUspDJHYUKXOyLZEZlvAzz6Ww=@protonmail.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 23:32:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_EXCESS_BASE64=0.979, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, May 16, 2020 at 02:42:47PM +0000, Victor Lavaud via wrote:
> 
> 
> 
> Sent with ProtonMail Secure Email.
> 

> From 207a1a34accdc5b563d29484292829a4193c35f8 Mon Sep 17 00:00:00 2001
> From: Victor Lavaud <victor.lavaud@gmail.com>
> Date: Sat, 16 May 2020 16:33:00 +0200
> Subject: [PATCH] Fix missing Exec field in qemu.desktop
> 
> Signed-off-by: Victor Lavaud <victor.lavaud@pm.me>
> ---
>  ui/qemu.desktop | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/ui/qemu.desktop b/ui/qemu.desktop
> index 20f09f56be..1b9f02a0cc 100644
> --- a/ui/qemu.desktop
> +++ b/ui/qemu.desktop
> @@ -6,3 +6,4 @@ Type=Application
>  Terminal=false
>  Keywords=Emulators;Virtualization;KVM;
>  NoDisplay=true
> +Exec=qemu

There is no such binary, and we *intentionally* don't included any
'Exec' field, because it doesn't make sense. We consider the validation
tool that complains about missing 'Exec' field to be incorrect

   https://bugs.launchpad.net/qemu/+bug/1868221


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


