Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292CEC10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 10:48:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDB7520674
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 10:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d9EfpdE+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDB7520674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBFxs-00021y-Tl
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 06:48:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41822)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jBFx7-0001ZV-U5
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 06:48:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jBFx6-0002Hk-8a
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 06:48:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48115
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jBFx6-0002GW-3U
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 06:48:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583750882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dfs4bLnKPMrPBBqiD6X3fhzWdGMzniu5ksEqWfyfwxE=;
 b=d9EfpdE+xKW7fNxPx8r/K5CyQ8BYpnYfCiS1DaDeY0NxNuiTUI0lvwBdd2TfGORAWU/StY
 7zLSeoMn7YNCgN/O5+qVLOn9UmZj4aJQtpXSzNHNlBJP2QZgYLmrspHRN05vc5k+MjSuJe
 +oRevFAEvckv5qwzQ31aJSGmChXdrfw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-FdjttE_BNEe_r0V4JbhTmw-1; Mon, 09 Mar 2020 06:48:00 -0400
X-MC-Unique: FdjttE_BNEe_r0V4JbhTmw-1
Received: by mail-ed1-f72.google.com with SMTP id d12so7651034edq.16
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 03:48:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uYE/LvIUZEfuEBFQDNfL+so93YAJ2CHeIvmuUDrIQvU=;
 b=tcxLRJBqgx//myhOLn0NxqsrAxBiudfoWD8xaakiTsP2JBm+8xKQ0FvP10251MTNjI
 QnxFx8BiOU4gu7q8YfzkPYZl6jeYwD8luKvn9mY/h/nGoMhsMMpb1hi50xkJiniTopoQ
 wpXXQ5Zwu4C/4R0mb45A4u3QNYXk+S/6QubtKOnaBC/D6LA3JoauaHKz6mwgdt8sc3a6
 1BAsqQVNLDqVqAtqYdeAfgzmNbMpfFjpGQnueZBBUnopovVpRCubbgCRTriwSdSX6qMG
 GWJaHNu6w5TQE9Wuf1+uwk/eO9DrSWY2xnGcr/qMArWyl6f0stqsySsd7krewKTBZYtS
 kZTQ==
X-Gm-Message-State: ANhLgQ1XGmQZC84rjTaoBURnS7evi6Ht1dzRpeQqXWd4f4LVtQYSeqWI
 6UezZp/MZl2xf+BFW6+A3E3b1EEgt83dXccTTeBGULWlEPATJMVgjbGZcWkNXxIVe34eBFrWuuF
 WLmnNio6BARQcTss=
X-Received: by 2002:a17:906:a2d3:: with SMTP id
 by19mr14356235ejb.7.1583750879374; 
 Mon, 09 Mar 2020 03:47:59 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtwjGXNDhYJe37uk2bmzYFjiamwyxyFIToF3e//G0oAcJqsDqVe1d0oT/hdV58fsYR0EdPZYg==
X-Received: by 2002:a17:906:a2d3:: with SMTP id
 by19mr14356213ejb.7.1583750879134; 
 Mon, 09 Mar 2020 03:47:59 -0700 (PDT)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id e4sm905119edy.30.2020.03.09.03.47.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2020 03:47:58 -0700 (PDT)
Subject: Re: [PATCH 2/3] configure: Fix building with SASL on Windows
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200307172222.14764-1-philmd@redhat.com>
 <20200307172222.14764-3-philmd@redhat.com>
 <20200309095746.GB3033513@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3efe572c-5c68-a552-9327-e0cf18007a90@redhat.com>
Date: Mon, 9 Mar 2020 11:47:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200309095746.GB3033513@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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

On 3/9/20 10:57 AM, Daniel P. Berrang=C3=A9 wrote:
> On Sat, Mar 07, 2020 at 06:22:21PM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
>> The Simple Authentication and Security Layer (SASL) library
>> re-defines the struct iovec on Win32 [*]. QEMU also re-defines
>> it in "qemu/osdep.h". The two definitions then clash on a MinGW
>> build.
>> We can avoid the SASL definition by defining STRUCT_IOVEC_DEFINED.
>> Add the definition to vnc_sasl_cflags if we are uing MinGW.
>>
>> [*] https://github.com/cyrusimap/cyrus-sasl/blob/cyrus-sasl-2.1.27/inclu=
de/sasl.h#L187
>>
>> Cc: Alexey Pavlov <alexpux@gmail.com>
>> Cc: Biswapriyo Nath <nathbappai@gmail.com>
>> Cc: Youry Metlitsky <winaes@yandex.ru>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>   configure | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/configure b/configure
>> index 0c2dd1eb08..0bc87ce42a 100755
>> --- a/configure
>> +++ b/configure
>> @@ -3375,7 +3375,13 @@ if test "$vnc" =3D "yes" && test "$vnc_sasl" !=3D=
 "no" ; then
>>   int main(void) { sasl_server_init(NULL, "qemu"); return 0; }
>>   EOF
>>     # Assuming Cyrus-SASL installed in /usr prefix
>> -  vnc_sasl_cflags=3D""
>> +  if test "$mingw32" =3D "yes" && test "$iovec" !=3D "yes"; then
>=20
> I don't get why we need the "iovec !=3D yes" check there ?
>=20
> On mingw sys/uio.h doesn't exist, so "$iovec" will always
> be "no", and so this conditional is equivalent to
>=20
>     if test "$mingw32" =3D "yes; then

Indeed.

>=20
> If for some strange reason, a future Windows adds sys/uio.h
> header containing struct iovec, then QEMU won't define its
> own local copy if struct iovec, and so "$iovec" will be "yes".
>=20
> In this situation we don't want SASL to define its struct iovec
> either.
>=20
> IOW we need -DSTRUCT_IOVEC_DEFINED no matter what $iovec value
> is AFAICT.

Way simpler!

>=20
> This would mean the previous patch is redundant too.

Yes, thanks for reviewing :)

>=20
>> +    # QEMU defines struct iovec in "qemu/osdep.h",
>> +    # we don't want libsasl to redefine it in <sasl/sasl.h>.
>> +    vnc_sasl_cflags=3D"-DSTRUCT_IOVEC_DEFINED"
>> +  else
>> +    vnc_sasl_cflags=3D""
>> +  fi
>>     vnc_sasl_libs=3D"-lsasl2"
>>     if compile_prog "$vnc_sasl_cflags" "$vnc_sasl_libs" ; then
>>       vnc_sasl=3Dyes
>=20
> Regards,
> Daniel
>=20


