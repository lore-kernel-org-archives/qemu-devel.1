Return-Path: <SRS0=wc0w=5G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6F3C4332B
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 11:18:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E409C20732
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 11:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TMgs94F1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E409C20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFc8v-0000Gh-2K
	for qemu-devel@archiver.kernel.org; Sat, 21 Mar 2020 07:18:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58895)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jFc7r-0007rR-77
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 07:17:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jFc7p-0002Ru-HF
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 07:17:10 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:21805)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jFc7p-0002Rg-Df
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 07:17:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584789428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HGtICMXezxTHqlM0HRPNQihNpWWid+Rk59bmd9pe7oA=;
 b=TMgs94F1OnY/m/CABU+Oo9G8p9j0xEzlliN1rSm7eQLsR9SBu1/ovgTqo5BDNzT/zXkKo7
 6w8r1rg4rWPy+GoCJZFdUGa9SKMb+9WwsliTrxmv/DIoWAfwG9cGXQ5Hw4U7ymEpu98I89
 fc777oTsS9BjjwzgtubRjeSxTO/14IU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-k7vuTGIYMkekB8n1HW-0Kg-1; Sat, 21 Mar 2020 07:17:06 -0400
X-MC-Unique: k7vuTGIYMkekB8n1HW-0Kg-1
Received: by mail-ed1-f71.google.com with SMTP id dn10so7376354edb.6
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2020 04:17:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=enn6Sv6e1toWyIrizEsSPkNMpKmSwk41VGW1LIXXRyI=;
 b=NwmxjZ57LW6rKqFjWYKYVfJ05JFinkoZ5YPYP37Kw5arOxh973AGQ83EtALLrDL0pI
 ChP1IJtpWr0Blm3kLxELXnBfCsO+GQelzQ7zMkqbXEJ5nh3eLmW4FLdHjLdB6mY/qU+3
 G83Sbb/J7WnDWxV9k/aozEkICJPAC/i8lLO/KdOfRPe//x4nwLGAZThcH0wP1FOZ7ulS
 RnxljQzWVCyv4s2ASpK7njnYtMiMRWb5tSqB2HfOHbDFrMEWW+7kB1iNOsrgl+CoxZC5
 5ailkGClon2llcXenDgXdCgoXgFllAWznG7Fw4mJhwMipptLmbH/vV4n2VvbSRzcOHHb
 8dug==
X-Gm-Message-State: ANhLgQ3M070AJxBTdOglUluBgRD77vo0nzihS6rOYF56I+r4a9heSB4X
 qQX/gGFmt582ztJFOvpUHGIXCw4lgbC0qaOJBG3Wtg2NW5rQDZ8bT268wtev/G6oLLDRBrPWopq
 zBkA3KuT/cz3mkm4=
X-Received: by 2002:a50:c8c2:: with SMTP id k2mr12370894edh.149.1584789425289; 
 Sat, 21 Mar 2020 04:17:05 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvs44fht4WQ94NqDH3wu3VC84yuO7Z6CPvOrvWwlbb76jS2BOjztIqJJye4gIGYGFt5645DrA==
X-Received: by 2002:a50:c8c2:: with SMTP id k2mr12370870edh.149.1584789424993; 
 Sat, 21 Mar 2020 04:17:04 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id x6sm546255edl.61.2020.03.21.04.17.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Mar 2020 04:17:04 -0700 (PDT)
Subject: Re: [PULL v2 05/13] target/rx: CPU definitions
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200320103551.29246-1-f4bug@amsat.org>
 <20200320103551.29246-2-f4bug@amsat.org>
 <c7cf4bab-b9ac-4387-0709-a02c04b24061@redhat.com>
 <e4bc22f6-128d-99e9-9359-3253f666c065@linaro.org>
 <CAFEAcA8RM6U1hKX1Wn5YmR71y=VrGimt46z_OR=+O1i9neahiw@mail.gmail.com>
 <70930618-a369-cb26-1b9b-aa7864deefc9@redhat.com>
 <CAFEAcA_xRmiTfNfYHW7DLM9pCSvssNRXZWkqoQSggFLgEUPMRw@mail.gmail.com>
 <c37c2932-a409-238f-9906-422c98583833@redhat.com>
Message-ID: <21262a89-5735-d8ab-673b-b6d223d3b5bb@redhat.com>
Date: Sat, 21 Mar 2020 12:17:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <c37c2932-a409-238f-9906-422c98583833@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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

On 3/21/20 12:05 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 3/20/20 5:37 PM, Peter Maydell wrote:
>> On Fri, 20 Mar 2020 at 16:32, Philippe Mathieu-Daud=C3=A9=20
>> <philmd@redhat.com> wrote:
>>> -fwrapv is here indeed.
>>>
>>> I use
>>> --extra-cflags=3D-fsanitize=3Daddress,alignment,array-bounds,bool,built=
in,enum,float-cast-overflow,float-divide-by-zero,function,integer-divide-by=
-zero,nonnull-attribute,null,pointer-overflow,return,returns-nonnull-attrib=
ute,shift-base,shift-exponent,signed-integer-overflow,unreachable,vla-bound=
,vptr=20
>>>
>>
>> There was a bug in older clang versions where the shift-base
>> sanitizer didn't honour -fwrapv:
>> https://bugs.llvm.org/show_bug.cgi?id=3D25552
>>
>> https://wiki.qemu.org/Testing#clang_UBSan
>> says you can work around the clang bug with -fno-sanitize=3Dshift-base.
>>
>> The bug was fixed upstream back in 2016, though, so the
>> fix ought to be in clang 4, I think. Are you using an
>> old clang version, or has it regressed in newer clang?
>=20
> I am sorry I am very confused here.
>=20
> $ clang -v
> clang version 8.0.0 (Fedora 8.0.0-3.fc30)
>=20
> I use scan-build which set CC=3Dccc-analyzer.
>=20
> $ ccc-analyzer -v
> gcc version 9.2.1 20190827 (Red Hat 9.2.1-1) (GCC)
>=20
> I use the output of 'make V=3D1' and run directly ccc-analyzer, I get:
>=20
> gcc: error: unrecognized argument to =E2=80=98-fsanitize=3D=E2=80=99 opti=
on: =E2=80=98array-bounds=E2=80=99
> gcc: error: unrecognized argument to =E2=80=98-fsanitize=3D=E2=80=99 opti=
on: =E2=80=98function=E2=80=99
>=20
> So Clang is used.
>=20
> I notice ccc-analyzer appends -Wno-shift-negative-value, however if I=20
> run the 'make V=3D1' output using clang instead (with all the -fsanitize=
=20
> options, -fwrapv, -Wno-shift-negative-value) then no warning are emitted.
>=20
> So I think this is simply a problem with scan-build/ccc-analyzer, or I=20
> should tune it more for QEMU.

Eh I simply needed to RTFM more attentively:

  --keep-cc

    Do not override CC and CXX make variables. Useful when
    running make in autoconf-based (and similar) projects
    where configure can add extra flags to those variables.


