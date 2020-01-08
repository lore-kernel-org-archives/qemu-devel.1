Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC143C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 15:01:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4F2520678
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 15:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JPSSjGD8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4F2520678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipCqC-0003JG-ND
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 10:01:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40672)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ipClI-0005Y1-Dg
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 09:56:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ipClH-0005mP-6c
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 09:56:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37596
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ipClH-0005lr-2l
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 09:56:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578495402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=859kSLPRB+/IV0xc+rXfbz5TiWbLpt3EloVTTkQXDqY=;
 b=JPSSjGD8ymTH+koCZO/q19s2jBU71B6iPjgeZy3OSb2DxxLmtDTu6d38Me0f387NMPQXNG
 3xB9k41pP1aI48jn57yRA8u2htRg9pEqD7So459DGxekBkDq4nKpzc/MvVr5f0EeOKSc1Q
 9p5mG927OQs5hfUxTugrFtvmvje6LnI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-9Jwnlb54NFm6cxrSkf3Rlw-1; Wed, 08 Jan 2020 09:56:41 -0500
Received: by mail-wm1-f69.google.com with SMTP id 7so458320wmf.9
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 06:56:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RkQjN3gzDIXfxEOGnUb0qM3kbk6+rYCuTePE4gd3FFY=;
 b=DUDnWP0HJRUqqcDX1y0PDS2n1t7csJBxoBN4bU4+DmbHOXfbIX/uwn27nV0lpxZXcV
 qTaPyFUoUmvsoaxip+JKNCfj92qnxjDHC4AjzGvMEC2dshyr3N6y9Be4kdi5FSi0cFgH
 /DeWbf3PUG+53IELHCDgVFXovHamo4F53KGEYtNDY6R+Snglynoqd8tydT5Xkr//VU1h
 KGZCN7PX7zs+urZSdPrSEvKsJhCSjfAOezBWebjeuPBv0UG4SWUAxwrDdQeKW+pgoN/x
 daF664D78DWJ3YisHcn6d62GR9SEdwNg/8W6RfswCQ4RDdi5CN/1DQCqpRLJVib38v3O
 Erlw==
X-Gm-Message-State: APjAAAVCOl4oBKRFh1uhpN6P2g5yhDiZdETqGgu0oLW9XhASCcnd61ZA
 28eSWE96IQTw+oioLuVN9NM/uuTgS8sbk1U0jyQPC28nuil7groB7+PzuDgw2162hqxtr4UlO9n
 gIB6lE05dfO3nvLA=
X-Received: by 2002:adf:dfc1:: with SMTP id q1mr4961170wrn.155.1578495400073; 
 Wed, 08 Jan 2020 06:56:40 -0800 (PST)
X-Google-Smtp-Source: APXvYqwSyrCabfJf9cA1lrS9axV4KMA1eTGY5MldtkmXFJz0ML63cw8NCqPoySUGpRn9D1rXtneXQg==
X-Received: by 2002:adf:dfc1:: with SMTP id q1mr4961140wrn.155.1578495399809; 
 Wed, 08 Jan 2020 06:56:39 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id t5sm4495616wrr.35.2020.01.08.06.56.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2020 06:56:39 -0800 (PST)
Subject: Re: [PATCH] vl: fix memory leak in configure_accelerators
To: kuhn.chenqun@huawei.com, qemu-devel@nongnu.org, pbonzini@redhat.com
References: <20200108114207.58084-1-kuhn.chenqun@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2bf0ae4f-b024-c421-b9d2-eefe99453e04@redhat.com>
Date: Wed, 8 Jan 2020 15:56:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200108114207.58084-1-kuhn.chenqun@huawei.com>
Content-Language: en-US
X-MC-Unique: 9Jwnlb54NFm6cxrSkf3Rlw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: liyiting@huawei.com, pannengyuan@huawei.com, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/8/20 12:42 PM, kuhn.chenqun@huawei.com wrote:
> From: Chen Qun <kuhn.chenqun@huawei.com>
>=20
> The accel_list forgot to free, the asan output:
>=20
> Direct leak of 16 byte(s) in 1 object(s) allocated from:
>      #0 0xffff919331cb in __interceptor_malloc (/lib64/libasan.so.4+0xd31=
cb)
>      #1 0xffff913f7163 in g_malloc (/lib64/libglib-2.0.so.0+0x57163)
>      #2 0xffff91413d9b in g_strsplit (/lib64/libglib-2.0.so.0+0x73d9b)
>      #3 0xaaab42fb58e7 in configure_accelerators /qemu/vl.c:2777
>      #4 0xaaab42fb58e7 in main /qemu/vl.c:4121
>      #5 0xffff8f9b0b9f in __libc_start_main (/lib64/libc.so.6+0x20b9f)
>      #6 0xaaab42fc1dab  (/qemu/build/aarch64-softmmu/qemu-system-aarch64+=
0x8b1dab)
>=20
> Indirect leak of 4 byte(s) in 1 object(s) allocated from:
>      #0 0xffff919331cb in __interceptor_malloc (/lib64/libasan.so.4+0xd31=
cb)
>      #1 0xffff913f7163 in g_malloc (/lib64/libglib-2.0.so.0+0x57163)
>      #2 0xffff9141243b in g_strdup (/lib64/libglib-2.0.so.0+0x7243b)
>      #3 0xffff91413e6f in g_strsplit (/lib64/libglib-2.0.so.0+0x73e6f)
>      #4 0xaaab42fb58e7 in configure_accelerators /qemu/vl.c:2777
>      #5 0xaaab42fb58e7 in main /qemu/vl.c:4121
>      #6 0xffff8f9b0b9f in __libc_start_main (/lib64/libc.so.6+0x20b9f)
>      #7 0xaaab42fc1dab  (/qemu/build/aarch64-softmmu/qemu-system-aarch64+=
0x8b1dab)
>=20
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   vl.c | 1 +
>   1 file changed, 1 insertion(+)
>=20
> diff --git a/vl.c b/vl.c
> index 86474a55c9..035a24e52b 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2788,6 +2788,7 @@ static void configure_accelerators(const char *prog=
name)
>                   error_report("invalid accelerator %s", *tmp);
>               }
>           }
> +        g_strfreev(accel_list);
>       } else {
>           if (accel !=3D NULL) {
>               error_report("The -accel and \"-machine accel=3D\" options =
are incompatible");
>=20


