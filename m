Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58798C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 12:49:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 223AD2082F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 12:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MCIX46vY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 223AD2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqFhz-00082u-FI
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 08:49:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jqFhH-0007Vo-Ni
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 08:49:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23756
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jqFhG-0006Yf-C3
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 08:49:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593521349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G1epzNqfey4HCQTXVg4w9gtCn9c6aKwADG6OIFahxMs=;
 b=MCIX46vYf3myCkR7igWKzHvTAWTDwKcXssjH14NRRBrxbXeFkPPwiF9sajJy6QRxzVh/M6
 /e5p+CUaOGCJ27trgN4bM5a/wvfmBs67/gU5QtlIXDiHPtC2AhApthWkWsIY48LXpp3psY
 sC7LuYQpu3roQLbKTaawItGM99ZfK0E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-JtSUvhOZPzGvd5CYZpaMhw-1; Tue, 30 Jun 2020 08:49:07 -0400
X-MC-Unique: JtSUvhOZPzGvd5CYZpaMhw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D12F8EC1A3;
 Tue, 30 Jun 2020 12:49:05 +0000 (UTC)
Received: from titinator (ovpn-114-115.ams2.redhat.com [10.36.114.115])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E24637BEA0;
 Tue, 30 Jun 2020 12:48:54 +0000 (UTC)
References: <20200626164307.3327380-1-dinechin@redhat.com>
 <20200626164307.3327380-11-dinechin@redhat.com>
 <20200626172940.GO1028934@redhat.com>
User-agent: mu4e 1.5.2; emacs 26.3
From: Christophe de Dinechin <dinechin@redhat.com>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH 10/10] REMOVE: Instrumentation to show the module
 functions being replaced
In-reply-to: <20200626172940.GO1028934@redhat.com>
Date: Tue, 30 Jun 2020 14:48:53 +0200
Message-ID: <lylfk4d8i2.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dinechin@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dinechin@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 00:34:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020-06-26 at 19:29 CEST, Daniel P. Berrang=C3=A9 wrote...
> On Fri, Jun 26, 2020 at 06:43:07PM +0200, Christophe de Dinechin wrote:
>> Signed-off-by: Christophe de Dinechin <dinechin@redhat.com>
>> ---
>>  include/qemu/module.h | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/include/qemu/module.h b/include/qemu/module.h
>> index 1922a0293c..8d6e10ba81 100644
>> --- a/include/qemu/module.h
>> +++ b/include/qemu/module.h
>> @@ -14,10 +14,13 @@
>>  #ifndef QEMU_MODULE_H
>>  #define QEMU_MODULE_H
>>
>> +#include "trace/recorder.h"
>>
>>  #define DSO_STAMP_FUN         glue(qemu_stamp, CONFIG_STAMP)
>>  #define DSO_STAMP_FUN_STR     stringify(DSO_STAMP_FUN)
>>
>> +RECORDER_DECLARE(modules);
>> +
>>  #ifdef BUILD_DSO
>>  void DSO_STAMP_FUN(void);
>>  /* This is a dummy symbol to identify a loaded DSO as a QEMU module, so=
 we can
>> @@ -55,6 +58,7 @@ static void __attribute__((constructor)) do_qemu_init_=
 ## function(void)    \
>>      static void __attribute__((constructor)) Name##_register(void)     =
 \
>>      {                                                                  =
 \
>>          Name =3D Name##_implementation;                                =
   \
>> +        record(modules, "Setting " #Name " to %p", Name);              =
 \
>>      }                                                                  =
 \
>>      Ret Name##_implementation Args
>>  #else /* !CONFIG_MODULES */
>
> Contrary to the commit $SUBJECT, I think you should keep this, not remove
> it. It should use QEMU's trace backend though.

OK. Will add a trace backend version in next iteration.

>
> Regards,
> Daniel


--
Cheers,
Christophe de Dinechin (IRC c3d)


