Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA35C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 12:10:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BAF52075E
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 12:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LQ3Bcm4a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BAF52075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVaQN-0001fy-W5
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 07:10:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41566)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iVaMU-0005Ut-AV
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 07:06:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iVaMT-0006W9-1x
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 07:06:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57663
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iVaMS-0006Vx-Uf
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 07:06:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573819560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=0rsc2syZAGNiJQguTtEIYS/+4HkrozIeUTM/Nj56BiA=;
 b=LQ3Bcm4aw/iqgzlRTW8xmK/f02/xxDMT1mYBCpmtDTaIpy66LT1gh396PZzIpavL3JX0yx
 W+Gq1IFkq6nEy/hsKME8hwGk5bvG6mXXg2xjh6YspJMLwtFhq2T4GqNihcTfuv+kJsYwhq
 mAPsOaROlq2Mu4NNvcTY5aR0nG2VSzk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47--T5VFY5eMR-w7nwBfjM9pw-1; Fri, 15 Nov 2019 07:05:58 -0500
Received: by mail-wm1-f71.google.com with SMTP id d140so5541244wmd.1
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 04:05:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MutinVGm+Wx8wY8bknhCTpGKkfHtOQ471c3Ok3Kytmc=;
 b=pmhkKAeNomzY/W51yidLpNeSPteFHaZW6JEzkYLGMzT+4xkXAsLOtB3lNGSAr5tk4I
 uRhJxvzZwYAFO0UD78pU69HJqktT4DJiygT5wjnz9yXdKTiALlfKLXJDhWEefds/efb8
 4BszLAb+w49gUUclBWYhDB89M93RFIxu8U4N0hFwH3b+55ITBf8UmmnGa3H+/hkJAQVq
 Z/J19D9rqP0a5hywMW4HifhO+Ntnik/MXFGh4PRRizcsbFt+5E/gr8A2+2heI17/+lkp
 HSlC/BEh9XjHI9OK4Xdkbx/V9VYlG13r2plE7AzViz7bMyT9u9ecOGOJ6wQPTa7m9m51
 R3Mg==
X-Gm-Message-State: APjAAAXjlJUgu1NsKXLMZXxVvSAzCKe2Akpo0RZNOaRaFS57WAJSouyg
 esApnEJIalMSBWbABpv7siw4evH9ZX4vn9kpIhrXKjPec3DzKKxNtkeCATe6OkjRdya95vPLBlM
 TEcd1XnZ6Oe5Zjzk=
X-Received: by 2002:a1c:2342:: with SMTP id j63mr13619340wmj.56.1573819557055; 
 Fri, 15 Nov 2019 04:05:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqwoxpGwg6l1OyTgHIyQa3XfP7F2Od6UF0ARNnfFbrwOPGuVGAGqz1tWctAcsBkckEvOHV+fXw==
X-Received: by 2002:a1c:2342:: with SMTP id j63mr13619309wmj.56.1573819556722; 
 Fri, 15 Nov 2019 04:05:56 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:a15b:f753:1ac4:56dc?
 ([2001:b07:6468:f312:a15b:f753:1ac4:56dc])
 by smtp.gmail.com with ESMTPSA id w13sm10707897wrm.8.2019.11.15.04.05.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Nov 2019 04:05:56 -0800 (PST)
