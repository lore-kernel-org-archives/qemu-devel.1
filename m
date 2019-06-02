Return-Path: <SRS0=s7fR=UB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D07CC282DC
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2019 13:23:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 593562791D
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2019 13:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="faxRDXfz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 593562791D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49153 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXQS5-00086b-EJ
	for qemu-devel@archiver.kernel.org; Sun, 02 Jun 2019 09:23:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hXQRL-0007md-Sv
	for qemu-devel@nongnu.org; Sun, 02 Jun 2019 09:22:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hXQRG-0004Fk-PX
	for qemu-devel@nongnu.org; Sun, 02 Jun 2019 09:22:23 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34711)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hXQRG-0004Eb-Hs
	for qemu-devel@nongnu.org; Sun, 02 Jun 2019 09:22:18 -0400
Received: by mail-wr1-x444.google.com with SMTP id e16so1246707wrn.1
	for <qemu-devel@nongnu.org>; Sun, 02 Jun 2019 06:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=5fC/lQIDFj2exvwbecU7yQNp1xlFzqDhegz4Ki6+CUI=;
	b=faxRDXfzj0ecenpoIkXWqxiE02R8M/r4cP7XMm5cCv3khp+msLIi7W1Ra2U7yHReoA
	zjJhCApPvne1OMqW8ShcNOIQgSjrjDuVH7/8IQolppIAQ0/MuFPVPOfssptpsSjldl/z
	WfyFHySv6s98nC2Y1tFFvbLqGYX19UVDh1CsZJFG9x1I7XVlUaEVhw2GTiy9Xzw4JFGU
	y0kLvUcSRZhqLU5YfDohcBJXxFf+2VX9WadI0MWdAsElZKtFJRNRzcG2FQHoUC1mCX9t
	XbX/gagKRfDcxBYjyNVfmbAxldk9xZfd/H3KNnCna9Dxt6G8NGRDx+si/5bUAFMT8crR
	WCkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=5fC/lQIDFj2exvwbecU7yQNp1xlFzqDhegz4Ki6+CUI=;
	b=IZHrh74dtWurdx2K0p6aTtX2V0TrRF0dYUcX5/huOhU8p1ZAFLIga4ukwhPOBc9obj
	S9avsTn0B8vdBEdpahZbLVBYAXLQEPs0vCvFDmNUld41iBWuuCGR4Ftmd6d1O+ldvuml
	ThevGv3FEy6qKhIzMAiG+IEtReFPZRdKRKkUxnT3STc0whYpGcWsocYLMKIE43oBIIBi
	fEvvmNE79sHmgo3gwQ8ENbLV3BYqKPyn0M1x5ucAgHdgSFtqHk4wIvwx121WU1Y/dFFE
	4Esd+mI6T6lU3hCR+ugwsy9ntj1y9JgsHZEJy3mv0psP7molFDt+logr5rLbk6NCyJEi
	mzyQ==
X-Gm-Message-State: APjAAAVnYHS4NpI9sSx6Ys0Vy3hUkj+BcFEHu/CmY7ND501uhjuwQ6EV
	s6Fypz6l1Qg+oG3ZNUBr2qBuGg==
X-Google-Smtp-Source: APXvYqw4QLmqxGBxeJhMxi5FS//TGYRc+SZY19nrjBAp/+CsQQMhPvsreCNsE0/r3K/z8IP2IOK+PA==
X-Received: by 2002:a05:6000:110:: with SMTP id
	o16mr12562488wrx.200.1559481736147; 
	Sun, 02 Jun 2019 06:22:16 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	k125sm27000326wmb.34.2019.06.02.06.22.15
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Sun, 02 Jun 2019 06:22:15 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id B24781FF87;
	Sun,  2 Jun 2019 14:22:14 +0100 (BST)
References: <1551718283-4487-1-git-send-email-mateja.marjanovic@rt-rk.com>
	<1551718283-4487-2-git-send-email-mateja.marjanovic@rt-rk.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <1551718283-4487-2-git-send-email-mateja.marjanovic@rt-rk.com>
Date: Sun, 02 Jun 2019 14:22:14 +0100
Message-ID: <877ea4dsvt.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH 1/2] target/mips: Improve performance for
 MSA binary operations
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
Cc: arikalo@wavecomp.com, aurelien@aurel32.net, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Mateja Marjanovic <mateja.marjanovic@rt-rk.com> writes:

> From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
>
> Eliminate loops for better performance.

Have you done any measurements of the bellow loop unrolling? Because
this is something that maybe we can achieve and let the compiler make
the choice.

>
> Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
> ---
>  target/mips/msa_helper.c | 43 ++++++++++++++++++++++++++++++-------------
>  1 file changed, 30 insertions(+), 13 deletions(-)
>
> diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
> index 4c7ec05..1152fda 100644
> --- a/target/mips/msa_helper.c
> +++ b/target/mips/msa_helper.c
> @@ -804,28 +804,45 @@ void helper_msa_ ## func ## _df(CPUMIPSState *env, =
uint32_t df,         \
>      wr_t *pwd =3D &(env->active_fpu.fpr[wd].wr);                        =
  \
>      wr_t *pws =3D &(env->active_fpu.fpr[ws].wr);                        =
  \
>      wr_t *pwt =3D &(env->active_fpu.fpr[wt].wr);
> \

