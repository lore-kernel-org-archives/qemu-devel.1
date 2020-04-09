Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E7B7C2BA19
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 17:21:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4734820768
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 17:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NtSxtNVx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4734820768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMasI-0002n4-CI
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 13:21:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35217)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jMari-0002N3-Np
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 13:21:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jMarh-0000Sf-7A
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 13:21:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37523
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jMarh-0000SO-2s
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 13:21:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586452880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WRgQvFu0uYR4P2SQ1rdn22acQVBNCuWAv3mI5eeSHME=;
 b=NtSxtNVx7nVXV/Zw8eGfL7/dis6G76iWMyuqYKIYRVKjO/nSEFiOJrlybkCyey5whzgw9U
 57xsQJA5HGqgAWI3mri986Gk6Ni+MRMydPNNaV9bnSm4MgoPOhrYO3MrDarniGF8WWT3+5
 xaZZuN+5juvlRh3uTR7e5cBbRDQEeks=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-TKzRxz4WPUK2cM-FkIY_9A-1; Thu, 09 Apr 2020 13:21:18 -0400
X-MC-Unique: TKzRxz4WPUK2cM-FkIY_9A-1
Received: by mail-ed1-f72.google.com with SMTP id l4so516432edw.23
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2020 10:21:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=blNdhEcjyKRh3YF+CdxOeJ8ksNt4ITHBYGiHq1+uPe8=;
 b=fvCHe05evGAbpMSti9ZsSsp+AD2VzIXpkAbmxoKOhUVDO+PvFS4LPPkmdgIasnKt3h
 +w4wuTDIDCljCVF6o5FvQBb//FqldyK8p/7oq5yXsSHxVl7ilB9cIdoIyKWMeAeAE+e5
 LlWg4apxV1yqJ+BCyGPlm7SM2VkOMLsoQTE4BsbJhlM+4i1CQ3rWF9O3fbAKjCBSTg/A
 9edCa+Xh7IHClE+Ikd0JiGFNEoBuO63KTuwuLOlhXYLDSNOCm13fMws1Ki4V39hvr6cX
 gxjUb2sVok5iPl8SsImdugT7bXDPMeU1NmxvFjYUOCPA8zPLkZ+zOmUZhvIHiV5iSLiV
 nc4g==
X-Gm-Message-State: AGi0PuZoTEl+YAJyZt2Lg2iI7FZPwo2JZLEb8j2ABkOA2Wbdw113+ZnU
 4VQEeLipCrqB6DIkzxoBJCCE3xXST2M70VkUEof2nR/4FkaPs8PpO8GRKf8iTYhSlt00lJoQwIp
 Sy4rtNT4tYx4UTuI=
X-Received: by 2002:a05:6402:206c:: with SMTP id
 bd12mr1036527edb.287.1586452876851; 
 Thu, 09 Apr 2020 10:21:16 -0700 (PDT)
X-Google-Smtp-Source: APiQypKUQLCpNkX92mHqFwsJpbnZl0XjDyRaAAqEHxORtxmfeLlJsT7KHAFtmtRTAXXLounRIQ0aKQ==
X-Received: by 2002:a05:6402:206c:: with SMTP id
 bd12mr1036515edb.287.1586452876647; 
 Thu, 09 Apr 2020 10:21:16 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id dc25sm3785210ejb.59.2020.04.09.10.21.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Apr 2020 10:21:16 -0700 (PDT)
Subject: Re: [PATCH 2/2] gdbstub: i386: Fix gdb_get_reg16() parameter to
 unbreak gdb
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
References: <20200409164954.36902-1-peterx@redhat.com>
 <20200409164954.36902-3-peterx@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b559bedc-c6d7-922b-35fd-96ac4f068d9b@redhat.com>
Date: Thu, 9 Apr 2020 19:21:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200409164954.36902-3-peterx@redhat.com>
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/9/20 6:49 PM, Peter Xu wrote:
> We should only pass in gdb_get_reg16() with the GByteArray* object
> itself, no need to shift.  Without this patch, gdb remote attach will
> crash QEMU.

You are correct.

Fixes: a010bdbe719 ("extend GByteArray to read register helpers")

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Same problem in m68k_fpu_gdb_get_reg().

TODO for 5.1, rename mem_buf -> array.

>=20
> Cc: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   target/i386/gdbstub.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
> index f3d23b614e..b98a99500a 100644
> --- a/target/i386/gdbstub.c
> +++ b/target/i386/gdbstub.c
> @@ -106,7 +106,7 @@ int x86_cpu_gdb_read_register(CPUState *cs, GByteArra=
y *mem_buf, int n)
>       } else if (n >=3D IDX_FP_REGS && n < IDX_FP_REGS + 8) {
>           floatx80 *fp =3D (floatx80 *) &env->fpregs[n - IDX_FP_REGS];
>           int len =3D gdb_get_reg64(mem_buf, cpu_to_le64(fp->low));
> -        len +=3D gdb_get_reg16(mem_buf + len, cpu_to_le16(fp->high));
> +        len +=3D gdb_get_reg16(mem_buf, cpu_to_le16(fp->high));
>           return len;
>       } else if (n >=3D IDX_XMM_REGS && n < IDX_XMM_REGS + CPU_NB_REGS) {
>           n -=3D IDX_XMM_REGS;
>=20


