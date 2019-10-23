Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C84CA9EB9
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 19:27:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F73220679
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 19:27:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F73220679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNMHg-0002zQ-Ql
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 15:27:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41315)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iNLHr-0000lH-KN
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 14:23:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iNLHo-0003dT-6E
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 14:23:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48902)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iNLHm-0003ZB-4Q
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 14:23:08 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C9614C04B31E
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 18:23:02 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id z5so6266206wma.5
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 11:23:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aabKx3Sw58gZ8F5vMUyxedq8mepIjKfbdhzgpSqLYKU=;
 b=S/lxnJ8HTR3Hr4zGOoMVkuUvUdr9fumPd3fCiq0a90RIfQEak/uMVzwt9S09+BcHVi
 flkVbWPGODWG+kJR+Umgd6qta9DwneY/Pe6+ichyMniUswSVFsrxI1WCdM0Z0nHtNOYl
 PZgJlUUQedOdindFDjjYcGPHCwvg46zpAZi1FboogGMN+aMCZcBHMRQWFpbFACrU9FAM
 dprV/WgZ+CqAti5Es9lM8uMfMEJNKHJ9myx2BYmWuYzUc/EVrbZLzgruRXpfqTLvEIjB
 PORnxFWzY0GlWvmBHYegjqM7FuiVpdMPs7Gqe7+8vwzzgO2Ika140jKhXxNBojx+vUXK
 Cj4A==
X-Gm-Message-State: APjAAAVCrusDI2X15s6fAnqG7O3GmAFFfupYSXEOlMqLIJ40y2ohrgIY
 7hyr8d+P1hcuZZrNYrKD9nlrv7BcVj1L/Uk0UtiapkQnQku8hmoteCcSj6FW7BU1hD4YxiehxBD
 jM20rX3ngfk2M5rc=
X-Received: by 2002:a5d:53c1:: with SMTP id a1mr66917wrw.243.1571854981556;
 Wed, 23 Oct 2019 11:23:01 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx62nRFKjGA+3JxwMsNzp8z20yv6BiN2z4HiUFAv0RrZeGa8wI8Ru/Vq+K9DGcRH/HFA3GtDw==
X-Received: by 2002:a5d:53c1:: with SMTP id a1mr66902wrw.243.1571854981266;
 Wed, 23 Oct 2019 11:23:01 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id p1sm7211086wmg.11.2019.10.23.11.22.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Oct 2019 11:23:00 -0700 (PDT)
Subject: Re: [PATCH] cputlb: Fix tlb_vaddr_to_host
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20191023154952.30731-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1aefcc9f-67fe-d4c6-207f-db0de292df27@redhat.com>
Date: Wed, 23 Oct 2019 20:22:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191023154952.30731-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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

On 10/23/19 5:49 PM, Richard Henderson wrote:
> Using uintptr_t instead of target_ulong meant that, for 64-bit guest
> and 32-bit host, we truncated the guest address comparator and so may
> not hit the tlb when we should.
>=20
> Fixes: 4811e9095c0
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>=20
> Fixes aarch64 emulation on arm32 host, after our recent changes
> to tlb probing.
>=20
>=20
> r~
>=20
> ---
>   accel/tcg/cputlb.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 6f4194df96..5eebddcca8 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1189,7 +1189,7 @@ void *tlb_vaddr_to_host(CPUArchState *env, abi_pt=
r addr,
>                           MMUAccessType access_type, int mmu_idx)
>   {
>       CPUTLBEntry *entry =3D tlb_entry(env, mmu_idx, addr);
> -    uintptr_t tlb_addr, page;
> +    target_ulong tlb_addr, page;
>       size_t elt_ofs;
>  =20
>       switch (access_type) {
>=20

Clang catched this with -Wshorten-64-to-32 but there are so many other=20
warnings to fix that we can not use it :(

accel/tcg/cputlb.c:620:26: error: implicit conversion loses integer=20
precision: 'size_t' (aka 'unsigned long') to 'unsigned int'=20
[-Werror,-Wshorten-64-to-32]
         unsigned int n =3D tlb_n_entries(env, mmu_idx);
                      ~   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
accel/tcg/cputlb.c:788:13: error: implicit conversion loses integer=20
precision: 'uintptr_t' (aka 'unsigned long') to 'unsigned int'=20
[-Werror,-Wshorten-64-to-32]
     index =3D tlb_index(env, mmu_idx, vaddr_page);
           ~ ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Maybe we could try to clean accel/tcg/ and use it there at least.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