Subject: Re: [PATCH V2] WHPX: refactor load library
To: Sunil Muthuswamy <sunilmut@microsoft.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 "Justin Terry (VM)" <juterry@microsoft.com>
References: <MW2PR2101MB1116578040BE1F0C1B662318C0760@MW2PR2101MB1116.namprd21.prod.outlook.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <eb09cdfc-42b3-d0ab-60db-7c837d559284@redhat.com>
Date: Fri, 15 Nov 2019 13:05:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <MW2PR2101MB1116578040BE1F0C1B662318C0760@MW2PR2101MB1116.namprd21.prod.outlook.com>
Content-Language: en-US
X-MC-Unique: -T5VFY5eMR-w7nwBfjM9pw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Stefan Weil <sw@weilnetz.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/11/19 19:54, Sunil Muthuswamy wrote:
> This refactors the load library of WHV libraries to make it more
> modular. It makes a helper routine that can be called on demand.
> This allows future expansion of load library/functions to support
> functionality that is dependent on some feature being available.
>=20
> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> ---
> Changes since v1:
> - Fixed typo of load_whp_dispatch_fns
> - Fixed free of the right handle
>=20
>  target/i386/whp-dispatch.h |  4 +++
>  target/i386/whpx-all.c     | 85 +++++++++++++++++++++++++++++++---------=
------
>  2 files changed, 62 insertions(+), 27 deletions(-)
>=20
> diff --git a/target/i386/whp-dispatch.h b/target/i386/whp-dispatch.h
> index 23791fbb47..87d049ceab 100644
> --- a/target/i386/whp-dispatch.h
> +++ b/target/i386/whp-dispatch.h
> @@ -50,5 +50,9 @@ extern struct WHPDispatch whp_dispatch;
> =20
>  bool init_whp_dispatch(void);
> =20
> +typedef enum WHPFunctionList {
> +    WINHV_PLATFORM_FNS_DEFAULT,
> +    WINHV_EMULATION_FNS_DEFAULT,
> +} WHPFunctionList;
> =20
>  #endif /* WHP_DISPATCH_H */
> diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
> index ed95105eae..f3c61fa5d8 100644
> --- a/target/i386/whpx-all.c
> +++ b/target/i386/whpx-all.c
> @@ -1356,6 +1356,58 @@ static void whpx_handle_interrupt(CPUState *cpu, i=
nt mask)
>      }
>  }
> =20
> +/*
> + * Load the functions from the given library, using the given handle. If=
 a
> + * handle is provided, it is used, otherwise the library is opened. The
> + * handle will be updated on return with the opened one.
> + */
> +static bool load_whp_dispatch_fns(HMODULE *handle,
> +    WHPFunctionList function_list)
> +{
> +    HMODULE hLib =3D *handle;
> +
> +    #define WINHV_PLATFORM_DLL "WinHvPlatform.dll"
> +    #define WINHV_EMULATION_DLL "WinHvEmulation.dll"
> +    #define WHP_LOAD_FIELD(return_type, function_name, signature) \
> +        whp_dispatch.function_name =3D \
> +            (function_name ## _t)GetProcAddress(hLib, #function_name); \
> +        if (!whp_dispatch.function_name) { \
> +            error_report("Could not load function %s", #function_name); =
\
> +            goto error; \
> +        } \
> +
> +    #define WHP_LOAD_LIB(lib_name, handle_lib) \
> +    if (!handle_lib) { \
> +        handle_lib =3D LoadLibrary(lib_name); \
> +        if (!handle_lib) { \
> +            error_report("Could not load library %s.", lib_name); \
> +            goto error; \
> +        } \
> +    } \
> +
> +    switch (function_list) {
> +    case WINHV_PLATFORM_FNS_DEFAULT:
> +        WHP_LOAD_LIB(WINHV_PLATFORM_DLL, hLib)
> +        LIST_WINHVPLATFORM_FUNCTIONS(WHP_LOAD_FIELD)
> +        break;
> +
> +    case WINHV_EMULATION_FNS_DEFAULT:
> +        WHP_LOAD_LIB(WINHV_EMULATION_DLL, hLib)
> +        LIST_WINHVEMULATION_FUNCTIONS(WHP_LOAD_FIELD)
> +        break;
> +    }
> +
> +    *handle =3D hLib;
> +    return true;
> +
> +error:
> +    if (hLib) {
> +        FreeLibrary(hLib);
> +    }
> +
> +    return false;
> +}
> +
>  /*
>   * Partition support
>   */
> @@ -1491,51 +1543,30 @@ static void whpx_type_init(void)
> =20
>  bool init_whp_dispatch(void)
>  {
> -    const char *lib_name;
> -    HMODULE hLib;
> -
>      if (whp_dispatch_initialized) {
>          return true;
>      }
> =20
> -    #define WHP_LOAD_FIELD(return_type, function_name, signature) \
> -        whp_dispatch.function_name =3D \
> -            (function_name ## _t)GetProcAddress(hLib, #function_name); \
> -        if (!whp_dispatch.function_name) { \
> -            error_report("Could not load function %s from library %s.", =
\
> -                         #function_name, lib_name); \
> -            goto error; \
> -        } \
> -
> -    lib_name =3D "WinHvPlatform.dll";
> -    hWinHvPlatform =3D LoadLibrary(lib_name);
> -    if (!hWinHvPlatform) {
> -        error_report("Could not load library %s.", lib_name);
> +    if (!load_whp_dispatch_fns(&hWinHvPlatform, WINHV_PLATFORM_FNS_DEFAU=
LT)) {
>          goto error;
>      }
> -    hLib =3D hWinHvPlatform;
> -    LIST_WINHVPLATFORM_FUNCTIONS(WHP_LOAD_FIELD)
> =20
> -    lib_name =3D "WinHvEmulation.dll";
> -    hWinHvEmulation =3D LoadLibrary(lib_name);
> -    if (!hWinHvEmulation) {
> -        error_report("Could not load library %s.", lib_name);
> +    if (!load_whp_dispatch_fns(&hWinHvEmulation, WINHV_EMULATION_FNS_DEF=
AULT)) {
>          goto error;
>      }
> -    hLib =3D hWinHvEmulation;
> -    LIST_WINHVEMULATION_FUNCTIONS(WHP_LOAD_FIELD)
> =20
>      whp_dispatch_initialized =3D true;
> -    return true;
> -
> -    error:
> =20
> +    return true;
> +error:
>      if (hWinHvPlatform) {
>          FreeLibrary(hWinHvPlatform);
>      }
> +
>      if (hWinHvEmulation) {
>          FreeLibrary(hWinHvEmulation);
>      }
> +
>      return false;
>  }
> =20
>=20

Queued, thanks.

Paolo


