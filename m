Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 949A8C282DD
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 16:42:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FE3A206ED
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 16:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CQrDjCAf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FE3A206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipxMs-00011v-DT
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 11:42:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56214)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ipxM5-0008Bs-O8
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 11:41:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ipxM4-0004hV-5t
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 11:41:49 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31546
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ipxM4-0004ew-1H
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 11:41:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578674506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mwiJCA6cLNGKpM99GToD6rYOqdMw/Rep8ekN0v2CaXU=;
 b=CQrDjCAftt0yK7jSUalN3L+Q4G1WbV7V4ApmnZoKyhMYcrYxHYsFSeRskQBUg5FhnzVIvM
 huxModWGhAVDKQH4Q0Pk3Np2tHDo9qxwK2VOp2aJoKzcpV1ZPEmeHSFWX9ziYPBzUtTUt/
 os7KI9pUzaemnOIljcQcfXb4ibkm2pY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-E_9OWY0tM461hNj84Lz43g-1; Fri, 10 Jan 2020 11:41:43 -0500
Received: by mail-wm1-f71.google.com with SMTP id s25so652098wmj.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 08:41:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hDdFgC2o/R0ejXosRy0Un3P2MWktgvM3eXYwLfq6+7k=;
 b=YMW9n05cmVWOHCbkHI89571LcEWERCO1dGWEcgJTp+7Aq5d2E3eGjeOj2EAtPq8yxF
 BJ5VwemWBiPHPTIGeP5kB9YsHPkKuq6p70Tw/TsQwOaPkReFaw7TnJh1cuQs2UoV1Zmq
 gVg3/g7xVFFTO8FP6S5pGDqaJ6vaSrUyreOdk98Z1bg5O+XnD92P3U7PJ20zBi8xsNLq
 akRysbgb+Klv4LbnS3lIQ7/JB9qnm4QedqMk4pOszo5LkzsZ9oM3JoiyDWBi8X4Py5RR
 8dmC2LA7FJdHhVQ3TXnQGcPX/V7XT0X31/n7j77n5Ox//qS6MdMGRMIhCPlLTPh9Ft25
 XXCQ==
X-Gm-Message-State: APjAAAUMjCFhsLITI5QMeuiWIOUMpUpKOE1QRQ+tESqkDtlxYcdDGOQ7
 f80QHMLLBWAmX7fimCanRNQadIkCsLrIzBTxR65bIKBiJO+Z6AMm5XmHqu0zgplsq7sNaQcg4/d
 lR0Gu7LfKpxBIKD4=
X-Received: by 2002:a05:600c:224d:: with SMTP id
 a13mr5369989wmm.70.1578674502472; 
 Fri, 10 Jan 2020 08:41:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqy0MftR3yeLBw6gEyxj0DSXzOuKH6b8ddVzTogv6yUj9eUDNELxEHuDVCsOyshMwA3CMrzjgQ==
X-Received: by 2002:a05:600c:224d:: with SMTP id
 a13mr5369962wmm.70.1578674502288; 
 Fri, 10 Jan 2020 08:41:42 -0800 (PST)
Received: from [192.168.1.24] (lfbn-mon-1-1519-115.w92-167.abo.wanadoo.fr.
 [92.167.83.115])
 by smtp.gmail.com with ESMTPSA id g18sm2686080wmh.48.2020.01.10.08.41.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jan 2020 08:41:41 -0800 (PST)
Subject: Re: [PATCH 0/4] buildsys: Build quicker (mostly tools and linux-user)
To: Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20200109153939.27173-1-philmd@redhat.com>
 <d94666ae-df03-0162-e3d0-e0038b68da83@vivier.eu>
 <CAAdtpL69XLuoZNEank0dC9M-tWCKhJqFKO46u5jjeLpf4TF=Pg@mail.gmail.com>
 <d7e57fe9-9c0f-10bf-dfd2-c1832d34cada@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8279ff6e-b598-50a0-97ec-2bb7966e0a14@redhat.com>
Date: Fri, 10 Jan 2020 17:41:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <d7e57fe9-9c0f-10bf-dfd2-c1832d34cada@vivier.eu>
Content-Language: en-US
X-MC-Unique: E_9OWY0tM461hNj84Lz43g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/10/20 3:03 PM, Laurent Vivier wrote:
> Le 10/01/2020 =C3=A0 10:17, Philippe Mathieu-Daud=C3=A9 a =C3=A9crit=C2=
=A0:
>> Le ven. 10 janv. 2020 09:36, Laurent Vivier <laurent@vivier.eu
>> <mailto:laurent@vivier.eu>> a =C3=A9crit=C2=A0:
>>
>>      Le 09/01/2020 =C3=A0 16:39, Philippe Mathieu-Daud=C3=A9 a =C3=A9cri=
t=C2=A0:
>>      > In some configuration (linux-user, tools) we can ignore building
>>      > various objects (and the libfdt).
>>      >
>>      > Philippe Mathieu-Daud=C3=A9 (4):
>>      >=C2=A0 =C2=A0configure: Do not build libfdt is not required
>>      >=C2=A0 =C2=A0Makefile: Clarify all the codebase requires qom/ obje=
cts
>>      >=C2=A0 =C2=A0Makefile: Restrict system emulation and tools objects
>>      >=C2=A0 =C2=A0Makefile: Remove unhelpful comment
>>      >
>>      >=C2=A0 configure=C2=A0 =C2=A0 =C2=A0|=C2=A0 2 ++
>>      >=C2=A0 Makefile.objs | 31 ++++++++++---------------------
>>      >=C2=A0 2 files changed, 12 insertions(+), 21 deletions(-)
>>      >
>>
>>      Did you test this with all the combinations of --[enable|disable]-t=
ools,
>>      --[enable|disable]-user and --[enable|disable]-system
>>
>>
>> I tested 12 of 27 because I thought some sets might overlap but I might
>> have missed something, what combination is giving you problem?
>>
>=20
> I didn't test your series, but I did this kind of change in the past and
> sometime enabling tools without enabling softmmu can show missing
> objects at build time, or you can also see if tools are built with
> softmmu while tools are disabled.
>=20
> I used to test with something like
>=20
> for user in enable disable; do
>      for tools in enable disable; do
>          for system in enable disable; do
>              rm -fr build
>              mkdir build && \
>              (cd build && \
>               ../configure --$user-user \
>                            --$system-system \
>                            --$tools-tools && \
>               make || exit)
>          done
>      done
> done

I tested all these 8 combinations, no problem.


