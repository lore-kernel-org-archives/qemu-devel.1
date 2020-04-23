Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF08C2BA19
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 07:24:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 359C220736
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 07:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UkVEH8qI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 359C220736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRWDP-00006C-EB
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 03:24:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43918)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRWCm-00084f-F0
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 03:23:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRWCl-0004sE-TD
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 03:23:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54144
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jRWCl-0004ry-GU
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 03:23:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587626606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dKCuMmBmzndHaHTW8o0diLeOHeBb2mtLY3I87hgef/g=;
 b=UkVEH8qI5GKKydIRK65PLLNVjiVqA4hVB7/rLBteeJctz+L4pGdYRP/ZR69iIUqvYh1p6e
 LH+P/T9AGhIAGzlZdkx3nJOAswrTNCWnBkdG+J8LlpCtwLNYNwD+lVTbgZuUmEMIUTaH6W
 WlJKUvz9btrkeDse3l9dOlSPM0605xo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-yZqOtUlpOMmlEj7cnoZvdw-1; Thu, 23 Apr 2020 03:23:20 -0400
X-MC-Unique: yZqOtUlpOMmlEj7cnoZvdw-1
Received: by mail-wr1-f71.google.com with SMTP id p2so2403929wrx.12
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 00:23:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IX24VkSMnMN0fAjeVbMI3N9QgAuh8E9Jat5sq+clf+w=;
 b=m0oPOHmX25fprOGt+AXeTeX1RWOIAKi4HTFuJjKkRPny1DHBvBw8J87mpSxom28SA6
 6eiocR54nH33+VmQNRi3EtE9Dhc9I/5a9CXNq9M2ADjWRneVZbTtF1dNHG8P7IWLEP66
 UZYSwpor+6ZccPrBvOEvmiGMS4aDByreUOlv76pA0w6MTOXnZOZ0EMCmjcU6PLCm/Xcc
 6P97hk30StQWftGZ+hLhiJlN941ostvq4MlYlBilOuthRzifHhexGUTI9f+X8eZVImVx
 8Oiub+Pa7zmlD8H/VNcAW/fJGvkW2I7ut/tbNZftJ4s/FRmYh/3H65Vivr9JGg7q7u7A
 N/hQ==
X-Gm-Message-State: AGi0PubczyiGHM/MH/y+vrfYbXcJRwz5XNUJwgEg6Y4YC6khahNSiU/i
 /W9RCOVb4M90G7vOl/8dKWYztNdUWIwpz/Ui4kjQ0U8OhVJm6MqUK41+0TVmZ87MrJoDdXiDG/c
 3MIUHvVwh7HDYLoY=
X-Received: by 2002:a05:600c:2f17:: with SMTP id
 r23mr2444636wmn.81.1587626598502; 
 Thu, 23 Apr 2020 00:23:18 -0700 (PDT)
X-Google-Smtp-Source: APiQypIVG76gVZoYNeC92GMgCGIg6QP1SeceQaFxP5ikqxBWjhugrTx7kNK/19c8YRnkXhIR91VlAg==
X-Received: by 2002:a05:600c:2f17:: with SMTP id
 r23mr2444596wmn.81.1587626598125; 
 Thu, 23 Apr 2020 00:23:18 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id w10sm2487034wrg.52.2020.04.23.00.23.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2020 00:23:16 -0700 (PDT)
Subject: Re: [PATCH 2/6] target/arm: Make set_feature() available for other
 files
To: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
References: <20200421131926.12116-1-philmd@redhat.com>
 <20200421131926.12116-3-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <04770c4b-285f-031d-7c2a-5b2f477ac40e@redhat.com>
