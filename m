Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA38C10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 19:54:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB9BC20880
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 19:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJlBYZOU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB9BC20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58150 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDaLh-00079Y-5H
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 15:54:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hDaKw-0006qr-Gt
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 15:53:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hDaKv-0001IE-M3
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 15:53:46 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:38519)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1hDaKv-0001HP-9g
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 15:53:45 -0400
Received: by mail-wr1-x433.google.com with SMTP id k11so17886432wro.5
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 12:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=yY3yl2owJBHFtc13otFBnfnNNoXnTFflI6nrhYUF9+U=;
	b=WJlBYZOUqYbSHq6jqdSnglLp6abWfbIx6GD7Xvkr+S3nchJSzZTdPt1LxWbwjn59DW
	jDf5xhuUH2GsGIJ3RiUYju1iFLCYIkeKqp3tMql5fZM/nJOzD7+umLEy4nLox2X1qwAc
	NPuDuep1rIUTbUy7aLokOTacS3NaguLgK86/JIzMmV23b6mCFmRh81bRdcN1cMqpirBQ
	bfM1T+EWdC4FY65sjt5xTnlXpZV5O/5wapG1jz7LcBUh3oDXPtQL4YusAxwx56bBjO/x
	+Bkii9TabzSe9dGSRvy8ysXUKgqfYCJrJ/R6cRNH05Wg8ZSicOuIhrS3Ue6yG0eLpL48
	fW+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=yY3yl2owJBHFtc13otFBnfnNNoXnTFflI6nrhYUF9+U=;
	b=hwzMyNHOAEXoC41n0ROw6lcA5B5v5DJVCO/1q9xyx+SRAR/ZZE/axGj0P2YJkQ36aS
	OsuesLfXyAaPA0qs0uLTMsZ1+1Tktg63QwkD4rz9I0PiPv2GilmlGLj2a/UT4FJlvur0
	aUAeqAp9mychxXyaNDxwYe5bMMyOhf90urUNY3Ntrge0ij0SvNuCXUi+S6OfIafDPI/C
	cypMxbHzRhPJZbts0mPq3IKRvLSGaq8USd2+mwRfuEWZFdV6ZUqGNacmpRuq7TPTCc4k
	CSkTxWZxCwR7UR6+Z59+tBlNgpBN04keS+3kX6s5kYiXuNAugRzehInFDX1a5NyP3Eh4
	nKOg==
X-Gm-Message-State: APjAAAUL3e5g75wpkfWLSzfngYFsir+AXFmlgFKdot5M8Xkbl8BrLrW8
	WiWowRS1Ap3AzgfidnoKJthBL9ivwAbfjqD2Kvs=
X-Google-Smtp-Source: APXvYqzSGrr2Xl8R9Ln2m2IaPWE4oy6wd3q2QhJcPHkjH76SxfNs53sOsg8zJ3VgPY/YIID9z7YT4SNa3/0zHA+irQM=
X-Received: by 2002:adf:db05:: with SMTP id s5mr20772947wri.247.1554753222901; 
	Mon, 08 Apr 2019 12:53:42 -0700 (PDT)
MIME-Version: 1.0
References: <1554750276-19230-1-git-send-email-lidong.chen@oracle.com>
In-Reply-To: <1554750276-19230-1-git-send-email-lidong.chen@oracle.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 8 Apr 2019 21:53:30 +0200
Message-ID:
 <CAJ+F1C+c=+p__B=cZg5cOH-StcyMFLv3cB07LDFybk_Em8CpUA@mail.gmail.com>
To: Lidong Chen <lidong.chen@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::433
Subject: Re: [Qemu-devel] [PATCH] sd: Fix out-of-bounds assertions
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
Cc: darren.kenny@oracle.com, QEMU <qemu-devel@nongnu.org>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408195330.mhyMJbfu1idfk2AbubOlBXyjhUNrPDNvLCD_H3q5k6o@z>

On Mon, Apr 8, 2019 at 9:51 PM Lidong Chen <lidong.chen@oracle.com> wrote:
>
> Due to an off-by-one error, the assert statements allow an
> out-of-bounds array access.
>
> Signed-off-by: Lidong Chen <lidong.chen@oracle.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/sd/sd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index aaab15f..818f86c 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -144,7 +144,7 @@ static const char *sd_state_name(enum SDCardStates st=
ate)
>      if (state =3D=3D sd_inactive_state) {
>          return "inactive";
>      }
> -    assert(state <=3D ARRAY_SIZE(state_name));
> +    assert(state < ARRAY_SIZE(state_name));
>      return state_name[state];
>  }
>
> @@ -165,7 +165,7 @@ static const char *sd_response_name(sd_rsp_type_t rsp=
)
>      if (rsp =3D=3D sd_r1b) {
>          rsp =3D sd_r1;
>      }
> -    assert(rsp <=3D ARRAY_SIZE(response_name));
> +    assert(rsp < ARRAY_SIZE(response_name));
>      return response_name[rsp];
>  }
>
> --
> 1.8.3.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

