Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C464FC3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 17:07:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 994522166E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 17:07:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 994522166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3NtB-0002GP-ES
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 13:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49849)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i3Nmn-0003Ap-Nc
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 13:00:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i3Nmm-0003yG-Pn
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 13:00:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35180)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i3Nmm-0003xz-KF
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 13:00:36 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A0E412BE94
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 17:00:35 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id l16so1981128wmg.2
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 10:00:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AkAUqRXuCNfRpGfsPBiD4amV1J23gRhXvSJJdpDQmNA=;
 b=sHou+jVW38zXAZ+vVnFXSXUGnUSJXG+Jcsg1kGAMEWDLmgiT5LFpeUUi1kxgthtRkA
 NwD0VOCcLRXhBR2wXzFiK1k2k+uMoOT4nEakeX2MUZgs1xeiqfr/zQyzvfspCtZx/Zhl
 uq6bsz1iuBA1P2SvAbugXm6Qzjwjq6hhHMqD/77xdfrWRR46euYwynwiJD0NdF+BzIch
 BFL3DD0GiUnNNYQ4aXcJP4jgopTH7xK+GwKyTRt8BFgV3WVdgDNtziGAcneFMIWnFBO4
 /DXNVzNW0IRptDKnqXr6WHrK71EUb0VaQPWA41mMsdLX1DDbQAYduyXSVteFxXRIa4Qt
 IL3w==
X-Gm-Message-State: APjAAAVZRXF9nVEPPu7BE9pU1rJcHRLYs6ak81Cg2IqT2T7y+brgWF9r
 V/lpACQv5s14z/Llg0nBCksULf1v0Dg+df2v4rPjvTMP/xD++pBh3K1Xm0UAPSeN7sdgqLK16LS
 SxqQlyi+/cstBb6Q=
X-Received: by 2002:a1c:1b14:: with SMTP id b20mr801147wmb.122.1567098034367; 
 Thu, 29 Aug 2019 10:00:34 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxKBvJfUKX0IPAvIm+VNwWBUg54c1L1rC7T3byIcQVAFXCL1l3iu3ktGqAPTYPNB3bjlNDUVQ==
X-Received: by 2002:a1c:1b14:: with SMTP id b20mr801132wmb.122.1567098034196; 
 Thu, 29 Aug 2019 10:00:34 -0700 (PDT)
Received: from [192.168.1.41] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id e9sm2080127wrt.69.2019.08.29.10.00.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Aug 2019 10:00:33 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190828231651.17176-1-richard.henderson@linaro.org>
 <20190828231651.17176-7-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <83d1c716-c2ff-146e-6d9b-40960218acd6@redhat.com>
Date: Thu, 29 Aug 2019 19:00:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190828231651.17176-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 6/8] cputlb: Remove double-alignment in
 store_helper
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
Cc: david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/29/19 1:16 AM, Richard Henderson wrote:
> We have already aligned page2 to the start of the next page.
> There is no reason to do that a second time.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>  accel/tcg/cputlb.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 7fb67d2f05..d0f8db33a2 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1518,8 +1518,7 @@ store_helper(CPUArchState *env, target_ulong addr=
, uint64_t val,
>          entry2 =3D tlb_entry(env, mmu_idx, page2);
>          tlb_addr2 =3D tlb_addr_write(entry2);
>          if (!tlb_hit_page(tlb_addr2, page2)
> -            && !victim_tlb_hit(env, mmu_idx, index2, tlb_off,
> -                               page2 & TARGET_PAGE_MASK)) {
> +            && !victim_tlb_hit(env, mmu_idx, index2, tlb_off, page2)) =
{
>              tlb_fill(env_cpu(env), page2, size2, MMU_DATA_STORE,
>                       mmu_idx, retaddr);
>          }
>=20

