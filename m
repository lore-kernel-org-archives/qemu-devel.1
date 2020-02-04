Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1294FC3524B
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:39:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8C6E20674
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u+5adK6i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8C6E20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz2AP-0005m0-2p
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 12:39:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43897)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iz29l-0005L4-NV
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:38:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iz29k-00064P-Qu
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:38:37 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42134)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iz29k-00061Q-KI
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:38:36 -0500
Received: by mail-wr1-x441.google.com with SMTP id k11so24128722wrd.9
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 09:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=ugTENM2v3HppAfuC6fYEmU2F35q5chyYoVs7cITlxgg=;
 b=u+5adK6iDayhKKLhXwkXkvBEQqYD9vqYvCC8e3FYLvoN+VmeVdyXxSFspdLwlqeR8a
 8AmETywN+Vg1sH2/s478AWwGMpQ/Q3PgcuOoUNlPRHYSWmBa4VTDNeoqGDs2gHvYGduo
 OmS4oxmbShwR2BcwoSFq5KZW2TAXhogHT/4xYoKqcs87V8WG4/xXjtf6/ZRKH/oFpj8Y
 K0VJSlEN1wnl/OB76rdkG2BkxNiBHNaOLDPK11BO4j6k6nTQA2a8QgKqrCY4UGrFhMbf
 CxCqGwSFhZ3wB10s6lHQBs+cqVRMaV/CthoNCA+fxouVsAJf61RLICcvBN+WCt7GsAIa
 /Ajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=ugTENM2v3HppAfuC6fYEmU2F35q5chyYoVs7cITlxgg=;
 b=gSyKR9ywpypLy7IphWXrT5E8n7fFYO6K+J9fOsQOaVKD44wJhAHX3X8gitd5PF15N6
 +We+77+IyGFZv4K4bILc1NRYImYzSCnFvMcALFNha0bmu/LWcnJhw38a2K6rtOuFK0zk
 KRwr/yxVP73y1zpzg72Kstb+d0EDntN+HP4SWw6AGRdeVlTZaHszHRb832qZsQMV5CMi
 ja4cQzLIL9GNFGqX9ttk14SwRcmqMHZmpWttVeRefkaJDlhf5ALvOCKvSGMp4CGCHQGs
 cxsMjIVcff4/wInjp87CwFZaMfP6DAzqJObMgAmkwjPcjUsi8xbPlpr/nEAFYPjSKyH8
 NueQ==
X-Gm-Message-State: APjAAAU0zUavHZIIsQeaqkUlGKEKhT+IRNJlXxNffN+4JBfHSDJDJbGR
 pMSMAGWmHoGW9BQvy5p6u6odLWuG/pg=
X-Google-Smtp-Source: APXvYqwGVYRLuBBgw3VF6oTX9XrNBxTvZJNQwigabEI755d4ByokAh1VF7i9dXcmEQkSpRDmncqPRQ==
X-Received: by 2002:a5d:5148:: with SMTP id u8mr24520888wrt.132.1580837914849; 
 Tue, 04 Feb 2020 09:38:34 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e6sm4502008wme.3.2020.02.04.09.38.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2020 09:38:33 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EFD701FF87;
 Tue,  4 Feb 2020 17:38:32 +0000 (GMT)
References: <20200204161036.20889-1-pbonzini@redhat.com>
User-agent: mu4e 1.3.7; emacs 27.0.60
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] exec: do not define use_icount for user-mode emulation
In-reply-to: <20200204161036.20889-1-pbonzini@redhat.com>
Date: Tue, 04 Feb 2020 17:38:32 +0000
Message-ID: <87r1za8d7r.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Paolo Bonzini <pbonzini@redhat.com> writes:

> use_icount is also defined by stubs/cpu-get-icount.c, we do not need
> to have a useless definition in exec.c.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  exec.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/exec.c b/exec.c
> index 67e520d18e..5fc3746053 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -98,15 +98,15 @@ CPUTailQ cpus =3D QTAILQ_HEAD_INITIALIZER(cpus);
>  /* current CPU in the current thread. It is only valid inside
>     cpu_exec() */
>  __thread CPUState *current_cpu;
> -/* 0 =3D Do not count executed instructions.
> -   1 =3D Precise instruction counting.
> -   2 =3D Adaptive rate instruction counting.  */
> -int use_icount;
>=20=20
>  uintptr_t qemu_host_page_size;
>  intptr_t qemu_host_page_mask;
>=20=20
>  #if !defined(CONFIG_USER_ONLY)
> +/* 0 =3D Do not count executed instructions.
> +   1 =3D Precise instruction counting.
> +   2 =3D Adaptive rate instruction counting.  */
> +int use_icount;
>=20=20
>  typedef struct PhysPageEntry PhysPageEntry;


--=20
Alex Benn=C3=A9e

