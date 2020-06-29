Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8069C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 10:14:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D28C23884
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 10:14:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D28C23884
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpqo9-0006Di-Sy
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 06:14:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56688)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>)
 id 1jpqnG-0005Hp-MQ; Mon, 29 Jun 2020 06:13:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:50024)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>)
 id 1jpqnE-0006Ox-Gk; Mon, 29 Jun 2020 06:13:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id E0EE7AEFE;
 Mon, 29 Jun 2020 10:13:38 +0000 (UTC)
Subject: Re: [PATCH 01/10] modules: Provide macros making it easier to
 identify module exports
To: Christophe de Dinechin <dinechin@redhat.com>, qemu-devel@nongnu.org
References: <20200626164307.3327380-1-dinechin@redhat.com>
 <20200626164307.3327380-2-dinechin@redhat.com>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <2fff081b-273a-45c4-9117-a16eceb66c66@suse.de>
Date: Mon, 29 Jun 2020 12:13:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200626164307.3327380-2-dinechin@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/28 22:46:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello Christophe,

On 6/26/20 6:42 PM, Christophe de Dinechin wrote:
> In order to facilitate the move of large chunks of functionality to
> load modules, it is simpler to create a wrapper with the same name
> that simply relays the implementation. For efficiency, this is
> typically done using inline functions in the header for the
> corresponding functionality. In that case, we rename the actual
> implementation by appending _implementation to its name. This makes it
> easier to select which function you want to put a breakpoint on.
> 
> Signed-off-by: Christophe de Dinechin <dinechin@redhat.com>
> ---
>  include/qemu/module.h | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/include/qemu/module.h b/include/qemu/module.h
> index 011ae1ae76..1922a0293c 100644
> --- a/include/qemu/module.h
> +++ b/include/qemu/module.h
> @@ -39,6 +39,30 @@ static void __attribute__((constructor)) do_qemu_init_ ## function(void)    \
>  }
>  #endif
>  
> +#ifdef CONFIG_MODULES
> +/* Identify which functions are replaced by a callback stub */
> +#ifdef MODULE_STUBS
> +#define MODIFACE(Ret,Name,Args)                                         \
> +    Ret (*Name)Args;                                                    \
> +    extern Ret Name##_implementation Args
> +#else /* !MODULE_STUBS */
> +#define MODIFACE(Ret,Name,Args)                                         \
> +    extern Ret (*Name)Args;                                             \
> +    extern Ret Name##_implementation Args
> +#endif /* MODULE_STUBS */
> +
> +#define MODIMPL(Ret,Name,Args)                                          \
> +    static void __attribute__((constructor)) Name##_register(void)      \
> +    {                                                                   \
> +        Name = Name##_implementation;                                   \
> +    }                                                                   \
> +    Ret Name##_implementation Args
> +#else /* !CONFIG_MODULES */
> +/* When not using a module, such functions are called directly */
> +#define MODIFACE(Ret,Name,Args)         Ret Name Args
> +#define MODIMPL(Ret,Name,Args)          Ret Name Args
> +#endif /* CONFIG_MODULES */
> +
>  typedef enum {
>      MODULE_INIT_MIGRATION,
>      MODULE_INIT_BLOCK,
> 

Just as background, I am interested in all modules-related work, because of my long term plan to have target-specific modules as well:

 https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg04628.html

I am not 100% clear on what is the goal and expected usage of this preprocessor code, despite the commit message,
maybe you could clarify a bit with more verbosity?

Additionally if you happen to be interested, maybe you know already or could think about what this could mean for target-specific modules,
which will require some improvements to the modules "subsystem"(?) as well.

In my experimentation I didn't have to do this preprocessor work, instead I had to fine tune a bit the makefile support (rules.mak and makefiles)
to be able to accomodate for (even large) modules in target/ as well.

Thanks!

CLaudio