Date: Thu, 23 Apr 2020 09:23:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200421131926.12116-3-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 03:23:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, Eric Auger <eric.auger@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/21/20 3:19 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> From: Thomas Huth <thuth@redhat.com>
>=20
> Move the common set_feature() and unset_feature() functions
> from cpu.c and cpu64.c to cpu.h.
>=20
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Message-ID: <20190921150420.30743-2-thuth@redhat.com>
> [PMD: Split Thomas's patch in two: set_feature, cpu_register (later)]
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>   target/arm/cpu.h   | 10 ++++++++++
>   target/arm/cpu.c   | 10 ----------
>   target/arm/cpu64.c | 11 +----------
>   3 files changed, 11 insertions(+), 20 deletions(-)
>=20
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 8b9f2961ba..5e32fe7518 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -696,6 +696,16 @@ typedef struct CPUARMState {
>       void *gicv3state;
>   } CPUARMState;
>  =20
> +static inline void set_feature(CPUARMState *env, int feature)
> +{
> +    env->features |=3D 1ULL << feature;
> +}
> +
> +static inline void unset_feature(CPUARMState *env, int feature)
> +{
> +    env->features &=3D ~(1ULL << feature);
> +}

Nack sigh... This still doesn't work:

target/arm/kvm64.c: At top level:
target/arm/kvm64.c:450:20: error: conflicting types for =E2=80=98set_featur=
e=E2=80=99
  static inline void set_feature(uint64_t *features, int feature)
                     ^~~~~~~~~~~
In file included from include/sysemu/kvm.h:252:0,
                  from target/arm/kvm64.c:27:
target/arm/cpu.h:699:20: note: previous definition of =E2=80=98set_feature=
=E2=80=99 was here
  static inline void set_feature(CPUARMState *env, int feature)
                     ^~~~~~~~~~~
target/arm/kvm64.c:455:20: error: conflicting types for =E2=80=98unset_feat=
ure=E2=80=99
  static inline void unset_feature(uint64_t *features, int feature)
                     ^~~~~~~~~~~~~
In file included from include/sysemu/kvm.h:252:0,
                  from target/arm/kvm64.c:27:
target/arm/cpu.h:704:20: note: previous definition of =E2=80=98unset_featur=
e=E2=80=99=20
was here
  static inline void unset_feature(CPUARMState *env, int feature)
                     ^~~~~~~~~~~~~
rules.mak:69: recipe for target 'target/arm/kvm64.o' failed
make: *** [target/arm/kvm64.o] Error 1

> +
>   /**
>    * ARMELChangeHookFn:
>    * type of a function which can be registered via arm_register_el_chang=
e_hook()
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index a79f233b17..37f18d1648 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -724,16 +724,6 @@ static bool arm_cpu_virtio_is_big_endian(CPUState *c=
s)
>  =20
>   #endif
>  =20
> -static inline void set_feature(CPUARMState *env, int feature)
> -{
> -    env->features |=3D 1ULL << feature;
> -}
> -
> -static inline void unset_feature(CPUARMState *env, int feature)
> -{
> -    env->features &=3D ~(1ULL << feature);
> -}
> -
>   static int
>   print_insn_thumb1(bfd_vma pc, disassemble_info *info)
>   {
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 62d36f9e8d..622082eae2 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -21,6 +21,7 @@
>   #include "qemu/osdep.h"
>   #include "qapi/error.h"
>   #include "cpu.h"
> +#include "internals.h"

This include is not necessary.

>   #include "qemu/module.h"
>   #if !defined(CONFIG_USER_ONLY)
>   #include "hw/loader.h"
> @@ -29,16 +30,6 @@
>   #include "kvm_arm.h"
>   #include "qapi/visitor.h"
>  =20
> -static inline void set_feature(CPUARMState *env, int feature)
> -{
> -    env->features |=3D 1ULL << feature;
> -}
> -
> -static inline void unset_feature(CPUARMState *env, int feature)
> -{
> -    env->features &=3D ~(1ULL << feature);
> -}
> -
>   #ifndef CONFIG_USER_ONLY
>   static uint64_t a57_a53_l2ctlr_read(CPUARMState *env, const ARMCPRegInf=
o *ri)
>   {
>=20


