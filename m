Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989DAC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 13:48:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5508420675
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 13:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TcPjXnni"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5508420675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqGcB-0007ik-CN
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 09:47:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jqGTy-0001Ia-Ro
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 09:39:30 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60957
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jqGTx-0006Kl-CC
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 09:39:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593524368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BshmLbkCegvWQdOrab3Q23b6T16SbqzgLcrY5ZDWofo=;
 b=TcPjXnniUnZJ33tHWmA3dPUViBWL7tbXLNiUhp+0FZuKAdWjCIg7V/6epToeNwE4d9sze6
 BwjC04kAJCDIpX51rIP43DaiL9mGfm6jWjQBIOwzyDBggas6W+UJMvfySvfHx5QYpGQBJ6
 zYNs2Ngs3kg9iB294APZ8XDXjgE6uBk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-fxhnA3w1Mg6DgPEn1ZgnZw-1; Tue, 30 Jun 2020 09:39:24 -0400
X-MC-Unique: fxhnA3w1Mg6DgPEn1ZgnZw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB03C800D5C;
 Tue, 30 Jun 2020 13:39:22 +0000 (UTC)
Received: from titinator (ovpn-114-115.ams2.redhat.com [10.36.114.115])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 252647FE9C;
 Tue, 30 Jun 2020 13:39:11 +0000 (UTC)
References: <20200626164307.3327380-1-dinechin@redhat.com>
 <20200626164307.3327380-2-dinechin@redhat.com>
 <20200630052756-mutt-send-email-mst@kernel.org>
User-agent: mu4e 1.5.2; emacs 26.3
From: Christophe de Dinechin <dinechin@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 01/10] modules: Provide macros making it easier to
 identify module exports
In-reply-to: <20200630052756-mutt-send-email-mst@kernel.org>
Date: Tue, 30 Jun 2020 15:39:10 +0200
Message-ID: <lybll0d669.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dinechin@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dinechin@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 01:11:03
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?utf-8?Q?Mar?= =?utf-8?Q?c-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020-06-30 at 11:38 CEST, Michael S. Tsirkin wrote...
> On Fri, Jun 26, 2020 at 06:42:58PM +0200, Christophe de Dinechin wrote:
>> In order to facilitate the move of large chunks of functionality to
>> load modules, it is simpler to create a wrapper with the same name
>> that simply relays the implementation. For efficiency, this is
>> typically done using inline functions in the header for the
>> corresponding functionality. In that case, we rename the actual
>> implementation by appending _implementation to its name. This makes it
>> easier to select which function you want to put a breakpoint on.
>>
>> Signed-off-by: Christophe de Dinechin <dinechin@redhat.com>
>> ---
>>  include/qemu/module.h | 24 ++++++++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>>
>> diff --git a/include/qemu/module.h b/include/qemu/module.h
>> index 011ae1ae76..1922a0293c 100644
>> --- a/include/qemu/module.h
>> +++ b/include/qemu/module.h
>> @@ -39,6 +39,30 @@ static void __attribute__((constructor)) do_qemu_init_ ## function(void)    \
>>  }
>>  #endif
>>
>> +#ifdef CONFIG_MODULES
>> +/* Identify which functions are replaced by a callback stub */
>> +#ifdef MODULE_STUBS
>> +#define MODIFACE(Ret,Name,Args)                                         \
>> +    Ret (*Name)Args;                                                    \
>> +    extern Ret Name##_implementation Args
>> +#else /* !MODULE_STUBS */
>> +#define MODIFACE(Ret,Name,Args)                                         \
>> +    extern Ret (*Name)Args;                                             \
>> +    extern Ret Name##_implementation Args
>> +#endif /* MODULE_STUBS */
>> +
>> +#define MODIMPL(Ret,Name,Args)                                          \
>> +    static void __attribute__((constructor)) Name##_register(void)      \
>> +    {                                                                   \
>> +        Name = Name##_implementation;                                   \
>> +    }                                                                   \
>> +    Ret Name##_implementation Args
>> +#else /* !CONFIG_MODULES */
>> +/* When not using a module, such functions are called directly */
>> +#define MODIFACE(Ret,Name,Args)         Ret Name Args
>> +#define MODIMPL(Ret,Name,Args)          Ret Name Args
>> +#endif /* CONFIG_MODULES */
>> +
>>  typedef enum {
>>      MODULE_INIT_MIGRATION,
>>      MODULE_INIT_BLOCK,
>
> Hmm that's quite a bit of overhead for each call across modules.

Do you mean runtime overhead, i.e. the difference between
foo(x) and (*foo)(x)?


> Can't code patching be used somehow?

I've considered it, but this seems like a bit of a hammer for half a dozen
calls that are mostly init, so not performance sensitive.

In the old times, ld.so used to do that for you. All you had to do was to
mark one symbol as weak. Apparently for security reasons, that feature was
dropped several years ago. At least, that put call patching where it
belonged, i.e. in the loader.

>
>
>> --
>> 2.26.2


--
Cheers,
Christophe de Dinechin (IRC c3d)


