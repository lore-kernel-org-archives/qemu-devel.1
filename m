Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FAD8C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 13:56:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A02220774
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 13:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bphSvw6v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A02220774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqGkC-0004aV-Em
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 09:56:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jqGct-0001Mb-OE
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 09:48:43 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40529
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jqGcq-0008CN-RS
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 09:48:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593524920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1kDF33SkBIMxX+TfeNkB1aYwsB9NxRjpAPfkp9doQcs=;
 b=bphSvw6vaPEF7UR7SOShPDlbz0tAsj7bp23GiYzcWhCcAT+oaIZ59wSlzzM1B5oX2S52MK
 oxhFg12JpLL9Lgn8pqymmIJRb0zNKc8TSGappL9CBcbN0sWdUb16XgMyrnwXKLiQ1mBVvM
 qMffNLJTKoGPCX8KaHrwzqllV17hu3Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-faW0U_rtMHeV6m4_6I5SJQ-1; Tue, 30 Jun 2020 09:48:34 -0400
X-MC-Unique: faW0U_rtMHeV6m4_6I5SJQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45E0A80183C;
 Tue, 30 Jun 2020 13:48:33 +0000 (UTC)
Received: from titinator (ovpn-114-115.ams2.redhat.com [10.36.114.115])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 86A647166E;
 Tue, 30 Jun 2020 13:48:22 +0000 (UTC)
References: <20200626164307.3327380-1-dinechin@redhat.com>
 <20200626164307.3327380-2-dinechin@redhat.com>
 <2fff081b-273a-45c4-9117-a16eceb66c66@suse.de>
User-agent: mu4e 1.5.2; emacs 26.3
From: Christophe de Dinechin <dinechin@redhat.com>
To: Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH 01/10] modules: Provide macros making it easier to
 identify module exports
In-reply-to: <2fff081b-273a-45c4-9117-a16eceb66c66@suse.de>
Date: Tue, 30 Jun 2020 15:48:21 +0200
Message-ID: <ly8sg4d5qy.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 =?utf-8?Q?M?= =?utf-8?Q?arc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020-06-29 at 12:13 CEST, Claudio Fontana wrote...
> Hello Christophe,
>
> On 6/26/20 6:42 PM, Christophe de Dinechin wrote:
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
>>
>
> Just as background, I am interested in all modules-related work, because of my long term plan to have target-specific modules as well:
>
>  https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg04628.html
>
> I am not 100% clear on what is the goal and expected usage of this
> preprocessor code, despite the commit message, maybe you could clarify a
> bit with more verbosity?

Well, so far, the preference seems to be to go through a more verbose
approach with an explicit table of functions.

What the preprocessor code did was:

- If you build without modules, nothing changes, you get a direct call

- If you build with modules:

 + In the DSO, foo is replaced with foo_implementation
 + Elsewhere, foo is replaced with a function pointer also called foo.
 + The implementation adds constructor code that sets foo to point to foo_implementation


>
> Additionally if you happen to be interested, maybe you know already or
> could think about what this could mean for target-specific modules, which
> will require some improvements to the modules "subsystem"(?) as well.

So far, I've only integrated Gerd's workaround for target-specific
modules. Some additional mechanics is needed to name target-specific
modules, e.g. put them in some target directory.

>
> In my experimentation I didn't have to do this preprocessor work, instead
> I had to fine tune a bit the makefile support (rules.mak and makefiles) to
> be able to accomodate for (even large) modules in target/ as well.

It's probably because the modules you were dealing with already had the
required indirection and module_init calls, i.e. they were only invoked
using QOM already.

The mechanism I was proposing is to quickly add the indirection for
qemu functionality that does not have such indirect calls yet.

The consensus so far seems to be that the syntax I proposed is not nice, and
that it's better to make it more explicit through a table and indirect
calls, even if that means changing the call sites.

>
> Thanks!
>
> CLaudio


--
Cheers,
Christophe de Dinechin (IRC c3d)


