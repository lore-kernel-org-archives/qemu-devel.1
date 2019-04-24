Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140B5C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 10:15:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2A5520878
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 10:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XoDE2OXu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2A5520878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39036 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJEwN-0006RB-13
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 06:15:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hJEue-00055J-V3
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 06:14:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hJEhy-0005BA-Eo
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 06:00:55 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40554)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1hJEhy-00057x-48
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 06:00:54 -0400
Received: by mail-wm1-x342.google.com with SMTP id z24so4155138wmi.5
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 03:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=xlmmcryFskM6LVHSnB503rp3QfJerIeYBwauhUiyLw4=;
	b=XoDE2OXuYVSzI5v6gyt/+r8wuWoFnp0ZbxUHOGwRLhCVs2fg0Ho7MPxA/4t1leLgEN
	rsnR3MCfJiSpBox3bqJITRr6HZtekUkPOtfhVOlZfvvoCZRS2oRyez7kYYXQB37eB8KV
	iPOaQ7sSGcXcCcO4D83zHg0tSwErvb/SDldKeAI/gMDjoMWQm32ZgnWk9so2wENeW0Rr
	urn3HYnIYwAuMRmWVl3v8m3Fa1aX6C3ITp90Fr1bBQww81ocwZF7cNJAFsNDTr21Ugmw
	RBO1txfbAMuNKc2vbdcfirs+81r28nDNDmHn8RTjoFiWgNh8Y9tZpNuhcM2+XaDS3fkr
	WuVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=xlmmcryFskM6LVHSnB503rp3QfJerIeYBwauhUiyLw4=;
	b=N/2B8rMs3MZgtXys61nIoW4Ik3iK4RsjJFY2/PC3MufjB0hct5Pm8bKFJn3FLEfiLL
	uvSAyKdLaHlW4Xi8PS67jWJIXi8pdwf6ABxXJ2Z3kNxHpTcWhA+6gf2uq1r97zwamcPO
	oXF7J2Vo+B1wm0Lv4+PvWrhE6Mnk2EqgXBBbhENNMjTyCEJK6X/zojabHg5/Rwg5cgbH
	sTDakpqG+3cw18sxklx4iEm3AkjfWDAZjS8qXpQ16SqteH/V5jlJZsK+NfLkCxHCttXW
	9Cw3UV84F7yiO/EM48KEI1DPNitU7KYUS0iuMm7EZoCr8VmYus7cEKICDvJX8VYd26F2
	z7UQ==
X-Gm-Message-State: APjAAAU35Rm+fBxh9mxMK9+llN/HLhHMNwZQNTmmLA7xJ+ZGcbndkIqr
	pNyozjSdxsjMwcNCPI/1WGz4lc3awhzBWHrkZ8Q=
X-Google-Smtp-Source: APXvYqw2b298t5OnGNgd5hgHuoL8h0JjnvCzXdgWm5T0mIO92xZCEsCMMg1W9n0a6boybP13NUscgpPmjGrGkHV8K2E=
X-Received: by 2002:a1c:ca0c:: with SMTP id a12mr6187618wmg.46.1556100052134; 
	Wed, 24 Apr 2019 03:00:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190424094557.28404-1-thuth@redhat.com>
In-Reply-To: <20190424094557.28404-1-thuth@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 24 Apr 2019 12:00:39 +0200
Message-ID:
 <CAJ+F1CLWyeT+dGycXso_nDV6YyAm_pte2hhC9YzePZbs67aYOQ@mail.gmail.com>
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH] tests/tpm-tests: Use g_test_skip() to mark
 skipped tests
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	QEMU <qemu-devel@nongnu.org>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190424100039.ZTzixLereAipAzPvZnBKxz5lTds9BceYlDJ9R7aAAl0@z>

On Wed, Apr 24, 2019 at 11:49 AM Thomas Huth <thuth@redhat.com> wrote:
>
> Since we do not use gtester anymore (which had a bug here),
> we can now use g_test_skip() to mark skipped tests.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  tests/tpm-tests.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/tpm-tests.c b/tests/tpm-tests.c
> index 582ec0cfd4..e640777aa9 100644
> --- a/tests/tpm-tests.c
> +++ b/tests/tpm-tests.c
> @@ -22,7 +22,7 @@ static bool
>  tpm_test_swtpm_skip(void)
>  {
>      if (!tpm_util_swtpm_has_tpm2()) {
> -        g_test_message("swtpm not in PATH or missing --tpm2 support");
> +        g_test_skip("swtpm not in PATH or missing --tpm2 support");
>          return true;
>      }
>
> --
> 2.21.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

