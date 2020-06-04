Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8436C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 08:49:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A282C20738
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 08:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bsi4iupL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A282C20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jglYk-0005bD-OI
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 04:49:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jglYD-00052P-RM
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 04:48:37 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49736
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jglYD-0000kP-3T
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 04:48:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591260515;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=TTTK3+BJtsszlItE+gxQgs97EwRIsWaXiLQLWKAEmNE=;
 b=bsi4iupLJmB9LiEbcFrmdG4VX9oHX9TOmGsYdFv/64IJ3nW+KbFfM61nQAWaRRnRe0HhQX
 Pvgp1qS/7cVHoNqX3yj7st7n8qocqCJs9cpftDpRAPbK7O/XGH9GU7LcHWaY3Y2BKexXXw
 qB9Brjj6kOG8/8aAIehPA/9a0KQZVug=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-VjP-AeaHOyOzn7VS-XSf-w-1; Thu, 04 Jun 2020 04:48:32 -0400
X-MC-Unique: VjP-AeaHOyOzn7VS-XSf-w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D1D0108BD0B
 for <qemu-devel@nongnu.org>; Thu,  4 Jun 2020 08:48:31 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.64])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0DF3060C84;
 Thu,  4 Jun 2020 08:48:23 +0000 (UTC)
Date: Thu, 4 Jun 2020 09:48:20 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 0/2] build qxl as module
Message-ID: <20200604084820.GC3050580@redhat.com>
References: <20200604075943.7001-1-kraxel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200604075943.7001-1-kraxel@redhat.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 01:08:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: dinechin@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 04, 2020 at 09:59:41AM +0200, Gerd Hoffmann wrote:
>

There's no info here, or in the commit message about the
intended goal of this modularization ? If we're modularizing
devices, why only qxl and not other devices too ?

> 
> Gerd Hoffmann (2):
>   qdev: add support for device module loading
>   vga: build qxl as module
> 
>  Makefile.objs            |  1 +
>  Makefile.target          |  7 ++++++
>  include/hw/qdev-core.h   |  3 +++
>  include/qemu/module.h    |  1 +
>  hw/core/qdev.c           | 49 ++++++++++++++++++++++++++++++++++++++++
>  qdev-monitor.c           |  5 ++++
>  hw/Makefile.objs         |  1 +
>  hw/display/Makefile.objs |  4 +++-
>  8 files changed, 70 insertions(+), 1 deletion(-)
> 
> -- 
> 2.18.4
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


