Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765E5C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 18:07:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44A3C2068F
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 18:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iMBnegET"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44A3C2068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiMgq-0008WN-E5
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 13:07:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59169)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iiMch-00032S-Jx
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 13:03:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iiMcg-0001A9-2F
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 13:03:35 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41266)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iiMcf-00018T-Qm
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 13:03:34 -0500
Received: by mail-wr1-x444.google.com with SMTP id c9so10270395wrw.8
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 10:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=ZG5NP8rMS0BrICVsan1aqbJ7h7SmQ3alUGwiQ3MJBkw=;
 b=iMBnegETxXM/3RoSMs86kHen3vYHNMEVukD7RtiN+DQ8bD7OoVH0IfTU4EHHGMir3p
 3t8bErwgCL+KxGQxTpRh8meqwGUNIiw8vyNYitgsjvnAq+VBu5xn+TeR0KliBVuoddPn
 dEiiKQOUy0QuSEb2AynfLYSJ+oZ/pGEVS7xdgEs7Kpqe5stQLthQ4VxQqHza29ZbdXUn
 c8t+NyR85fgMdI49Fcko4/G/ezjkHvs8ML5O2HzxTxrZk7QwkDE7JTbnTiHffvIhOuLo
 aVl3epRqrgRmoQHyeinm3cTa8e7cwU2BPWftyA0Y7tM1v67J32RU0h/G/u7J28u+GkGG
 gWHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=ZG5NP8rMS0BrICVsan1aqbJ7h7SmQ3alUGwiQ3MJBkw=;
 b=A4zMNJ5WH5acaichxhTa/zghj+sgZDgUcdz3rHsKciG1+KOxrs5X/0hmuwNpeHrlqI
 kAe8p3knRZn5YzbH6iMxNRWfmoQkSR6eRxgR5sCy8BZ+WPTdorKkFNgg31FejVEp/AYe
 sjtCsVN2AqoyaEK/Nux8CzS/LdWjZbd81VoQIDwMnUfYVh2L516MKwaCfkKakarWwP26
 /DvMjX6NlQ3vtWrmElpOLBJ9JWbj/Ze+6nllMIT0NIHz5mRnDJId9f2Os8TVhsWz+7Cl
 TMcuQWZYo+VA0sy4WUDs+dJCSOzFYivJtJn+ooEsyGpT2ayR9PwZp9IT50Mo9zOJcKuf
 FZdw==
X-Gm-Message-State: APjAAAX5h/c33tSlUW4eWcobKeUAwTvxfYt54Qu+u4mcY9JCdMK2E6zP
 WFHgL+EGaKbbbgI4CAef+IcrWYCCXz4=
X-Google-Smtp-Source: APXvYqzP2mqGJqIQN2M4A7EhGju1w3n/Q4U75mBQ7gh4JdaVP/A8snOc6pFCKRn1Qk4C9rW6ioByqg==
X-Received: by 2002:adf:e5cf:: with SMTP id a15mr93839wrn.140.1576865012667;
 Fri, 20 Dec 2019 10:03:32 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v188sm11221621wma.10.2019.12.20.10.03.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 10:03:31 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DE1DB1FF87;
 Fri, 20 Dec 2019 18:03:30 +0000 (GMT)
References: <20191216221158.29572-1-richard.henderson@linaro.org>
 <20191216221158.29572-21-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 20/28] target/sh4: Remove MMU_MODE{0,1}_SUFFIX
In-reply-to: <20191216221158.29572-21-richard.henderson@linaro.org>
Date: Fri, 20 Dec 2019 18:03:30 +0000
Message-ID: <87sglec1sd.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> The functions generated by these macros are unused.
>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/sh4/cpu.h | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
> index ecaa7a18a9..452a596e67 100644
> --- a/target/sh4/cpu.h
> +++ b/target/sh4/cpu.h
> @@ -254,8 +254,6 @@ void cpu_load_tlb(CPUSH4State * env);
>  #define cpu_list sh4_cpu_list
>=20=20
>  /* MMU modes definitions */
> -#define MMU_MODE0_SUFFIX _kernel
> -#define MMU_MODE1_SUFFIX _user
>  #define MMU_USER_IDX 1
>  static inline int cpu_mmu_index (CPUSH4State *env, bool ifetch)
>  {


--=20
Alex Benn=C3=A9e