If we can ensure alignment for the various vector registers then the
compiler always has the option of using host vectors (certainly for int
and logic operations).

> -    uint32_t i;                                                         \
>                                                                          \

>      switch (df) {                                                       \
>      case DF_BYTE:                                                       \
> -        for (i =3D 0; i < DF_ELEMENTS(DF_BYTE); i++) {                  =
  \
> -            pwd->b[i] =3D msa_ ## func ## _df(df, pws->b[i], pwt->b[i]);=
  \
> -        }                                                               \
> +        pwd->b[0]  =3D msa_ ## func ## _df(df, pws->b[0], pwt->b[0]);   =
  \
> +        pwd->b[1]  =3D msa_ ## func ## _df(df, pws->b[1], pwt->b[1]);   =
  \
> +        pwd->b[2]  =3D msa_ ## func ## _df(df, pws->b[2], pwt->b[2]);   =
  \
> +        pwd->b[3]  =3D msa_ ## func ## _df(df, pws->b[3], pwt->b[3]);   =
  \
> +        pwd->b[4]  =3D msa_ ## func ## _df(df, pws->b[4], pwt->b[4]);   =
  \
> +        pwd->b[5]  =3D msa_ ## func ## _df(df, pws->b[5], pwt->b[5]);   =
  \
> +        pwd->b[6]  =3D msa_ ## func ## _df(df, pws->b[6], pwt->b[6]);   =
  \
> +        pwd->b[7]  =3D msa_ ## func ## _df(df, pws->b[7], pwt->b[7]);   =
  \
> +        pwd->b[8]  =3D msa_ ## func ## _df(df, pws->b[8], pwt->b[8]);   =
  \
> +        pwd->b[9]  =3D msa_ ## func ## _df(df, pws->b[9], pwt->b[9]);   =
  \
> +        pwd->b[10] =3D msa_ ## func ## _df(df, pws->b[10], pwt->b[10]); =
  \
> +        pwd->b[11] =3D msa_ ## func ## _df(df, pws->b[11], pwt->b[11]); =
  \
> +        pwd->b[12] =3D msa_ ## func ## _df(df, pws->b[12], pwt->b[12]); =
  \
> +        pwd->b[13] =3D msa_ ## func ## _df(df, pws->b[13], pwt->b[13]); =
  \
> +        pwd->b[14] =3D msa_ ## func ## _df(df, pws->b[14], pwt->b[14]); =
  \
> +        pwd->b[15] =3D msa_ ## func ## _df(df, pws->b[15], pwt->b[15]); =
  \
>          break;                                                          \
>      case DF_HALF:                                                       \
> -        for (i =3D 0; i < DF_ELEMENTS(DF_HALF); i++) {                  =
  \
> -            pwd->h[i] =3D msa_ ## func ## _df(df, pws->h[i], pwt->h[i]);=
  \
> -        }                                                               \
> +        pwd->h[0] =3D msa_ ## func ## _df(df, pws->h[0], pwt->h[0]);    =
  \
> +        pwd->h[1] =3D msa_ ## func ## _df(df, pws->h[1], pwt->h[1]);    =
  \
> +        pwd->h[2] =3D msa_ ## func ## _df(df, pws->h[2], pwt->h[2]);    =
  \
> +        pwd->h[3] =3D msa_ ## func ## _df(df, pws->h[3], pwt->h[3]);    =
  \
> +        pwd->h[4] =3D msa_ ## func ## _df(df, pws->h[4], pwt->h[4]);    =
  \
> +        pwd->h[5] =3D msa_ ## func ## _df(df, pws->h[5], pwt->h[5]);    =
  \
> +        pwd->h[6] =3D msa_ ## func ## _df(df, pws->h[6], pwt->h[6]);    =
  \
> +        pwd->h[7] =3D msa_ ## func ## _df(df, pws->h[7], pwt->h[7]);    =
  \
>          break;                                                          \
>      case DF_WORD:                                                       \
> -        for (i =3D 0; i < DF_ELEMENTS(DF_WORD); i++) {                  =
  \
> -            pwd->w[i] =3D msa_ ## func ## _df(df, pws->w[i], pwt->w[i]);=
  \
> -        }                                                               \
> +        pwd->w[0] =3D msa_ ## func ## _df(df, pws->w[0], pwt->w[0]);    =
  \
> +        pwd->w[1] =3D msa_ ## func ## _df(df, pws->w[1], pwt->w[1]);    =
  \
> +        pwd->w[2] =3D msa_ ## func ## _df(df, pws->w[2], pwt->w[2]);    =
  \
> +        pwd->w[3] =3D msa_ ## func ## _df(df, pws->w[3], pwt->w[3]);    =
  \
>          break;                                                          \
>      case DF_DOUBLE:                                                     \
> -        for (i =3D 0; i < DF_ELEMENTS(DF_DOUBLE); i++) {                =
  \
> -            pwd->d[i] =3D msa_ ## func ## _df(df, pws->d[i], pwt->d[i]);=
  \
> -        }                                                               \
> +        pwd->d[0] =3D msa_ ## func ## _df(df, pws->d[0], pwt->d[0]);    =
  \
> +        pwd->d[1] =3D msa_ ## func ## _df(df, pws->d[1], pwt->d[1]);    =
  \
>          break;                                                          \
>      default:                                                            \
>          assert(0);                                                      \


--
Alex Benn=C3=A9e

