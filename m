Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D33C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 12:49:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 318AD20727
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 12:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OHrt5/cJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 318AD20727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBHr0-0006uH-DL
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 08:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33813)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jBHl4-00009d-A2
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 08:43:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jBHl2-0005mh-0p
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 08:43:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24806
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jBHl1-0005fE-3O
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 08:43:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583757821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gUPnh3b4Vmsns6SmCmuv6rjABRc4D3rtbZ3vM8IAHZ4=;
 b=OHrt5/cJMKawLoL71CnR/BE15uhzc3KTJtcGw3zJaC6lHff0zo6fC83S9MlNOuLCYVGs8c
 dZGdL+orPMK5vyNX+TrtLhLkkiKwECc8QJ/PPPrPn8GbmRgq/1oQEBf3S+IQXrsgJ5qOUm
 b+p6PJXcIAKA2ccBk56mU8xpV3cUJHE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-0dhXTRTBPia0v-OYew1OMg-1; Mon, 09 Mar 2020 08:43:39 -0400
X-MC-Unique: 0dhXTRTBPia0v-OYew1OMg-1
Received: by mail-ed1-f72.google.com with SMTP id y35so7894090ede.4
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 05:43:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HfIe3ut4m22quuHm0kzJtSMf+2mHRDjoamnFT3+Cs/8=;
 b=Am10CK8Z2RvDbvRuJ9K8fa1pfpW4LMwTdmfnLlI8PuJdSFzwClYnT7FOoZK7FZHa71
 7H0GlsEuaVD+AruvCHUsiZ8ffPqUC5AP8oWf6etMt564vMd3RyBSJCHuhtzgqaOGJI1n
 JPTgUqxQU5If3nMsYKcokyvSrB+y91BnNS0XgJvDKRi5IyipXiWD168RIrIUrGXxhLSr
 u4sqoAUdYdk4RJDdNCX0ei0mGw8w6sOIQMwDIMv6jC/76bSqCmUcgNCcYoyov1Y2hEYs
 Vj3H4WvnfRzLiOMl3tzd5w2msvXvCm+ge1MMwCFnj5S9a0AN14P3YMrK1ijTMi7Bl3vs
 ueeQ==
X-Gm-Message-State: ANhLgQ1LXFXW/HtMwBN8Qp428BivyjkXDK8xzrwW+bTpMQWb7EYAzC9G
 5bb1zIMxuY0U5P1fYDHSVOeuB/IRY5fbzJvu7rg4xxzZVefsqvjoQErN2wnQep5cjDR7dXDp57O
 6qSdC6EmLKdQ9btQ=
X-Received: by 2002:a17:906:2484:: with SMTP id
 e4mr14281586ejb.204.1583757818016; 
 Mon, 09 Mar 2020 05:43:38 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtALj28q1FCsd1BBGGonWYh8/K1VfmwmaLRwxgNhOHO8D/Kk3d+G1XkHaa2/vHzaK/s7KO4Tw==
X-Received: by 2002:a17:906:2484:: with SMTP id
 e4mr14281564ejb.204.1583757817736; 
 Mon, 09 Mar 2020 05:43:37 -0700 (PDT)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id l9sm904297edw.83.2020.03.09.05.43.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2020 05:43:37 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] configure: Fix building with SASL on Windows
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200309122454.22551-1-philmd@redhat.com>
 <20200309122454.22551-2-philmd@redhat.com>
 <20200309123014.GH3033513@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4b275fa8-45e9-a3bf-a915-70c1651ce84c@redhat.com>
Date: Mon, 9 Mar 2020 13:43:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200309123014.GH3033513@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Fam Zheng <fam@euphon.net>, Alexey Pavlov <alexpux@gmail.com>,
 =?UTF-8?B?0JDQu9C10LrRgdC10Lkg0J/QsNCy0LvQvtCy?= <alexey.pawlow@gmail.com>,
 qemu-devel@nongnu.org,
 =?UTF-8?B?0JzQtdGC0LvQuNGG0LrQuNC5INCu0YDQuNC5INCS0LjQutGC0L7RgNC+0LLQuNGH?=
 <winaes@narod.ru>, Biswapriyo Nath <nathbappai@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Youry Metlitsky <winaes@yandex.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/9/20 1:30 PM, Daniel P. Berrang=C3=A9 wrote:
> On Mon, Mar 09, 2020 at 01:24:53PM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
>> The Simple Authentication and Security Layer (SASL) library
>> re-defines the struct iovec on Win32 [*]. QEMU also re-defines
>> it in "qemu/osdep.h". The two definitions then clash on a MinGW
>> build.
>> We can avoid the SASL definition by defining STRUCT_IOVEC_DEFINED.
>> Since QEMU already defines 'struct iovec' if it is missing, add
>> the definition to vnc_sasl_cflags to avoid SASL re-defining it.
>>
>> [*] https://github.com/cyrusimap/cyrus-sasl/blob/cyrus-sasl-2.1.27/inclu=
de/sasl.h#L187
>>
>> Cc: Alexey Pavlov <alexpux@gmail.com>
>> Cc: Biswapriyo Nath <nathbappai@gmail.com>
>> Reported-by: Youry Metlitsky <winaes@yandex.ru>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>> v2:
>> Since QEMU provides 'struct iovec' if missing, always define
>> STRUCT_IOVEC_DEFINED (danpb review).
>> ---
>>   configure | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/configure b/configure
>> index cbf864bff1..a4cd4bccfb 100755
>> --- a/configure
>> +++ b/configure
>> @@ -3349,7 +3349,9 @@ if test "$vnc" =3D "yes" && test "$vnc_sasl" !=3D =
"no" ; then
>>   int main(void) { sasl_server_init(NULL, "qemu"); return 0; }
>>   EOF
>>     # Assuming Cyrus-SASL installed in /usr prefix
>> -  vnc_sasl_cflags=3D""
>> +  # QEMU defines struct iovec in "qemu/osdep.h",
>> +  # we don't want libsasl to redefine it in <sasl/sasl.h>.
>> +  vnc_sasl_cflags=3D"-DSTRUCT_IOVEC_DEFINED"
>>     vnc_sasl_libs=3D"-lsasl2"
>>     if compile_prog "$vnc_sasl_cflags" "$vnc_sasl_libs" ; then
>>       vnc_sasl=3Dyes
>=20
> This works so:
>=20
>    Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>=20
>=20
> however, I'm wondering if we'd be better doing this in a more
> localized place. This applies to everything we compile, but
> only one place imports sasl.h, so should we instead do
>=20
>     #define STRUCT_IOVEC_DEFINED
>     #include <sasl/saslh.>
>=20
> in vnc-auth-sasl.h, so we localize the namespace pollution.

Good idea, but we'll need to remember this fix if we ever use=20
<sasl/sasl.h> in another header.

>=20
> Regards,
> Daniel
>=20


