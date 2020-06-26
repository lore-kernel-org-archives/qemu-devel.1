Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5415EC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 17:31:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21962206DD
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 17:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QPPNGBE5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21962206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1josBx-0004Xb-9S
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 13:31:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43882)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1josAv-0003tR-Sz
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 13:30:05 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42334
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1josAs-0004Sm-SS
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 13:30:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593192601;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Yl1QQu7TNqKXYZN/uWYOu3rwQn+c3wwjdxGQLh+EI8w=;
 b=QPPNGBE51yoet/EXWhTSrXSI4CjvEClST2qZsp52ZsD2ZimNWN6nIICrnzubQ44Hqll8Sd
 /cCX+KvQEJuS0VXy2IUH0YWFcDpaYt/FdAHCchjeF9hSEXC46ylymSrMGkyPlYWcZkOJfF
 RFfOQ8pPTxhWkkM7sJCyk/HhtMjPJo0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-yxtyuzrxNCSpLjifQzk3dA-1; Fri, 26 Jun 2020 13:29:57 -0400
X-MC-Unique: yxtyuzrxNCSpLjifQzk3dA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F4C2193F560;
 Fri, 26 Jun 2020 17:29:56 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E9EC25D9CC;
 Fri, 26 Jun 2020 17:29:43 +0000 (UTC)
Date: Fri, 26 Jun 2020 18:29:40 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Christophe de Dinechin <dinechin@redhat.com>
Subject: Re: [PATCH 10/10] REMOVE: Instrumentation to show the module
 functions being replaced
Message-ID: <20200626172940.GO1028934@redhat.com>
References: <20200626164307.3327380-1-dinechin@redhat.com>
 <20200626164307.3327380-11-dinechin@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200626164307.3327380-11-dinechin@redhat.com>
User-Agent: Mutt/1.14.0 (2020-05-02)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 03:23:21
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On Fri, Jun 26, 2020 at 06:43:07PM +0200, Christophe de Dinechin wrote:
> Signed-off-by: Christophe de Dinechin <dinechin@redhat.com>
> ---
>  include/qemu/module.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/qemu/module.h b/include/qemu/module.h
> index 1922a0293c..8d6e10ba81 100644
> --- a/include/qemu/module.h
> +++ b/include/qemu/module.h
> @@ -14,10 +14,13 @@
>  #ifndef QEMU_MODULE_H
>  #define QEMU_MODULE_H
>  
> +#include "trace/recorder.h"
>  
>  #define DSO_STAMP_FUN         glue(qemu_stamp, CONFIG_STAMP)
>  #define DSO_STAMP_FUN_STR     stringify(DSO_STAMP_FUN)
>  
> +RECORDER_DECLARE(modules);
> +
>  #ifdef BUILD_DSO
>  void DSO_STAMP_FUN(void);
>  /* This is a dummy symbol to identify a loaded DSO as a QEMU module, so we can
> @@ -55,6 +58,7 @@ static void __attribute__((constructor)) do_qemu_init_ ## function(void)    \
>      static void __attribute__((constructor)) Name##_register(void)      \
>      {                                                                   \
>          Name = Name##_implementation;                                   \
> +        record(modules, "Setting " #Name " to %p", Name);               \
>      }                                                                   \
>      Ret Name##_implementation Args
>  #else /* !CONFIG_MODULES */

Contrary to the commit $SUBJECT, I think you should keep this, not remove
it. It should use QEMU's trace backend though.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


