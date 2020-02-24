Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB27C35671
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 12:44:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 760462072D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 12:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TWa3AvhQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 760462072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6D6L-0002Cd-OB
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 07:44:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34624)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j6D5a-0001nI-WA
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 07:43:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j6D5a-000516-0e
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 07:43:58 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38151
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j6D5Z-00050o-Ta
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 07:43:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582548237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xAz4Ji8zYnKfgxSLYS6VIvmLV5Pf+1C1PlY53aWlhyE=;
 b=TWa3AvhQ1EMC1kHS203NYPMfov5qrTkxDpEEEBP4F3ZbQehIqNeuq9WSfpDm81gLoTbmj+
 faY2h1FrQE500w2TPrT3DV6FwCAnmL7iYG4BsNxrg1PwE1P3Xs7C1l1L21OjZs01sTb+lO
 kVI181+DxDMlku+/4S+P0/ZRD9ntS+g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-s5ioid2-MnC-UC-lKhOGkg-1; Mon, 24 Feb 2020 07:43:55 -0500
X-MC-Unique: s5ioid2-MnC-UC-lKhOGkg-1
Received: by mail-wm1-f69.google.com with SMTP id y125so3280748wmg.1
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 04:43:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SJtMslOvTVELZ4aVZLyqMWHADED/tIvEtDmH461OaXE=;
 b=OgMTOdpccQSUe4XjP59wzCWZ8IRH5GdPLGbgBvp0OsZoMDxpHsVj/DbxrTdR/+kpRJ
 oVOMNaRX65tfCKJ3LEhBfpJimbZ30bM/x3+NYs4/CUVGmLIBl360OU2Hd6CVBb41XXef
 LAXGxy2+TzqRNGQlT9cKBzQwnMZByKhOswGvzyRlMSEDfrC0AnHsT5wBMODTo68DUrGa
 /xRexQA8yMzkRqUvt20K7UUxzunUGIo+s0SCOavGvhVkJK+iKqRpmpdKBrcZhFYxMREz
 DnF6YOB6uwoKNKoyH6PEOHKZo+iu69Q3ZF8dMXxrfsdZL8pxGVstddwM7Lm5N20RUKc5
 +5Aw==
X-Gm-Message-State: APjAAAX4vstc4ptvS2rR/muWIKnfDml0k7hlDBHeHy/FwpvjVnoVXBlq
 GBIXQnvaBEIOX3RirVIW70613PauzGMnlgriXxAyYZBsEYgGIs2zJ6NDMxSLDel56IgZ6MPVdlf
 Spb2XEfG3R+gkG3U=
X-Received: by 2002:a7b:c416:: with SMTP id k22mr23122951wmi.10.1582548234421; 
 Mon, 24 Feb 2020 04:43:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqwbwWPhLowp5Em+mWKJ1dz0WrMEhylKrSNVDwtYRlc8FI2DOynVXcRzR7G++c3FUpJBt8aeVQ==
X-Received: by 2002:a7b:c416:: with SMTP id k22mr23122923wmi.10.1582548234187; 
 Mon, 24 Feb 2020 04:43:54 -0800 (PST)
Received: from [192.168.178.40] ([151.21.175.179])
 by smtp.gmail.com with ESMTPSA id d4sm18643994wra.14.2020.02.24.04.43.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Feb 2020 04:43:53 -0800 (PST)
Subject: Re: [PATCH] target: i386: Check float overflow about register stack
To: Chen Gang <chengang@emindsoft.com.cn>
References: <20200221034547.5215-1-chengang@emindsoft.com.cn>
 <a5533719-7ef1-938b-e52c-20711e65417f@redhat.com>
 <900fd511-72f0-675d-4a7e-d228b2ade9c7@emindsoft.com.cn>
 <d893eac5-0b7a-ddfe-2acf-a6f27ab48ccf@redhat.com>
 <f3bea474-468b-5818-9f69-5463be6d9b2a@emindsoft.com.cn>
 <2ab8ed82-dadd-2d5e-5bbc-69a67ba89e26@redhat.com>
 <22cf9eb4-7d48-5eb1-5d4e-38d83c0a3f40@emindsoft.com.cn>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <487e94c0-ccdf-2317-9ee2-6674aaed0aa8@redhat.com>
Date: Mon, 24 Feb 2020 13:43:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <22cf9eb4-7d48-5eb1-5d4e-38d83c0a3f40@emindsoft.com.cn>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: qemu-devel@nongnu.org, Chen Gang <gang.chen.5i5j@gmail.com>,
 ehabkost@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/02/20 13:25, Chen Gang wrote:
> On 2020/2/22 =E4=B8=8B=E5=8D=883:37, Paolo Bonzini wrote:
>> On 22/02/20 03:10, Chen Gang wrote:
>>> Set C1 to 1 if stack overflow occurred; set to 0 otherwise".
>>>
>>> In helper_fxam_ST0, I guess, we need "env->fpus |=3D 0x200" (but I don'=
t
>>> know wheter it will be conflict with SIGND(temp)). And we have to still
>>> need foverflow, because all env->fptags being 0 doesn't mean overflow.
>>
>> No, you need to add "env->fpus |=3D 0x200" and "env->fpus &=3D ~0x200"
>> directly to fpush, fpop, etc.
>>
>=20
> OK. The content below is my next TODO, welcome your opinions.
>=20
> When overflow occurs, for me, we need keep everything no touch except
> set C1 flag.

No, push will overwrite the top entry if there is overflow.

> In fxam, we don't clear C1, but keep no touch for clearning
> C1 in another places.

FXAM is neither push nor pop, it just detects an empty slot via fptags.
 FXAM should be okay with my patch.

> When underflow occurs, for me, we need keep everything no touch except
> set env->fpstt 8, so the next consecutive fpop/f[i]stp* can be checked
> easier, and the next fpush/f[i]ld* can work well in normal.
> For fxam, we check env->fpstt =3D=3D 8 and env->fptags for empty. And whe=
n
> env->fpstt is 8, it need be set 7 before used in fincstp and ffree_STN.

I don't think you need env->fpstt to be set to 8 in any case.  Also, pop
must mark ST(0) as empty always, even if underflow occurs, and also
clear C1 if underflow occurs.

Paolo


