Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11A3C43219
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 14:12:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9020020644
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 14:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TWoOG2/g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9020020644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58174 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJf76-0003mb-GG
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 10:12:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hJeez-0004hs-2e
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:43:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hJeex-0000ud-66
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:43:32 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:50708)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hJeev-0000px-7G
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:43:31 -0400
Received: by mail-wm1-x344.google.com with SMTP id 10so9444091wmk.0
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 06:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=jFqmADiyvo9F/GBVSEWGeSb6o0jIysEM5L+l/ownRME=;
	b=TWoOG2/gEuBc9onJkbOenU8+hk5sxE7NXrGRET0g0Mde5U4zC8mC3NRHSEKqjeGrj+
	/1Irao9Kfn8s5iz3komzc4QaOCNK9eF7RPKSlNp5UahoJOGmx91F59gq3h/cE5WpQWKm
	KCwRbm6t3FnDVywIL7WSxUDmeWoURw8ocTK5/PCzWTwRrpjblD/GTS0dzVA0VMgZoL51
	Xa5i0it9dXATJcwoTsZEbNnZvXcwqGNitK6gyQArrzQ9lbGUhFdj9L45Og1aumkoXM57
	IZnf+YR195vhjrioDktELeFuN1xikYlM1Ues1OGhOJqWh2x4EiroMa2dDK1rOTdFpO5/
	yMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=jFqmADiyvo9F/GBVSEWGeSb6o0jIysEM5L+l/ownRME=;
	b=WNc9CsQ60Rf6rzxvN5Wf4UZtsDTC7bI2Cx9qHPnFyp70xWBcI3d5WtAxlcBp3Z5Tfm
	fOk2Kl0nPlYtF/lAwq3VE7cJZO6N8KWkYSXvJTFhQwllchNL61Pe3YfQzLvgfX1DfxuZ
	Sth5tQ37T8zEjf6wJ4ghC1nFZsGCoW4XZkA2glHRp3q3hoB4NDc610VqIHXpqP9FTzL6
	snZKHaNYY8ylHCfEbKRQGEuqN9KuILlyNmUMnZslukzowDZ5jP4BNJ1bGpiO6W4GMad1
	Qshr9jH7nn0ErApFPhXreYdd5AZQ6pjM1MZd5QeYUOz0s6CKmvQyQMeQTGmuj1VLN5N1
	swOA==
X-Gm-Message-State: APjAAAW4IXHdKLjLPITbWwTp38vjxdH2zurZ33v10NHrR4HUVhu6PMJ5
	2HSMjbTvDVG/VvcSoxMmwZTgbA==
X-Google-Smtp-Source: APXvYqxN/E7eWZ3vkfcv0+q45SC/HsW+SJE/gSnRrjMUCZtcgfpRLfkN2dF2jXANmLQND5z7UsHqng==
X-Received: by 2002:a7b:c14c:: with SMTP id z12mr3615772wmi.138.1556199807802; 
	Thu, 25 Apr 2019 06:43:27 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id v2sm9278615wrq.12.2019.04.25.06.43.27
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 25 Apr 2019 06:43:27 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id CF4651FF87;
	Thu, 25 Apr 2019 14:43:26 +0100 (BST)
References: <20190408182748.1238-1-jan.bobek@gmail.com>
	<20190408182748.1238-6-jan.bobek@gmail.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jan Bobek <jan.bobek@gmail.com>
In-reply-to: <20190408182748.1238-6-jan.bobek@gmail.com>
Date: Thu, 25 Apr 2019 14:43:26 +0100
Message-ID: <87zhoeurnl.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [RISU PATCH 5/5] risu_i386: remove old unused code
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425134326.8AeCIAXdSgxpfEXNeixDYzS16BzBirxruaIGlnPyMzE@z>


Jan Bobek <jan.bobek@gmail.com> writes:

> The code being removed is a remnant of the past implementation; it has
> since been replaced by its more powerful, architecture-independent
> counterpart in reginfo.c.
>
> Signed-off-by: Jan Bobek <jan.bobek@gmail.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  risu_i386.c | 58 -----------------------------------------------------
>  1 file changed, 58 deletions(-)
>
> diff --git a/risu_i386.c b/risu_i386.c
> index eb4dff4..14b0db3 100644
> --- a/risu_i386.c
> +++ b/risu_i386.c
> @@ -16,13 +16,6 @@
>  #include "risu.h"
>  #include "risu_reginfo_i386.h"
>
> -struct reginfo master_ri, apprentice_ri;
> -
> -static int insn_is_ud2(uint32_t insn)
> -{
> -    return ((insn & 0xffff) =3D=3D 0x0b0f);
> -}
> -
>  void advance_pc(void *vuc)
>  {
>      ucontext_t *uc =3D (ucontext_t *) vuc;
> @@ -61,54 +54,3 @@ uintptr_t get_pc(struct reginfo *ri)
>  {
>      return ri->gregs[REG_EIP];
>  }
> -
> -int send_register_info(int sock, void *uc)
> -{
> -    struct reginfo ri;
> -    fill_reginfo(&ri, uc);
> -    return send_data_pkt(sock, &ri, sizeof(ri));
> -}
> -
> -/* Read register info from the socket and compare it with that from the
> - * ucontext. Return 0 for match, 1 for end-of-test, 2 for mismatch.
> - * NB: called from a signal handler.
> - */
> -int recv_and_compare_register_info(int sock, void *uc)
> -{
> -    int resp;
> -    fill_reginfo(&master_ri, uc);
> -    recv_data_pkt(sock, &apprentice_ri, sizeof(apprentice_ri));
> -    if (memcmp(&master_ri, &apprentice_ri, sizeof(master_ri)) !=3D 0) {
> -        /* mismatch */
> -        resp =3D 2;
> -    } else if (insn_is_ud2(master_ri.faulting_insn)) {
> -        /* end of test */
> -        resp =3D 1;
> -    } else {
> -        /* either successful match or expected undef */
> -        resp =3D 0;
> -    }
> -    send_response_byte(sock, resp);
> -    return resp;
> -}
> -
> -/* Print a useful report on the status of the last comparison
> - * done in recv_and_compare_register_info(). This is called on
> - * exit, so need not restrict itself to signal-safe functions.
> - * Should return 0 if it was a good match (ie end of test)
> - * and 1 for a mismatch.
> - */
> -int report_match_status(void)
> -{
> -    fprintf(stderr, "match status...\n");
> -    fprintf(stderr, "master reginfo:\n");
> -    dump_reginfo(&master_ri);
> -    fprintf(stderr, "apprentice reginfo:\n");
> -    dump_reginfo(&apprentice_ri);
> -    if (memcmp(&master_ri, &apprentice_ri, sizeof(master_ri)) =3D=3D 0) {
> -        fprintf(stderr, "match!\n");
> -        return 0;
> -    }
> -    fprintf(stderr, "mismatch!\n");
> -    return 1;
> -}


--
Alex Benn=C3=A9e

