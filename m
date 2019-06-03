Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED19C282CE
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 15:44:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBA18278CE
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 15:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3NvzhpR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBA18278CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36951 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXp81-0004yB-1T
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 11:44:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <randrianasulu@gmail.com>) id 1hXp7G-0004YT-TB
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 11:43:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <randrianasulu@gmail.com>) id 1hXp7F-0005Ko-RG
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 11:43:18 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:39249)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <randrianasulu@gmail.com>)
	id 1hXp7F-0005GF-Iw; Mon, 03 Jun 2019 11:43:17 -0400
Received: by mail-lf1-x141.google.com with SMTP id p24so7514617lfo.6;
	Mon, 03 Jun 2019 08:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:user-agent:cc:references:in-reply-to
	:mime-version:content-transfer-encoding:content-disposition
	:message-id; bh=oSZhidXep9ZqP/yYb06ujCa4jLpPDdZ3fQEzb4ebxeA=;
	b=K3NvzhpRLI5Em/Y4B58Yi0W2IO+q2FNksM2oj1PQHj8Rsk8h/seJURnt3Rx59Woq2t
	gF4L+TgVNYfDjHTJtYxVlwGv2HZ12Bs9DFYkt2iPaRnMP6A5K8IsWC5GCU4gvnuYJAg4
	3SO0gLoYr8ZZcYixBkc1Lk1b7vVG2m+mzGq6v1vS1Y0e8vcgnXE/N+/pUia9qS09/qri
	VFqeb7Q/QoQAE3l+FvxeXZdND/wqHDQUHtDWyfX7U8SPgj4b4+o8ynhwikri/AwIO6sx
	TFiGndjoI8fTuoKdHM+H0FiQpshwg+XxXNZSBueOuvY5RHinRJfLkDnHHPY7ilFeX3KM
	6JsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:user-agent:cc:references
	:in-reply-to:mime-version:content-transfer-encoding
	:content-disposition:message-id;
	bh=oSZhidXep9ZqP/yYb06ujCa4jLpPDdZ3fQEzb4ebxeA=;
	b=J/V0PZ3LuRtfmNRA1rplvjP3bGYR9fGj0/i9CEDsqRDFLCq/Bshmf+177p32XwjxfG
	ldSDgH9Pe7IT20PV1LqtKvR2P/GKL5Tx+VEoqXy+WzrdStTkU6XkTJYYj/7OgkiMxeg0
	qqpA7vTKlNLzFA+MVqLhBF67zSuOZlXbbpvKFGU1ImUtQyQbLR61OsfAHg6JLOKjS+uH
	6BkKd37kDK57jwcOcKhYysKEzbkacWA0K7PWPVmdRblB2WV1DrvQDuoTN111f79tSIy2
	ts+bgtn/UWtsZMqnN3lL67oID+okGLRw9MzfOESJzFmLTcOp0juii4UKhX7AbQoL1EMo
	RdOw==
X-Gm-Message-State: APjAAAX9iI7PWkG+uqy0U6mliYYcG5gjN2rYd4hlPcblp4YePGGVEnsa
	121ZiUipkPCF96TA/ca5B/k=
X-Google-Smtp-Source: APXvYqxQFRrcZh1MLOpMtz1rPunzFizLDpRKnWN2JRZAcxIb+5NFTUkWljdNJRAjJmOjH/8dulCTDg==
X-Received: by 2002:ac2:4ac5:: with SMTP id m5mr13592083lfp.95.1559576594831; 
	Mon, 03 Jun 2019 08:43:14 -0700 (PDT)
Received: from [192.168.1.121] ([176.116.252.109])
	by smtp.gmail.com with ESMTPSA id s5sm3202338lfe.43.2019.06.03.08.43.13
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 08:43:14 -0700 (PDT)
From: Andrew Randrianasulu <randrianasulu@gmail.com>
To: Alex =?utf-8?q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 3 Jun 2019 18:35:12 +0300
User-Agent: KMail/1.9.10
References: <20190603150120.29255-1-alex.bennee@linaro.org>
In-Reply-To: <20190603150120.29255-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <201906031835.13420.randrianasulu@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::141
Subject: Re: [Qemu-devel] [RFC PATCH] cputlb: use uint64_t for interim
 values for unaligned load
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: 1830872@bugs.launchpad.net, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=82 =
Monday 03 June 2019 18:01:20 Alex Benn=C3=A9e =D0=BD=D0=B0=D0=BF=D0=B8=D1=
=81=D0=B0=D0=BB(=D0=B0):
> When running on 32 bit TCG backends a wide unaligned load ends up
> truncating data before returning to the guest. We specifically have
> the return type as uint64_t to avoid any premature truncation so we
> should use the same for the interim types.
>=20
> Hopefully fixes #1830872
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  accel/tcg/cputlb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index cdcc3771020..b796ab1cbea 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1303,7 +1303,7 @@ load_helper(CPUArchState *env, target_ulong addr, T=
CGMemOpIdx oi,
>          && unlikely((addr & ~TARGET_PAGE_MASK) + size - 1
>                      >=3D TARGET_PAGE_SIZE)) {
>          target_ulong addr1, addr2;
> -        tcg_target_ulong r1, r2;
> +        uint64_t r1, r2;
>          unsigned shift;
>      do_unaligned_access:
>          addr1 =3D addr & ~(size - 1);

Unfortunatly, this doesn't fix 32-bit qemu-system-x86_64 .... so, my bug is=
 separate from #1830872 ?

I also was unable to convince qemu to use my kernel-only x86_64 gcc 6.5.0 c=
ross-compiler ..
probably x86-64 testing on i686 requires either docker (I don't have this
) or 'real' cross-compiler (build with glibc support).

