Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62D5C2BB55
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 11:13:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0FB7206F7
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 11:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AjSuva8C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0FB7206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLmAR-0007Ki-Vb
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 07:13:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49656)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jLm9m-0006mK-VD
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 07:12:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jLm9l-0006yw-Qv
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 07:12:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34973
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jLm9l-0006yk-NB
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 07:12:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586257957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cSUdV4YJp2r4Uc62ffvGv4zQUWbZQAl/6XoUgsGODn4=;
 b=AjSuva8CVgv+4s0+CBsNYnM0GmmjxmQ3+InvqNB9L6hR4dPpqr5KcV+t5kYT4Am8tycvbo
 J0OIqSipoa4Fh1nEJHtw2Uy9flq8pcgR/zDRonwU/U8Kv0emC/ZBxvhkDVVvnI2A8mJWYU
 4ZuvnTMOrTeLSkU+BZVWTaHpF/LFTT0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-PP_P1QU4MAK69TKjjGRMHw-1; Tue, 07 Apr 2020 07:12:32 -0400
X-MC-Unique: PP_P1QU4MAK69TKjjGRMHw-1
Received: by mail-ed1-f71.google.com with SMTP id i10so2747012edk.13
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2020 04:12:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IAfi00UCbTdnAMY5UYEliobHyzCVnYDyFiL/3c4BkNQ=;
 b=k3RjEPw3RH2t74pzBVsl+wcJ27EoA5PeY1g7WO6DhRY7e5sdhAvwykKBfGOQBU48cg
 4Zj9Jw4f86w2VfPDAQ3qyiuNjE0DQH0oNyYB4NcdnVuPTV9lWck2gatkF5whnzkrZYSj
 Mub2HyBYWgQ8RKl74MYuudfUFkGEm8kmIpWOTd6u2uZLOLuoGjvPQEn16fmXOeMvh7Zf
 nPUG65UR8oHdv76cU7+B+HmYUeTOOz4/+ELdZlz4rGjbEuPYS29U1YdWSA3gcAdD4F/I
 bLacaq2iVvXbXl6mb/sv11tz1otct1rjuhs3czaPqrwyUilWhiidzbPDYwuhMFaokY7p
 h60g==
X-Gm-Message-State: AGi0PuZWEQbuenlQ0U0x0131tfnsXQVEkldRTrTArMuVzSQQNV7XweSM
 xpax/uyGDB5r1px7OSAdAMEMu+6EmBtE92mj4OWuJ8XFgTVsrkVJg1vxhSqIGv4cDkrMzxg1pdd
 g4KIerl246KmQq5s=
X-Received: by 2002:aa7:d383:: with SMTP id x3mr1406526edq.222.1586257950506; 
 Tue, 07 Apr 2020 04:12:30 -0700 (PDT)
X-Google-Smtp-Source: APiQypLP8KhvooDY/+6tUl/Q2jOO/xv5gwREsKSI52xQQ5F8gveGHutUjxeJqjsUv16s2owLMTT4Sg==
X-Received: by 2002:aa7:d383:: with SMTP id x3mr1406488edq.222.1586257950106; 
 Tue, 07 Apr 2020 04:12:30 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id um17sm420868ejb.50.2020.04.07.04.12.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2020 04:12:29 -0700 (PDT)
Subject: Re: [PATCH v1 1/2] dma/xlnx-zdma: Fix descriptor loading (MEM) wrt
 endianness
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
References: <20200404122718.25111-1-edgar.iglesias@gmail.com>
 <20200404122718.25111-2-edgar.iglesias@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e447464e-eeb9-3024-fc52-6e03dcb79a17@redhat.com>
Date: Tue, 7 Apr 2020 13:12:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200404122718.25111-2-edgar.iglesias@gmail.com>
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me,
 richard.henderson@linaro.org, frederic.konrad@adacore.com, qemu-arm@nongnu.org,
 luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/4/20 2:27 PM, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>=20
> Fix descriptor loading from memory wrt host endianness.
>=20
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>   hw/dma/xlnx-zdma.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/dma/xlnx-zdma.c b/hw/dma/xlnx-zdma.c
> index 1c45367f3c..5f4775f663 100644
> --- a/hw/dma/xlnx-zdma.c
> +++ b/hw/dma/xlnx-zdma.c
> @@ -299,19 +299,22 @@ static void zdma_put_regaddr64(XlnxZDMA *s, unsigne=
d int basereg, uint64_t addr)
>       s->regs[basereg + 1] =3D addr >> 32;
>   }
>  =20
> -static bool zdma_load_descriptor(XlnxZDMA *s, uint64_t addr, void *buf)
> +static bool zdma_load_descriptor(XlnxZDMA *s, uint64_t addr,
> +                                 XlnxZDMADescr *descr)
>   {
>       /* ZDMA descriptors must be aligned to their own size.  */
>       if (addr % sizeof(XlnxZDMADescr)) {
>           qemu_log_mask(LOG_GUEST_ERROR,
>                         "zdma: unaligned descriptor at %" PRIx64,
>                         addr);
> -        memset(buf, 0x0, sizeof(XlnxZDMADescr));
> +        memset(descr, 0x0, sizeof(XlnxZDMADescr));
>           s->error =3D true;
>           return false;
>       }
>  =20
> -    address_space_read(s->dma_as, addr, s->attr, buf, sizeof(XlnxZDMADes=
cr));
> +    descr->addr =3D address_space_ldq_le(s->dma_as, addr, s->attr, NULL)=
;
> +    descr->size =3D address_space_ldl_le(s->dma_as, addr + 8, s->attr, N=
ULL);
> +    descr->attr =3D address_space_ldl_le(s->dma_as, addr + 12, s->attr, =
NULL);

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>       return true;
>   }
>  =20
> @@ -344,7 +347,7 @@ static void zdma_update_descr_addr(XlnxZDMA *s, bool =
type,
>       } else {
>           addr =3D zdma_get_regaddr64(s, basereg);
>           addr +=3D sizeof(s->dsc_dst);
> -        address_space_read(s->dma_as, addr, s->attr, (void *) &next, 8);
> +        next =3D address_space_ldq_le(s->dma_as, addr, s->attr, NULL);
>       }
>  =20
>       zdma_put_regaddr64(s, basereg, next);
>=20


