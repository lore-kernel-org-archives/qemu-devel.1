Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA35C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 13:37:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3569220856
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 13:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q84wU1rE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3569220856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35910 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSiU6-0004db-HO
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 09:37:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hSiTL-0004Ku-Ug
	for qemu-devel@nongnu.org; Mon, 20 May 2019 09:37:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hSiTK-00074F-Mr
	for qemu-devel@nongnu.org; Mon, 20 May 2019 09:36:59 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:37124)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hSiTJ-00073L-8X
	for qemu-devel@nongnu.org; Mon, 20 May 2019 09:36:58 -0400
Received: by mail-wm1-x335.google.com with SMTP id 7so13097768wmo.2
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 06:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=g171TZfbwJBUkgDqDrsfcfL/AtW++H2RbDdvDa3VH8k=;
	b=q84wU1rEbIUVI1ui6CjlxcXJ+gBCu1L7spFJMq+ZbS3jvzpWH4+oCPwFL2JPxcXC+Q
	1ysXtTDtqczEsh2tKaRKesLOHmiu4sRa5A0Q7JrVslCv+hIfi1/yqnElMwxwOaDX7VCI
	7vqXDxPnKWTi+jyfgSw2KTDBAeqE1HUKkX6jIEl8gBtGEFSK9smArv2rAXs5Z3FYbeqB
	OjWxHJTyDfeIYS77O/kYZWfBcnKUJRjqmNNSNArRctWK7z12b6d9BNtfTSVID/cXg7+F
	A0JL7hkTYstCPNPfoKREIxLry8C7daNQtU51md0VBk00E5sM2M1jpm202CBC/e4jFzqZ
	vl+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=g171TZfbwJBUkgDqDrsfcfL/AtW++H2RbDdvDa3VH8k=;
	b=JnV9VCvYhflVKQV9TKT1pjMhtWkEV2hV3BSZqKwA+PbJZ4pg4N8/bK8DjC+WUaBJ3m
	MDCxd2Xf+4RkNcrWcwJxJfHASHESFwNly1gOWsf5vI1uXZ1q14oyGmWo9uBWVK4n+DFk
	OgtIybhr8/9IUsc8c3Wt0SCtYb5GcHLUpRjJnnctnpcsQmDsgTGiVoMWlp5HqrIySw2s
	Czm2uSbV6wglsZbldHMeJEY2Q9Kge9YGPJMSyoal/Yi/DisI+0SUSD2BdBP1PxcAm5V9
	cKeetZ7DrVq792d450sFZICkhwjsV0jpkkDZ7NJcknEkvfXbIQnR0ESIubcOUns78sDV
	4swA==
X-Gm-Message-State: APjAAAVx/CbYgJbD/zUoMjMvtF75/tsaxgcyfu0Xcbeqe13cpsAbeFXi
	xDISCVv0DMaoqVZtA5JFBGXndA==
X-Google-Smtp-Source: APXvYqyd5U+Pb9hEhV2G+oMxglEZDTImHYOeJHe/VJWl8OUwvVPS8fbu6o9MzkUnOiz2W/ssrT84cw==
X-Received: by 2002:a1c:7008:: with SMTP id l8mr11654839wmc.49.1558359415331; 
	Mon, 20 May 2019 06:36:55 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	z20sm20650943wmf.14.2019.05.20.06.36.54
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 20 May 2019 06:36:54 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 484EA1FF87;
	Mon, 20 May 2019 14:36:54 +0100 (BST)
References: <20181209193749.12277-1-cota@braap.org>
	<20181209193749.12277-12-cota@braap.org>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Emilio G. Cota" <cota@braap.org>
In-reply-to: <20181209193749.12277-12-cota@braap.org>
Date: Mon, 20 May 2019 14:36:54 +0100
Message-ID: <87mujhgscp.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::335
Subject: Re: [Qemu-devel] [RFC v2 11/38] tcg: add tcg_gen_st_ptr
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
	Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Emilio G. Cota <cota@braap.org> writes:

> Will gain a user soon.
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tcg/tcg-op.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
> index e2948b10a2..d3c79a6cb2 100644
> --- a/tcg/tcg-op.h
> +++ b/tcg/tcg-op.h
> @@ -1219,6 +1219,11 @@ static inline void tcg_gen_ld_ptr(TCGv_ptr r, TCGv=
_ptr a, intptr_t o)
>      glue(tcg_gen_ld_,PTR)((NAT)r, a, o);
>  }
>
> +static inline void tcg_gen_st_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t o)
> +{
> +    glue(tcg_gen_st_, PTR)((NAT)r, a, o);
> +}
> +
>  static inline void tcg_gen_discard_ptr(TCGv_ptr a)
>  {
>      glue(tcg_gen_discard_,PTR)((NAT)a);


--
Alex Benn=C3=A9e

