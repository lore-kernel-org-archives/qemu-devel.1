Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7078DC43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 11:11:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AB5B206F1
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 11:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cJqE/9O3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AB5B206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHmtu-0008Ml-Bx
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 07:11:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35463)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jHmtI-0007x7-K8
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 07:11:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jHmtG-0002xl-FO
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 07:11:07 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:27748)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jHmtG-0002vA-0x
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 07:11:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585307464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wiSWL+mVegwvCumQirN2lXQa6vItERuUbefwxn1s1rA=;
 b=cJqE/9O3XMMS0ObXjmxEeMYakzaj76oKk/jUD8InWTvFtv3jpKERvv/Tn0QQQSFlQEDnA3
 5d5C3+dU6pZRwq7R8spSBYcoDotGJQvRZhWMktwS7XVYRjUeCKIja2Gh0042o83wLKY+jv
 scy4GKI8sPs51Z4L1Qm24Yrh+LZiFDw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-ZqdklmAxOVir4uNQCa3epA-1; Fri, 27 Mar 2020 07:11:00 -0400
X-MC-Unique: ZqdklmAxOVir4uNQCa3epA-1
Received: by mail-ed1-f70.google.com with SMTP id a14so7889057edx.22
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 04:11:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=j2aG0nV/BbLeWMuQlvNHo0WKlAEUF5qxvvavoxykUF8=;
 b=osQnEA4EW3ESYxZfuVL5YbPdnbCeOMizKQFlQ8NU0Rl+lMpYsVrAfW73cXWUWNUPEM
 u/jxU0R6K2Yr2Kg6/lupquqAa00HEAyXd03T55L+ZM+vvS68zxkc7QxyXQLDiC3rAB9s
 v3MahEYXSvd3UU3AO4EyFwaWD92tn4PYB8ggYlLOuaamG6OeT0CxUIiVVuYHsw2yKyAk
 TPhryP8C/XGhWckEBIgUaj3VIbhrP26+aGpdZi5Y77WhvTqXNmbaG+417fFgpI1Htrqk
 YqRuL1qAWgnokoZnBmMTbDQ/8QG/NXj6MPJJdXaf9h+e1rB8gStrzNjZIPcyP0bgP5Pg
 MSpg==
X-Gm-Message-State: ANhLgQ0/rEsn8yE4pn/RJQR2PKc5tofGkIRjZ/TF+otys0ENb4qyOLvP
 AgL9WsV1NRb6xF6Gz+WuZYOxakNtjQwiHKGIye1Y0qYr6iP3RV6rkoNu4/3Sxymt7FDK97HWKeP
 UIvXtPrFt2mLd5LU=
X-Received: by 2002:a05:6402:17aa:: with SMTP id
 j10mr12234394edy.146.1585307458731; 
 Fri, 27 Mar 2020 04:10:58 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtqxzI0yxDDzgGooYZZ1/tVgnm851FbgyAenKjl21MyKu8BlwZFaE4X6BXFw/RcKnTc5FSnwQ==
X-Received: by 2002:a05:6402:17aa:: with SMTP id
 j10mr12234377edy.146.1585307458508; 
 Fri, 27 Mar 2020 04:10:58 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id t3sm685107eji.7.2020.03.27.04.10.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2020 04:10:57 -0700 (PDT)
Subject: Re: [PATCH v1 1/7] elf-ops: bail out if we have no function symbols
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200327094945.23768-1-alex.bennee@linaro.org>
 <20200327094945.23768-2-alex.bennee@linaro.org>
 <0aa311c7-ae89-6dc2-d1ef-514a75bd0c6e@redhat.com>
Message-ID: <e988e64d-3056-feec-099e-9bad9b40626d@redhat.com>
Date: Fri, 27 Mar 2020 12:10:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <0aa311c7-ae89-6dc2-d1ef-514a75bd0c6e@redhat.com>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/27/20 11:53 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 3/27/20 10:49 AM, Alex Benn=C3=A9e wrote:
>> It's perfectly possible to have no function symbols in your elf file
>> and if we do the undefined behaviour sanitizer rightly complains about
>> us passing NULL to qsort. Check nsyms before we go ahead.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>> =C2=A0 include/hw/elf_ops.h | 7 ++++++-
>> =C2=A0 1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
>> index a1411bfcab6..b5d4074d1e3 100644
>> --- a/include/hw/elf_ops.h
>> +++ b/include/hw/elf_ops.h
>> @@ -170,8 +170,13 @@ static int glue(load_symbols, SZ)(struct elfhdr=20
>> *ehdr, int fd, int must_swab,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i++;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0 syms =3D g_realloc(syms, nsyms * sizeof(*syms));

Something was bugging me why looking at this line, now I remembered:=20
another patch from 2 years ago :)

https://www.mail-archive.com/qemu-devel@nongnu.org/msg528713.html

Is this the same emitted warning? It seems.

   $ qemu-system-xtensa -M kc705 -m 128M -semihosting -nographic=20
-monitor null -kernel Image.elf
   include/hw/elf_ops.h:179:5: runtime error: null pointer passed as=20
argument 1, which is declared to never be null

If so, can you add it to the commit description?

Thanks!

>> +=C2=A0=C2=A0=C2=A0 /* check we have symbols left */
>> +=C2=A0=C2=A0=C2=A0 if (nsyms =3D=3D 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto fail;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 syms =3D g_realloc(syms, nsyms * sizeof(*syms));
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qsort(syms, nsyms, sizeof(*syms), glue(sy=
mcmp, SZ));
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < nsyms - 1; i++) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (syms[i].st_si=
ze =3D=3D 0) {
>>
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


