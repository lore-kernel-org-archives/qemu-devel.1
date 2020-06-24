Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D68BC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 09:02:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0804120857
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 09:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fiqgeHc3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0804120857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo1IJ-00041B-An
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 05:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jo1Go-0003WO-Ee
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 05:00:38 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43715
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jo1Gm-0006wW-51
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 05:00:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592989235;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=MEHMTaLh1c0eNVyV63lKg5QYoGN7PpUq2YzYXaswtBo=;
 b=fiqgeHc3yfiZARuphJC4AWC1l6BKki7dpLYnlwmQU6dUOGdvtoz5n1Qe2nKwQhMRdzXIkZ
 AF6a+vGMaq5EhGb/3MHUnYeDByNzjlf3afHLRuahVqFHbRXGCEMH1LoWhG2Ol26lmJI9LB
 CbfCWrfW01EgLkXFdclOeO8nQfq7AMY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-QOaZq18-N0qCd4Z6AvG66g-1; Wed, 24 Jun 2020 05:00:29 -0400
X-MC-Unique: QOaZq18-N0qCd4Z6AvG66g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA6A9188361F;
 Wed, 24 Jun 2020 09:00:26 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 823C67FD03;
 Wed, 24 Jun 2020 08:59:58 +0000 (UTC)
Date: Wed, 24 Jun 2020 09:59:56 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Christophe de Dinechin <dinechin@redhat.com>
Subject: Re: [PATCH] trivial: Remove extra character in configure help
Message-ID: <20200624085956.GE774096@redhat.com>
References: <20200624083337.912846-1-dinechin@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200624083337.912846-1-dinechin@redhat.com>
User-Agent: Mutt/1.14.0 (2020-05-02)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 00:34:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 24, 2020 at 10:33:37AM +0200, Christophe de Dinechin wrote:
> Signed-off-by: Christophe de Dinechin <dinechin@redhat.com>
> ---
>  configure | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/configure b/configure
> index ba88fd1824..c7a6a5adfe 100755
> --- a/configure
> +++ b/configure
> @@ -1787,7 +1787,7 @@ Advanced options (experts only):
>    --block-drv-ro-whitelist=L
>                             set block driver read-only whitelist
>                             (affects only QEMU, not qemu-img)
> -  --enable-trace-backends=B Set trace backend
> +  --enable-trace-backends= Set trace backend

This is just following the style of the option above. "B" is a
placeholder for the desired backend(s).

>                             Available backends: $trace_backend_list
>    --with-trace-file=NAME   Full PATH,NAME of file to store traces
>                             Default:trace-<pid>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


