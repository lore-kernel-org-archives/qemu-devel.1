Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9196C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 09:33:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 558D52133D
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 09:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZTOU7Tyj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 558D52133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51595 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU6Zp-0007wd-FS
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 05:33:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hU6Yu-0007G6-7h
	for qemu-devel@nongnu.org; Fri, 24 May 2019 05:32:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hU6Ys-0005II-2d
	for qemu-devel@nongnu.org; Fri, 24 May 2019 05:32:27 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:50529)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hU6Yq-0005HW-TV
	for qemu-devel@nongnu.org; Fri, 24 May 2019 05:32:25 -0400
Received: by mail-wm1-x342.google.com with SMTP id f204so8632298wme.0
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 02:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=EobVpsYfx98AjwqDqD6kA4vzeWpRjiGGCrAXPbjMEBU=;
	b=ZTOU7TyjW2sQAcqQqsEUUiGl/zGnlRXD1XSXsFF12xqJbjWEadkLr45EeAIq1kt9LV
	IuGovKVO5qAfcrEQfdXY6gJ7xAMtLWb+bJ0eDqzGzGCMT+STOSU9Q7CCgzK3BcUpfDJp
	YxggD3MqGCbU3znjbndJ/ECTBPbSV0CU7n3m7G3mEHr7eJo2pbehmj3LupBCLXN6Hfj9
	r42yYTv651wyVx/0YvFLgjK2zi+jaf4fpoygDjm89L3Boesdh4BW4t1ZpO1ckGOburPW
	9lsVzwKMQIHsS1EHN20ZPMH1NHjX+1pLug69FLYRlAJ828Haf8gfQLcEPip2RQXXymJ9
	U13Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=EobVpsYfx98AjwqDqD6kA4vzeWpRjiGGCrAXPbjMEBU=;
	b=PGBHe2yeJEBphukOGr/b1J/EluYylcaUIX0qeDgjIJfgE55HPiNjLO248xC91UvuOU
	/J/Dab249uzUwYHejCrtNfIxMUPHGnLdunlfyVldIu1ahgcUgWTS8mYwuNbGdOEKam2Q
	ga95Ft6lqECYzEP9DCy36ra5NCDyB9Ep7EzhHNbchANL8snRtt7CK/JMY8W8+YzuoXpd
	9GyIUheA1vfLUnyOKUY4i7QW+Iiq/+qGqcV0KM9IOTP1xiEGZV7yEQDsGQnGrl1V0fpn
	//eG5JMwrQvMaHZNHPiaGM/mm4RfEpyYyCwBXIyS3ywDaj8xekcGryMJ7UNpge9lHPt0
	bvTA==
X-Gm-Message-State: APjAAAWGyeJb3NcogTSSreiM4HqLDd0R2nmIWr+lx3S9n1cgXuGIApti
	1q+jutoUUPj+6FsgZaQeqRHpI1WoQo4=
X-Google-Smtp-Source: APXvYqx9AhlkTnKdjKX4M+ZaBQKKNdhXPTxW2rQI/p6wueq7Sz9/lbo9JzXiMo9BBCkmje3d/kxe8w==
X-Received: by 2002:a1c:eb07:: with SMTP id j7mr14840756wmh.138.1558690343725; 
	Fri, 24 May 2019 02:32:23 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	y16sm1650522wru.28.2019.05.24.02.32.22
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 24 May 2019 02:32:23 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id A16B01FF87;
	Fri, 24 May 2019 10:32:22 +0100 (BST)
References: <20190523204409.21068-1-jan.bobek@gmail.com>
	<20190523204409.21068-12-jan.bobek@gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jan Bobek <jan.bobek@gmail.com>
In-reply-to: <20190523204409.21068-12-jan.bobek@gmail.com>
Date: Fri, 24 May 2019 10:32:22 +0100
Message-ID: <87a7fc19ll.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [RISU v3 11/11] risu_reginfo_i386: rework
 --xfeatures value parsing
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Jan Bobek <jan.bobek@gmail.com> writes:

> Have the --xfeatures option accept "sse", "avx" and "avx512" in
> addition to a plain numerical value, purely for users' convenience.
> Don't fail silently when an incorrect value is specified, to avoid
> confusion.
>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Jan Bobek <jan.bobek@gmail.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


> ---
>  risu_reginfo_i386.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/risu_reginfo_i386.c b/risu_reginfo_i386.c
> index 01ea179..194e0ad 100644
> --- a/risu_reginfo_i386.c
> +++ b/risu_reginfo_i386.c
> @@ -53,8 +53,25 @@ const char * const arch_extra_help
>
>  void process_arch_opt(int opt, const char *arg)
>  {
> +    char *endptr;
> +
>      assert(opt =3D=3D FIRST_ARCH_OPT);
> -    xfeatures =3D strtoull(arg, 0, 0);
> +
> +    if (!strcmp(arg, "sse")) {
> +        xfeatures =3D XFEAT_X87 | XFEAT_SSE;
> +    } else if (!strcmp(arg, "avx")) {
> +        xfeatures =3D XFEAT_X87 | XFEAT_SSE | XFEAT_AVX;
> +    } else if (!strcmp(arg, "avx512")) {
> +        xfeatures =3D XFEAT_X87 | XFEAT_SSE | XFEAT_AVX | XFEAT_AVX512;
> +    } else {
> +        xfeatures =3D strtoull(arg, &endptr, 0);
> +        if (*endptr) {
> +            fprintf(stderr,
> +                    "Unable to parse '%s' in '%s' into an xfeatures inte=
ger mask\n",
> +                    endptr, arg);
> +            exit(1);
> +        }
> +    }
>  }
>
>  const int reginfo_size(void)


--
Alex Benn=C3=A9e

