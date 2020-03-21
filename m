Return-Path: <SRS0=wc0w=5G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8868C4332B
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 11:06:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6823B20732
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 11:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DnSt92nF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6823B20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFbxW-0005dL-Ho
	for qemu-devel@archiver.kernel.org; Sat, 21 Mar 2020 07:06:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57394)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jFbwu-0005Ck-5V
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 07:05:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jFbws-0004e2-7n
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 07:05:51 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:36083)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jFbws-0004cx-2V
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 07:05:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584788749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wpFs7PxFsTSLwk+CSE8Qu8tEzu7aOPzY7KVP7Q5kQf4=;
 b=DnSt92nFDzNpSA5Z26K1xGsc/J1uvoxyClP0gHyi5xGy5Ara+TABLvDARO+Rn/t3t8qlpD
 i0GxjrM9noGzrDZRbmd9uO+KzxeBrtFqWbKdQGyh9Kekmu32L6caQ0qST+ESvPP3qB4Oky
 YONki1lWbo6oJORjnSAFy2xoGeLyCYY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-CJc8rph5NEW3FHOO29F-nA-1; Sat, 21 Mar 2020 07:05:41 -0400
X-MC-Unique: CJc8rph5NEW3FHOO29F-nA-1
Received: by mail-ed1-f72.google.com with SMTP id a32so7333006edf.17
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2020 04:05:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7J1ZWVl3+HE/uqcOn+5IQNiieZl0YKqO0tzbaLyko3Y=;
 b=HR8uzCOwi+iAVuQKhiOLxbfN85uLjC8qNVpKjKA4O+oYFw87ZUVvibcSAbFnGOJmFa
 GHdpMyQgMV4f8XzNhHT1tgGoFe5SIae8fbmJ8eG3tmXu/5mMOuat4Po0UDemmjU1DQFG
 XlaSs+fDDZcOaUiEIN3uXU1L+BI4L3nui76lKq4kW8pE9EmWUPfkSmAtgP5MQSEFoZ1o
 3xSB4A2Q2xkgRtriOUVu980CjZGJ5vQ4ik1TrH17bYusbiChiTO6rlxw/oeogCp7NwUK
 i8Qe80uo4QBahmxMGqmkMKxfcpGqNxRk0B9Lvlu0BtoGuvqPzjR/QrAhW/nbApQGnaQV
 muNA==
X-Gm-Message-State: ANhLgQ0dNydPdogi1TOMimGHjOPvu5deWOtX1gxqbIfZ/ub4e6HDChLn
 SOEKzAB/rIlsHh+3tYUuZ/N6+jGlnmcsIVA0DSrIYJNZSrD+Y8HcACLiMDUN1Wb31G1n/TnSImM
 FoUauvg0FMItIx3Y=
X-Received: by 2002:a17:906:e097:: with SMTP id
 gh23mr8042059ejb.209.1584788740158; 
 Sat, 21 Mar 2020 04:05:40 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuXNaCracbqcE+04bXwP2GTJNcPg7RIK3NMX766VS/KBVBAmPIlxjrXUJP0jPfV6dNjUNEGcA==
X-Received: by 2002:a17:906:e097:: with SMTP id
 gh23mr8042031ejb.209.1584788739799; 
 Sat, 21 Mar 2020 04:05:39 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id f17sm280155edj.86.2020.03.21.04.05.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Mar 2020 04:05:38 -0700 (PDT)
Subject: Re: [PULL v2 05/13] target/rx: CPU definitions
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200320103551.29246-1-f4bug@amsat.org>
 <20200320103551.29246-2-f4bug@amsat.org>
 <c7cf4bab-b9ac-4387-0709-a02c04b24061@redhat.com>
 <e4bc22f6-128d-99e9-9359-3253f666c065@linaro.org>
 <CAFEAcA8RM6U1hKX1Wn5YmR71y=VrGimt46z_OR=+O1i9neahiw@mail.gmail.com>
 <70930618-a369-cb26-1b9b-aa7864deefc9@redhat.com>
 <CAFEAcA_xRmiTfNfYHW7DLM9pCSvssNRXZWkqoQSggFLgEUPMRw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c37c2932-a409-238f-9906-422c98583833@redhat.com>
Date: Sat, 21 Mar 2020 12:05:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_xRmiTfNfYHW7DLM9pCSvssNRXZWkqoQSggFLgEUPMRw@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/20/20 5:37 PM, Peter Maydell wrote:
> On Fri, 20 Mar 2020 at 16:32, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com> wrote:
>> -fwrapv is here indeed.
>>
>> I use
>> --extra-cflags=3D-fsanitize=3Daddress,alignment,array-bounds,bool,builti=
n,enum,float-cast-overflow,float-divide-by-zero,function,integer-divide-by-=
zero,nonnull-attribute,null,pointer-overflow,return,returns-nonnull-attribu=
te,shift-base,shift-exponent,signed-integer-overflow,unreachable,vla-bound,=
vptr
>=20
> There was a bug in older clang versions where the shift-base
> sanitizer didn't honour -fwrapv:
> https://bugs.llvm.org/show_bug.cgi?id=3D25552
>=20
> https://wiki.qemu.org/Testing#clang_UBSan
> says you can work around the clang bug with -fno-sanitize=3Dshift-base.
>=20
> The bug was fixed upstream back in 2016, though, so the
> fix ought to be in clang 4, I think. Are you using an
> old clang version, or has it regressed in newer clang?

I am sorry I am very confused here.

$ clang -v
clang version 8.0.0 (Fedora 8.0.0-3.fc30)

I use scan-build which set CC=3Dccc-analyzer.

$ ccc-analyzer -v
gcc version 9.2.1 20190827 (Red Hat 9.2.1-1) (GCC)

I use the output of 'make V=3D1' and run directly ccc-analyzer, I get:

gcc: error: unrecognized argument to =E2=80=98-fsanitize=3D=E2=80=99 option=
: =E2=80=98array-bounds=E2=80=99
gcc: error: unrecognized argument to =E2=80=98-fsanitize=3D=E2=80=99 option=
: =E2=80=98function=E2=80=99

So Clang is used.

I notice ccc-analyzer appends -Wno-shift-negative-value, however if I=20
run the 'make V=3D1' output using clang instead (with all the -fsanitize=20
options, -fwrapv, -Wno-shift-negative-value) then no warning are emitted.

So I think this is simply a problem with scan-build/ccc-analyzer, or I=20
should tune it more for QEMU.


